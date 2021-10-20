% ********** TRANSITION FUNCTION **********

#program step(t).

%%% Applicability %%%
applicable(e(t, ACT, E)) :- e(t, ACT, E), de(t, ACT, E), pre(t, ACT, E, true).
applicable(e(t, ACT, E)) :- e(t, ACT, E), de(t, ACT, E), w(t-1, W, Ew), dw(t-1, W, Ew),
                            pre(t, ACT, E, Fpre), formula(Fpre), entails(w(t-1, W, Ew), Fpre).

not_applicable(t, ACT) :- t > 0, time(t), plan(t, ACT), action(ACT), e(t, ACT, E), de(t, ACT, E), not applicable(e(t, ACT, E)).
applicable(t, ACT)     :- t > 0, time(t), plan(t, ACT), action(ACT), not not_applicable(t, ACT).

% check_on_w(w(t-1, W, Ew), Fpre) :- t > 0, time(t), plan(t, ACT), action(ACT), w(t-1, W, Ew), dw(t-1, W, Ew),
%                                    e(t, ACT, E), de(t, ACT, E), pre(t, ACT, E, Fpre), formula(Fpre).

% #show pre/4.
% #show de/3.
% #show check_on_w/2.
% #show same_path/2.
% #show q/3.
% \todo: controlla applicability!!!!!!!!!!!!!!!!!!!!




% not_applicable(t, ACT) :- t > 0, time(t), action(ACT), dw(t-1, W, Ew), not applicable(t, ACT, dw(t-1, W, Ew)).


% STEP 1: determine the new designated worlds. The computation of the other worlds begins from the designated worlds
dw(t, w(t-1, W, Ew), e(t, ACT, E)) :- t > 0, time(t), plan(t, ACT), action(ACT),
                                      w(t-1, W, Ew), e(t, ACT, E), pre(t, ACT, E, true),
                                      dw(t-1, W, Ew), de(t, ACT, E).

dw(t, w(t-1, W, Ew), e(t, ACT, E)) :- t > 0, time(t), plan(t, ACT), action(ACT),
                                      w(t-1, W, Ew), e(t, ACT, E), pre(t, ACT, E, Fpre),
                                      dw(t-1, W, Ew), de(t, ACT, E), entails(w(t-1, W, Ew), Fpre).

% STEP 2: determine the new possible worlds
%          - 2.1: a designated world is a possible world
w(t, w(t-1, W, Ew), e(t, ACT, E)) :- t > 0, time(t), plan(t, ACT), action(ACT),
                                     w(t-1, W, Ew), e(t, ACT, E), dw(t-1, W, Ew), de(t, ACT, E),
                                     dw(t, w(t-1, W, Ew), e(t, ACT, E)).

%          - 2.2: apply recursive step

% Confronto lo stato a tempo t-1 con l'azione che eseguo a tempo t e guardo le somiglianze nei path
% Caso base: un designated world e un designated event hanno lo stesso path
same_path(w(t-1, W, Ew), e(t, ACT, E)) :- t > 0, time(t), plan(t, ACT), action(ACT),
                                          w(t-1, W, Ew), e(t, ACT, E), dw(t-1, W, Ew), de(t, ACT, E).

% Passo induttivo: se W2 e E2 hanno lo stesso path e W2 -AG-> W & E2 -AG-> E, allora W ed E hanno lo stesso path
same_path(w(t-1, W, Ew), e(t, ACT, E)) :- t > 0, time(t), plan(t, ACT), action(ACT), agent(AG),
                                          w(t-1, W, Ew), e(t, ACT, E), w(t-1, W2, Ew2), e(t, ACT, E2),
                                          same_path(w(t-1, W2, Ew2), e(t, ACT, E2)),
                                          r(w(t-1, W2, Ew2), w(t-1, W, Ew), AG), q(e(t, ACT, E2), e(t, ACT, E), AG).

w(t, w(t-1, W, Ew), e(t, ACT, E)) :- t > 0, time(t), plan(t, ACT), action(ACT),
                                     w(t-1, W, Ew), e(t, ACT, E), pre(t, ACT, E, true),
                                     same_path(w(t-1, W, Ew), e(t, ACT, E)).

