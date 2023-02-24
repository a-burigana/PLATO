%%%%% Multi-pointed Kripke model %%%%%
% At each time step we have exactly one Kripke model
% Let t=0. We now describe how a simple Kripke model is represented

%% Agents
ag(a). ag(b).

%% Propositional atoms
atom(p). atom(q).

#program step(t).

% Worlds (w/2) - w(t, W) means that at time t there exists a world named W
w(t, 1).
w(t, 2).

% Pointed worlds (pw/2) - pw(t, W) means that at time t W is a pointed world
pw(t, 1).

% Relations (r/4) - r(t, W1, W2, AG) means that at time t there exist an edge from W1 to W2 labelled with AG
r(t, 1, 1, a). r(t, 1, 2, b).
r(t, 2, 2, a). r(t, 2, 2, b).

%%% Valuation (holds/3) - holds(t, W, P) (resp., holds(t, W, -P)) means that at time t, atom P is true (resp., false) in world W
holds(t, 1,  p). holds(t, 1, -q).
holds(t, 2, -p). holds(t, 2, -q).


%%%%% Modal formulae %%%%%
% The syntax of a modad formula is as follows (where P is a propositional atom, AG is an agent and F, F1, F2 are formulae):
%  - P / -P
%  - not(F)
%  - and(F1, F2)
%  - box(AG, F)

% Suppose we have the following formula:
formula(box(a, box(b, -q))).

% This formula also requires the following to be formulae:
formula(box(b, -q)).
formula(-q).

% I would like to write a Python function that checks whether a modal
% formula is true in a Kripke model at time t. Something like "@models(t, F)"

% The semantics of truth for modal formulae is the standard one of Kripke
% semantics (if you need further details, please do let me know). Moreover,
% we also have that:
% (M, {pw_1, ..., pw_n}) |= phi  iff  for each pw_i, (M, pw_i) |= phi
