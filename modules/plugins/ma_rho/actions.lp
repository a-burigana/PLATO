#program base.
epistemic(ACT) :- sensing(ACT).
epistemic(ACT) :- announcement(ACT).

obs_type(f_obs).
obs_type(p_obs).
obs_type(obl  ).

%%% Generating event spectrum %%%

% Ontic actions
e(ACT, 1) :- action(ACT), ontic(ACT).             % sigma

de(ACT, 1) :- action(ACT), ontic(ACT).

metaq(ACT, 1, 1, f_obs) :- action(ACT), ontic(ACT).
metaq(ACT, 1, 0, obl  ) :- action(ACT), ontic(ACT).

% Sensing actions
e(ACT, 2) :- action(ACT), sensing(ACT).           % sigma
e(ACT, 1) :- action(ACT), sensing(ACT).           % tau

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

% Announcement actions
e(ACT, 2) :- action(ACT), announcement(ACT).      % sigma
e(ACT, 1) :- action(ACT), announcement(ACT).      % tau

de(ACT, 2) :- action(ACT), announcement(ACT).

metaq(ACT, 2, 2, f_obs) :- action(ACT), announcement(ACT).
metaq(ACT, 1, 1, f_obs) :- action(ACT), announcement(ACT).

metaq(ACT, 2, 2, p_obs) :- action(ACT), announcement(ACT).
metaq(ACT, 1, 1, p_obs) :- action(ACT), announcement(ACT).
metaq(ACT, 2, 1, p_obs) :- action(ACT), announcement(ACT).
metaq(ACT, 1, 2, p_obs) :- action(ACT), announcement(ACT).

metaq(ACT, 2, 0, obl  ) :- action(ACT), announcement(ACT).
metaq(ACT, 1, 0, obl  ) :- action(ACT), announcement(ACT).




% n_ontic(K)     :- K = { ontic(ACT)     : action(ACT) }.
% n_epistemic(K) :- K = { epistemic(ACT) : action(ACT) }.

% n_actions(K1+K2) :- n_ontic(K1), n_epistemic(K2).
% event_id(1..K) :- n_ontic(K1), n_epistemic(K2), K = K1 + 2*K2.      % sig_ont + sig_epi + tau+epi

% 1 { e_id(ACT, 1, ID) : event_id(ID) } 1 :- ontic(ACT).      % sig_ont
% 1 { e_id(ACT, 2, ID) : event_id(ID) } 1 :- epistemic(ACT).  % sig_epi, tau_epi
% 1 { e_id(ACT, 1, ID) : event_id(ID) } 1 :- epistemic(ACT).  % sig_epi, tau_epi

% :- e_id(ACT1, E1, ID1), e_id(ACT2, E2, ID2), ID1 = ID2, ACT1 != ACT2.
% :- e_id(ACT , E1, ID1), e_id(ACT , E2, ID2), ID1 = ID2, E1   != E2  .

% % less_then_e(ACT1, E1, ACT2, E2) :- action(ACT1), action(ACT2), e(ACT1, E1), e(ACT2, E2), ACT1 < ACT2.
% % less_then_e(ACT , E1, ACT , E2) :- action(ACT ),               e(ACT , E1), e(ACT , E2), E1   < E2  .

% :- e(ACT1, E1), e(ACT2, E2), e_id(ACT1, E1, ID1), e_id(ACT2, E2, ID2), ACT1 < ACT2, ID1 > ID2.
% :- e(ACT , E1), e(ACT , E2), e_id(ACT , E1, ID1), e_id(ACT , E2, ID2), E1   < E2,   ID1 > ID2.

% % #show less_then_e/4.
% #show e_id/3.

% e(ACT, E) :- e_id(ACT, _, E).

% % Ontic actions
% de(ACT, E) :- e_id(ACT, 1, E), ontic(ACT).

% metaq(ACT, E, E, f_obs) :- ontic(ACT), e_id(ACT, 1, E).
% metaq(ACT, E, 0, obl  ) :- ontic(ACT), e_id(ACT, 1, E).

% % Sensing actions
% de(ACT, E) :- sensing(ACT), e_id(ACT, 2, E).
% de(ACT, E) :- sensing(ACT), e_id(ACT, 1, E).

% metaq(ACT, E , E , f_obs) :- sensing(ACT), e_id(ACT, _, E).

% metaq(ACT, E , E , p_obs) :- sensing(ACT), e_id(ACT, _, E).
% metaq(ACT, E1, E2, p_obs) :- sensing(ACT), e_id(ACT, ID1, E1), e_id(ACT, ID2, E2), E1 != E2, ID1 != ID2.

% metaq(ACT, E , 0 , obl  ) :- sensing(ACT), e_id(ACT, _, E).

% % Sensing announcement
% de(ACT, E) :- announcement(ACT), e_id(ACT, 2, E).

% metaq(ACT, E , E , f_obs) :- announcement(ACT), e_id(ACT, _, E).

% metaq(ACT, E , E , p_obs) :- announcement(ACT), e_id(ACT, _, E).
% metaq(ACT, E1, E2, p_obs) :- announcement(ACT), e_id(ACT, ID1, E1), e_id(ACT, ID2, E2), E1 != E2, ID1 != ID2.

% metaq(ACT, E , 0 , obl  ) :- announcement(ACT), e_id(ACT, _, E).
