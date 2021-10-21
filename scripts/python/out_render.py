#!/usr/bin/python

#execution example: "python3 out_reader.py output" --- rember not to put the txt extension, is considered like that as default
#after that run "dot -Tpng output.dot >> output.png" or "dot -Tpdf output.dot >> output.pdf"

import sys
import re
from collections import defaultdict
from sortedcontainers import SortedSet, SortedDict


# def remove_phi(string):
# 	replaced = re.sub('phi\(', 'p', string)
# 	replaced = re.sub('\)', '', replaced)
# 	return replaced

def generate_designated(new_designated):
	new_designated = re.sub('^dw\(', '', new_designated)
	new_designated = re.sub('\)$', '', new_designated)
	# new_designated = remove_phi(new_designated)
	return new_designated

def last_designated(new_designated,designated):
	new_designated = generate_designated(new_designated)
	np_splitted = new_designated.split(',')
	p_splitted = designated.split(',')
	if np_splitted[0] >= p_splitted[0]:
		return new_designated
	else:
		return designated

def generate_world_key(world):
	replaced = re.sub(' w\(', '', world)
	replaced = re.sub('\)$', '', replaced)
	# no_phi = remove_phi(replaced)
	return replaced

def generate_world(world, designated):
	key = generate_world_key(world)
	# splitted = no_phi.split(',')
	# key = splitted[0] + '_' + splitted[1] + '_' + splitted[2];
	if (key) != designated:
		print('\tnode [shape = circle] "' + key + '";', file = outputfile)
	else:
		print('\tnode [shape = doublecircle] "' + key + '";', file = outputfile)
	return key

def initialize_rank(world, rank_map):
	key = generate_world_key(world)
	if (re.search('_', key)):
		splitted = re.split('_', key, 1)
		rank_map[splitted[1]] = SortedSet()
	else:
		rank_map[''] = SortedSet()

def generate_rank(world, rank_map):
	key = generate_world_key(world)
	if (re.search('_', key)):
		splitted = re.split('_', key, 1)
		rank_map[splitted[1]].add('"' + key + '"')
	else:
		rank_map[''].add('"' + key + '"')

def generate_hold_key(hold):
	replaced = re.sub('^holds\(', '', hold)
	replaced = re.sub('\)$', '', replaced)
	# no_phi = remove_phi(replaced)
	return replaced

def initialize_atom_table(hold, atom_table, key_table):
	hold_key = generate_hold_key(hold)
	subbed = re.sub(r"w\((\w+?)\)", r"\1", hold_key)
	splitted = subbed.split(',')
	atom_table[splitted[0]] = SortedSet()
	key_table[splitted[0]] = splitted[0]

def generate_atom_table(hold, atom_table):
	hold_key = generate_hold_key(hold)
	subbed = re.sub(r"w\((\w+?)\)", r"\1", hold_key)
	splitted = subbed.split(',')
	atom_table[splitted[0]].add(splitted[1])


def initialize_cluster(world, cluster_map):
	key = generate_world_key(world)
	subbed = re.sub("[^_]", "", key)
	cluster_map[subbed] = SortedSet()

def generate_cluster(world, cluster_map):
	key = generate_world_key(world)
	subbed = re.sub("[^_]", "", key)
	cluster_map[subbed].add('"' + key + '"')

def generate_edge_key(edge):
	replaced = re.sub('^r\(', '', edge)
	replaced1 = re.sub('\)$', '', replaced)
	# no_phi = remove_phi(replaced1)
	return replaced1

def initialize_edges(edge, edges_map):
	key = generate_edge_key(edge)
	subbed = re.sub(r"w\((\w+?)\)", r"\1", key)
	splitted = subbed.split(',')
	edges_map['"' + splitted[0] + '"' + ' -> ' + '"' + splitted[1] + '"'] = SortedSet()

def generate_edges(edge,edges_map):
	key = generate_edge_key(edge)
	subbed = re.sub(r"w\((\w+?)\)", r"\1", key)
	splitted = subbed.split(',')
	edges_map['"' + splitted[0] + '"' + ' -> ' + '"' + splitted[1] + '"'].add(splitted[2])

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

def simplify_names(n):
	t = 0
	pattern_w = r"w\(" + str(t) + r",(\d+),__ini\)"
	replace_w = r"w(W\1)"
	find = re.search(pattern_w, n)
	
	while (find):
		n = re.sub(pattern_w, replace_w, n)
		t = t + 1

		pattern_e = r"e\(" + str(t) + r",\w+?,(\w+?)\)"
		replace_e = r"e(\1)"
		n = re.sub(pattern_e, replace_e, n)

		pattern_w = r"w\(" + str(t) + r",w\((\w+?)\),e\((\w+?)\)\)"
		replace_w = r"w(\1_\2)"
		find = re.search(pattern_w, n)
	return n

outputfile = open(sys.argv[1]+'.dot', 'w')
#outputfile_table = open(sys.argv[1]+'_table.dot', 'w')
#print('digraph K_structure{',end="\n", file = outputfile_table)
#print('\trankdir=BT;',end="\n", file = outputfile_table)
#print('\tranksep=0.75',end="\n", file = outputfile_table)
#print('\tnewrank=true;',end="\n", file = outputfile_table)
#print('\tsize="8,5;"',end="\n", file = outputfile_table)


designated = '0,2,__ini'	# \todo: CHECK
n_designated = re.compile('dw\(\S*\)')
n_world = re.compile('\sw\(\S*\)')
n_edge = re.compile('r\(\S*\)')
n_holds = re.compile('holds\(\S*\)')
n_atom = re.compile('atom\(\S*\)')


print('digraph K_structure{',end="\n", file = outputfile)
print('\trankdir=BT;',end="\n", file = outputfile)
print('\tranksep=0.75',end="\n", file = outputfile)
print('\tnewrank=true;',end="\n", file = outputfile)
print('\tsize="8,5;"',end="\n", file = outputfile)
print('\n//WORLDS List:',end="\n", file = outputfile)

with open(sys.argv[1]+'.txt', 'r') as n:
	n = n.read()
	n = simplify_names(n)

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
	for key,values in atom_table.items():
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
