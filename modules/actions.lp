#program base.
epistemic(ACT) :- action_type(ACT, sensing).
epistemic(ACT) :- action_type(ACT, announcement).

% ********** EVENT MODELS **********

% ***** ONTIC ACTIONS *****
e(ACT, sig) :- action(ACT), action_type(ACT, ontic).
e(ACT, eps) :- action(ACT), action_type(ACT, ontic).

-idle(ACT, sig)     :- action(ACT), action_type(ACT, ontic).
idle(ACT, eps)      :- action(ACT), action_type(ACT, ontic).

q(ACT, sig, sig, f_obs) :- action(ACT), action_type(ACT, ontic).
q(ACT, sig, eps, obl  ) :- action(ACT), action_type(ACT, ontic).

q(ACT, eps, eps, f_obs) :- action(ACT), action_type(ACT, ontic).
q(ACT, eps, eps, obl  ) :- action(ACT), action_type(ACT, ontic).

precond(ACT, sig, true) :- action(ACT), action_type(ACT, ontic), action_pre(ACT, F).
precond(ACT, eps, true) :- action(ACT), action_type(ACT, ontic).

postcond(ACT, sig, P, F     ) :- action(ACT), action_type(ACT, ontic), causes(ACT,     P , F), atom(P).
postcond(ACT, sig, P, neg(F)) :- action(ACT), action_type(ACT, ontic), causes(ACT, neg(P), F), atom(P).

inertia( ACT, sig, P        ) :- action(ACT), action_type(ACT, ontic), atom(P), 0 { postcond(ACT, sig, P, F) } 0, 0 { postcond(ACT, sig, P, neg(F)) } 0.
inertia( ACT, eps, P        ) :- action(ACT), action_type(ACT, ontic), atom(P).

de(ACT, sig) :- action(ACT), action_type(ACT, ontic).


% ***** SENSING ACTIONS *****
e(ACT, sig) :- action(ACT), action_type(ACT, sensing).
e(ACT, tau) :- action(ACT), action_type(ACT, sensing).
e(ACT, eps) :- action(ACT), action_type(ACT, sensing).

-idle(ACT, sig)     :- action(ACT), action_type(ACT, sensing).
-idle(ACT, tau)     :- action(ACT), action_type(ACT, sensing).
idle(ACT, eps)      :- action(ACT), action_type(ACT, sensing).

q(ACT, sig, sig, f_obs) :- action(ACT), action_type(ACT, sensing).
q(ACT, tau, tau, f_obs) :- action(ACT), action_type(ACT, sensing).

q(ACT, sig, sig, p_obs) :- action(ACT), action_type(ACT, sensing).
q(ACT, tau, tau, p_obs) :- action(ACT), action_type(ACT, sensing).
q(ACT, sig, tau, p_obs) :- action(ACT), action_type(ACT, sensing).
q(ACT, tau, sig, p_obs) :- action(ACT), action_type(ACT, sensing).

q(ACT, sig, eps, obl  ) :- action(ACT), action_type(ACT, sensing).
q(ACT, tau, eps, obl  ) :- action(ACT), action_type(ACT, sensing).

q(ACT, eps, eps, f_obs) :- action(ACT), action_type(ACT, sensing).
q(ACT, eps, eps, p_obs) :- action(ACT), action_type(ACT, sensing).
q(ACT, eps, eps, obl  ) :- action(ACT), action_type(ACT, sensing).

% precond(ACT, sig, and(P, F))      :- action(ACT), action_type(ACT, sensing), action_pre(ACT, F), determines(ACT, P).
% precond(ACT, tau, and(neg(P), F)) :- action(ACT), action_type(ACT, sensing), action_pre(ACT, F), determines(ACT, P).

precond(ACT, sig, P)      :- action(ACT), action_type(ACT, sensing), determines(ACT, P).
precond(ACT, tau, neg(P)) :- action(ACT), action_type(ACT, sensing), determines(ACT, P).
precond(ACT, eps, true)   :- action(ACT), action_type(ACT, sensing).

inertia(ACT, E, P) :- action(ACT), action_type(ACT, sensing), e(ACT, E), atom(P).

de(ACT, sig) :- action(ACT), action_type(ACT, sensing).
de(ACT, tau) :- action(ACT), action_type(ACT, sensing).


% ***** ANNOUNCEMENT ACTIONS *****
e(ACT, sig) :- action(ACT), action_type(ACT, announcement).
e(ACT, tau) :- action(ACT), action_type(ACT, announcement).
e(ACT, eps) :- action(ACT), action_type(ACT, announcement).

