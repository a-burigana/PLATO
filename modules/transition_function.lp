% ********** TRANSITION FUNCTION **********

#program step(t).

%%% Applicability %%%
applicable(t, ACT, de(t, ACT, E)) :- t > 0, time(t), action(ACT), dw(t-1, W, Ew), pre(t, ACT, E, true).
applicable(t, ACT, de(t, ACT, E)) :- t > 0, time(t), action(ACT), dw(t-1, W, Ew), pre(t, ACT, E, Epre), formula(Epre), entails(pw(t-1, W, Ew), Epre).

not_applicable(t, ACT) :- t > 0, time(t), action(ACT), de(t, ACT, E), not applicable(t, ACT, de(t, ACT, E)).
applicable(t, ACT)     :- t > 0, time(t), action(ACT), not not_applicable(t, ACT).

% not_applicable(t, ACT) :- t > 0, time(t), action(ACT), dw(t-1, W, Ew), not applicable(t, ACT, dw(t-1, W, Ew)).


% STEP 1: determine the new designated worlds. The computation of the other worlds begins from the designated worlds
dw(t, pw(t-1, W, Ew), e(t, ACT, E)) :- t > 0, time(t), plan(t, ACT), action(ACT), e(t, ACT, E), pre(t, ACT, E, Fpre),
                                       de(t, ACT, E), dw(t-1, W, Ew), entails(pw(t-1, W, Ew), Fpre).

% STEP 2: determine the new possible worlds
%          - 2.1: a designated world is a possible world
pw(t, pw(t-1, W, Ew), e(t, ACT, E)) :- t > 0, time(t), plan(t, ACT), action(ACT), e(t, ACT, E), dw(t, pw(t-1, W, Ew), E).

%          - 2.2: apply recursive step

% Confronto lo stato a tempo t-1 con l'azione che eseguo a tempo t e guardo le somiglianze nei path
% Caso base: un designated world e un designated event hanno lo stesso path
same_path(pw(t-1, W, Ew), e(t, ACT, E)) :- t > 0, time(t), plan(t, ACT), action(ACT), dw(t-1, W, Ew), de(t, ACT, E).

% Passo induttivo: se W2 e E2 hanno lo stesso path e W2 -AG-> W & E2 -AG-> E, allora W ed E hanno lo stesso path
same_path(pw(t-1, W, Ew), e(t, ACT, E)) :- t > 0, time(t), plan(t, ACT), action(ACT), agent(AG),
                                           pw(t-1, W2, Ew2), e(t, ACT, E2), same_path(pw(t-1, W2, Ew2), e(t, ACT, E2)),
                                           r(pw(t-1, W2, Ew2), pw(t-1, W, Ew), AG), q(e(t, ACT, E2), e(t, ACT, E), AG).


pw(t, pw(t-1, W, Ew), e(t, ACT, E)) :- t > 0, time(t), plan(t, ACT), action(ACT), pre(t, ACT, E, true),
                                       same_path(pw(t-1, W, Ew), e(t, ACT, E)).

pw(t, pw(t-1, W, Ew), e(t, ACT, E)) :- t > 0, time(t), plan(t, ACT), action(ACT), pre(t, ACT, E, Fpre), formula(Fpre),
                                       same_path(pw(t-1, W, Ew), e(t, ACT, E)), entails(pw(t-1, W, Ew), Fpre).

% STEP 3: determine the accessibility relations
r(pw(t, pw(t-1, W, Ew), e(t, ACT, E1)),
  pw(t, pw(t-1, V, Ev), e(t, ACT, E2)), AG) :- t > 0, time(t), plan(t, ACT), action(ACT), agent(AG),
                                               r(pw(t-1, W, Ew), pw(t-1, V, Ev), AG), q(e(t, ACT, E1), e(t, ACT, E2), AG).


% STEP 4: determine the interpretation of the worlds
holds (pw(t, W, e(t, ACT, E)), P) :- t > 0, time(t), plan(t, ACT), action(ACT), atom(P), pw(t, W, e(t, ACT, E)), post(t, ACT, E,  P, true).
-holds(pw(t, W, e(t, ACT, E)), P) :- t > 0, time(t), plan(t, ACT), action(ACT), atom(P), pw(t, W, e(t, ACT, E)), post(t, ACT, E, -P, true).

% Postcondition is satisfied
holds (pw(t, pw(t-1, W, Ew), e(t, ACT, E)), P) :- t > 0, time(t), plan(t, ACT), action(ACT), atom(P), post(t, ACT, E,  P, Fpost),
                                                  entails(pw(t-1, W, Ew), Fpost), formula(Fpost), not atom(Fpost).

-holds(pw(t, pw(t-1, W, Ew), e(t, ACT, E)), P) :- t > 0, time(t), plan(t, ACT), action(ACT), atom(P), post(t, ACT, E, -P, Fpost),
                                                  entails(pw(t-1, W, Ew), Fpost), formula(Fpost), not atom(Fpost).

% Postcondition is not satisfied
holds (pw(t, pw(t-1, W, Ew), e(t, ACT, E)), P) :- t > 0, time(t), plan(t, ACT), action(ACT), atom(P), post(t, ACT, E,  P, Fpost),
                                                  not entails(pw(t-1, W, Ew), Fpost), not atom(Fpost), formula(Fpost),  holds(pw(t-1, W, Ew), P).

-holds(pw(t, pw(t-1, W, Ew), e(t, ACT, E)), P) :- t > 0, time(t), plan(t, ACT), action(ACT), atom(P), post(t, ACT, E, -P, Fpost),
                                                  not entails(pw(t-1, W, Ew), Fpost), not atom(Fpost), formula(Fpost), -holds(pw(t-1, W, Ew), P).

% Inertia
holds (pw(t, pw(t-1, W, Ew), e(t, ACT, E)), P) :- t > 0, time(t), plan(t, ACT), action(ACT), atom(P), post(t, ACT, E, P, P),  holds(pw(t-1, W, Ew), P).
-holds(pw(t, pw(t-1, W, Ew), e(t, ACT, E)), P) :- t > 0, time(t), plan(t, ACT), action(ACT), atom(P), post(t, ACT, E, P, P), -holds(pw(t-1, W, Ew), P).
