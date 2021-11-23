#!/usr/bin/python

#execution example: "python3 out_reader.py output" --- rember not to put the txt extension, is considered like that as default
#after that run "dot -Tpng output.dot >> output.png" or "dot -Tpdf output.dot >> output.pdf"

import sys
import re
from collections import defaultdict
from sortedcontainers import SortedSet, SortedDict


def generate_designated(new_designated):
	new_designated = re.sub('dw\(', '', new_designated)
	new_designated = re.sub('\)$', '', new_designated)
	return new_designated

def last_designated(new_designated,designated):
	new_designated = generate_designated(new_designated)
	np_splitted = new_designated.split(',')
	p_splitted = designated.split(',')
	if np_splitted[0] >= p_splitted[0]:
		return np_splitted[0] + '_' + np_splitted[1] + '_' + np_splitted[2] + '_' + np_splitted[3]
	else:
		return p_splitted[0] + '_' + p_splitted[1] + '_' + np_splitted[2] + '_' + p_splitted[3]

def generate_world_key(world):
	replaced = re.sub('w\(', '', world)
	replaced = re.sub('\)$', '', replaced)
	return replaced

def generate_world(world, designated):
	key = generate_world_key(world)
	splitted = key.split(',')
	key = splitted[0] + '_' + splitted[1] + '_' + splitted[2] + '_' + splitted[3]
	if (key) != designated:
		print('\tnode [shape = circle] "' + key + '";', file = outputfile)
	else:
		print('\tnode [shape = doublecircle] "' + key + '";', file = outputfile)
	return key

def initialize_rank(world, rank_map):
	key = generate_world_key(world)
	splitted = re.split(',', key)
	rank_map[2**int(splitted[0])+int(splitted[3])+1] = SortedSet()

def generate_rank(world, rank_map):
	key = generate_world_key(world)
	splitted = re.split(',', key)
	rank_map[2**int(splitted[0])+int(splitted[3])+1].add('"' + splitted[0] + '_' + splitted[1] + '_' + splitted[2] + '_' + splitted[3] + '"')

def generate_hold_key(hold):
	replaced = re.sub('^holds\(', '', hold)
	replaced = re.sub('\)$', '', replaced)
	return replaced

def initialize_atom_table(hold, atom_table, key_table):
	hold_key = generate_hold_key(hold)
	splitted = hold_key.split(',')
	atom_table[splitted[0]+splitted[1]+splitted[2]+splitted[3]] = SortedSet()
	key_table[splitted[0]+splitted[1]+splitted[2]+splitted[3]] = splitted[0] + '_' + splitted[1] + '_' + splitted[2] + '_' + splitted[3]

def generate_atom_table(hold, atom_table):
	hold_key = generate_hold_key(hold)
	splitted = hold_key.split(',')
	atom_table[splitted[0]+splitted[1]+splitted[2]+splitted[3]].add(splitted[4])


def initialize_cluster(world, cluster_map):
	key = generate_world_key(world)
	splitted = key.split(',')
	cluster_map[splitted[0]] = SortedSet()

def generate_cluster(world, cluster_map):
	key = generate_world_key(world)
	splitted = key.split(',')
	cluster_map[splitted[0]].add('"' + splitted[0] + '_' + splitted[1] + '_' + splitted[2] + '_' + splitted[3] + '"')

def generate_edge_key(edge):
	replaced = re.sub('^r\(', '', edge)
	replaced1 = re.sub('\)$', '', replaced)
	return replaced1

def initialize_edges(edge, edges_map):
	key = generate_edge_key(edge)
	splitted = key.split(',')
	edges_map['"' + splitted[0] + '_' + splitted[1] + '_' + splitted[2] + '_' + splitted[3]+ '"'+' -> '+ '"' + splitted[4] + '_' + splitted[5] + '_' + splitted[6] + '_' + splitted[7]+ '"'] = SortedSet()

def generate_edges(edge,edges_map):
	key = generate_edge_key(edge)
	splitted = key.split(',')
	edges_map['"' + splitted[0] + '_' + splitted[1] + '_' + splitted[2] + '_' + splitted[3]+ '"'+' -> '+ '"' + splitted[4] + '_' + splitted[5] + '_' + splitted[6] + '_' + splitted[7]+ '"'].add(splitted[8])

