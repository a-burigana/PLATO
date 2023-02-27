#program base.
epistemic(ACT) :- sensing(ACT).
epistemic(ACT) :- announcement(ACT).

% ********** EVENT MODELS **********

% ***** ONTIC ACTIONS *****
e(ACT, sig) :- action(ACT), ontic(ACT).
e(ACT, eps) :- action(ACT), ontic(ACT).

-idle(ACT, sig)     :- action(ACT), ontic(ACT).
idle(ACT, eps)      :- action(ACT), ontic(ACT).

q(ACT, sig, sig, f_obs) :- action(ACT), ontic(ACT).
q(ACT, sig, eps, obl  ) :- action(ACT), ontic(ACT).

% precond(ACT, sig, F)    :- action(ACT), ontic(ACT), action_pre(ACT, F).

precond(ACT, sig, true) :- action(ACT), ontic(ACT), action_pre(ACT, F).
precond(ACT, eps, true) :- action(ACT), ontic(ACT).

postcond(ACT, sig, P, F     ) :- action(ACT), ontic(ACT), causes(ACT,     P , F), atom(P).
postcond(ACT, sig, P, neg(F)) :- action(ACT), ontic(ACT), causes(ACT, neg(P), F), atom(P).
inertia( ACT, sig, P        ) :- action(ACT), ontic(ACT), atom(P), 0 { causes(ACT, P, _) } 0, 0 { causes(ACT, neg(P), _) } 0.

de(ACT, sig) :- action(ACT), ontic(ACT).


% ***** SENSING ACTIONS *****
e(ACT, sig) :- action(ACT), sensing(ACT).
e(ACT, tau) :- action(ACT), sensing(ACT).
e(ACT, eps) :- action(ACT), sensing(ACT).

-idle(ACT, sig)     :- action(ACT), sensing(ACT).
-idle(ACT, tau)     :- action(ACT), sensing(ACT).
idle(ACT, eps)      :- action(ACT), sensing(ACT).

q(ACT, sig, sig, f_obs) :- action(ACT), sensing(ACT).
q(ACT, tau, tau, f_obs) :- action(ACT), sensing(ACT).

q(ACT, sig, sig, p_obs) :- action(ACT), sensing(ACT).
q(ACT, tau, tau, p_obs) :- action(ACT), sensing(ACT).
q(ACT, sig, tau, p_obs) :- action(ACT), sensing(ACT).
q(ACT, tau, sig, p_obs) :- action(ACT), sensing(ACT).

q(ACT, sig, eps, obl  ) :- action(ACT), sensing(ACT).
q(ACT, tau, eps, obl  ) :- action(ACT), sensing(ACT).

% precond(ACT, sig, and(P, F))      :- action(ACT), sensing(ACT), action_pre(ACT, F), determines(ACT, P).
% precond(ACT, tau, and(neg(P), F)) :- action(ACT), sensing(ACT), action_pre(ACT, F), determines(ACT, P).

precond(ACT, sig, P)      :- action(ACT), sensing(ACT), determines(ACT, P).
precond(ACT, tau, neg(P)) :- action(ACT), sensing(ACT), determines(ACT, P).
precond(ACT, eps, true)   :- action(ACT), sensing(ACT).

inertia(ACT, E, P) :- action(ACT), sensing(ACT), e(ACT, E), atom(P).

de(ACT, sig) :- action(ACT), sensing(ACT).
de(ACT, tau) :- action(ACT), sensing(ACT).


% ***** ANNOUNCEMENT ACTIONS *****
e(ACT, sig) :- action(ACT), announcement(ACT).
e(ACT, tau) :- action(ACT), announcement(ACT).
e(ACT, eps) :- action(ACT), announcement(ACT).

-idle(ACT, sig)      :- action(ACT), announcement(ACT).
-idle(ACT, tau)      :- action(ACT), announcement(ACT).
idle(ACT, eps)       :- action(ACT), announcement(ACT).

