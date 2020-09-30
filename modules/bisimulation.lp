#program step(t).

% % ********** BISIMULATION ********** (Dovier, ICLP 2015)
% Reflexivity and Symmetry
bis(t, R1, P1, t , R1, P1) :- t > 0, time(t), possible_world(t, R1, P1).
bis(t, R1, P1, T2, R2, P2) :- t > 0, time(t), time(T2), T2 <= t, possible_world(t, R1, P1), possible_world(T2, R2, P2), bis(T2, R2, P2, t, R1, P1).

% Nondeterministic choice
{ bis(t, R1, P1, T2, R2, P2) } :- t > 0, time(t), time(T2), T2 < t, possible_world(t, R1, P1), possible_world(T2, R2, P2).

:- time(t), time(T2), time(T3), time(T4), T2 < t, possible_world(t, R1, P1), possible_world(T2, R2, P2), possible_world(T3, R3, P3),
    bis(t, R1, P1, T2, R2, P2), believes(t, R1, P1, T3, R3, P3, AG), 0 { possible_world(T4, R4, P4) : bis(T3, R3, P3, T4, R4, P4), believes(T2, R2, P2, T4, R4, P4, AG) } 0.

:- time(t), time(T2), T2 < t, possible_world(t, R1, P1), possible_world(T2, R2, P2),
    bis(t, R1, P1, T2, R2, P2), holds(t, R1, P1, F), not holds(T2, R2, P2, F), fluent(F).

% Visited states
:- plan(t, ACT), pointed(t, R1, P1), pointed(T2, R2, P2), T2 < t, bis(t, R1, P1, T2, R2, P2).
