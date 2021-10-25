% ********** TRANSITION FUNCTION **********

#program step(t).

%%% Applicability %%%
applicable(e(t, ACT, E)) :- e(t, ACT, E), de(t, ACT, E), pre(t, ACT, E, true).
applicable(e(t, ACT, E)) :- e(t, ACT, E), de(t, ACT, E), w(t, W, Ew), dw(t, W, Ew),
                            pre(t, ACT, E, Fpre), formula(Fpre), entails(w(t, W, Ew), Fpre).

not_applicable(t, ACT) :- time(t), plan(t, ACT), action(ACT), e(t, ACT, E), de(t, ACT, E), not applicable(e(t, ACT, E)).
applicable(t, ACT)     :- time(t), plan(t, ACT), action(ACT), not not_applicable(t, ACT).


% STEP 1: determine the new designated worlds. The computation of the other worlds begins from the designated worlds
dw(t+1, w(t, W, Ew), e(t, ACT, E)) :- time(t), plan(t, ACT), action(ACT),
                                      w(t, W, Ew), e(t, ACT, E), pre(t, ACT, E, true),
                                      dw(t, W, Ew), de(t, ACT, E).

dw(t+1, w(t, W, Ew), e(t, ACT, E)) :- time(t), plan(t, ACT), action(ACT),
                                      w(t, W, Ew), e(t, ACT, E), pre(t, ACT, E, Fpre),
                                      dw(t, W, Ew), de(t, ACT, E), entails(w(t, W, Ew), Fpre).

% STEP 2: determine the new possible worlds
%          - 2.1: a designated world is a possible world
w(t+1, w(t, W, Ew), e(t, ACT, E)) :- time(t), plan(t, ACT), action(ACT),
                                     w(t, W, Ew), e(t, ACT, E), dw(t, W, Ew), de(t, ACT, E),
                                     dw(t, w(t, W, Ew), e(t, ACT, E)).

%          - 2.2: apply recursive step

% Confronto lo stato a tempo t-1 con l'azione che eseguo a tempo t e guardo le somiglianze nei path
% Caso base: un designated world e un designated event hanno lo stesso path
same_path(w(t, W, Ew), e(t, ACT, E)) :- time(t), plan(t, ACT), action(ACT),
                                        w(t, W, Ew), e(t, ACT, E), dw(t, W, Ew), de(t, ACT, E).

% Passo induttivo: se W2 e E2 hanno lo stesso path e W2 -AG-> W & E2 -AG-> E, allora W ed E hanno lo stesso path
same_path(w(t, W, Ew), e(t, ACT, E)) :- time(t), plan(t, ACT), action(ACT), agent(AG),
                                        w(t, W, Ew), e(t, ACT, E), w(t, W2, Ew2), e(t, ACT, E2),
                                        same_path(w(t, W2, Ew2), e(t, ACT, E2)),
                                        r(w(t, W2, Ew2), w(t, W, Ew), AG), q(e(t, ACT, E2), e(t, ACT, E), AG).

w(t+1, w(t, W, Ew), e(t, ACT, E)) :- time(t), plan(t, ACT), action(ACT), check_conditions(ACT, check_everywhere),
                                     w(t, W, Ew), e(t, ACT, E), pre(t, ACT, E, true),
                                     same_path(w(t, W, Ew), e(t, ACT, E)).

w(t+1, w(t, W, Ew), e(t, ACT, E)) :- time(t), plan(t, ACT), action(ACT), check_conditions(ACT, check_everywhere),
                                     w(t, W, Ew), e(t, ACT, E), pre(t, ACT, E, Fpre), formula(Fpre),
                                     same_path(w(t, W, Ew), e(t, ACT, E)), entails(w(t, W, Ew), Fpre).

w(t+1, w(t, W, Ew), e(t, ACT, E)) :- time(t), plan(t, ACT), action(ACT), check_conditions(ACT, check_on_designated),
                                     w(t, W, Ew), e(t, ACT, E),
                                     same_path(w(t, W, Ew), e(t, ACT, E)).

% STEP 3: determine the accessibility relations
r(w(t+1, w(t, W, Ew), e(t, ACT, E1)),
  w(t+1, w(t, V, Ev), e(t, ACT, E2)), AG) :- time(t), plan(t, ACT), action(ACT), agent(AG),
                                             w(t, W, Ew), e(t, ACT, E1), w(t, V, Ev), e(t, ACT, E2),
                                             w(t+1, w(t, W, Ew), e(t, ACT, E1)), w(t+1, w(t, V, Ev), e(t, ACT, E2)),
                                             r(w(t, W, Ew), w(t, V, Ev), AG), q(e(t, ACT, E1), e(t, ACT, E2), AG).


% STEP 4: determine the interpretation of the worlds
holds (w(t+1, w(t, W, Ew), e(t, ACT, E)), P) :- time(t), plan(t, ACT), action(ACT), atom(P), w(t+1, w(t, W, Ew), e(t, ACT, E)), post(t, ACT, E,  P, true).
-holds(w(t+1, w(t, W, Ew), e(t, ACT, E)), P) :- time(t), plan(t, ACT), action(ACT), atom(P), w(t+1, w(t, W, Ew), e(t, ACT, E)), post(t, ACT, E, -P, true).

% Postcondition is satisfied
holds (w(t+1, w(t, W, Ew), e(t, ACT, E)), P) :- time(t), plan(t, ACT), action(ACT), atom(P), post(t, ACT, E,  P, Fpost),
                                                entails(w(t, W, Ew), Fpost), formula(Fpost), not atom(Fpost),
                                                w(t+1, w(t, W, Ew), e(t, ACT, E)).

-holds(w(t+1, w(t, W, Ew), e(t, ACT, E)), P) :- time(t), plan(t, ACT), action(ACT), atom(P), post(t, ACT, E, -P, Fpost),
                                                entails(w(t, W, Ew), Fpost), formula(Fpost), not atom(Fpost),
                                                w(t+1, w(t, W, Ew), e(t, ACT, E)).

% Postcondition is not satisfied
holds (w(t+1, w(t, W, Ew), e(t, ACT, E)), P) :- time(t), plan(t, ACT), action(ACT), atom(P), post(t, ACT, E,  P, Fpost),
                                                not entails(w(t, W, Ew), Fpost), not atom(Fpost), formula(Fpost),  holds(w(t, W, Ew), P),
                                                w(t+1, w(t, W, Ew), e(t, ACT, E)).

-holds(w(t+1, w(t, W, Ew), e(t, ACT, E)), P) :- time(t), plan(t, ACT), action(ACT), atom(P), post(t, ACT, E, -P, Fpost),
                                                not entails(w(t, W, Ew), Fpost), not atom(Fpost), formula(Fpost), -holds(w(t, W, Ew), P),
                                                w(t+1, w(t, W, Ew), e(t, ACT, E)).

% Inertia
holds (w(t+1, w(t, W, Ew), e(t, ACT, E)), P) :- time(t), plan(t, ACT), action(ACT), atom(P), post(t, ACT, E, P, P),
                                                 holds(w(t, W, Ew), P), w(t+1, w(t, W, Ew), e(t, ACT, E)).
-holds(w(t+1, w(t, W, Ew), e(t, ACT, E)), P) :- time(t), plan(t, ACT), action(ACT), atom(P), post(t, ACT, E, P, P),
                                                -holds(w(t, W, Ew), P), w(t+1, w(t, W, Ew), e(t, ACT, E)).

% \todo: check correctness of holds
% \todo: metti caso con Fpost = -P, atom(P).