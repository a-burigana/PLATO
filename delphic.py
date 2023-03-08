import sys, os, time, clingo
from typing           import Optional
from sortedcontainers import SortedSet, SortedDict
from clingo           import Function, Number, SymbolType


def main(argv):
    (clingo_args, clingo_files) = parse_arguments(argv)
    app_name = '################\n#    delphic   #\n################\n\nbuilt on clingo'
    clingo.clingo_main(Application(app_name), clingo_files + clingo_args)

def parse_arguments(argv):
    clingo_args = ['-t 2', '--configuration=frumpy']
    instance    = ''
    domain      = ''
    semantics   = 'semantics/delphic.lp'
    config      = 'run_config/search.lp'

    i = 0
    n = len(argv)

    while i < n:
        opt = argv[i]
        i  += 1

        if opt in ('-h', '--help'):
            print('delphic.py TODO')
            sys.exit()
        elif opt in ('-i', '--instance'):
            instance = argv[i]
            domain   = os.path.dirname(instance) + '/domain.lp'
            i += 1
        elif opt in ('-s', '--semantics'):
            if (argv[i] == 'delphic'):
                semantics = 'semantics/delphic.lp'
            elif (argv[i] == 'kripke'):
                semantics = 'semantics/kripke.lp'
            else:
                print('Error: unknown semantics')
            i += 1
        elif opt in ('-d', '--debug'):
            config = 'run_config/debug.lp'
        elif opt in ('-p', '--print'):
            clingo_args.append('-c print=true')
        else:
            clingo_args.append(opt)
    
    clingo_files = [config, semantics, domain, instance]

    return (clingo_args, clingo_files)



#############################################################
#                                                           #
#                 CLINGO MULTI-SHOT SOLVING                 #
#                                                           #
#############################################################



class Application:
    def __init__(self, name):
        self.program_name = name

    def main(self, ctl, files):
        # print(ctl._arguments)

        if len(files) > 0:
            for f in files:
                ctl.load(f)
        else:
            ctl.load('-')

        step = 0
        ret: Optional[SolveResult] = None

        while (step == 0 or not ret.satisfiable):
            parts = []
            parts.append(('check', [Number(step)]))

            if step > 0:
                ctl.release_external(Function('query', [Number(step - 1)]))
                parts.append(('step', [Number(step)]))
                ctl.cleanup()
            else:
                parts.append(('base', []))

            ctl.ground(parts)
            ctl.assign_external(Function('query', [Number(step)]), True)

            # ret = ctl.solve()
            ret = ctl.solve(on_model=print_states)

            step = step + 1



#############################################################
#                                                           #
#          GRAPHICAL OUTPUT GENERATION (GRAPHVIZ)           #
#                                                           #
#############################################################



def print_states(m):
    print_states_ = [s.arguments[0].name for s in m.symbols(atoms=True) if s.name == 'print_states'][0]

    if (print_states_ == 'false'):
        print('hasta la vista')
        return 0
    
    semantics = [s.arguments[0].string for s in m.symbols(atoms=True) if s.name == 'semantics'][0]
    all_worlds  = {s for s in m.symbols(atoms=True) if s.name == 'w'}
    # all_rels    = {s for s in m.symbols(atoms=True) if s.name == 'r'}
    # all_rels    = build_rels(all_worlds, all_rels)

    states      = build_states(m, semantics, all_worlds)
    world_names = generate_world_names(all_worlds)
    atoms       = generate_atoms(m)
    outputfile  = open('out/test.dot', 'w')
    labels      = [s.arguments[1].name for s in m.symbols(atoms=True) if s.name == 'plan']
    # labels.insert(0, '')

    font = '"Helvetica,Arial,sans-serif"'

    print('digraph {',                       end = '\n', file = outputfile)
    print('\tfontname='       + font + ';',  end = '\n', file = outputfile)
    print('\tnode [fontname=' + font + '];', end = '\n', file = outputfile)
    print('\tedge [fontname=' + font + '];', end = '\n', file = outputfile)
    print('\tlabeljust=l;',                  end = '\n', file = outputfile)
    print('\trankdir=BT;',                   end = '\n', file = outputfile)
    print('\tranksep=1.5',                   end = '\n', file = outputfile)
    print('\tnewrank=true;',                 end = '\n', file = outputfile)
    # print('\tsize="3.5";',                   end = '\n', file = outputfile)
    print('\tcompound=true;',                end = '\n', file = outputfile)

    t = 0
    
    for s in states:
        # label = labels[t] if t == 0 else 's' + str(t) + ' = ' + 's' + str(t-1) + ' * ' + labels[t]
        print_cluster(semantics, states, t, world_names, atoms, outputfile)
        t += 1
    
    print_rels(states, world_names, outputfile)
    # print_cluster_rels(states, world_names, labels, outputfile)
    print_vals(semantics, states, all_worlds, world_names, atoms, outputfile)
    print('}', file = outputfile)
    outputfile.close()

    os.system('dot -Tpdf out/test.dot > out/test.pdf')

