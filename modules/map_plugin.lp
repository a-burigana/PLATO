% ********** mA^\rho PLUGIN **********

#program base.

%%% Generating preconditions for epistemic actions %%%
formula(and( P, F)) :- action(ACT), sensing(ACT), executable(ACT, F), determines(ACT, P, _), formula(F), atom(P).
formula(and(-P, F)) :- action(ACT), sensing(ACT), executable(ACT, F), determines(ACT, P, _), formula(F), atom(P).
formula(-P)         :- action(ACT), sensing(ACT), executable(ACT, F), determines(ACT, P, _),             atom(P).

formula(and( P, F)) :- action(ACT), announcement(ACT), executable(ACT, F), announces(ACT, P, _), formula(F), atom(P).
formula(and(-P, F)) :- action(ACT), announcement(ACT), executable(ACT, F), announces(ACT, P, _), formula(F), atom(P).
formula(-P)         :- action(ACT), announcement(ACT), executable(ACT, F), announces(ACT, P, _),             atom(P).


#program step(t).

%%% Checking observability relations %%%
is_fully_obs  (t, AG) :- t > 0, time(t), plan(t, ACT),       action(ACT),  observes(ACT, AG, true), agent(AG).
is_partial_obs(t, AG) :- t > 0, time(t), plan(t, ACT),      sensing(ACT),  aware_of(ACT, AG, true), agent(AG).
is_partial_obs(t, AG) :- t > 0, time(t), plan(t, ACT), announcement(ACT),  aware_of(ACT, AG, true), agent(AG).
is_oblivious  (t, AG) :- t > 0, time(t), plan(t, ACT),       action(ACT), oblivious(ACT, AG),       agent(AG).

is_fully_obs  (t, AG) :- t > 0, time(t), plan(t, ACT),       action(ACT),  observes(ACT, AG, F   ), agent(AG), formula(F),     entails(pw(t-1, W, E), F), dw(t-1, W, E).
is_partial_obs(t, AG) :- t > 0, time(t), plan(t, ACT),      sensing(ACT),  aware_of(ACT, AG, F   ), agent(AG), formula(F),     entails(pw(t-1, W, E), F), dw(t-1, W, E).
is_partial_obs(t, AG) :- t > 0, time(t), plan(t, ACT), announcement(ACT),  aware_of(ACT, AG, F   ), agent(AG), formula(F),     entails(pw(t-1, W, E), F), dw(t-1, W, E).
is_oblivious  (t, AG) :- t > 0, time(t), plan(t, ACT),       action(ACT),  observes(ACT, AG, F   ), agent(AG), formula(F), not entails(pw(t-1, W, E), F), dw(t-1, W, E).
is_oblivious  (t, AG) :- t > 0, time(t), plan(t, ACT),      sensing(ACT),  aware_of(ACT, AG, F   ), agent(AG), formula(F), not entails(pw(t-1, W, E), F), dw(t-1, W, E).
is_oblivious  (t, AG) :- t > 0, time(t), plan(t, ACT), announcement(ACT),  aware_of(ACT, AG, F   ), agent(AG), formula(F), not entails(pw(t-1, W, E), F), dw(t-1, W, E).


%%% Generating event spectrum %%%

% Ontic actions
e(t, ACT, sig) :- t > 0, time(t), plan(t, ACT), action(ACT), ontic(ACT).
e(t, ACT, eps) :- t > 0, time(t), plan(t, ACT), action(ACT), ontic(ACT).

de(t, ACT, sig) :- t > 0, time(t), plan(t, ACT), action(ACT), ontic(ACT).

pre(t, ACT, sig, F   ) :- t > 0, time(t), plan(t, ACT), action(ACT), ontic(ACT), executable(ACT, F), formula(F).
pre(t, ACT, eps, true) :- t > 0, time(t), plan(t, ACT), action(ACT), ontic(ACT).

post(t, ACT, sig, P, F) :- t > 0, time(t), plan(t, ACT), action(ACT), ontic(ACT), literal(P),     causes(ACT, P, F), formula(F).
post(t, ACT, sig, P, P) :- t > 0, time(t), plan(t, ACT), action(ACT), ontic(ACT),    atom(P), not causes(ACT, P, _).
post(t, ACT, eps, P, P) :- t > 0, time(t), plan(t, ACT), action(ACT), ontic(ACT),    atom(P).

q(e(t, ACT, sig), e(t, ACT, sig), AG) :- t > 0, time(t), plan(t, ACT), action(ACT), ontic(ACT), agent(AG), is_fully_obs(t, AG).
q(e(t, ACT, sig), e(t, ACT, eps), AG) :- t > 0, time(t), plan(t, ACT), action(ACT), ontic(ACT), agent(AG), is_oblivious(t, AG).
q(e(t, ACT, eps), e(t, ACT, eps), AG) :- t > 0, time(t), plan(t, ACT), action(ACT), ontic(ACT), agent(AG).

% Sensing actions
e(t, ACT, sig) :- t > 0, time(t), plan(t, ACT), action(ACT), sensing(ACT).
e(t, ACT, tau) :- t > 0, time(t), plan(t, ACT), action(ACT), sensing(ACT).
e(t, ACT, eps) :- t > 0, time(t), plan(t, ACT), action(ACT), sensing(ACT).

