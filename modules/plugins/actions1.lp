#program base.
epistemic(ACT) :- sensing(ACT).
epistemic(ACT) :- announcement(ACT).

obs_type(f_obs).
obs_type(p_obs).
obs_type(obl  ).
obs_type(all  ).

%%% Generating event spectrum %%%

% Events: e(<act_name>, <event_name>, <is_null>, <has_post>).

pre(ACT, 0, true) :- action(ACT).

% Ontic actions
e(ACT, 1, 0, 1) :- action(ACT), ontic(ACT).             % sigma
e(ACT, 0, 1, 0) :- action(ACT), ontic(ACT).             % epsilon

de(ACT, 1) :- action(ACT), ontic(ACT).

% dpre(ACT, 1, true) :- action(ACT), ontic(ACT), executable(ACT, true).
% dpre(ACT, 1, F   ) :- action(ACT), ontic(ACT), executable(ACT, F), formula(F).

% post(ACT, 1, P, true) :- action(ACT), ontic(ACT), literal(P), causes(ACT, P, true).
% post(ACT, 1, P, F   ) :- action(ACT), ontic(ACT), literal(P), causes(ACT, P, F), formula(F).

metaq(ACT, 1, 1, f_obs) :- action(ACT), ontic(ACT).
metaq(ACT, 1, 0, obl  ) :- action(ACT), ontic(ACT).
metaq(ACT, 0, 0, all  ) :- action(ACT), ontic(ACT).

% Sensing actions
e(ACT, 2, 0, 0) :- action(ACT), sensing(ACT).           % sigma
e(ACT, 1, 0, 0) :- action(ACT), sensing(ACT).           % tau
e(ACT, 0, 1, 0) :- action(ACT), sensing(ACT).           % epsilon

de(ACT, 2) :- action(ACT), sensing(ACT).
de(ACT, 1) :- action(ACT), sensing(ACT).

% dpre(ACT, 2, true) :- action(ACT), sensing(ACT), executable(ACT, true).
% dpre(ACT, 1, true) :- action(ACT), sensing(ACT), executable(ACT, true).
% dpre(ACT, 2, F   ) :- action(ACT), sensing(ACT), executable(ACT, F), formula(F).
% dpre(ACT, 1, F   ) :- action(ACT), sensing(ACT), executable(ACT, F), formula(F).

% pre(ACT, 2,  P) :- action(ACT), sensing(ACT), determines(ACT, P), atom(P).
% pre(ACT, 1, -P) :- action(ACT), sensing(ACT), determines(ACT, P), atom(P).

% formula(-P) :- action(ACT), sensing(ACT), determines(ACT, P), atom(P).

metaq(ACT, 2, 2, f_obs) :- action(ACT), sensing(ACT).
metaq(ACT, 1, 1, f_obs) :- action(ACT), sensing(ACT).

metaq(ACT, 2, 2, p_obs) :- action(ACT), sensing(ACT).
metaq(ACT, 1, 1, p_obs) :- action(ACT), sensing(ACT).
metaq(ACT, 2, 1, p_obs) :- action(ACT), sensing(ACT).
metaq(ACT, 1, 2, p_obs) :- action(ACT), sensing(ACT).

metaq(ACT, 2, 0, obl  ) :- action(ACT), sensing(ACT).
metaq(ACT, 1, 0, obl  ) :- action(ACT), sensing(ACT).
metaq(ACT, 0, 0, all  ) :- action(ACT), sensing(ACT).

% Announcement actions
e(ACT, 2, 0, 0) :- action(ACT), announcement(ACT).      % sigma
e(ACT, 1, 0, 0) :- action(ACT), announcement(ACT).      % tau
e(ACT, 0, 1, 0) :- action(ACT), announcement(ACT).      % epsilon

de(ACT, 2) :- action(ACT), announcement(ACT).

% dpre(ACT, 2, true) :- action(ACT), announcement(ACT), executable(ACT, true).
% dpre(ACT, 2, F   ) :- action(ACT), announcement(ACT), executable(ACT, F), formula(F).

% pre(ACT, 2,  P) :- action(ACT), announcement(ACT), announces(ACT, P), atom(P).
% pre(ACT, 1, -P) :- action(ACT), announcement(ACT), announces(ACT, P), atom(P).

% formula(-P) :- action(ACT), announcement(ACT), announces(ACT, P), atom(P).

metaq(ACT, 2, 2, f_obs) :- action(ACT), announcement(ACT).
metaq(ACT, 1, 1, f_obs) :- action(ACT), announcement(ACT).

metaq(ACT, 2, 2, p_obs) :- action(ACT), announcement(ACT).
metaq(ACT, 1, 1, p_obs) :- action(ACT), announcement(ACT).
metaq(ACT, 2, 1, p_obs) :- action(ACT), announcement(ACT).
metaq(ACT, 1, 2, p_obs) :- action(ACT), announcement(ACT).

metaq(ACT, 2, 0, obl  ) :- action(ACT), announcement(ACT).
metaq(ACT, 1, 0, obl  ) :- action(ACT), announcement(ACT).
metaq(ACT, 0, 0, all  ) :- action(ACT), announcement(ACT).