def compare_keys(key1,key2,edges_map,edges_map_both):
	key1_mod = re.sub('\_|->|"', '', key1)
	substrings = re.split('\s+',key1_mod)
	key1_inverted = substrings[1] + substrings[0]
	key2_mod = re.sub('\_|->|"|\s+', '', key2)
	if key1_inverted == key2_mod:
		edges_map_both[key1] = SortedSet();
		edges_map_both[key1] = edges_map[key1].intersection(edges_map[key2])
		edges_map[key1] = edges_map[key1].difference(edges_map_both[key1])
		edges_map[key2] = edges_map[key2].difference(edges_map_both[key1])

def check_backforth_edge(edges_map,edges_map_both):
	for key, values in edges_map.items():
		for key_nested, values_nested in edges_map.items():
			if key_nested != key:
				compare_keys(key,key_nested,edges_map,edges_map_both)

# def simplify_names(n):
# 	pattern_e = r"e\(\w+,(\w+?)\)"
# 	replace_e = r"e(\1)"
# 	n = re.sub(pattern_e, replace_e, n)
	
# 	t = 0
# 	pattern_w = r"w\(" + str(t) + r",(\d+),__ini\)"
# 	replace_w = r"w(" + str(t) + r":W\1)"
# 	find = re.search(pattern_w, n)
	
# 	while (find):
# 		n = re.sub(pattern_w, replace_w, n)
# 		t = t + 1

# 		pattern_w = r"w\(" + str(t) + r",w\((\d+?):(\w+?)\),e\((\w+?)\)\)"
# 		replace_w = r"w(" + str(t) + r":\2_\1)"
# 		find = re.search(pattern_w, n)
# 	return n

def generate_plan(n):
	plan = ""
	pattern = r"plan\(\d+?,\w+?\)"
	actions = re.findall(pattern, n)

	for action in actions:
		action = re.sub('plan\(', '', action)
		action = re.sub('\)', '', action)
		splitted = re.split(",", action)
		plan = plan + splitted[1] + ", "
	return plan

outputfile = open(sys.argv[1]+'.dot', 'w')
#outputfile_table = open(sys.argv[1]+'_table.dot', 'w')
#print('digraph K_structure{',end="\n", file = outputfile_table)
#print('\trankdir=BT;',end="\n", file = outputfile_table)
#print('\tranksep=0.75',end="\n", file = outputfile_table)
#print('\tnewrank=true;',end="\n", file = outputfile_table)
#print('\tsize="8,5;"',end="\n", file = outputfile_table)

designated = ''
n_designated = re.compile('dw\(\S*\)')
n_world = re.compile('w\(\S*\)')
n_edge = re.compile('r\(\S*\)')
n_holds = re.compile('holds\(\S*\)')
n_atom = re.compile('atom\(\S*\)')

