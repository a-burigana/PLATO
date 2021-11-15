% ********** TRANSITION FUNCTION **********

#program step(t).

%%% Applicability %%%
applicable_event(t, ACT, E) :- time(t), action(ACT), e(ACT, E), de(ACT, E), dpre(ACT, E, true).
applicable_event(t, ACT, E) :- time(t), action(ACT), e(ACT, E), de(ACT, E), w(t, W, Ew, Hw), dw(t, W, Ew, Hw),
                               dpre(ACT, E, Fpre), formula(Fpre), entails(t, t, W, Ew, Hw, Fpre).

not_applicable(t, ACT) :- time(t), action(ACT), e(ACT, E), de(ACT, E), not applicable_event(t, ACT, E).
applicable(t, ACT)     :- time(t), action(ACT), not not_applicable(t, ACT).


% pf(t+1, Hwo, Hw) :- time(t), time(T), T <= t, plan(t, ACT), action(ACT), e(ACT, E), w(T, W, Hwo),
%                     same_path(t, T, W, Hwo, E), Hw = (Hwo+t+1)*(Hwo+t+2)/2 + t+1.

% STEP 1: determine the new designated worlds. The computation of the other worlds begins from the designated worlds
% Important: we assume that the designate event is *not* null
% dw(t+1, w(t, W, Ew), e(ACT, E)) :- time(t), plan(t, ACT), action(ACT),
%                                    w(t, W, Ew), e(ACT, E), pre(ACT, E, true),
%                                    dw(t, W, Ew), de(ACT, E).

% dw(t+1, W, E, Hw) :- time(t), plan(t, ACT), action(ACT), w(t, W, Hwo), e(ACT, E), pre(ACT, E, true),
%                   dw(t, W, Hwo), de(ACT, E), pf(t+1, Hwo, Hw).

% dw(t+1, W, E, Hw) :- time(t), plan(t, ACT), action(ACT), w(t, W, Hwo), e(ACT, E), pre(ACT, E, Fpre),
%                   dw(t, W, Hwo), de(ACT, E), entails(t, W, Ew, Fpre), pf(t+1, Hwo, Hw).

% % STEP 2: determine the new possible worlds
% %          - 2.1: a designated world is a possible world
% w(t+1, W, E, Hw) :- time(t), plan(t, ACT), action(ACT), w(t, W, Hwo), e(ACT, E), not ne(ACT, E),
%                  dw(t, W, Hwo), de(ACT, E), dw(t+1, W, E, Hw), pf(t+1, Hwo, Hw).

% %          - 2.2: apply recursive step

% % Confronto lo stato a tempo t-1 con l'azione che eseguo a tempo t e guardo le somiglianze nei path
% % Caso base: un designated world e un designated event hanno lo stesso path
% % same_path(t, w(t, W, Ew), e(ACT, E)) :- time(t), plan(t, ACT), action(ACT), w(t, W, Ew), e(ACT, E),
% %                                         dw(t, W, Ew), de(ACT, E).

% same_path(t, t, W, Hw, E) :- time(t), plan(t, ACT), action(ACT), w(t, W, Hw), e(ACT, E),
%                              dw(t, W, Hw), de(ACT, E).

% % Passo induttivo: se W2 e E2 hanno lo stesso path e W2 -AG-> W & E2 -AG-> E, allora W ed E hanno lo stesso path
% same_path(t, T, W, Hw, E) :- time(t), time(T), T <= t, plan(t, ACT), action(ACT), agent(AG),
%                              w(T, W, Hw), e(ACT, E), w(t, W2, Hw2), e(ACT, E2),
%                              same_path(t, t, W2, Hw2, E2), r(t, W2, Hw2, T, W, Hw, AG), q(t, ACT, E2, E, AG).

% w(t+1, W, E, Hw) :- time(t), time(T), T <= t, plan(t, ACT), action(ACT), w(T, W, Hwo), e(ACT, E), not ne(ACT, E),
%                  pre(ACT, E, true), same_path(t, T, W, Hwo, E), pf(t+1, Hwo, Hw).

% w(t+1, W, E, Hw) :- time(t), time(T), T <= t, plan(t, ACT), action(ACT), w(T, W, Hwo), e(ACT, E), not ne(ACT, E),
%                  pre(ACT, E, Fpre), formula(Fpre), entails(T, W, Hwo, Fpre),
%                  same_path(t, T, W, Hwo, E), pf(t+1, Hwo, Hw).


% STEP 3: determine the accessibility relations
% r(t+1, W, E, Hw,
%   t+1, V, Hv , AG) :- time(t), time(Tw), time(Tv), Tw <= t, Tv <= t, plan(t, ACT), action(ACT), agent(AG),
%                       w(Tw, W, Ewo, Hwo), w(Tv, V, Hvo), e(ACT, E1), e(ACT, E2), not ne(ACT, E1), not ne(ACT, E2),
%                       w(t+1, W, E, Hw), w(t+1, V, Hv), pf(t+1, Hwo, Hw), pf(t+1, Hvo, Hv),
%                       same_path(t, Tw, W, Ewo, Hwo, E1), same_path(t, Tv, V, Hvo, E2),
%                       r(Tw, W, Ewo, Hwo, Tv, V, Hvo, AG), q(t, ACT, E1, E2, AG).

