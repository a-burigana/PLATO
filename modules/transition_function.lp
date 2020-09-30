% ********** TRANSITION FUNCTION **********

#program base.

% Sensing or Announcement
soa(ACT) :- sensing(ACT).
soa(ACT) :- announcement(ACT).

#program step(t).

% is_executable/2: the action ACT is executable at time t
is_executable(t, ACT) :- t > 0, time(t), plan(t, ACT), action(ACT), pointed(t-1, R, P), executable(ACT, EXEC), entails(t-1, R, P, EXEC), formula(EXEC).
is_executable(t, ACT) :- t > 0, time(t), plan(t, ACT), action(ACT), pointed(t-1, R, P), executable(ACT, true).

% is_executable_effect/6: the effect CAUSED/SENSED/ANN of the action ACT is executable at time t
is_executable_effect(t, ACT, t-1, R , P , CAUSED) :- t > 0, time(t), plan(t, ACT), ontic(ACT), causes(ACT, CAUSED, true ), pointed(t-1, R, P).
is_executable_effect(t, ACT, t-1, R , P , CAUSED) :- t > 0, time(t), plan(t, ACT), ontic(ACT), causes(ACT, CAUSED, EEXEC), entails(t-1, R, P, EEXEC), pointed(t-1, R, P), formula(EEXEC).

is_executable_effect(t, ACT, t-1, R , P , SENSED) :- t > 0, time(t), plan(t, ACT), sensing(ACT), determines(ACT, SENSED, true ), pointed(t-1, R, P).
is_executable_effect(t, ACT, t-1, R , P , SENSED) :- t > 0, time(t), plan(t, ACT), sensing(ACT), determines(ACT, SENSED, EEXEC), entails(t-1, R, P, EEXEC), pointed(t-1, R, P), formula(EEXEC).

is_executable_effect(t, ACT, t-1, R , P , ANN   ) :- t > 0, time(t), plan(t, ACT), announcement(ACT), announces(ACT, ANN, true ), pointed(t-1, R, P).
is_executable_effect(t, ACT, t-1, R , P , ANN   ) :- t > 0, time(t), plan(t, ACT), announcement(ACT), announces(ACT, ANN, EEXEC), entails(t-1, R, P, EEXEC), pointed(t-1, R, P), formula(EEXEC).

% For ontic actions: let P2 be a possibility that is reachable from the pointed one with a path labeled only with fully observant agents.
% Then the effect CAUSED is executable in P2 if P2 entails its executability condition EEXEC
is_executable_effect(t, ACT, T2, R2, P2, CAUSED) :- t > 0, time(t), time(T2), T2 < t, plan(t, ACT), ontic(ACT), causes(ACT, CAUSED, true ), possible_world(T2, R2, P2),
                                                    reaches_no_oblivious(t, T2, R2, P2).

is_executable_effect(t, ACT, T2, R2, P2, CAUSED) :- t > 0, time(t), time(T2), T2 < t, plan(t, ACT), ontic(ACT), causes(ACT, CAUSED, EEXEC), possible_world(T2, R2, P2), formula(EEXEC),
                                                    reaches_no_oblivious(t, T2, R2, P2), entails(T2, R2, P2, EEXEC).

% For sensing/announcement actions: let P2 be a possibility that is reachable from the pointed one with a path labeled only with fully or partially observant agents.
% Then the effect SENSED/ANN is executable in P2 if P2 entails its executability condition EEXEC
is_executable_effect(t, ACT, T2, R2, P2, SENSED) :- t > 0, time(t), time(T2), T2 < t, plan(t, ACT), sensing(ACT), determines(ACT, SENSED, true), possible_world(T2, R2, P2), fluent(SENSED),
                                                    reaches_no_oblivious(t, T2, R2, P2).

is_executable_effect(t, ACT, T2, R2, P2, SENSED) :- t > 0, time(t), time(T2), T2 < t, plan(t, ACT), sensing(ACT), determines(ACT, SENSED, EEXEC), possible_world(T2, R2, P2), formula(EEXEC), fluent(SENSED),
                                                    reaches_no_oblivious(t, T2, R2, P2), entails(T2, R2, P2, EEXEC).

is_executable_effect(t, ACT, T2, R2, P2, ANN   ) :- t > 0, time(t), time(T2), T2 < t, plan(t, ACT), announcement(ACT), announces(ACT, ANN, true), possible_world(T2, R2, P2), formula(ANN),
                                                    reaches_no_oblivious(t, T2, R2, P2).

is_executable_effect(t, ACT, T2, R2, P2, ANN   ) :- t > 0, time(t), time(T2), T2 < t, plan(t, ACT), announcement(ACT), announces(ACT, ANN, EEXEC), possible_world(T2, R2, P2), formula(ANN),formula(EEXEC),
                                                    reaches_no_oblivious(t, T2, R2, P2), entails(T2, R2, P2, EEXEC).

is_fully_obs  (t, AG) :- t > 0, time(t), plan(t, ACT), action(ACT), observes (ACT, AG, true), agent(AG).
is_partial_obs(t, AG) :- t > 0, time(t), plan(t, ACT),    soa(ACT), aware_of (ACT, AG, true), agent(AG).
is_oblivious  (t, AG) :- t > 0, time(t), plan(t, ACT), action(ACT), oblivious(ACT, AG),       agent(AG).

is_fully_obs  (t, AG) :- t > 0, time(t), plan(t, ACT), action(ACT), observes (ACT, AG, OBS ), agent(AG),     entails(t-1, R, PP, OBS), formula(OBS), pointed(t-1, R, PP).
is_partial_obs(t, AG) :- t > 0, time(t), plan(t, ACT),    soa(ACT), aware_of (ACT, AG, OBS ), agent(AG),     entails(t-1, R, PP, OBS), formula(OBS), pointed(t-1, R, PP).
is_oblivious  (t, AG) :- t > 0, time(t), plan(t, ACT), action(ACT), observes (ACT, AG, OBS ), agent(AG), not entails(t-1, R, PP, OBS), formula(OBS), pointed(t-1, R, PP).
is_oblivious  (t, AG) :- t > 0, time(t), plan(t, ACT),    soa(ACT), aware_of (ACT, AG, OBS ), agent(AG), not entails(t-1, R, PP, OBS), formula(OBS), pointed(t-1, R, PP).

#include "actions.lp".
% #include "actions_pov.lp".

% #include "actions/ontic_actions.lp".
% #include "actions/sensing_actions.lp".
% #include "actions/announcement_actions.lp".
