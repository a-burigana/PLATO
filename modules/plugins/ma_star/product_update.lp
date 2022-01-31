% ********** mA^* PLUGIN **********

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

%%% Applicability %%%
applicable_event(t, ACT, E) :- time(t), action(ACT), e(ACT, E, 0, _), de(ACT, E), dpre(ACT, E, true).
applicable_event(t, ACT, E) :- time(t), action(ACT), e(ACT, E, 0, _), de(ACT, E), w(t, W, Ew, Hw), dw(t, W, Ew, Hw),
                               dpre(ACT, E, Fpre), formula(Fpre), entails(t, W, Ew, Hw, Fpre).

not_applicable(t, ACT) :- time(t), action(ACT), e(ACT, E, 0, _), de(ACT, E), not applicable_event(t, ACT, E).
applicable(t, ACT)     :- time(t), action(ACT), not not_applicable(t, ACT).


% check_on_w(t, W, Ew, Hw, F) :- time(t), action(ACT), dpre(ACT, E, F), formula(F),
%                                w(t, W, Ew, Hw), e(ACT, E, 0, _), dw(t, W, Ew, Hw), de(ACT, E).

dw(t+1, W, Ew, Hw) :- time(t), plan(t, ACT), action(ACT), w(t, W, Ewo, Hwo), e(ACT, Ew, 0, _), dw(t, W, Ewo, Hwo), de(ACT, Ew),
                      dpre(ACT, Ew, true), Hw = (t+1) * Hwo + Ewo + Ew.

dw(t+1, W, Ew, Hw) :- time(t), plan(t, ACT), action(ACT), w(t, W, Ewo, Hwo), e(ACT, Ew, 0, _), dw(t, W, Ewo, Hwo), de(ACT, Ew),
                      dpre(ACT, Ew, Fpre), formula(Fpre), entails(t, W, Ewo, Hwo, Fpre), Hw = (t+1) * Hwo + Ewo + Ew.


% rr(t, Wd, Ewd, Hwd) :- time(t), dw(t, Wd, Ewd, Hwd).
% rr(t, W , Ew , Hw ) :- time(t), dw(t, Wd, Ewd, Hwd), w(t, W, Ew, Hw), r(t, Wd, Ewd, Hwd, t, W, Ew, Hw, AG), agent(AG).
% rr(t, W , Ew , Hw ) :- time(t), w(t, W, Ew, Hw), w(t, V, Ev, Hv),
%                        rr(t, V, Ev, Hv), r(t, V, Ev, Hv, t, W, Ew, Hw, AG), agent(AG).


% Sigma (ontic)
w(t+1, W, 1, Hw) :- time(t), plan(t, ACT), action(ACT), ontic(ACT), w(t, W, Ewo, Hwo), e(ACT, 1, 0, _),
                    pre(ACT, 1, true), Hw = (t+1) * Hwo + Ewo + 1.%,
                    % rr(t, Wo, Ewo, Hwo).

% Sigma (epistemic)
w(t+1, W, 2, Hw) :- time(t), plan(t, ACT), action(ACT), epistemic(ACT), w(t, W, Ewo, Hwo), e(ACT, 2, 0, _),
                    pre(ACT, 2, true), Hw = (t+1) * Hwo + Ewo + 2.%,
                    % rr(t, Wo, Ewo, Hwo).

w(t+1, W, 2, Hw) :- time(t), plan(t, ACT), action(ACT), epistemic(ACT), w(t, W, Ewo, Hwo), e(ACT, 2, 0, _),
                    pre(ACT, 2,  Fpre), atom(Fpre),     holds(t, W, Ewo, Hwo, Fpre), Hw = (t+1) * Hwo + Ewo + 2.%,
                    % rr(t, Wo, Ewo, Hwo).

% w(t+1, W, 2, Hw) :- time(t), plan(t, ACT), action(ACT), epistemic(ACT), w(t, W, Ewo, Hwo), e(ACT, 2, 0, _),
%                     pre(ACT, 2, -Fpre), atom(Fpre), not holds(t, W, Ewo, Hwo, Fpre), Hw = (t+1) * Hwo + Ewo + 2.%,
%                     % rr(t, Wo, Ewo, Hwo).

% Tau
w(t+1, W, 1, Hw) :- time(t), plan(t, ACT), action(ACT), epistemic(ACT), w(t, W, Ewo, Hwo), e(ACT, 1, 0, 0),
                    pre(ACT, 1, true), agent(AG), obs(t, AG, p_obs), Hw = (t+1) * Hwo + Ewo + 1.%,
                    % rr(t, Wo, Ewo, Hwo).