w(t, w(t-1, W, Ew), e(t, ACT, E)) :- t > 0, time(t), plan(t, ACT), action(ACT),
                                     w(t-1, W, Ew), e(t, ACT, E), pre(t, ACT, E, Fpre), formula(Fpre),
                                     same_path(w(t-1, W, Ew), e(t, ACT, E)), entails(w(t-1, W, Ew), Fpre).

% STEP 3: determine the accessibility relations
r(w(t, w(t-1, W, Ew), e(t, ACT, E1)),
  w(t, w(t-1, V, Ev), e(t, ACT, E2)), AG) :- t > 0, time(t), plan(t, ACT), action(ACT), agent(AG),
                                             w(t-1, W, Ew), e(t, ACT, E1), w(t-1, V, Ev), e(t, ACT, E2),
                                             w(t, w(t-1, W, Ew), e(t, ACT, E1)), w(t, w(t-1, V, Ev), e(t, ACT, E2)),
                                             r(w(t-1, W, Ew), w(t-1, V, Ev), AG), q(e(t, ACT, E1), e(t, ACT, E2), AG).


% STEP 4: determine the interpretation of the worlds
holds (w(t, W, e(t, ACT, E)), P) :- t > 0, time(t), plan(t, ACT), action(ACT), atom(P), w(t, W, e(t, ACT, E)), post(t, ACT, E,  P, true).
-holds(w(t, W, e(t, ACT, E)), P) :- t > 0, time(t), plan(t, ACT), action(ACT), atom(P), w(t, W, e(t, ACT, E)), post(t, ACT, E, -P, true).

% Postcondition is satisfied
holds (w(t, w(t-1, W, Ew), e(t, ACT, E)), P) :- t > 0, time(t), plan(t, ACT), action(ACT), atom(P), post(t, ACT, E,  P, Fpost),
                                                entails(w(t-1, W, Ew), Fpost), formula(Fpost), not atom(Fpost),
                                                w(t, w(t-1, W, Ew), e(t, ACT, E)).

-holds(w(t, w(t-1, W, Ew), e(t, ACT, E)), P) :- t > 0, time(t), plan(t, ACT), action(ACT), atom(P), post(t, ACT, E, -P, Fpost),
                                                entails(w(t-1, W, Ew), Fpost), formula(Fpost), not atom(Fpost),
                                                w(t, w(t-1, W, Ew), e(t, ACT, E)).

% Postcondition is not satisfied
holds (w(t, w(t-1, W, Ew), e(t, ACT, E)), P) :- t > 0, time(t), plan(t, ACT), action(ACT), atom(P), post(t, ACT, E,  P, Fpost),
                                                not entails(w(t-1, W, Ew), Fpost), not atom(Fpost), formula(Fpost),  holds(w(t-1, W, Ew), P),
                                                w(t, w(t-1, W, Ew), e(t, ACT, E)).

-holds(w(t, w(t-1, W, Ew), e(t, ACT, E)), P) :- t > 0, time(t), plan(t, ACT), action(ACT), atom(P), post(t, ACT, E, -P, Fpost),
                                                not entails(w(t-1, W, Ew), Fpost), not atom(Fpost), formula(Fpost), -holds(w(t-1, W, Ew), P),
                                                w(t, w(t-1, W, Ew), e(t, ACT, E)).

% Inertia
holds (w(t, w(t-1, W, Ew), e(t, ACT, E)), P) :- t > 0, time(t), plan(t, ACT), action(ACT), atom(P), post(t, ACT, E, P, P),
                                                 holds(w(t-1, W, Ew), P), w(t, w(t-1, W, Ew), e(t, ACT, E)).
-holds(w(t, w(t-1, W, Ew), e(t, ACT, E)), P) :- t > 0, time(t), plan(t, ACT), action(ACT), atom(P), post(t, ACT, E, P, P),
                                                -holds(w(t-1, W, Ew), P), w(t, w(t-1, W, Ew), e(t, ACT, E)).
