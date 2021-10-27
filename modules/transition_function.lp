% ********** TRANSITION FUNCTION **********

#program step(t).

%%% Applicability %%%
applicable_event(t, e(ACT, E)) :- time(t), action(ACT), e(ACT, E), de(ACT, E), pre(ACT, E, true).
applicable_event(t, e(ACT, E)) :- time(t), action(ACT), e(ACT, E), de(ACT, E), w(t, W, Ew), dw(t, W, Ew),
                                  pre(ACT, E, Fpre), formula(Fpre), entails(w(t, W, Ew), Fpre).

not_applicable(t, ACT) :- time(t), action(ACT), e(ACT, E), de(ACT, E), not applicable_event(t, e(ACT, E)).
applicable(t, ACT)     :- time(t), action(ACT), not not_applicable(t, ACT).


% STEP 1: determine the new designated worlds. The computation of the other worlds begins from the designated worlds
% Important: we assume that the designate event is *not* null
dw(t+1, w(t, W, Ew), e(ACT, E)) :- time(t), plan(t, ACT), action(ACT),
                                   w(t, W, Ew), e(ACT, E), pre(ACT, E, true),
                                   dw(t, W, Ew), de(ACT, E).

dw(t+1, w(t, W, Ew), e(ACT, E)) :- time(t), plan(t, ACT), action(ACT),
                                   w(t, W, Ew), e(ACT, E), pre(ACT, E, Fpre),
                                   dw(t, W, Ew), de(ACT, E), entails(w(t, W, Ew), Fpre).

% STEP 2: determine the new possible worlds
%          - 2.1: a designated world is a possible world
w(t+1, w(t, W, Ew), e(ACT, E)) :- time(t), plan(t, ACT), action(ACT), not ne(ACT, E),
                                  w(t, W, Ew), e(ACT, E), dw(t, W, Ew), de(ACT, E),
                                  dw(t+1, w(t, W, Ew), e(ACT, E)).

%          - 2.2: apply recursive step

% Confronto lo stato a tempo t-1 con l'azione che eseguo a tempo t e guardo le somiglianze nei path
% Caso base: un designated world e un designated event hanno lo stesso path
same_path(t, w(t, W, Ew), e(ACT, E)) :- time(t), plan(t, ACT), action(ACT),
                                        w(t, W, Ew), e(ACT, E), dw(t, W, Ew), de(ACT, E).

% Passo induttivo: se W2 e E2 hanno lo stesso path e W2 -AG-> W & E2 -AG-> E, allora W ed E hanno lo stesso path
% same_path(t, w(T, W, Ew), e(ACT, E)) :- time(t), time(T), T <= t, plan(t, ACT), action(ACT), agent(AG),
%                                         w(T, W, Ew), e(ACT, E), w(t, W2, Ew2), e(ACT, E2),
%                                         same_path(t, w(t, W2, Ew2), e(ACT, E2)),
%                                         r(w(t, W2, Ew2), w(T, W, Ew), AG), q(t, e(ACT, E2), e(ACT, E), AG).


w(t+1, w(t, W, Ew), e(ACT, E)) :- time(t), plan(t, ACT), action(ACT), check_conditions(ACT, check_everywhere),
                                  w(t, W, Ew), e(ACT, E), not ne(ACT, E), pre(ACT, E, true),
                                  same_path(t, w(t, W, Ew), e(ACT, E)).

w(t+1, w(t, W, Ew), e(ACT, E)) :- time(t), plan(t, ACT), action(ACT), check_conditions(ACT, check_everywhere),
                                  w(t, W, Ew), e(ACT, E), not ne(ACT, E), pre(ACT, E, Fpre), formula(Fpre),
                                  same_path(t, w(t, W, Ew), e(ACT, E)), entails(w(t, W, Ew), Fpre).

w(t+1, w(t, W, Ew), e(ACT, E)) :- time(t), plan(t, ACT), action(ACT), check_conditions(ACT, check_on_designated),
                                  w(t, W, Ew), e(ACT, E), not ne(ACT, E),
                                  same_path(t, w(t, W, Ew), e(ACT, E)).

w(t+1, w(T, W, Ew), e(ACT, E)) :- time(t), time(T), T <= t, plan(t, ACT), action(ACT), check_conditions(ACT, check_on_designated),
                                  w(T, W, Ew), e(ACT, E), not ne(ACT, E),
                                  same_path(t, w(T, W, Ew), e(ACT, E)).


% STEP 3: determine the accessibility relations
% r(w(t+1, w(Tw, W, Ew), e(ACT, E1)),
%   w(t+1, w(Tv, V, Ev), e(ACT, E2)), AG) :- time(t), time(Tw), time(Tv), Tw <= t, Tv <= t, plan(t, ACT), action(ACT), agent(AG),
%                                            w(Tw, W, Ew), w(Tv, V, Ev), e(ACT, E1), e(ACT, E2), not ne(ACT, E1), not ne(ACT, E2),
%                                            w(t+1, w(Tw, W, Ew), e(ACT, E1)), w(t+1, w(Tv, V, Ev), e(ACT, E2)),
%                                            r(w(Tw, W, Ew), w(Tv, V, Ev), AG), q(t, e(ACT, E1), e(ACT, E2), AG).

