#script (python)
import sys, os, time, clingo
from typing           import Optional
from sortedcontainers import SortedSet, SortedDict
from clingo           import Function, Number, SymbolType

def main(prg):
    step = 0
    ret: Optional[SolveResult] = None
    ground_time = 0
    solve_time  = 0

    while (step == 0 or not ret.satisfiable):
        parts = []
        parts.append(('check', [Number(step)]))

        if step > 0:
            prg.release_external(Function('query', [Number(step - 1)]))
            parts.append(('step', [Number(step)]))
            prg.cleanup()
        else:
            parts.append(('base', []))

        start = time.time()
        prg.ground(parts)
        end   = time.time()
        ground_time += end-start

        # print('Grounding time at step ' + str(step) + ': ' + str(end-start))

        prg.assign_external(Function('query', [Number(step)]), True)

        start = time.time()
        # ret  = prg.solve()
        ret   = prg.solve(on_model=print_states)
        end   = time.time()
        solve_time += end-start

        step = step + 1
    
    # print('Total grounding time: ' + str(ground_time))
    # print('Total solving   time: ' + str(solve_time ))
#
def print_states(m):
    semantics = [s.arguments[0].string for s in m.symbols(atoms=True) if s.name == 'semantics'][0]
    all_worlds  = {s for s in m.symbols(atoms=True) if s.name == 'w'}
    # all_rels    = {s for s in m.symbols(atoms=True) if s.name == 'r'}
    # all_rels    = build_rels(all_worlds, all_rels)

    states      = build_states(m, semantics, all_worlds)
    world_names = generate_world_names(all_worlds)
    atoms       = generate_atoms(m)
    outputfile  = open('out/test.dot', 'w')
    labels      = [s.arguments[1].name for s in m.symbols(atoms=True) if s.name == 'plan']
    labels.insert(0, 's0')

    font = '"Helvetica,Arial,sans-serif"'

    print('digraph {',                       end = '\n', file = outputfile)
    print('\tfontname='       + font + ';',  end = '\n', file = outputfile)
    print('\tnode [fontname=' + font + '];', end = '\n', file = outputfile)
    print('\tedge [fontname=' + font + '];', end = '\n', file = outputfile)
    print('\tlabelloc=t;',                   end = '\n', file = outputfile)
    print('\tlabeljust=l;',                  end = '\n', file = outputfile)
    print('\trankdir=BT;',                   end = '\n', file = outputfile)
    print('\tranksep=1.5',                   end = '\n', file = outputfile)
    # print('\tnewrank=true;',                 end = '\n', file = outputfile)
    print('\tsize="3.5";',                   end = '\n', file = outputfile)

    t = 0
    
    for s in states:
        label = labels[t] if t == 0 else 's' + str(t) + ' = ' + 's' + str(t-1) + ' * ' + labels[t]
        print_cluster(states, t, world_names, atoms, label, outputfile)
        t += 1
    
    print_rels(states, world_names, outputfile)
    print_vals(semantics, states, all_worlds, world_names, atoms, outputfile)
    print('}', file = outputfile)
    outputfile.close()

    os.system('dot -Tpdf out/test.dot > out/test.pdf')
#
def print_cluster(states, t, world_names, atoms, label, outputfile):
    print('',                                   end = '\n',  file = outputfile)
    print('\tsubgraph cluster_' + str(t)+ ' {', end ='\n',   file = outputfile)
    print('\t\tlabel="' + label + '";',         end ='\n\n', file = outputfile)

    s = states[t]
    
    print_worlds(s[0], s[3], world_names, s[1], outputfile)
    print('', end ='\n', file = outputfile)

    print('\t}', end ='\n', file = outputfile)
#
def print_worlds(worlds, des, world_names, rels, outputfile):
    ranked_worlds = SortedDict()
    
    for w in worlds:
        in_edges  = {world_names[v] for v in rels for ag in rels[v] if w in rels[v][ag]}
        out_edges = {world_names[v] for ag in rels[w] for v in rels[w][ag]}

        # in_edges = list(in_edges)
        # in_edges.sort()

        # out_edges = list(out_edges)
        # out_edges.sort()

        edges = in_edges.intersection(out_edges)
        edges = list(edges)
        edges.sort()

        e    = '' # w.arguments[2].name
        rank = ''.join(edges) + e

        if (ranked_worlds.get(rank) == None):
            ranked_worlds[rank] = SortedSet({w})
        else:
            ranked_worlds[rank].add(w)
    
    for rank in ranked_worlds:
        wr = ''
        
        for w in ranked_worlds[rank]:
            shape = ' [shape = doublecircle]' if (w in des) else ''
            wr += world_names[w] + shape + '; '
        
        print('\t\t' + '{ rank=same; ' + wr + '}', end = '\n', file = outputfile)