de(t, ACT, sig) :- t > 0, time(t), plan(t, ACT), action(ACT), sensing(ACT).

pre(t, ACT, sig, and( P, F)) :- t > 0, time(t), plan(t, ACT), action(ACT), sensing(ACT), executable(ACT, F), determines(ACT, P, _).
pre(t, ACT, sig, and(-P, F)) :- t > 0, time(t), plan(t, ACT), action(ACT), sensing(ACT), executable(ACT, F), determines(ACT, P, _).
pre(t, ACT, eps, true      ) :- t > 0, time(t), plan(t, ACT), action(ACT), sensing(ACT).

post(t, ACT, sig, P, P) :- t > 0, time(t), plan(t, ACT), action(ACT), sensing(ACT), atom(P).
post(t, ACT, tau, P, P) :- t > 0, time(t), plan(t, ACT), action(ACT), sensing(ACT), atom(P).
post(t, ACT, eps, P, P) :- t > 0, time(t), plan(t, ACT), action(ACT), sensing(ACT), atom(P).

q(e(t, ACT, sig), e(t, ACT, sig), AG) :- t > 0, time(t), plan(t, ACT), action(ACT), sensing(ACT), agent(AG), is_fully_obs(t, AG).
q(e(t, ACT, tau), e(t, ACT, tau), AG) :- t > 0, time(t), plan(t, ACT), action(ACT), sensing(ACT), agent(AG), is_fully_obs(t, AG).

q(e(t, ACT, sig), e(t, ACT, sig), AG) :- t > 0, time(t), plan(t, ACT), action(ACT), sensing(ACT), agent(AG), is_partial_obs(t, AG).
q(e(t, ACT, tau), e(t, ACT, tau), AG) :- t > 0, time(t), plan(t, ACT), action(ACT), sensing(ACT), agent(AG), is_partial_obs(t, AG).
q(e(t, ACT, sig), e(t, ACT, tau), AG) :- t > 0, time(t), plan(t, ACT), action(ACT), sensing(ACT), agent(AG), is_partial_obs(t, AG).
q(e(t, ACT, tau), e(t, ACT, sig), AG) :- t > 0, time(t), plan(t, ACT), action(ACT), sensing(ACT), agent(AG), is_partial_obs(t, AG).

q(e(t, ACT, eps), e(t, ACT, eps), AG) :- t > 0, time(t), plan(t, ACT), action(ACT), sensing(ACT), agent(AG).

% Announcement actions
e(t, ACT, sig) :- t > 0, time(t), plan(t, ACT), action(ACT), announcement(ACT).
e(t, ACT, tau) :- t > 0, time(t), plan(t, ACT), action(ACT), announcement(ACT).
e(t, ACT, eps) :- t > 0, time(t), plan(t, ACT), action(ACT), announcement(ACT).

de(t, ACT, sig) :- t > 0, time(t), plan(t, ACT), action(ACT), announcement(ACT).

pre(t, ACT, sig, and( P, F)) :- t > 0, time(t), plan(t, ACT), action(ACT), announcement(ACT), executable(ACT, F), announces(ACT, P, _).
pre(t, ACT, sig, and(-P, F)) :- t > 0, time(t), plan(t, ACT), action(ACT), announcement(ACT), executable(ACT, F), announces(ACT, P, _).
pre(t, ACT, eps, true      ) :- t > 0, time(t), plan(t, ACT), action(ACT), announcement(ACT).

post(t, ACT, sig, P, P) :- t > 0, time(t), plan(t, ACT), action(ACT), announcement(ACT), atom(P).
post(t, ACT, tau, P, P) :- t > 0, time(t), plan(t, ACT), action(ACT), announcement(ACT), atom(P).
post(t, ACT, eps, P, P) :- t > 0, time(t), plan(t, ACT), action(ACT), announcement(ACT), atom(P).

q(e(t, ACT, sig), e(t, ACT, sig), AG) :- t > 0, time(t), plan(t, ACT), action(ACT), announcement(ACT), agent(AG), is_fully_obs(t, AG).
q(e(t, ACT, tau), e(t, ACT, tau), AG) :- t > 0, time(t), plan(t, ACT), action(ACT), announcement(ACT), agent(AG), is_fully_obs(t, AG).

q(e(t, ACT, sig), e(t, ACT, sig), AG) :- t > 0, time(t), plan(t, ACT), action(ACT), announcement(ACT), agent(AG), is_partial_obs(t, AG).
q(e(t, ACT, tau), e(t, ACT, tau), AG) :- t > 0, time(t), plan(t, ACT), action(ACT), announcement(ACT), agent(AG), is_partial_obs(t, AG).
q(e(t, ACT, sig), e(t, ACT, tau), AG) :- t > 0, time(t), plan(t, ACT), action(ACT), announcement(ACT), agent(AG), is_partial_obs(t, AG).
q(e(t, ACT, tau), e(t, ACT, sig), AG) :- t > 0, time(t), plan(t, ACT), action(ACT), announcement(ACT), agent(AG), is_partial_obs(t, AG).

q(e(t, ACT, eps), e(t, ACT, eps), AG) :- t > 0, time(t), plan(t, ACT), action(ACT), announcement(ACT), agent(AG).