% r(w(t+1, w(Tw, W, Ew), e(ACT, E1)),
%   w(Tv , V           , Ev        ), AG) :- time(t), time(Tw), time(Tv), Tw <= t, Tv <= t, plan(t, ACT), action(ACT), agent(AG),
%                                            w(Tw, W, Ew), w(Tv, V, Ev), e(ACT, E1), not ne(ACT, E1),
%                                            e(ACT, E2), ne(ACT, E2), same_path(t, w(Tv, V, Ev), e(ACT, E2)),
%                                            w(t+1, w(Tw, W, Ew), e(ACT, E1)),
%                                            r(w(Tw, W, Ew), w(Tv, V, Ev), AG), q(t, e(ACT, E1), e(ACT, E2), AG).


% STEP 4: determine the interpretation of the worlds
    holds(w(t+1, w(T, W, Ew), e(ACT, E)), P) :- time(t), time(T), T <= t, plan(t, ACT), action(ACT), ontic(ACT), e(ACT, E), atom(P),
                                                w(t+1, w(T, W, Ew), e(ACT, E)), post(ACT, E,  P, true).

-holds(w(t+1, w(T, W, Ew), e(ACT, E)), P) :- time(t), time(T), T <= t, plan(t, ACT), action(ACT), ontic(ACT), e(ACT, E), atom(P),
                                                w(t+1, w(T, W, Ew), e(ACT, E)), post(ACT, E, -P, true).

% Postcondition is satisfied
    holds(w(t+1, w(T, W, Ew), e(ACT, E)), P) :- time(t), time(T), T <= t, plan(t, ACT), action(ACT), ontic(ACT), e(ACT, E), atom(P), post(ACT, E,  P, Fpost),
                                                entails(w(T, W, Ew), Fpost), formula(Fpost),
                                                w(t+1, w(T, W, Ew), e(ACT, E)).

-holds(w(t+1, w(T, W, Ew), e(ACT, E)), P) :- time(t), time(T), T <= t, plan(t, ACT), action(ACT), ontic(ACT), e(ACT, E), atom(P), post(ACT, E, -P, Fpost),
                                                entails(w(T, W, Ew), Fpost), formula(Fpost),
                                                w(t+1, w(T, W, Ew), e(ACT, E)).

% Postcondition is not satisfied
    holds(w(t+1, w(T, W, Ew), e(ACT, E)), P) :- time(t), time(T), T <= t, plan(t, ACT), action(ACT), ontic(ACT), e(ACT, E), atom(P), post(ACT, E,  P, Fpost),
                                                not entails(w(T, W, Ew), Fpost), formula(Fpost),     holds(w(T, W, Ew), P),
                                                w(t+1, w(T, W, Ew), e(ACT, E)).

-holds(w(t+1, w(T, W, Ew), e(ACT, E)), P) :- time(t), time(T), T <= t, plan(t, ACT), action(ACT), ontic(ACT), e(ACT, E), atom(P), post(ACT, E, -P, Fpost),
                                                not entails(w(T, W, Ew), Fpost), formula(Fpost), -holds(w(T, W, Ew), P),
                                                w(t+1, w(T, W, Ew), e(ACT, E)).

% Inertia in ontic actions
    holds(w(t+1, w(T, W, Ew), e(ACT, E)), P) :- time(t), time(T), T <= t, plan(t, ACT), action(ACT), ontic(ACT), e(ACT, E), atom(P), not post(ACT, E,  P, _),
                                                holds(w(T, W, Ew), P), w(t+1, w(T, W, Ew), e(ACT, E)).

% Event with no postconditions in ontic action
    holds(w(t+1, w(T, W, Ew), e(ACT, E)), P) :- time(t), time(T), T <= t, plan(t, ACT), action(ACT), ontic(ACT), e(ACT, E), atom(P), no_post(ACT, E),
                                                holds(w(T, W, Ew), P), w(t+1, w(T, W, Ew), e(ACT, E)).
-holds(w(t+1, w(T, W, Ew), e(ACT, E)), P) :- time(t), time(T), T <= t, plan(t, ACT), action(ACT), ontic(ACT), e(ACT, E), atom(P), no_post(ACT, E),
                                                -holds(w(T, W, Ew), P), w(t+1, w(T, W, Ew), e(ACT, E)).

% Epistemic actions
    holds(w(t+1, w(T, W, Ew), e(ACT, E)), P) :- time(t), time(T), T <= t, plan(t, ACT), action(ACT), epistemic(ACT), e(ACT, E), atom(P),
                                                holds(w(T, W, Ew), P), w(t+1, w(T, W, Ew), e(ACT, E)).
-holds(w(t+1, w(T, W, Ew), e(ACT, E)), P) :- time(t), time(T), T <= t, plan(t, ACT), action(ACT), epistemic(ACT), e(ACT, E), atom(P),
                                                -holds(w(T, W, Ew), P), w(t+1, w(T, W, Ew), e(ACT, E)).

% \todo: check correctness of holds
