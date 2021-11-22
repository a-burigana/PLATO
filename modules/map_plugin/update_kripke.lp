% ********** mA^\rho PLUGIN **********

semantics(kripke).

#defined ontic/1.
#defined sensing/1.
#defined announcement/1.

#defined causes/3.
#defined determines/2.
#defined announces/2.

#defined aware_of/3.
#defined oblivious/2.

#defined same_path/7.

#program step(t).

check_on_w(t, t, W, Ew, Hw, F) :- time(t), action(ACT), dpre(ACT, E, F), formula(F),
                                  w(t, W, Ew, Hw), e(ACT, E, 0, _), dw(t, W, Ew, Hw), de(ACT, E).

dw(t+1, W, Ew, Hw) :- time(t), plan(t, ACT), action(ACT), w(t, W, Ewo, Hwo), e(ACT, Ew, 0, _), dw(t, W, Ewo, Hwo), de(ACT, Ew),
                      dpre(ACT, Ew, true), Hw = Hwo + Ewo + (t+1)*Ew.

dw(t+1, W, Ew, Hw) :- time(t), plan(t, ACT), action(ACT), w(t, W, Ewo, Hwo), e(ACT, Ew, 0, _), dw(t, W, Ewo, Hwo), de(ACT, Ew),
                      dpre(ACT, Ew, Fpre), formula(Fpre), entails(t, t, W, Ewo, Hwo, Fpre), Hw = Hwo + Ewo + (t+1)*Ew.


% w(t+1, W, Ew, Hw) :- time(t), plan(t, ACT), action(ACT), w(t, W, Ewo, Hwo), e(ACT, Ew, 0, _),
%                      dw(t, W, Ewo, Hwo), de(ACT, Ew), dw(t+1, W, Ew, Hw), Hw = Hwo + Ewo + (t+1)*Ew.

w(t+1, W, Ew, Hw) :- time(t), time(Tw), Tw <= t, plan(t, ACT), action(ACT), w(Tw, W, Ewo, Hwo), e(ACT, Ew, 0, _),
                     pre(ACT, Ew, true), Hw = Hwo + Ewo + (t+1)*Ew, dw(t, Wd, Ewd, Hwd), rr(t, Wd, Ewd, Hwd, Tw, W, Ewo, Hwo).

w(t+1, W, Ew, Hw) :- time(t), time(Tw), time(T), Tw <= t, Tw <= T, plan(t, ACT), action(ACT), w(Tw, W, Ewo, Hwo), e(ACT, Ew, 0, _),
                     pre(ACT, Ew, Fpre), formula(Fpre), entails(T, Tw, W, Ewo, Hwo, Fpre), Hw = Hwo + Ewo + (t+1)*Ew,
                     dw(t, Wd, Ewd, Hwd), rr(t, Wd, Ewd, Hwd, Tw, W, Ewo, Hwo).

rr(t , W, Ew, Hw,
   Tv, V, Ev, Hv) :- time(t), time(Tv), Tv <= t, dw(t, W, Ew, Hw), w(t, W, Ew, Hw), w(Tv, V, Ev, Hv),
                     r(t, W, Ew, Hw, Tv, V, Ev, Hv, AG), agent(AG).

rr(t , W, Ew, Hw,
   Tv, V, Ev, Hv) :- time(t), time(Tu), time(Tv), Tv <= Tu, Tu <= t, dw(t, W, Ew, Hw), w(t, W, Ew, Hw), w(Tv, V, Ev, Hv), w(Tu, U, Eu, Hu),
                     rr(t, W, Ew, Hw, Tu, U, Eu, Hu), r(Tu, U, Eu, Hu, Tv, V, Ev, Hv, AG), agent(AG).

