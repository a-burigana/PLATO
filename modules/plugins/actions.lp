#program base.
epistemic(ACT) :- sensing(ACT).
epistemic(ACT) :- announcement(ACT).

obs_type(f_obs).
obs_type(p_obs).
obs_type(obl  ).
obs_type(all  ).

%%% Generating event spectrum %%%

% Events: e(<act_name>, <event_name>, <is_null>, <has_post>).

% Ontic actions
e(ACT, 1, 0, 1) :- action(ACT), ontic(ACT).             % sigma
e(ACT, 0, 1, 0) :- action(ACT), ontic(ACT).             % epsilon

de(ACT, 1) :- action(ACT), ontic(ACT).

metaq(ACT, 1, 1, f_obs) :- action(ACT), ontic(ACT).
metaq(ACT, 1, 0, obl  ) :- action(ACT), ontic(ACT).
metaq(ACT, 0, 0, all  ) :- action(ACT), ontic(ACT).

% Sensing actions
e(ACT, 2, 0, 0) :- action(ACT), sensing(ACT).           % sigma
e(ACT, 1, 0, 0) :- action(ACT), sensing(ACT).           % tau
e(ACT, 0, 1, 0) :- action(ACT), sensing(ACT).           % epsilon

de(ACT, 2) :- action(ACT), sensing(ACT).
de(ACT, 1) :- action(ACT), sensing(ACT).

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

metaq(ACT, 2, 2, f_obs) :- action(ACT), announcement(ACT).
metaq(ACT, 1, 1, f_obs) :- action(ACT), announcement(ACT).

metaq(ACT, 2, 2, p_obs) :- action(ACT), announcement(ACT).
metaq(ACT, 1, 1, p_obs) :- action(ACT), announcement(ACT).
metaq(ACT, 2, 1, p_obs) :- action(ACT), announcement(ACT).
metaq(ACT, 1, 2, p_obs) :- action(ACT), announcement(ACT).

metaq(ACT, 2, 0, obl  ) :- action(ACT), announcement(ACT).
metaq(ACT, 1, 0, obl  ) :- action(ACT), announcement(ACT).
metaq(ACT, 0, 0, all  ) :- action(ACT), announcement(ACT).