% w(t+1, W, 1, Hw) :- time(t), plan(t, ACT), action(ACT), epistemic(ACT), w(t, W, Ewo, Hwo), e(ACT, 1, 0, 0),
%                     pre(ACT, 1,  Fpre), atom(Fpre),     holds(t, W, Ewo, Hwo, Fpre),
%                     agent(AG), obs(t, AG, p_obs), Hw = (t+1) * Hwo + Ewo + 1.%,
%                     % rr(t, Wo, Ewo, Hwo).

w(t+1, W, 1, Hw) :- time(t), plan(t, ACT), action(ACT), epistemic(ACT), w(t, W, Ewo, Hwo), e(ACT, 1, 0, 0),
                    pre(ACT, 1, -Fpre), atom(Fpre), not holds(t, W, Ewo, Hwo, Fpre),
                    agent(AG), obs(t, AG, p_obs), Hw = (t+1) * Hwo + Ewo + 1.%,
                    % rr(t, Wo, Ewo, Hwo).

% Epsilon
w(t+1, W, 0, Hw) :- time(t), plan(t, ACT), action(ACT),                 w(t, W, Ewo, Hwo), e(ACT, 0, 1, 0),
                    pre(ACT, 0, true), agent(AG), obs(t, AG, obl), Hw = (t+1) * Hwo + Ewo.%,
                    % rr(t, Wo, Ewo, Hwo).


%%% Accessibility relations with meta-q
r(t+1, W, Ew, Hw,
  t+1, V, Ev, Hv, AG) :- time(t), plan(t, ACT), action(ACT), agent(AG), obs(t, AG, OBS),
                         w(t, W, Ewo, Hwo), w(t, V, Evo, Hvo), e(ACT, Ew, 0, _), e(ACT, Ev, 0, _), obs_type(OBS), OBS != obl, OBS != all,
                         w(t+1, W, Ew, Hw), w(t+1, V, Ev, Hv), Hw = (t+1) * Hwo + Ewo + Ew, Hv = (t+1) * Hvo + Evo + Ev,
                         r(t, W, Ewo, Hwo, t, V, Evo, Hvo, AG), metaq(ACT, Ew, Ev, OBS).

r(t+1, W, Ew, Hw,
  t+1, V, 0 , Hv, AG) :- time(t), plan(t, ACT), action(ACT), agent(AG), obs(t, AG, obl),
                         w(t, W, Ewo, Hwo), w(t, V, Evo, Hvo), e(ACT, Ew, _, _), e(ACT, 0, 1, 0),
                         w(t+1, W, Ew, Hw), w(t+1, V, 0, Hv), Hw = (t+1) * Hwo + Ewo + Ew, Hv = (t+1) * Hvo + Evo,
                         r(t, W, Ewo, Hwo, t, V, Evo, Hvo, AG), metaq(ACT, Ew, 0, obl).

r(t+1, W, 0 , Hw,
  t+1, V, 0 , Hv, AG) :- time(t), plan(t, ACT), action(ACT), agent(AG),
                         w(t, W, Ewo, Hwo), w(t, V, Evo, Hvo), e(ACT, 0, 1, 0), e(ACT, 0, 1, 0),
                         w(t+1, W, 0, Hw), w(t+1, V, 0, Hv), Hw = (t+1) * Hwo + Ewo, Hv = (t+1) * Hvo + Evo,
                         r(t, W, Ewo, Hwo, t, V, Evo, Hvo, AG), metaq(ACT, 0, 0, all).


% STEP 4: determine the interpretation of the worlds
holds(t+1, W, 1, Hw, P) :- time(t), plan(t, ACT), action(ACT), ontic(ACT), e(ACT, 1, 0, 1),
                            w(t+1, W, 1, Hw), post(ACT, 1,  P, true), atom(P).

-holds(t+1, W, 1, Hw, P) :- time(t), plan(t, ACT), action(ACT), ontic(ACT), e(ACT, 1, 0, 1),
                            w(t+1, W, 1, Hw), post(ACT, 1, -P, true), atom(P).

% Postcondition is satisfied
holds(t+1, W, 1, Hw, P) :- time(t), plan(t, ACT), action(ACT), ontic(ACT), e(ACT, 1, 0, 1), formula(Fpost),
                            w(t+1, W, 1, Hw), w(t, W, Ewo, Hwo), post(ACT, 1,  P, Fpost), atom(P), entails(t, W, Ewo, Hwo, Fpost),
                            Hw = (t+1) * Hwo + Ewo + 1.

-holds(t+1, W, 1, Hw, P) :- time(t), plan(t, ACT), action(ACT), ontic(ACT), e(ACT, 1, 0, 1), formula(Fpost),
                            w(t+1, W, 1, Hw), w(t, W, Ewo, Hwo), post(ACT, 1, -P, Fpost), atom(P), entails(t, W, Ewo, Hwo, Fpost),
                            Hw = (t+1) * Hwo + Ewo + 1.

