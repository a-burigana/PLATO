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


w(t+1, W, Ew, Hw) :- time(t), plan(t, ACT), action(ACT), w(t, W, Ewo, Hwo), e(ACT, Ew, 0, _),
                     dw(t, W, Ewo, Hwo), de(ACT, Ew), dw(t+1, W, Ew, Hw), Hw = Hwo + Ewo + (t+1)*Ew.

w(t+1, W, Ew, Hw) :- time(t), time(T), T <= t, plan(t, ACT), action(ACT), w(T, W, Ewo, Hwo), e(ACT, Ew, 0, _),
                     pre(ACT, Ew, true), Hw = Hwo + Ewo + (t+1)*Ew.

w(t+1, W, Ew, Hw) :- time(t), time(Tw), time(T), Tw <= t, Tw <= T, plan(t, ACT), action(ACT), w(Tw, W, Ewo, Hwo), e(ACT, Ew, 0, _),
                     pre(ACT, Ew, Fpre), formula(Fpre), entails(T, Tw, W, Ewo, Hwo, Fpre), Hw = Hwo + Ewo + (t+1)*Ew.


%%% Accessibility relations with meta-q
r(t+1, W, Ew, Hw,
  t+1, V, Ev, Hv, AG) :- time(t), time(Tw), time(Tv), Tw <= t, Tv <= t, plan(t, ACT), action(ACT), agent(AG), obs(t, AG, OBS),
                         w(Tw, W, Ewo, Hwo), w(Tv, V, Evo, Hvo), e(ACT, Ew, 0, _), e(ACT, Ev, 0, _), obs_type(OBS), OBS != obl,
                         w(t+1, W, Ew, Hw), w(t+1, V, Ev, Hv), Hw = Hwo + Ewo + (t+1)*Ew, Hv = Hvo + Evo + (t+1)*Ev, 
                         r(Tw, W, Ewo, Hwo, Tv, V, Evo, Hvo, AG), metaq(ACT, Ew, Ev, OBS).

r(t+1, W, Ew, Hw,
  Tv , V, Ev, Hv, AG) :- time(t), time(Tw), time(Tv), Tw <= t, Tv <= t, plan(t, ACT), action(ACT), agent(AG), obs(t, AG, obl),
                         w(Tw, W, Ewo, Hwo), w(Tv, V, Ev, Hv), e(ACT, Ew, 0, _), e(ACT, E, 1, 0),
                         w(t+1, W, Ew, Hw), Hw = Hwo + Ewo + (t+1)*Ew, 
                         r(Tw, W, Ewo, Hwo, Tv, V, Ev, Hv, AG), metaq(ACT, Ew, E, obl).

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
