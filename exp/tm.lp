#const maxT  = 0.
#const n_fl  = 6.
#const n_ag  = 3.
#const n_ags = 7.

%time(0..maxT).

% *** FLUENTS ***
fluent(a0).
formula(a0).
fluent(a1).
formula(a1).
fluent(bl).
formula(bl).
fluent(q0).
formula(q0).
fluent(q1).
formula(q1).
fluent(qf).
formula(qf).


% *** AGENTS ***
agent(a).
agent(b).
agent(c).


% *** ACTIONS ***
action(erase).
ontic(erase).
formula(-a0).
causes(erase, -a0, true).
formula(-a1).
causes(erase, -a1, true).
causes(erase, bl, true).
executable(erase, true).
observes(erase, a, true).
oblivious(erase, b).
oblivious(erase, c).


action(goto_q0).
ontic(goto_q0).
causes(goto_q0, q0, true).
formula(-q1).
ce_formula(q1).
causes(goto_q0, -q1, q1).
formula(-qf).
ce_formula(qf).
causes(goto_q0, -qf, qf).
executable(goto_q0, true).
observes(goto_q0, a, true).
observes(goto_q0, b, true).
observes(goto_q0, c, true).


action(goto_q1).
ontic(goto_q1).
formula(-q0).
ce_formula(q0).
causes(goto_q1, -q0, q0).
causes(goto_q1, q1, true).
causes(goto_q1, -qf, qf).
executable(goto_q1, true).
observes(goto_q1, a, true).
observes(goto_q1, b, true).
observes(goto_q1, c, true).


action(goto_qf).
ontic(goto_qf).
causes(goto_qf, -q0, q0).
causes(goto_qf, -q1, q1).
causes(goto_qf, qf, true).
executable(goto_qf, true).
observes(goto_qf, a, true).
observes(goto_qf, b, true).
observes(goto_qf, c, true).


action(read_0).
sensing(read_0).
determines(read_0, a0, true).
executable(read_0, a0).
observes(read_0, a, true).
observes(read_0, b, true).
oblivious(read_0, c).


action(read_1).
sensing(read_1).
determines(read_1, a1, true).
executable(read_1, a1).
observes(read_1, a, true).
observes(read_1, b, true).
oblivious(read_1, c).


action(read_bl).
sensing(read_bl).
determines(read_bl, bl, true).
executable(read_bl, bl).
observes(read_bl, a, true).
observes(read_bl, b, true).
oblivious(read_bl, c).


action(share_ab_0).
announcement(share_ab_0).
announces(share_ab_0, a0, true).
formula(b(a,a0)).
formula(and(b(a,a0),a0)).
executable(share_ab_0, and(b(a,a0),a0)).
observes(share_ab_0, a, true).
observes(share_ab_0, b, true).
aware_of(share_ab_0, c, true).


action(share_ab_1).
announcement(share_ab_1).
announces(share_ab_1, a1, true).
formula(b(a,a1)).
formula(and(b(a,a1),a1)).
executable(share_ab_1, and(b(a,a1),a1)).
observes(share_ab_1, a, true).
observes(share_ab_1, b, true).
aware_of(share_ab_1, c, true).


action(share_ab_bl).
announcement(share_ab_bl).
announces(share_ab_bl, bl, true).
formula(b(a,bl)).
formula(and(b(a,bl),bl)).
executable(share_ab_bl, and(b(a,bl),bl)).
observes(share_ab_bl, a, true).
observes(share_ab_bl, b, true).
aware_of(share_ab_bl, c, true).


action(share_ac_0).
announcement(share_ac_0).
announces(share_ac_0, a0, true).
executable(share_ac_0, and(b(a,a0),a0)).
observes(share_ac_0, a, true).
observes(share_ac_0, c, true).
aware_of(share_ac_0, b, true).


action(share_ac_1).
announcement(share_ac_1).
announces(share_ac_1, a1, true).
executable(share_ac_1, and(b(a,a1),a1)).
observes(share_ac_1, a, true).
observes(share_ac_1, c, true).
aware_of(share_ac_1, b, true).


action(share_ac_bl).
announcement(share_ac_bl).
announces(share_ac_bl, bl, true).
executable(share_ac_bl, and(b(a,bl),bl)).
observes(share_ac_bl, a, true).
observes(share_ac_bl, c, true).
aware_of(share_ac_bl, b, true).


action(share_b_0).
announcement(share_b_0).
announces(share_b_0, a0, true).
executable(share_b_0, and(b(a,a0),a0)).
observes(share_b_0, a, true).
observes(share_b_0, b, true).
oblivious(share_b_0, c).


action(share_b_1).
announcement(share_b_1).
announces(share_b_1, a1, true).
executable(share_b_1, and(b(a,a1),a1)).
observes(share_b_1, a, true).
observes(share_b_1, b, true).
oblivious(share_b_1, c).


action(share_b_bl).
announcement(share_b_bl).
announces(share_b_bl, bl, true).
executable(share_b_bl, and(b(a,bl),bl)).
observes(share_b_bl, a, true).
observes(share_b_bl, b, true).
oblivious(share_b_bl, c).