%%% Accessibility relations with meta-q
r(t+1, W, Ew, Hw,
  t+1, V, Ev, Hv, AG) :- time(t), time(Tw), time(Tv), Tw <= t, Tv <= Tw, plan(t, ACT), action(ACT), agent(AG), obs(t, AG, OBS),
                         w(Tw, W, Ewo, Hwo), w(Tv, V, Evo, Hvo), e(ACT, Ew, 0, _), e(ACT, Ev, 0, _), obs_type(OBS), OBS != obl,
                         w(t+1, W, Ew, Hw), w(t+1, V, Ev, Hv), Hw = Hwo + Ewo + (t+1)*Ew, Hv = Hvo + Evo + (t+1)*Ev,
                         rr(t, Wd, Ewd, Hwd, Tw, W, Ewo, Hwo), rr(t, Wd, Ewd, Hwd, Tv, V, Evo, Hvo),
                         r(Tw, W, Ewo, Hwo, Tv, V, Evo, Hvo, AG), metaq(ACT, Ew, Ev, OBS).

r(t+1, W, Ew, Hw,
  Tv , V, Ev, Hv, AG) :- time(t), time(Tw), time(Tv), Tw <= t, Tv <= Tw, plan(t, ACT), action(ACT), agent(AG), obs(t, AG, obl),
                         w(Tw, W, Ewo, Hwo), w(Tv, V, Ev, Hv), e(ACT, Ew, 0, _), e(ACT, 0, 1, 0),
                         w(t+1, W, Ew, Hw), Hw = Hwo + Ewo + (t+1)*Ew, rr(t, Wd, Ewd, Hwd, Tw, W, Ewo, Hwo),
                         r(Tw, W, Ewo, Hwo, Tv, V, Ev, Hv, AG), metaq(ACT, Ew, 0, obl).

% STEP 4: determine the interpretation of the worlds
holds(t+1, W, Ew, Hw, P) :- time(t), plan(t, ACT), action(ACT), ontic(ACT), e(ACT, Ew, 0, 1),
                           w(t+1, W, Ew, Hw), post(ACT, Ew,  P, true), atom(P).

-holds(t+1, W, Ew, Hw, P) :- time(t), plan(t, ACT), action(ACT), ontic(ACT), e(ACT, Ew, 0, 1),
                           w(t+1, W, Ew, Hw), post(ACT, Ew, -P, true), atom(P).

% Postcondition is satisfied
holds(t+1, W, Ew, Hw, P) :- time(t), time(Tw), Tw <= t, plan(t, ACT), action(ACT), ontic(ACT), e(ACT, Ew, 0, 1), formula(Fpost),
                           w(t+1, W, Ew, Hw), w(Tw, W, Ewo, Hwo), post(ACT, Ew,  P, Fpost), atom(P), entails(T, Tw, W, Ewo, Hwo, Fpost),
                           time(T), T <= t, Hw = Hwo + Ewo + (t+1)*Ew, rr(t, Wd, Ewd, Hwd, Tw, W, Ewo, Hwo).

-holds(t+1, W, Ew, Hw, P) :- time(t), time(Tw), Tw <= t, plan(t, ACT), action(ACT), ontic(ACT), e(ACT, Ew, 0, 1), formula(Fpost),
                           w(t+1, W, Ew, Hw), w(Tw, W, Ewo, Hwo), post(ACT, Ew, -P, Fpost), atom(P), entails(T, Tw, W, Ewo, Hwo, Fpost),
                           time(T), T <= t, Hw = Hwo + Ewo + (t+1)*Ew, rr(t, Wd, Ewd, Hwd, Tw, W, Ewo, Hwo).

% Inertia in ontic actions
holds(t+1, W, Ew, Hw, P) :- time(t), time(Tw), Tw <= t, plan(t, ACT), action(ACT), ontic(ACT), e(ACT, Ew, 0, 1),
                           not post(ACT, Ew, P, _), not post(ACT, Ew, -P, _), atom(P), holds(Tw, W, Ewo, Hwo, P),
                           w(t+1, W, Ew, Hw), w(Tw, W, Ewo, Hwo), Hw = Hwo + Ewo + (t+1)*Ew, rr(t, Wd, Ewd, Hwd, Tw, W, Ewo, Hwo).