% r(t+1, W, E, Hw ,
%   Tv , V, Hvo, AG) :- time(t), time(Tw), time(Tv), Tw <= t, Tv <= t, plan(t, ACT), action(ACT), agent(AG),
%                       w(Tw, W, Ewo, Hwo), w(Tv, V, Hvo), e(ACT, E1), e(ACT, E2), not ne(ACT, E1), ne(ACT, E2),
%                       w(t+1, W, E, Hw), pf(t+1, Hwo, Hw), same_path(t, Tv, V, Hvo, E2),
%                       r(Tw, W, Ewo, Hwo, Tv, V, Hvo, AG), q(t, ACT, E1, E2, AG).


% STEP 4: determine the interpretation of the worlds
 holds(t+1, W, E, Hw, P) :- time(t), plan(t, ACT), action(ACT), ontic(ACT), e(ACT, E),
                         w(t+1, W, E, Hw), post(ACT, E,  P, true), atom(P).

-holds(t+1, W, E, Hw, P) :- time(t), plan(t, ACT), action(ACT), ontic(ACT), e(ACT, E),
                         w(t+1, W, E, Hw), post(ACT, E, -P, true), atom(P).

% Postcondition is satisfied
 holds(t+1, W, E, Hw, P) :- time(t), time(Tw), Tw <= t, plan(t, ACT), action(ACT), ontic(ACT), e(ACT, E), formula(Fpost),
                         w(t+1, W, E, Hw), w(Tw, W, Ewo, Hwo), same_path(t, Tw, W, Ewo, Hwo, E, Hw), % pf(t+1, Hwo, Hw),
                         post(ACT, E,  P, Fpost), atom(P), entails(T, Tw, W, Ewo, Hwo, Fpost), time(T), T <= t.

-holds(t+1, W, E, Hw, P) :- time(t), time(Tw), Tw <= t, plan(t, ACT), action(ACT), ontic(ACT), e(ACT, E), formula(Fpost),
                         w(t+1, W, E, Hw), w(Tw, W, Ewo, Hwo), same_path(t, Tw, W, Ewo, Hwo, E, Hw), % pf(t+1, Hwo, Hw),
                         post(ACT, E, -P, Fpost), atom(P), entails(T, Tw, W, Ewo, Hwo, Fpost), time(T), T <= t.

% Inertia in ontic actions
holds(t+1, W, E, Hw, P) :- time(t), time(Tw), Tw <= t, plan(t, ACT), action(ACT), ontic(ACT), e(ACT, E),
                        not post(ACT, E, P, _), not post(ACT, E, -P, _), atom(P), holds(Tw, W, Ewo, Hwo, P),
                        w(t+1, W, E, Hw), w(Tw, W, Ewo, Hwo), same_path(t, Tw, W, Ewo, Hwo, E, Hw). %, pf(t+1, Hwo, Hw).

holds(t+1, W, E, Hw, P) :- time(t), time(Tw), Tw <= t, plan(t, ACT), action(ACT), ontic(ACT), e(ACT, E),
                        post(ACT, E, P, Fpost1), post(ACT, E, -P, Fpost2), atom(P), holds(Tw, W, Ewo, Hwo, P),
                        time(T1), time(T2), T1 <= t, T2 <= t,
                        not entails(T1, Tw, W, Ewo, Hwo, Fpost1), not entails(T2, Tw, W, Ewo, Hwo, Fpost2), formula(Fpost1), formula(Fpost2),
                        w(t+1, W, E, Hw), w(Tw, W, Ewo, Hwo), same_path(t, Tw, W, Ewo, Hwo, E, Hw). %, pf(t+1, Hwo, Hw).

% Event with no postconditions in ontic action
holds(t+1, W, E, Hw, P) :- time(t), time(Tw), Tw <= t, plan(t, ACT), action(ACT), ontic(ACT), e(ACT, E), no_post(ACT, E),
                        atom(P), holds(Tw, W, Ewo, Hwo, P), w(t+1, W, E, Hw), w(Tw, W, Ewo, Hwo), same_path(t, Tw, W, Ewo, Hwo, E, Hw). %, pf(t+1, Hwo, Hw).

% Epistemic actions
holds(t+1, W, E, Hw, P) :- time(t), time(Tw), Tw <= t, plan(t, ACT), action(ACT), epistemic(ACT), e(ACT, E),
                        atom(P), holds(Tw, W, Ewo, Hwo, P), w(t+1, W, E, Hw), w(Tw, W, Ewo, Hwo), same_path(t, Tw, W, Ewo, Hwo, E, Hw). %, pf(t+1, Hwo, Hw).