#
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
#
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
#
# def print_val(t, val, all_worlds, world_names, atoms, outputfile):
def print_vals(semantics, states, all_worlds, world_names, atoms, outputfile):
    print('\t\tnode [] val_table [shape=none label=<',                               end = '\n', file = outputfile)
    print('\t\t\t<TABLE border="0" cellspacing="0" cellborder="1" cellpadding="2">', end = '\n', file = outputfile)

    t = -1
    
    for s in states:
        t += 1
        val = s[2]
        
        for w in val:
            w_val = val[w]

            print('\t\t\t\t<TR>',                              end = '\n', file = outputfile)
            print('\t\t\t\t\t<TD>' + world_names[w] + '</TD>', end = '\n', file = outputfile)
            
            if (t == 0):
                print('\t\t\t\t\t<TD>-</TD>',                          end = '\n', file = outputfile)
            else:
                old_w_args = w.arguments[1].arguments if semantics == 'delphic' else [Number(t-1)] + w.arguments[1].arguments
                old_w      = world_names[find_world(all_worlds, old_w_args)]
                e          = w.arguments[2].name

                print('\t\t\t\t\t<TD>(' + old_w + ', ' + e + ')</TD>', end = '\n', file = outputfile)

            print('\t\t\t\t\t<TD>',                            end = '\n', file = outputfile)

            for p in atoms:
                if (p in w_val):
                    print('\t\t\t\t\t\t<font color="#0000ff"> ' + p + '</font>', end = '', file = outputfile)
                else:
                    print('\t\t\t\t\t\t<font color="#ff0000">-' + p + '</font>', end = '', file = outputfile)
                
                sep = ', ' if atoms.index(p) < len(atoms)-1 else ''
                print(sep, end = '\n', file = outputfile)

            print('\t\t\t\t\t</TD>', end = '\n', file = outputfile)
            print('\t\t\t\t</TR>',   end = '\n', file = outputfile)

    print('\t\t\t</TABLE>', end = '\n', file = outputfile)
    print('\t\t>];',        end = '\n', file = outputfile)
    
#
def generate_world_names(all_worlds):
    world_names = SortedDict()
    world_list  = list(all_worlds)
    world_list.sort()
    i = 0

    for w in world_list:
        world_names[w] = 'w' + str(i)
        i += 1
    
    return world_names
#
def generate_atoms(m):
    atoms = SortedSet()

    for s in m.symbols(atoms=True):
        if (s.name == 'atom'):
            atoms.add(s.arguments[0].name)
    
    return atoms

### States generation
def build_states(m, semantics, all_worlds):
    max_t  = get_max_t(m)
    states = []

    for t in range(max_t+1):
        states.append(build_state(m, semantics, t, all_worlds))

    return states
#
def get_max_t(m):
    return max([s.arguments[0].number for s in m.symbols(atoms=True) if s.name == 'time'])
    #max_t = 0
    #
    #for s in m.symbols(atoms=True):
    #    if (s.name == 'time' and s.arguments[0].number > max_t):
    #        max_t = s.arguments[0].number
    #
    #return max_t
#
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
#
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
#
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
#
def find_world(all_worlds, args):
    for w in all_worlds:
        if w.arguments == args:
            return w
    
    return None
#
#end.

#program check(t).
#external query(t).


% #def holds_atom(w, f):
% #    return f.name in val[w]
% ##
% #def holds_neg(w, f):
% #    h0 = holds_in_world_helper(w, f.arguments[0])
% #    return not h0
% ##
% #def holds_and(w, f):
% #    h0 = holds_in_world_helper(w, f.arguments[0])
% #    h1 = holds_in_world_helper(w, f.arguments[1])
% #    return h0 and h1
% ##
% #def holds_or(w, f):
% #    h0 = holds_in_world_helper(w, f.arguments[0])
% #    h1 = holds_in_world_helper(w, f.arguments[1])
% #    return h0 or h1
% ##
% #def holds_imply(w, f):
% #    h0 = holds_in_world_helper(w, f.arguments[0])
% #    h1 = holds_in_world_helper(w, f.arguments[1])
% #    return not h0 or h1
% ##
% #def holds_box(w, f):
% #    ag = f.arguments[0].name
% #    f2 = f.arguments[1]
% #
% #    for v in rels[w][ag]:
% #        if (not holds_in_world_helper(v, f2)):
% #            return False
% #
% #    return True
% ##
% #def holds_dia(w, f):
% #    ag = f.arguments[0].name
% #    f2 = f.arguments[1]
% #
% #    for v in rels[w][ag]:
% #        if (holds_in_world_helper(v, f2)):
% #            return True
% #
% #    return False
% ##
% #def holds_c(w, f):
% #    return False
% ##
% #def holds_in_world_helper(w, f):
% #    if (len(f.arguments) == 0):
% #        if (f.name == 'true'):
% #            return True
% #        elif (f.name == 'false'):
% #            return False
% #        else:
% #            return holds_atom(w, f)
% #    elif (f.name == 'neg'   and len(f.arguments) == 1):
% #        return holds_neg(w, f)
% #    elif (f.name == 'and'   and len(f.arguments) == 2):
% #        return holds_and(w, f)
% #    elif (f.name == 'or'    and len(f.arguments) == 2):
% #        return holds_or(w, f)
% #    elif (f.name == 'imply' and len(f.arguments) == 2):
% #        return holds_imply(w, f)
% #    elif (f.name == 'box'   and len(f.arguments) == 2):
% #        return holds_box(w, f)
% #    elif (f.name == 'dia'   and len(f.arguments) == 2):
% #        return holds_dia(w, f)
% #    elif (f.name == 'c'     and len(f.arguments) == 2):
% #        return holds_c(w, f)
% ##
% #
% #def holds_in_world(w, f):
% #    if (holds_in_world_helper(w, f)):
% #        return Number(1)
% #    else:
% #        return Number(0)
% ##
% #def holds(f):
% #    for wd in des:
% #        if (not holds_in_world_helper(wd, f)):
% #            return Number(0)
% #
% #    return Number(1)
