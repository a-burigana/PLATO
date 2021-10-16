% ********** TRANSITION FUNCTION **********

#program step(t).

%%% Applicability %%%
applicable(t, ACT, de(ACT, E)) :- t > 0, time(t), action(ACT), dw(t-1, W, Ew), pre(E, true).
applicable(t, ACT, de(ACT, E)) :- t > 0, time(t), action(ACT), dw(t-1, W, Ew), pre(E, Epre), formula(Epre), entails(pw(t-1, W, Ew), Epre).

not_applicable(t, ACT) :- t > 0, time(t), action(ACT), de(ACT, E), not applicable(t, ACT, de(ACT, E)).
applicable(t, ACT)     :- t > 0, time(t), action(ACT), not not_applicable(t, ACT).

not_applicable(t, ACT) :- t > 0, time(t), action(ACT), dw(t-1, W, Ew), not_applicable(t, ACT, dw(t-1, W, Ew)).
% STEP 1: determine the new designated worlds. The computation of the other worlds begins from the designated worlds
dw(t, pw(t-1, W, Ew), E) :- t > 0, time(t), plan(t, ACT), action(ACT), event(ACT, E), pre(E, Fpre),
                            de(ACT, E), dw(t-1, W, Ew), entails(pw(t-1, W, Ew), Fpre).

% STEP 2: determine the new possible worlds
%          - 2.1: a designated world is a possible world
pw(t, pw(t-1, W, Ew), E) :- t > 0, time(t), plan(t, ACT), action(ACT), event(ACT, E), dw(t, pw(t-1, W, Ew), E).

%          - 2.2: apply recursive step

% Confronto lo stato a tempo t-1 con l'azione che eseguo a tempo t e guardo le somiglianze nei path
% Caso base: un designated world e un designated event hanno lo stesso path
same_path(pw(t-1, W, Ew), E) :- t > 0, time(t), plan(t, ACT), action(ACT), event(ACT, E),
                                de(ACT, E), dw(t-1, W, Ew).

% Passo induttivo: se W2 e E2 hanno lo stesso path e W2 -AG-> W & E2 -AG-> E, allora W ed E hanno lo stesso path
same_path(pw(t-1, W, Ew), E) :- t > 0, time(t), plan(t, ACT), action(ACT), event(ACT, E), event(ACT, E2),
                                pw(t-1, W2, Ew2), same_path(pw(t-1, W2, Ew2), E2),
                                r(pw(t-1, W2, Ew2), pw(t-1, W, Ew), AG), q(E2, E, AG), agent(AG).


pw(t, pw(t-1, W, Ew), E) :- t > 0, time(t), plan(t, ACT), action(ACT), event(ACT, E), pre(E, Fpre),
                            same_path(pw(t-1, W, Ew), E), entails(pw(t-1, W, Ew), Fpre).

% STEP 3: determine the accessibility relations
r(pw(t, pw(t-1, W, Ew), E),
  pw(t, pw(t-1, V, Ev), F), AG) :- t > 0, time(t), plan(t, ACT), action(ACT), event(ACT, E), event(ACT, F),
                                   r(pw(t-1, W, Ew), pw(t-1, V, Ev), AG), q(E, F, AG), agent(AG). 


% STEP 4: determine the interpretation of the worlds
holds(pw(t, pw(t-1, W, Ew), E), P) :- t > 0, time(t), plan(t, ACT), action(ACT), event(ACT, E), atom(P),
                                      pw(t, pw(t-1, W, Ew), E), post(E, P, true).

-holds(pw(t, pw(t-1, W, Ew), E), P) :- t > 0, time(t), plan(t, ACT), action(ACT), event(ACT, E), atom(P),
                                      pw(t, pw(t-1, W, Ew), E), post(E, P, false).

holds(pw(t, pw(t-1, W, Ew), E), P) :- t > 0, time(t), plan(t, ACT), action(ACT), event(ACT, E), atom(P),
                                      pw(t, pw(t-1, W, Ew), E), post(E, P, Fpost), formula(Fpost), entails(pw(t-1, W, Ew), Fpost).