action(share_c_0).
announcement(share_c_0).
announces(share_c_0, a0, true).
executable(share_c_0, and(b(a,a0),a0)).
observes(share_c_0, a, true).
observes(share_c_0, c, true).
oblivious(share_c_0, b).


action(share_c_1).
announcement(share_c_1).
announces(share_c_1, a1, true).
executable(share_c_1, and(b(a,a1),a1)).
observes(share_c_1, a, true).
observes(share_c_1, c, true).
oblivious(share_c_1, b).


action(share_c_bl).
announcement(share_c_bl).
announces(share_c_bl, bl, true).
executable(share_c_bl, and(b(a,bl),bl)).
observes(share_c_bl, a, true).
observes(share_c_bl, c, true).
oblivious(share_c_bl, b).


action(write_ab_0).
ontic(write_ab_0).
causes(write_ab_0, a0, true).
ce_formula(a1).
causes(write_ab_0, -a1, a1).
formula(-bl).
ce_formula(bl).
causes(write_ab_0, -bl, bl).
executable(write_ab_0, true).
observes(write_ab_0, a, true).
observes(write_ab_0, b, true).
oblivious(write_ab_0, c).


action(write_ab_1).
ontic(write_ab_1).
ce_formula(a0).
causes(write_ab_1, -a0, a0).
causes(write_ab_1, a1, true).
causes(write_ab_1, -bl, bl).
executable(write_ab_1, true).
observes(write_ab_1, a, true).
observes(write_ab_1, b, true).
oblivious(write_ab_1, c).


action(write_ab_bl).
ontic(write_ab_bl).
causes(write_ab_bl, -a0, a0).
causes(write_ab_bl, -a1, a1).
causes(write_ab_bl, bl, true).
executable(write_ab_bl, true).
observes(write_ab_bl, a, true).
observes(write_ab_bl, b, true).
oblivious(write_ab_bl, c).


action(write_ac_0).
ontic(write_ac_0).
causes(write_ac_0, a0, true).
causes(write_ac_0, -a1, a1).
causes(write_ac_0, -bl, bl).
executable(write_ac_0, true).
observes(write_ac_0, a, true).
observes(write_ac_0, c, true).
oblivious(write_ac_0, b).


action(write_ac_1).
ontic(write_ac_1).
causes(write_ac_1, -a0, a0).
causes(write_ac_1, a1, true).
causes(write_ac_1, -bl, bl).
executable(write_ac_1, true).
observes(write_ac_1, a, true).
observes(write_ac_1, c, true).
oblivious(write_ac_1, b).


action(write_ac_bl).
ontic(write_ac_bl).
causes(write_ac_bl, -a0, a0).
causes(write_ac_bl, -a1, a1).
causes(write_ac_bl, bl, true).
executable(write_ac_bl, true).
observes(write_ac_bl, a, true).
observes(write_ac_bl, c, true).
oblivious(write_ac_bl, b).


action(write_bc_0).
ontic(write_bc_0).
causes(write_bc_0, a0, true).
causes(write_bc_0, -a1, a1).
causes(write_bc_0, -bl, bl).
executable(write_bc_0, true).
observes(write_bc_0, b, true).
observes(write_bc_0, c, true).
oblivious(write_bc_0, a).


action(write_bc_1).
ontic(write_bc_1).
causes(write_bc_1, -a0, a0).
causes(write_bc_1, a1, true).
causes(write_bc_1, -bl, bl).
executable(write_bc_1, true).
observes(write_bc_1, b, true).
observes(write_bc_1, c, true).
oblivious(write_bc_1, a).


action(write_bc_bl).
ontic(write_bc_bl).
causes(write_bc_bl, -a0, a0).
causes(write_bc_bl, -a1, a1).
causes(write_bc_bl, bl, true).
executable(write_bc_bl, true).
observes(write_bc_bl, b, true).
observes(write_bc_bl, c, true).
oblivious(write_bc_bl, a).




% *** INITIALLY ***

% ** initial pointed **
initially(-a0).
initially(-a1).
initially(bl).
initially(q0).
initially(-q1).
initially(-qf).

% ** initial beliefs **
agent_set(all_agents).
contains_ag(all_agents,a).
contains_ag(all_agents,b).
contains_ag(all_agents,c).
formula(c(all_agents,q0)).
initially(c(all_agents,q0)).
formula(c(all_agents,-q1)).
initially(c(all_agents,-q1)).
formula(c(all_agents,-qf)).
initially(c(all_agents,-qf)).
formula(c(all_agents,bl)).
initially(c(all_agents,bl)).
formula(c(all_agents,-a0)).
initially(c(all_agents,-a0)).
formula(c(all_agents,-a1)).
initially(c(all_agents,-a1)).



% ** commonly known fluent formulae **
init_sf(q0).
init_sf(-q1).
init_sf(-qf).
init_sf(bl).
init_sf(-a0).
init_sf(-a1).


% *** GOALS ***
goal(-qf).