def print_cluster(semantics, states, t, world_names, atoms, outputfile):
    print('',                                   end = '\n',   file = outputfile)
    print('\tsubgraph cluster_' + str(t)+ ' {', end = '\n',   file = outputfile)
    print('\t\tlabel="s' + str(t) + '";',       end = '\n',   file = outputfile)
    print('\t\tmargin=15;',                     end = '\n',   file = outputfile)
    print('\t\tcolor=red;',                     end = '\n',   file = outputfile)
    print('\t\tfontcolor=red;',                 end = '\n\n', file = outputfile)

    s = states[t]
    
    print_worlds(semantics, t, s[0], s[3], world_names, s[1], outputfile)
    print('', end ='\n', file = outputfile)

    print('\t}', end ='\n', file = outputfile)

def print_worlds(semantics, t, worlds, des, world_names, rels, outputfile):
    ranked_worlds = SortedDict()
    
    for w in worlds:
        in_worlds  = {world_names[v] for v  in rels    for ag in rels[v] if w in rels[v][ag]}
        out_worlds = {world_names[v] for ag in rels[w] for v  in rels[w][ag]}
        
        same_rank_worlds = in_worlds.intersection(out_worlds)
        same_rank_worlds = list(same_rank_worlds)
        same_rank_worlds.sort()
        
        rank = str(t) + ''.join(same_rank_worlds)
        
        # rank = str(t) + w.arguments[2].name

        if (ranked_worlds.get(rank) == None):
            ranked_worlds[rank] = SortedSet({w})
        else:
            ranked_worlds[rank].add(w)

    for rank in ranked_worlds:
        has_des = False
        wr = ''
        
        for w in ranked_worlds[rank]:
            shape = ' [shape = doublecircle]' if (w in des) else ''
            has_des = w in des
            wr += world_names[w] + shape + '; '
        
        # print('\t\t' + wr, end = '\n', file = outputfile)
        
        if (semantics == 'delphic'):
            if (has_des):
                print('\t\t' + '{ rank=source; ' + wr + '}', end = '\n', file = outputfile)
            else:
                print('\t\t' + '{ rank=same; ' + wr + '}', end = '\n', file = outputfile)
        else:
            print('\t\t' + wr, end = '\n', file = outputfile)

def generate_pretty_rels(states):
    pretty_rels = SortedDict()
    
    for s in states:
        rels = s[1]

        for w1 in rels:
            w1_rels = rels[w1]
            
            for ag in w1_rels:
                ag_worlds = w1_rels[ag]
                
                for w2 in ag_worlds:
                    both_dir = w1 != w2 and rels.get(w2) != None and rels[w2].get(ag) != None and w1 in rels[w2][ag]

                    if (not both_dir or (both_dir and w1 < w2)):
                        if (pretty_rels.get((w1, w2)) == None):
                            pretty_rels[(w1, w2)] = SortedSet({(ag, both_dir)})
                        else:
                            pretty_rels[(w1, w2)].add((ag, both_dir))
    
    return pretty_rels

def print_rels(states, world_names, outputfile):
    print('', end = '\n',  file = outputfile)
    pretty_rels = generate_pretty_rels(states)
    
    for (w1, w2) in pretty_rels:
        ags = pretty_rels[(w1, w2)]

        label      = ''
        label_both = ''

        for (ag, both_dir) in ags:
            if (both_dir):
                label_both += ag + ', '
            else:
                label      += ag + ', '
        
        if (label != ''):
            print('\t' + world_names[w1] + ' -> ' + world_names[w2] + ' [label="' + label[0:-2]      + '"];',          end = '\n', file = outputfile)

        if (label_both != ''):
            print('\t' + world_names[w1] + ' -> ' + world_names[w2] + ' [label="' + label_both[0:-2] + '" dir=both];', end = '\n', file = outputfile)

def print_cluster_rels(states, world_names, labels, outputfile):
    print('', end = '\n', file = outputfile)
    
    for t in range(len(states)-1):
        s1   = states[t]
        s2   = states[t+1]
        des1 = s1[3]
        des2 = s2[3]

        wd1  = list(des1)[0]
        wd2  = list(des2)[0]

        # print('\t' + world_names[wd1] + ' -> ' + world_names[wd2] + ' [arrowhead="vee" label="' + labels[t] + '" color=red fontcolor=red];', end = '\n', file = outputfile)
        print('\t' + world_names[wd1] + ' -> ' + world_names[wd2] + ' [arrowhead="vee" label="' + labels[t] + '" ltail=cluster_' + str(t) + ' lhead=cluster_' + str(t+1) + ' color=red fontcolor=red];', end = '\n', file = outputfile)