with open(sys.argv[1]+'.txt', 'r') as n:
	n = n.read()
	print('digraph K_structure{',end="\n", file = outputfile)
	print("\tlabelloc=\"t\";", end ="\n", file = outputfile)
	print("\tlabel=\"" + generate_plan(n) + "\";", end ="\n\n", file = outputfile)

	print('\trankdir=BT;',end="\n", file = outputfile)
	print('\tranksep=0.75',end="\n", file = outputfile)
	print('\tnewrank=true;',end="\n", file = outputfile)
	print('\tsize="8,5;"',end="\n", file = outputfile)
	print('\n//WORLDS List:',end="\n", file = outputfile)
	# n = simplify_names(n)

	#DESIGNATED
	designateds = re.findall(n_designated, n)
	for new_designated in designateds:
		designated = last_designated(new_designated,designated)


	#WORLDS
	poss_world = set()
	worlds = re.findall(n_world, n)
	for world in worlds:
		poss_world.add(generate_world(world,designated))

	#RANK
	cluster_map = SortedDict()
	for world in worlds:
		initialize_cluster(world,cluster_map)

	for world in worlds:
		generate_cluster(world,cluster_map)

	counter_cluster = 0
	print("\n//SUBGRAPHS List:", end ="\n", file = outputfile)
	for key,values in cluster_map.items():
		print("\t", end ="", file = outputfile)
		#print(key, end ="")
		#print('{rank = ' + str(counter_rank) + '; ', end ="", file = outputfile)
		print('subgraph cluster_'+str(counter_cluster)+ '{', end ="", file = outputfile)
		for val in values:
			print(val, end ="", file = outputfile)
			if values.index(val) != len(values)-1:
				print('; ', end ="", file = outputfile)
		print('};', file = outputfile)
		counter_cluster+=1

	#RANK
	rank_map = SortedDict()
	for world in worlds:
		initialize_rank(world,rank_map)

	for world in worlds:
		generate_rank(world,rank_map)

	#counter_rank = 0
	print("\n//RANKS List:", end ="\n", file = outputfile)
	for key,values in rank_map.items():
		#counter_rank+=1
		print("\t", end ="", file = outputfile)
		#print(key, end ="")
		#print('{rank = ' + str(counter_rank) + '; ', end ="", file = outputfile)
		print('{rank = same;', end ="", file = outputfile)
		for val in values:
			print(val, end ="", file = outputfile)
			if values.index(val) != len(values)-1:
				print('; ', end ="", file = outputfile)
		print('};', file = outputfile)

	#EDGES
	edges_map = dict()
	edges_map_both = dict()
	edges = re.findall(n_edge, n)
	for edge in edges:
		initialize_edges(edge,edges_map)

	for edge in edges:
		generate_edges(edge,edges_map)

	check_backforth_edge(edges_map,edges_map_both)

	print("\n//EDGES List:", end ="\n", file = outputfile)
	for key,values in edges_map.items():
		if len(values) > 0:
			print("\t", end ="", file = outputfile)
			print(key, end ="", file = outputfile)
			print(' [label="', end ="", file = outputfile)
			for val in values:
				print(val, end ="", file = outputfile)
				if values.index(val) != len(values)-1:
					print(',', end ="", file = outputfile)
			print('"];', file = outputfile)
	for key,values in edges_map_both.items():
		if len(values) > 0:
			print("\t", end ="", file = outputfile)
			print(key, end ="", file = outputfile)
			print(' [dir=both label="', end ="", file = outputfile)
			for val in values:
				print(val, end ="", file = outputfile)
				if values.index(val) != len(values)-1:
					print(',', end ="", file = outputfile)
			print('"];', file = outputfile)

#ATOMS-TABLE

#reading all the ATOMS for complete table
	ATOMS = SortedSet()
	atom_predicates = re.findall(n_atom, n)
	for atom_predicate in atom_predicates:
		atom_predicate = re.sub('^atom\(', '', atom_predicate)
		atom_predicate = re.sub('\)$', '', atom_predicate)
		ATOMS.add(atom_predicate)

#table print
	holds = re.findall(n_holds, n)
	atom_table = SortedDict()
	ft_keys = SortedDict()

	for hold in holds:
		initialize_atom_table(hold, atom_table,ft_keys)

	for hold in holds:
		generate_atom_table(hold, atom_table)

	print('\n//WORLDS description Table:\n\tnode [shape = plain]description[label=<\n\t<table border = "0" cellborder = "1" cellspacing = "0" >', end ="\n", file = outputfile)
	for key,values in atom_table.items(): # \todo: AGGIUNGI CASO IN CUI TUTTI GLI ATOMI SONO FALSE!!!
		if ft_keys[key] in poss_world:
			#counter_rank+=1
			print("\t\t", end ="", file = outputfile)
			#print(key, end ="")
			#print('{rank = ' + str(counter_rank) + '; ', end ="", file = outputfile)
			print('<tr><td>'+ ft_keys[key] + '</td>\t<td>', end ="", file = outputfile)
			for atom in ATOMS:
				if atom in atom_table[key]:
					print('<font color="#0000ff"> '+atom + '</font>', end ="", file = outputfile)
				else:
					print('<font color="#ff1020">-'+atom+"</font>", end ="", file = outputfile)
				if ATOMS.index(atom) != len(ATOMS)-1:
					print(', ', end ="", file = outputfile)
			print('</td></tr>', end ="\n", file = outputfile)
	print('\t</table>>]',end ="\n", file = outputfile)

print('}', file = outputfile)

outputfile.close()