-idle(ACT, sig)      :- action(ACT), action_type(ACT, announcement).
-idle(ACT, tau)      :- action(ACT), action_type(ACT, announcement).
idle(ACT, eps)       :- action(ACT), action_type(ACT, announcement).

q(ACT, sig, sig, f_obs) :- action(ACT), action_type(ACT, announcement).
q(ACT, tau, tau, f_obs) :- action(ACT), action_type(ACT, announcement).

q(ACT, sig, sig, p_obs) :- action(ACT), action_type(ACT, announcement).
q(ACT, tau, tau, p_obs) :- action(ACT), action_type(ACT, announcement).
q(ACT, sig, tau, p_obs) :- action(ACT), action_type(ACT, announcement).
q(ACT, tau, sig, p_obs) :- action(ACT), action_type(ACT, announcement).

q(ACT, sig, eps, obl  ) :- action(ACT), action_type(ACT, announcement).
q(ACT, tau, eps, obl  ) :- action(ACT), action_type(ACT, announcement).

q(ACT, eps, eps, f_obs) :- action(ACT), action_type(ACT, announcement).
q(ACT, eps, eps, p_obs) :- action(ACT), action_type(ACT, announcement).
q(ACT, eps, eps, obl  ) :- action(ACT), action_type(ACT, announcement).

% precond(ACT, sig, and(F2, F))      :- action(ACT), action_type(ACT, announcement), action_pre(ACT, F), announces(ACT, F2).
% precond(ACT, tau, and(neg(F2), F)) :- action(ACT), action_type(ACT, announcement), action_pre(ACT, F), announces(ACT, F2).

precond(ACT, sig, F)      :- action(ACT), action_type(ACT, announcement), announces(ACT, F).
precond(ACT, tau, neg(F)) :- action(ACT), action_type(ACT, announcement), announces(ACT, F).
precond(ACT, eps, true)   :- action(ACT), action_type(ACT, announcement).

inertia(ACT, E, P) :- action(ACT), action_type(ACT, announcement), e(ACT, E), atom(P).

de(ACT, sig) :- action(ACT), action_type(ACT, announcement).



% % ***** MY ONTIC ACTIONS *****
% e(ACT, sig1) :- action(ACT), my_action_type(ACT, ontic).
% e(ACT, sig2) :- action(ACT), my_action_type(ACT, ontic).
% e(ACT, eps ) :- action(ACT), my_action_type(ACT, ontic).

% -idle(ACT, sig1)     :- action(ACT), my_action_type(ACT, ontic).
% -idle(ACT, sig2)     :- action(ACT), my_action_type(ACT, ontic).
% idle(ACT, eps)       :- action(ACT), my_action_type(ACT, ontic).

% q(ACT, sig1, sig1, f_obs) :- action(ACT), my_action_type(ACT, ontic).
% q(ACT, sig1, sig2, s_obs) :- action(ACT), my_action_type(ACT, ontic).

% q(ACT, sig2, sig2, f_obs) :- action(ACT), my_action_type(ACT, ontic).
% q(ACT, sig2, sig2, s_obs) :- action(ACT), my_action_type(ACT, ontic).

% q(ACT, sig1, eps , obl  ) :- action(ACT), my_action_type(ACT, ontic).
% q(ACT, sig2, eps , obl  ) :- action(ACT), my_action_type(ACT, ontic).

% precond(ACT, sig1, F)    :- action(ACT), my_action_type(ACT, ontic), action_pre(ACT, F).
% precond(ACT, sig2, true) :- action(ACT), my_action_type(ACT, ontic).
% precond(ACT, eps , true) :- action(ACT), my_action_type(ACT, ontic).

% postcond(ACT, sig1, P, F     ) :- action(ACT), my_action_type(ACT, ontic), causes(ACT,  P, F), atom(P).
% postcond(ACT, sig2, P, F     ) :- action(ACT), my_action_type(ACT, ontic), causes(ACT,  P, F), atom(P).

% postcond(ACT, sig1, P, neg(F)) :- action(ACT), my_action_type(ACT, ontic), causes(ACT, -P, F), atom(P).
% postcond(ACT, sig2, P, neg(F)) :- action(ACT), my_action_type(ACT, ontic), causes(ACT, -P, F), atom(P).

% inertia( ACT, sig1, P        ) :- action(ACT), my_action_type(ACT, ontic), atom(P), 0 { causes(ACT, P, _) } 0, 0 { causes(ACT, -P, _) } 0.
% inertia( ACT, sig2, P        ) :- action(ACT), my_action_type(ACT, ontic), atom(P), 0 { causes(ACT, P, _) } 0, 0 { causes(ACT, -P, _) } 0.

% de(ACT, sig1) :- action(ACT), my_action_type(ACT, ontic).