def print_vals(semantics, states, all_worlds, world_names, atoms, outputfile):
    print('',                                                                      end = '\n', file = outputfile)
    print('\tnode [] val_table [shape=none label=<',                               end = '\n', file = outputfile)
    print('\t\t<TABLE border="0" cellspacing="0" cellborder="1" cellpadding="2">', end = '\n', file = outputfile)

    t = -1
    
    for s in states:
        t += 1
        val = s[2]
        
        for w in val:
            w_val = val[w]

            print('\t\t\t<TR>',                              end = '\n', file = outputfile)
            print('\t\t\t\t<TD>' + world_names[w] + '</TD>', end = '\n', file = outputfile)
            
            if (t == 0):
                print('\t\t\t\t<TD>-</TD>',                          end = '\n', file = outputfile)
            else:
                old_w_args = w.arguments[1].arguments if semantics == 'delphic' else [Number(t-1)] + w.arguments[1].arguments
                old_w      = world_names[find_world(all_worlds, old_w_args)]
                e          = w.arguments[2].name

                print('\t\t\t\t<TD>(' + old_w + ', ' + e + ')</TD>', end = '\n', file = outputfile)

            print('\t\t\t\t<TD>',                            end = '\n', file = outputfile)

            for p in atoms:
                if (p in w_val):
                    print('\t\t\t\t\t<font color="blue"> ' + p + '</font>', end = '', file = outputfile)
                else:
                    print('\t\t\t\t\t<font color="red">-'  + p + '</font>', end = '', file = outputfile)
                
                sep = ', ' if atoms.index(p) < len(atoms)-1 else ''
                print(sep, end = '\n', file = outputfile)

            print('\t\t\t\t</TD>', end = '\n', file = outputfile)
            print('\t\t\t</TR>',   end = '\n', file = outputfile)

    print('\t\t</TABLE>', end = '\n', file = outputfile)
    print('\t>];',        end = '\n', file = outputfile)

def generate_world_names(all_worlds):
    world_names = SortedDict()
    world_list  = list(all_worlds)
    world_list.sort()
    i = 0

    for w in world_list:
        world_names[w] = 'w' + str(i)
        i += 1
    
    return world_names

def generate_atoms(m):
    atoms = SortedSet()

    for s in m.symbols(atoms=True):
        if (s.name == 'atom'):
            atoms.add(s.arguments[0].name)
    
    return atoms

### States generation
def build_states(m, semantics, all_worlds):
    max_t  = max([s.arguments[0].number for s in m.symbols(atoms=True) if s.name == 'time'])
    states = []

    for t in range(max_t+1):
        states.append(build_state(m, semantics, t, all_worlds))

    return states

def build_state(m, semantics, t, all_worlds):
    r_symbols = SortedSet()
    h_symbols = SortedSet()
    worlds    = SortedSet()
    des       = SortedSet()

    for s in m.symbols(atoms=True):
        if (  s.name == 'w'  and s.arguments[0].number == t):
            worlds.add(s)
        elif (s.name == 'r'  and s.arguments[0].number == t):
            r_symbols.add(s)
        elif (s.name == 'v'  and s.arguments[0].number == t):
            h_symbols.add(s)
        elif (s.name == 'dw' and s.arguments[0].number == t):
            des.add(find_world(all_worlds, s.arguments))
    
    rels = build_rels(semantics, all_worlds, r_symbols)
    val  = build_val(worlds, h_symbols)

    return (worlds, rels, val, des)

def build_rels(semantics, worlds, r_symbols):
    rels = SortedDict()

    for s in r_symbols:
        w1 = find_world(worlds, s.arguments[0:3]) if semantics == 'delphic' else find_world(worlds, s.arguments[0:3])
        w2 = find_world(worlds, s.arguments[3:6]) if semantics == 'delphic' else find_world(worlds, [s.arguments[0]] + s.arguments[3:5])
        ag = s.arguments[6].name                  if semantics == 'delphic' else s.arguments[5].name

        w1_map = rels.get(w1)

        if (w1_map == None):
            rels[w1] = SortedDict({ag: SortedSet({w2})})
        else:
            ws = w1_map.get(ag)

            if (ws == None):
                w1_map[ag] = SortedSet({w2})
            else:
                ws.add(w2)

    return rels

def build_val(worlds, h_symbols):
    val = SortedDict()

    for s in h_symbols:
        w = find_world(worlds, s.arguments[0:3])
        p = s.arguments[3].name

        w_map = val.get(w)

        if (w_map == None):
            val[w] = SortedSet({p})
        else:
            val[w].add(p)

    for w in worlds:
        if (val.get(w) == None):
            val[w] = SortedSet()
    
    return val

def find_world(all_worlds, args):
    for w in all_worlds:
        if w.arguments == args:
            return w
    
    return None



#############################################################
#                                                           #
#                            MAIN                           #
#                                                           #
#############################################################



if __name__ == '__main__':
    main(sys.argv[1:])