% Inertia in ontic actions
holds(t+1, W, 1, Hw, P) :- time(t), plan(t, ACT), action(ACT), ontic(ACT), e(ACT, 1, 0, 1),
                            not post(ACT, 1, P, _), not post(ACT, 1, -P, _), atom(P), holds(t, W, Ewo, Hwo, P),
                            w(t+1, W, 1, Hw), w(t, W, Ewo, Hwo), Hw = (t+1) * Hwo + Ewo + 1.

holds(t+1, W, 1, Hw, P) :- time(t), plan(t, ACT), action(ACT), ontic(ACT), e(ACT, 1, 0, 1), formula(Fpost1), formula(Fpost2),
                            w(t+1, W, 1, Hw), w(t, W, Ewo, Hwo), holds(t, W, Ewo, Hwo, P),
                            post(ACT, 1, P, Fpost1), post(ACT, 1, -P, Fpost2), atom(P),
                            not entails(t, W, Ewo, Hwo, Fpost1), not entails(t, W, Ewo, Hwo, Fpost2),
                            Hw = (t+1) * Hwo + Ewo + 1.

holds(t+1, W, 0, Hw, P) :- time(t), plan(t, ACT), action(ACT), ontic(ACT), e(ACT, 0, 1, 0),
                            atom(P), holds(t, W, Ewo, Hwo, P), w(t+1, W, 0, Hw), w(t, W, Ewo, Hwo), Hw = (t+1) * Hwo + Ewo.

% Epistemic actions
holds(t+1, W, Ew, Hw, P) :- time(t), plan(t, ACT), action(ACT), epistemic(ACT), e(ACT, Ew, _, 0),
                            atom(P), holds(t, W, Ewo, Hwo, P), w(t+1, W, Ew, Hw), w(t, W, Ewo, Hwo), 
                            Hw = (t+1) * Hwo + Ewo + Ew.


%%% Checking observability relations %%%
obs(t, AG, f_obs) :- time(t), plan(t, ACT),       action(ACT),  observes(ACT, AG, true), agent(AG).
obs(t, AG, p_obs) :- time(t), plan(t, ACT),      sensing(ACT),  aware_of(ACT, AG, true), agent(AG).
obs(t, AG, p_obs) :- time(t), plan(t, ACT), announcement(ACT),  aware_of(ACT, AG, true), agent(AG).
obs(t, AG, obl  ) :- time(t), plan(t, ACT),       action(ACT), oblivious(ACT, AG),       agent(AG).

obs(t, AG, f_obs) :- time(t), plan(t, ACT),       action(ACT),  observes(ACT, AG, F   ), agent(AG), formula(F),     entails(t, W, Ewo, Hw, F), dw(t, W, Ewo, Hw).
obs(t, AG, p_obs) :- time(t), plan(t, ACT),      sensing(ACT),  aware_of(ACT, AG, F   ), agent(AG), formula(F),     entails(t, W, Ewo, Hw, F), dw(t, W, Ewo, Hw).
obs(t, AG, p_obs) :- time(t), plan(t, ACT), announcement(ACT),  aware_of(ACT, AG, F   ), agent(AG), formula(F),     entails(t, W, Ewo, Hw, F), dw(t, W, Ewo, Hw).
obs(t, AG, obl  ) :- time(t), plan(t, ACT),       action(ACT),  observes(ACT, AG, F   ), agent(AG), formula(F), not entails(t, W, Ewo, Hw, F), dw(t, W, Ewo, Hw).
obs(t, AG, obl  ) :- time(t), plan(t, ACT),      sensing(ACT),  aware_of(ACT, AG, F   ), agent(AG), formula(F), not entails(t, W, Ewo, Hw, F), dw(t, W, Ewo, Hw).
obs(t, AG, obl  ) :- time(t), plan(t, ACT), announcement(ACT),  aware_of(ACT, AG, F   ), agent(AG), formula(F), not entails(t, W, Ewo, Hw, F), dw(t, W, Ewo, Hw).

% check_on_w(t, W, Ew, Hw, F) :- time(t), plan(t, ACT),       action(ACT), observes(ACT, AG, F), agent(AG), formula(F), dw(t, W, Ew, Hw).
% check_on_w(t, W, Ew, Hw, F) :- time(t), plan(t, ACT),      sensing(ACT), aware_of(ACT, AG, F), agent(AG), formula(F), dw(t, W, Ew, Hw).
% check_on_w(t, W, Ew, Hw, F) :- time(t), plan(t, ACT), announcement(ACT), aware_of(ACT, AG, F), agent(AG), formula(F), dw(t, W, Ew, Hw).
