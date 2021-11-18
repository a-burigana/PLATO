% ********** mA^\rho PLUGIN **********

#defined ontic/1.
#defined sensing/1.
#defined announcement/1.

#defined causes/3.
#defined determines/2.
#defined announces/2.

#defined aware_of/3.
#defined oblivious/2.

#program step(t).

check_on_w(t, t, W, Ew, Hw, F) :- time(t), action(ACT), dpre(ACT, E, F), formula(F),
                                  w(t, W, Ew, Hw), e(ACT, E, 0, _), dw(t, W, Ew, Hw), de(ACT, E).

%%% Same path with meta-q
same_path(t, t, W, Ew, Hwo, E, Hw ) :- time(t), plan(t, ACT), action(ACT), w(t, W, Ew, Hwo), e(ACT, E, 0, _),
                                       dw(t, W, Ew, Hwo), de(ACT, E), Hw = Hwo + Ew + (t+1)*E.

same_path(t, T, W, Ew, Hwo, E, Hw ) :- time(t), time(T), T <= t, plan(t, ACT), action(ACT), agent(AG), obs(t, AG, OBS), obs_type(OBS), OBS != obl,
                                       w(T, W, Ew, Hwo), e(ACT, E, 0, _), w(t, W2, Ew2, Hw2), e(ACT, E2, 0, _), same_path(t, t, W2, Ew2, Hw2, E2, _),
                                       r(t, W2, Ew2, Hw2, T, W, Ew, Hwo, AG), metaq(ACT, E2, E, OBS), Hw = Hwo + Ew + (t+1)*E.

same_path(t, T, W, Ew, Hwo, E, Hwo) :- time(t), time(T), T <= t, plan(t, ACT), action(ACT), agent(AG), obs(t, AG, obl),
                                       w(T, W, Ew, Hwo), e(ACT, E, 1, 0), w(t, W2, Ew2, Hw2), e(ACT, E2, 1, 0), same_path(t, t, W2, Ew2, Hw2, E2, _),
                                       r(t, W2, Ew2, Hw2, T, W, Ew, Hwo, AG), metaq(ACT, E2, E, obl  ).

same_path(t, T, W, Ew, Hwo, E, Hwo) :- time(t), time(T), T <= t, plan(t, ACT), action(ACT), agent(AG),
                                       w(T, W, Ew, Hwo), e(ACT, E, 1, 0), w(t, W2, Ew2, Hw2), e(ACT, E2, 1, 0), same_path(t, t, W2, Ew2, Hw2, E2, _),
                                       r(t, W2, Ew2, Hw2, T, W, Ew, Hwo, AG), metaq(ACT, E2, E, all  ).


dw(t+1, W, E, Hw) :- time(t), plan(t, ACT), action(ACT), w(t, W, Ewo, Hwo), e(ACT, E, 0, _), dw(t, W, Ewo, Hwo), de(ACT, E),
                     dpre(ACT, E, true), same_path(t, t, W, Ewo, Hwo, E, Hw).

dw(t+1, W, E, Hw) :- time(t), plan(t, ACT), action(ACT), w(t, W, Ewo, Hwo), e(ACT, E, 0, _), dw(t, W, Ewo, Hwo), de(ACT, E),
                     dpre(ACT, E, Fpre), formula(Fpre), entails(t, t, W, Ewo, Hwo, Fpre), same_path(t, t, W, Ewo, Hwo, E, Hw).


w(t+1, W, E, Hw) :- time(t), plan(t, ACT), action(ACT), w(t, W, Ewo, Hwo), e(ACT, E, 0, _),
                    dw(t, W, Ewo, Hwo), de(ACT, E), dw(t+1, W, E, Hw), same_path(t, t, W, Ewo, Hwo, E, Hw).

w(t+1, W, E, Hw) :- time(t), time(T), T <= t, plan(t, ACT), action(ACT), w(T, W, Ewo, Hwo), e(ACT, E, 0, _),
                    pre(ACT, E, true), same_path(t, T, W, Ewo, Hwo, E, Hw).

w(t+1, W, E, Hw) :- time(t), time(Tw), time(T), Tw <= t, Tw <= T, plan(t, ACT), action(ACT), w(Tw, W, Ewo, Hwo), e(ACT, E, 0, _),
                    pre(ACT, E, Fpre), formula(Fpre), entails(T, Tw, W, Ewo, Hwo, Fpre),
                    same_path(t, Tw, W, Ewo, Hwo, E, Hw).


%%% Accessibility relations with meta-q
r(t+1, W, E1, Hw,
  t+1, V, E2, Hv , AG) :- time(t), time(Tw), time(Tv), Tw <= t, Tv <= t, plan(t, ACT), action(ACT), agent(AG), obs(t, AG, OBS),
                          w(Tw, W, Ew, Hwo), w(Tv, V, Ev, Hvo), e(ACT, E1, 0, _), e(ACT, E2, 0, _), obs_type(OBS), OBS != obl,
                          w(t+1, W, E1, Hw), w(t+1, V, E2, Hv), same_path(t, Tw, W, Ew, Hwo, E1, Hw), same_path(t, Tv, V, Ev, Hvo, E2, Hv),
                          r(Tw, W, Ew, Hwo, Tv, V, Ev, Hvo, AG), metaq(ACT, E1, E2, OBS).

r(t+1, W, E1, Hw,
  Tv , V, Ev, Hvo, AG) :- time(t), time(Tw), time(Tv), Tw <= t, Tv <= t, plan(t, ACT), action(ACT), agent(AG), obs(t, AG, obl),
                          w(Tw, W, Ew, Hwo), w(Tv, V, Ev, Hvo), e(ACT, E1, 0, _), e(ACT, E2, 1, 0),
                          w(t+1, W, E1, Hw), same_path(t, Tw, W, Ew, Hwo, E1, Hw),
                          r(Tw, W, Ew, Hwo, Tv, V, Ev, Hvo, AG), metaq(ACT, E1, E2, obl).

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