-holds(t+1, W, Ew, Hw, P) :- time(t), time(Tw), Tw <= t, plan(t, ACT), action(ACT), ontic(ACT), e(ACT, Ew, 0, 1), formula(Fpost1), formula(Fpost2),
                           w(t+1, W, Ew, Hw), w(Tw, W, Ewo, Hwo), holds(Tw, W, Ewo, Hwo, P),
                           post(ACT, Ew, P, Fpost1), post(ACT, Ew, -P, Fpost2), atom(P), time(T1), time(T2), T1 <= t, T2 <= t,
                           not entails(_, Tw, W, Ewo, Hwo, Fpost1), not entails(_, Tw, W, Ewo, Hwo, Fpost2),
                           Hw = Hwo + Ewo + (t+1)*Ew, rr(t, Wd, Ewd, Hwd, Tw, W, Ewo, Hwo).

% Epistemic actions
holds(t+1, W, Ew, Hw, P) :- time(t), time(Tw), Tw <= t, plan(t, ACT), action(ACT), epistemic(ACT), e(ACT, Ew, 0, 0),
                           atom(P), holds(Tw, W, Ewo, Hwo, P), w(t+1, W, Ew, Hw), w(Tw, W, Ewo, Hwo), 
                           Hw = Hwo + Ewo + (t+1)*Ew, rr(t, Wd, Ewd, Hwd, Tw, W, Ewo, Hwo).

%%% Checking observability relations %%%
obs(t, AG, f_obs) :- time(t), plan(t, ACT),       action(ACT),  observes(ACT, AG, true), agent(AG).
obs(t, AG, p_obs) :- time(t), plan(t, ACT),      sensing(ACT),  aware_of(ACT, AG, true), agent(AG).
obs(t, AG, p_obs) :- time(t), plan(t, ACT), announcement(ACT),  aware_of(ACT, AG, true), agent(AG).
obs(t, AG, obl  ) :- time(t), plan(t, ACT),       action(ACT), oblivious(ACT, AG),       agent(AG).

obs(t, AG, f_obs) :- time(t), plan(t, ACT),       action(ACT),  observes(ACT, AG, F   ), agent(AG), formula(F),     entails(t, t, W, Ewo, Hw, F), dw(t, W, Ewo, Hw).
obs(t, AG, p_obs) :- time(t), plan(t, ACT),      sensing(ACT),  aware_of(ACT, AG, F   ), agent(AG), formula(F),     entails(t, t, W, Ewo, Hw, F), dw(t, W, Ewo, Hw).
obs(t, AG, p_obs) :- time(t), plan(t, ACT), announcement(ACT),  aware_of(ACT, AG, F   ), agent(AG), formula(F),     entails(t, t, W, Ewo, Hw, F), dw(t, W, Ewo, Hw).
obs(t, AG, obl  ) :- time(t), plan(t, ACT),       action(ACT),  observes(ACT, AG, F   ), agent(AG), formula(F), not entails(t, t, W, Ewo, Hw, F), dw(t, W, Ewo, Hw).
obs(t, AG, obl  ) :- time(t), plan(t, ACT),      sensing(ACT),  aware_of(ACT, AG, F   ), agent(AG), formula(F), not entails(t, t, W, Ewo, Hw, F), dw(t, W, Ewo, Hw).
obs(t, AG, obl  ) :- time(t), plan(t, ACT), announcement(ACT),  aware_of(ACT, AG, F   ), agent(AG), formula(F), not entails(t, t, W, Ewo, Hw, F), dw(t, W, Ewo, Hw).

check_on_w(t, t, W, Ew, Hw, F) :- time(t), plan(t, ACT),       action(ACT), observes(ACT, AG, F), agent(AG), formula(F), dw(t, W, Ew, Hw).
check_on_w(t, t, W, Ew, Hw, F) :- time(t), plan(t, ACT),      sensing(ACT), aware_of(ACT, AG, F), agent(AG), formula(F), dw(t, W, Ew, Hw).
check_on_w(t, t, W, Ew, Hw, F) :- time(t), plan(t, ACT), announcement(ACT), aware_of(ACT, AG, F), agent(AG), formula(F), dw(t, W, Ew, Hw).