q(ACT, sig, sig, f_obs) :- action(ACT), announcement(ACT).
q(ACT, tau, tau, f_obs) :- action(ACT), announcement(ACT).

q(ACT, sig, sig, p_obs) :- action(ACT), announcement(ACT).
q(ACT, tau, tau, p_obs) :- action(ACT), announcement(ACT).
q(ACT, sig, tau, p_obs) :- action(ACT), announcement(ACT).
q(ACT, tau, sig, p_obs) :- action(ACT), announcement(ACT).

q(ACT, sig, eps, obl  ) :- action(ACT), announcement(ACT).
q(ACT, tau, eps, obl  ) :- action(ACT), announcement(ACT).

% precond(ACT, sig, and(F2, F))      :- action(ACT), announcement(ACT), action_pre(ACT, F), announces(ACT, F2).
% precond(ACT, tau, and(neg(F2), F)) :- action(ACT), announcement(ACT), action_pre(ACT, F), announces(ACT, F2).

precond(ACT, sig, F)      :- action(ACT), announcement(ACT), announces(ACT, F).
precond(ACT, tau, neg(F)) :- action(ACT), announcement(ACT), announces(ACT, F).
precond(ACT, eps, true)   :- action(ACT), announcement(ACT).

inertia(ACT, E, P) :- action(ACT), announcement(ACT), e(ACT, E), atom(P).

de(ACT, sig) :- action(ACT), announcement(ACT).



% % ***** MY ONTIC ACTIONS *****
% e(ACT, sig1) :- action(ACT), my_ontic(ACT).
% e(ACT, sig2) :- action(ACT), my_ontic(ACT).
% e(ACT, eps ) :- action(ACT), my_ontic(ACT).

% -idle(ACT, sig1)     :- action(ACT), my_ontic(ACT).
% -idle(ACT, sig2)     :- action(ACT), my_ontic(ACT).
% idle(ACT, eps)       :- action(ACT), my_ontic(ACT).

% q(ACT, sig1, sig1, f_obs) :- action(ACT), my_ontic(ACT).
% q(ACT, sig1, sig2, s_obs) :- action(ACT), my_ontic(ACT).

% q(ACT, sig2, sig2, f_obs) :- action(ACT), my_ontic(ACT).
% q(ACT, sig2, sig2, s_obs) :- action(ACT), my_ontic(ACT).

% q(ACT, sig1, eps , obl  ) :- action(ACT), my_ontic(ACT).
% q(ACT, sig2, eps , obl  ) :- action(ACT), my_ontic(ACT).

% precond(ACT, sig1, F)    :- action(ACT), my_ontic(ACT), action_pre(ACT, F).
% precond(ACT, sig2, true) :- action(ACT), my_ontic(ACT).
% precond(ACT, eps , true) :- action(ACT), my_ontic(ACT).

% postcond(ACT, sig1, P, F     ) :- action(ACT), my_ontic(ACT), causes(ACT,  P, F), atom(P).
% postcond(ACT, sig2, P, F     ) :- action(ACT), my_ontic(ACT), causes(ACT,  P, F), atom(P).

% postcond(ACT, sig1, P, neg(F)) :- action(ACT), my_ontic(ACT), causes(ACT, -P, F), atom(P).
% postcond(ACT, sig2, P, neg(F)) :- action(ACT), my_ontic(ACT), causes(ACT, -P, F), atom(P).

% inertia( ACT, sig1, P        ) :- action(ACT), my_ontic(ACT), atom(P), 0 { causes(ACT, P, _) } 0, 0 { causes(ACT, -P, _) } 0.
% inertia( ACT, sig2, P        ) :- action(ACT), my_ontic(ACT), atom(P), 0 { causes(ACT, P, _) } 0, 0 { causes(ACT, -P, _) } 0.

% de(ACT, sig1) :- action(ACT), my_ontic(ACT).
