% *** GOALS ***
goal(box(a,at_box1_room1)).
goal(box(b,at_box1_room1)).
goal(box(a,at_box2_room3)).
goal(box(b,at_box2_room3)).
goal(box(a,neg(box(b,at_box2_room3)))).
goal(box(b,neg(box(a,at_box2_room3)))).
goal(box(a,neg(box(b,at_box1_room1)))).
goal(box(b,neg(box(a,at_box1_room1)))).
goal(box(a,at_a_room3)).
goal(box(b,at_a_room3)).
