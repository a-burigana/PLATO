#const maxT  = 6.
#const n_fl  = 15.
#const n_ag  = 5.
#const n_ags = 31.

%time(0..maxT).

% *** ATOMS ***
atom(at_a_1).
atom(at_a_2).
atom(at_b_1).
atom(at_b_2).
atom(at_c_1).
atom(at_c_2).
atom(at_d_1).
atom(at_d_2).
atom(at_e_1).
atom(at_e_2).
atom(sa).
atom(sb).
atom(sc).
atom(sd).
atom(se).


% *** AGENTS ***
agent(a).
agent(b).
agent(c).
agent(d).
agent(e).


% *** ACTIONS ***
action(left_a).
action_type(left_a, ontic).
causes(left_a, at_a_1, true).
causes(left_a, neg(at_a_2), true).
action_pre(left_a, at_a_2).
observes(left_a, a, at_a_2).
observes(left_a, b, at_b_2).
observes(left_a, c, at_c_2).
observes(left_a, d, at_d_2).
observes(left_a, e, at_e_2).


action(left_b).
action_type(left_b, ontic).
causes(left_b, at_b_1, true).
causes(left_b, neg(at_b_2), true).
action_pre(left_b, at_b_2).
observes(left_b, a, at_a_2).
observes(left_b, b, at_b_2).
observes(left_b, c, at_c_2).
observes(left_b, d, at_d_2).
observes(left_b, e, at_e_2).


action(left_c).
action_type(left_c, ontic).
causes(left_c, at_c_1, true).
causes(left_c, neg(at_c_2), true).
action_pre(left_c, at_c_2).
observes(left_c, a, at_a_2).
observes(left_c, b, at_b_2).
observes(left_c, c, at_c_2).
observes(left_c, d, at_d_2).
observes(left_c, e, at_e_2).


action(left_d).
action_type(left_d, ontic).
causes(left_d, at_d_1, true).
causes(left_d, neg(at_d_2), true).
action_pre(left_d, at_d_2).
observes(left_d, a, at_a_2).
observes(left_d, b, at_b_2).
observes(left_d, c, at_c_2).
observes(left_d, d, at_d_2).
observes(left_d, e, at_e_2).


action(left_e).
action_type(left_e, ontic).
causes(left_e, at_e_1, true).
causes(left_e, neg(at_e_2), true).
action_pre(left_e, at_e_2).
observes(left_e, a, at_a_2).
observes(left_e, b, at_b_2).
observes(left_e, c, at_c_2).
observes(left_e, d, at_d_2).
observes(left_e, e, at_e_2).


action(right_a).
action_type(right_a, ontic).
causes(right_a, neg(at_a_1), true).
causes(right_a, at_a_2, true).
action_pre(right_a, at_a_1).
observes(right_a, a, at_a_1).
observes(right_a, b, at_b_1).
observes(right_a, c, at_c_1).
observes(right_a, d, at_d_1).
observes(right_a, e, at_e_1).


action(right_b).
action_type(right_b, ontic).
causes(right_b, neg(at_b_1), true).
causes(right_b, at_b_2, true).
action_pre(right_b, at_b_1).
observes(right_b, a, at_a_1).
observes(right_b, b, at_b_1).
observes(right_b, c, at_c_1).
observes(right_b, d, at_d_1).
observes(right_b, e, at_e_1).


action(right_c).
action_type(right_c, ontic).
causes(right_c, neg(at_c_1), true).
causes(right_c, at_c_2, true).
action_pre(right_c, at_c_1).
observes(right_c, a, at_a_1).
observes(right_c, b, at_b_1).
observes(right_c, c, at_c_1).
observes(right_c, d, at_d_1).
observes(right_c, e, at_e_1).


action(right_d).
action_type(right_d, ontic).
causes(right_d, neg(at_d_1), true).
causes(right_d, at_d_2, true).
action_pre(right_d, at_d_1).
observes(right_d, a, at_a_1).
observes(right_d, b, at_b_1).
observes(right_d, c, at_c_1).
observes(right_d, d, at_d_1).
observes(right_d, e, at_e_1).


action(right_e).
action_type(right_e, ontic).
causes(right_e, neg(at_e_1), true).
causes(right_e, at_e_2, true).
action_pre(right_e, at_e_1).
observes(right_e, a, at_a_1).
observes(right_e, b, at_b_1).
observes(right_e, c, at_c_1).
observes(right_e, d, at_d_1).
observes(right_e, e, at_e_1).


action(share_a_sa_1).
action_type(share_a_sa_1, announcement).
announces(share_a_sa_1, sa).
action_pre(share_a_sa_1, and(box(a,sa),at_a_1)).
observes(share_a_sa_1, a, at_a_1).
observes(share_a_sa_1, b, at_b_1).
observes(share_a_sa_1, c, at_c_1).
observes(share_a_sa_1, d, at_d_1).
observes(share_a_sa_1, e, at_e_1).


action(share_a_sa_2).
action_type(share_a_sa_2, announcement).
announces(share_a_sa_2, sa).
action_pre(share_a_sa_2, and(box(a,sa),at_a_2)).
observes(share_a_sa_2, a, at_a_2).
observes(share_a_sa_2, b, at_b_2).
observes(share_a_sa_2, c, at_c_2).
observes(share_a_sa_2, d, at_d_2).
observes(share_a_sa_2, e, at_e_2).


action(share_a_sb_1).
action_type(share_a_sb_1, announcement).
announces(share_a_sb_1, sb).
action_pre(share_a_sb_1, and(box(a,sb),at_a_1)).
observes(share_a_sb_1, a, at_a_1).
observes(share_a_sb_1, b, at_b_1).
observes(share_a_sb_1, c, at_c_1).
observes(share_a_sb_1, d, at_d_1).
observes(share_a_sb_1, e, at_e_1).


action(share_a_sb_2).
action_type(share_a_sb_2, announcement).
announces(share_a_sb_2, sb).
action_pre(share_a_sb_2, and(box(a,sb),at_a_2)).
observes(share_a_sb_2, a, at_a_2).
observes(share_a_sb_2, b, at_b_2).
observes(share_a_sb_2, c, at_c_2).
observes(share_a_sb_2, d, at_d_2).
observes(share_a_sb_2, e, at_e_2).


action(share_a_sc_1).
action_type(share_a_sc_1, announcement).
announces(share_a_sc_1, sc).
action_pre(share_a_sc_1, and(box(a,sc),at_a_1)).
observes(share_a_sc_1, a, at_a_1).
observes(share_a_sc_1, b, at_b_1).
observes(share_a_sc_1, c, at_c_1).
observes(share_a_sc_1, d, at_d_1).
observes(share_a_sc_1, e, at_e_1).


action(share_a_sc_2).
action_type(share_a_sc_2, announcement).
announces(share_a_sc_2, sc).
action_pre(share_a_sc_2, and(box(a,sc),at_a_2)).
observes(share_a_sc_2, a, at_a_2).
observes(share_a_sc_2, b, at_b_2).
observes(share_a_sc_2, c, at_c_2).
observes(share_a_sc_2, d, at_d_2).
observes(share_a_sc_2, e, at_e_2).


action(share_a_sd_1).
action_type(share_a_sd_1, announcement).
announces(share_a_sd_1, sd).
action_pre(share_a_sd_1, and(box(a,sd),at_a_1)).
observes(share_a_sd_1, a, at_a_1).
observes(share_a_sd_1, b, at_b_1).
observes(share_a_sd_1, c, at_c_1).
observes(share_a_sd_1, d, at_d_1).
observes(share_a_sd_1, e, at_e_1).


action(share_a_sd_2).
action_type(share_a_sd_2, announcement).
announces(share_a_sd_2, sd).
action_pre(share_a_sd_2, and(box(a,sd),at_a_2)).
observes(share_a_sd_2, a, at_a_2).
observes(share_a_sd_2, b, at_b_2).
observes(share_a_sd_2, c, at_c_2).
observes(share_a_sd_2, d, at_d_2).
observes(share_a_sd_2, e, at_e_2).


action(share_a_se_1).
action_type(share_a_se_1, announcement).
announces(share_a_se_1, se).
action_pre(share_a_se_1, and(box(a,se),at_a_1)).
observes(share_a_se_1, a, at_a_1).
observes(share_a_se_1, b, at_b_1).
observes(share_a_se_1, c, at_c_1).
observes(share_a_se_1, d, at_d_1).
observes(share_a_se_1, e, at_e_1).


action(share_a_se_2).
action_type(share_a_se_2, announcement).
announces(share_a_se_2, se).
action_pre(share_a_se_2, and(box(a,se),at_a_2)).
observes(share_a_se_2, a, at_a_2).
observes(share_a_se_2, b, at_b_2).
observes(share_a_se_2, c, at_c_2).
observes(share_a_se_2, d, at_d_2).
observes(share_a_se_2, e, at_e_2).


action(share_b_sa_1).
action_type(share_b_sa_1, announcement).
announces(share_b_sa_1, sa).
action_pre(share_b_sa_1, and(box(b,sa),at_b_1)).
observes(share_b_sa_1, a, at_a_1).
observes(share_b_sa_1, b, at_b_1).
observes(share_b_sa_1, c, at_c_1).
observes(share_b_sa_1, d, at_d_1).
observes(share_b_sa_1, e, at_e_1).


action(share_b_sa_2).
action_type(share_b_sa_2, announcement).
announces(share_b_sa_2, sa).
action_pre(share_b_sa_2, and(box(b,sa),at_b_2)).
observes(share_b_sa_2, a, at_a_2).
observes(share_b_sa_2, b, at_b_2).
observes(share_b_sa_2, c, at_c_2).
observes(share_b_sa_2, d, at_d_2).
observes(share_b_sa_2, e, at_e_2).


action(share_b_sb_1).
action_type(share_b_sb_1, announcement).
announces(share_b_sb_1, sb).
action_pre(share_b_sb_1, and(box(b,sb),at_b_1)).
observes(share_b_sb_1, a, at_a_1).
observes(share_b_sb_1, b, at_b_1).
observes(share_b_sb_1, c, at_c_1).
observes(share_b_sb_1, d, at_d_1).
observes(share_b_sb_1, e, at_e_1).


action(share_b_sb_2).
action_type(share_b_sb_2, announcement).
announces(share_b_sb_2, sb).
action_pre(share_b_sb_2, and(box(b,sb),at_b_2)).
observes(share_b_sb_2, a, at_a_2).
observes(share_b_sb_2, b, at_b_2).
observes(share_b_sb_2, c, at_c_2).
observes(share_b_sb_2, d, at_d_2).
observes(share_b_sb_2, e, at_e_2).


action(share_b_sc_1).
action_type(share_b_sc_1, announcement).
announces(share_b_sc_1, sc).
action_pre(share_b_sc_1, and(box(b,sc),at_b_1)).
observes(share_b_sc_1, a, at_a_1).
observes(share_b_sc_1, b, at_b_1).
observes(share_b_sc_1, c, at_c_1).
observes(share_b_sc_1, d, at_d_1).
observes(share_b_sc_1, e, at_e_1).


action(share_b_sc_2).
action_type(share_b_sc_2, announcement).
announces(share_b_sc_2, sc).
action_pre(share_b_sc_2, and(box(b,sc),at_b_2)).
observes(share_b_sc_2, a, at_a_2).
observes(share_b_sc_2, b, at_b_2).
observes(share_b_sc_2, c, at_c_2).
observes(share_b_sc_2, d, at_d_2).
observes(share_b_sc_2, e, at_e_2).


action(share_b_sd_1).
action_type(share_b_sd_1, announcement).
announces(share_b_sd_1, sd).
action_pre(share_b_sd_1, and(box(b,sd),at_b_1)).
observes(share_b_sd_1, a, at_a_1).
observes(share_b_sd_1, b, at_b_1).
observes(share_b_sd_1, c, at_c_1).
observes(share_b_sd_1, d, at_d_1).
observes(share_b_sd_1, e, at_e_1).


action(share_b_sd_2).
action_type(share_b_sd_2, announcement).
announces(share_b_sd_2, sd).
action_pre(share_b_sd_2, and(box(b,sd),at_b_2)).
observes(share_b_sd_2, a, at_a_2).
observes(share_b_sd_2, b, at_b_2).
observes(share_b_sd_2, c, at_c_2).
observes(share_b_sd_2, d, at_d_2).
observes(share_b_sd_2, e, at_e_2).


action(share_b_se_1).
action_type(share_b_se_1, announcement).
announces(share_b_se_1, se).
action_pre(share_b_se_1, and(box(b,se),at_b_1)).
observes(share_b_se_1, a, at_a_1).
observes(share_b_se_1, b, at_b_1).
observes(share_b_se_1, c, at_c_1).
observes(share_b_se_1, d, at_d_1).
observes(share_b_se_1, e, at_e_1).


action(share_b_se_2).
action_type(share_b_se_2, announcement).
announces(share_b_se_2, se).
action_pre(share_b_se_2, and(box(b,se),at_b_2)).
observes(share_b_se_2, a, at_a_2).
observes(share_b_se_2, b, at_b_2).
observes(share_b_se_2, c, at_c_2).
observes(share_b_se_2, d, at_d_2).
observes(share_b_se_2, e, at_e_2).


action(share_c_sa_1).
action_type(share_c_sa_1, announcement).
announces(share_c_sa_1, sa).
action_pre(share_c_sa_1, and(box(c,sa),at_c_1)).
observes(share_c_sa_1, a, at_a_1).
observes(share_c_sa_1, b, at_b_1).
observes(share_c_sa_1, c, at_c_1).
observes(share_c_sa_1, d, at_d_1).
observes(share_c_sa_1, e, at_e_1).


action(share_c_sa_2).
action_type(share_c_sa_2, announcement).
announces(share_c_sa_2, sa).
action_pre(share_c_sa_2, and(box(c,sa),at_c_2)).
observes(share_c_sa_2, a, at_a_2).
observes(share_c_sa_2, b, at_b_2).
observes(share_c_sa_2, c, at_c_2).
observes(share_c_sa_2, d, at_d_2).
observes(share_c_sa_2, e, at_e_2).


action(share_c_sb_1).
action_type(share_c_sb_1, announcement).
announces(share_c_sb_1, sb).
action_pre(share_c_sb_1, and(box(c,sb),at_c_1)).
observes(share_c_sb_1, a, at_a_1).
observes(share_c_sb_1, b, at_b_1).
observes(share_c_sb_1, c, at_c_1).
observes(share_c_sb_1, d, at_d_1).
observes(share_c_sb_1, e, at_e_1).


action(share_c_sb_2).
action_type(share_c_sb_2, announcement).
announces(share_c_sb_2, sb).
action_pre(share_c_sb_2, and(box(c,sb),at_c_2)).
observes(share_c_sb_2, a, at_a_2).
observes(share_c_sb_2, b, at_b_2).
observes(share_c_sb_2, c, at_c_2).
observes(share_c_sb_2, d, at_d_2).
observes(share_c_sb_2, e, at_e_2).


action(share_c_sc_1).
action_type(share_c_sc_1, announcement).
announces(share_c_sc_1, sc).
action_pre(share_c_sc_1, and(box(c,sc),at_c_1)).
observes(share_c_sc_1, a, at_a_1).
observes(share_c_sc_1, b, at_b_1).
observes(share_c_sc_1, c, at_c_1).
observes(share_c_sc_1, d, at_d_1).
observes(share_c_sc_1, e, at_e_1).


action(share_c_sc_2).
action_type(share_c_sc_2, announcement).
announces(share_c_sc_2, sc).
action_pre(share_c_sc_2, and(box(c,sc),at_c_2)).
observes(share_c_sc_2, a, at_a_2).
observes(share_c_sc_2, b, at_b_2).
observes(share_c_sc_2, c, at_c_2).
observes(share_c_sc_2, d, at_d_2).
observes(share_c_sc_2, e, at_e_2).


action(share_c_sd_1).
action_type(share_c_sd_1, announcement).
announces(share_c_sd_1, sd).
action_pre(share_c_sd_1, and(box(c,sd),at_c_1)).
observes(share_c_sd_1, a, at_a_1).
observes(share_c_sd_1, b, at_b_1).
observes(share_c_sd_1, c, at_c_1).
observes(share_c_sd_1, d, at_d_1).
observes(share_c_sd_1, e, at_e_1).


action(share_c_sd_2).
action_type(share_c_sd_2, announcement).
announces(share_c_sd_2, sd).
action_pre(share_c_sd_2, and(box(c,sd),at_c_2)).
observes(share_c_sd_2, a, at_a_2).
observes(share_c_sd_2, b, at_b_2).
observes(share_c_sd_2, c, at_c_2).
observes(share_c_sd_2, d, at_d_2).
observes(share_c_sd_2, e, at_e_2).


action(share_c_se_1).
action_type(share_c_se_1, announcement).
announces(share_c_se_1, se).
action_pre(share_c_se_1, and(box(c,se),at_c_1)).
observes(share_c_se_1, a, at_a_1).
observes(share_c_se_1, b, at_b_1).
observes(share_c_se_1, c, at_c_1).
observes(share_c_se_1, d, at_d_1).
observes(share_c_se_1, e, at_e_1).


action(share_c_se_2).
action_type(share_c_se_2, announcement).
announces(share_c_se_2, se).
action_pre(share_c_se_2, and(box(c,se),at_c_2)).
observes(share_c_se_2, a, at_a_2).
observes(share_c_se_2, b, at_b_2).
observes(share_c_se_2, c, at_c_2).
observes(share_c_se_2, d, at_d_2).
observes(share_c_se_2, e, at_e_2).


action(share_d_sa_1).
action_type(share_d_sa_1, announcement).
announces(share_d_sa_1, sa).
action_pre(share_d_sa_1, and(box(d,sa),at_d_1)).
observes(share_d_sa_1, a, at_a_1).
observes(share_d_sa_1, b, at_b_1).
observes(share_d_sa_1, c, at_c_1).
observes(share_d_sa_1, d, at_d_1).
observes(share_d_sa_1, e, at_e_1).


action(share_d_sa_2).
action_type(share_d_sa_2, announcement).
announces(share_d_sa_2, sa).
action_pre(share_d_sa_2, and(box(d,sa),at_d_2)).
observes(share_d_sa_2, a, at_a_2).
observes(share_d_sa_2, b, at_b_2).
observes(share_d_sa_2, c, at_c_2).
observes(share_d_sa_2, d, at_d_2).
observes(share_d_sa_2, e, at_e_2).


action(share_d_sb_1).
action_type(share_d_sb_1, announcement).
announces(share_d_sb_1, sb).
action_pre(share_d_sb_1, and(box(d,sb),at_d_1)).
observes(share_d_sb_1, a, at_a_1).
observes(share_d_sb_1, b, at_b_1).
observes(share_d_sb_1, c, at_c_1).
observes(share_d_sb_1, d, at_d_1).
observes(share_d_sb_1, e, at_e_1).


action(share_d_sb_2).
action_type(share_d_sb_2, announcement).
announces(share_d_sb_2, sb).
action_pre(share_d_sb_2, and(box(d,sb),at_d_2)).
observes(share_d_sb_2, a, at_a_2).
observes(share_d_sb_2, b, at_b_2).
observes(share_d_sb_2, c, at_c_2).
observes(share_d_sb_2, d, at_d_2).
observes(share_d_sb_2, e, at_e_2).


action(share_d_sc_1).
action_type(share_d_sc_1, announcement).
announces(share_d_sc_1, sc).
action_pre(share_d_sc_1, and(box(d,sc),at_d_1)).
observes(share_d_sc_1, a, at_a_1).
observes(share_d_sc_1, b, at_b_1).
observes(share_d_sc_1, c, at_c_1).
observes(share_d_sc_1, d, at_d_1).
observes(share_d_sc_1, e, at_e_1).


action(share_d_sc_2).
action_type(share_d_sc_2, announcement).
announces(share_d_sc_2, sc).
action_pre(share_d_sc_2, and(box(d,sc),at_d_2)).
observes(share_d_sc_2, a, at_a_2).
observes(share_d_sc_2, b, at_b_2).
observes(share_d_sc_2, c, at_c_2).
observes(share_d_sc_2, d, at_d_2).
observes(share_d_sc_2, e, at_e_2).


action(share_d_sd_1).
action_type(share_d_sd_1, announcement).
announces(share_d_sd_1, sd).
action_pre(share_d_sd_1, and(box(d,sd),at_d_1)).
observes(share_d_sd_1, a, at_a_1).
observes(share_d_sd_1, b, at_b_1).
observes(share_d_sd_1, c, at_c_1).
observes(share_d_sd_1, d, at_d_1).
observes(share_d_sd_1, e, at_e_1).


action(share_d_sd_2).
action_type(share_d_sd_2, announcement).
announces(share_d_sd_2, sd).
action_pre(share_d_sd_2, and(box(d,sd),at_d_2)).
observes(share_d_sd_2, a, at_a_2).
observes(share_d_sd_2, b, at_b_2).
observes(share_d_sd_2, c, at_c_2).
observes(share_d_sd_2, d, at_d_2).
observes(share_d_sd_2, e, at_e_2).


action(share_d_se_1).
action_type(share_d_se_1, announcement).
announces(share_d_se_1, se).
action_pre(share_d_se_1, and(box(d,se),at_d_1)).
observes(share_d_se_1, a, at_a_1).
observes(share_d_se_1, b, at_b_1).
observes(share_d_se_1, c, at_c_1).
observes(share_d_se_1, d, at_d_1).
observes(share_d_se_1, e, at_e_1).


action(share_d_se_2).
action_type(share_d_se_2, announcement).
announces(share_d_se_2, se).
action_pre(share_d_se_2, and(box(d,se),at_d_2)).
observes(share_d_se_2, a, at_a_2).
observes(share_d_se_2, b, at_b_2).
observes(share_d_se_2, c, at_c_2).
observes(share_d_se_2, d, at_d_2).
observes(share_d_se_2, e, at_e_2).


action(share_e_sa_1).
action_type(share_e_sa_1, announcement).
announces(share_e_sa_1, sa).
action_pre(share_e_sa_1, and(box(e,sa),at_e_1)).
observes(share_e_sa_1, a, at_a_1).
observes(share_e_sa_1, b, at_b_1).
observes(share_e_sa_1, c, at_c_1).
observes(share_e_sa_1, d, at_d_1).
observes(share_e_sa_1, e, at_e_1).


action(share_e_sa_2).
action_type(share_e_sa_2, announcement).
announces(share_e_sa_2, sa).
action_pre(share_e_sa_2, and(box(e,sa),at_e_2)).
observes(share_e_sa_2, a, at_a_2).
observes(share_e_sa_2, b, at_b_2).
observes(share_e_sa_2, c, at_c_2).
observes(share_e_sa_2, d, at_d_2).
observes(share_e_sa_2, e, at_e_2).


action(share_e_sb_1).
action_type(share_e_sb_1, announcement).
announces(share_e_sb_1, sb).
action_pre(share_e_sb_1, and(box(e,sb),at_e_1)).
observes(share_e_sb_1, a, at_a_1).
observes(share_e_sb_1, b, at_b_1).
observes(share_e_sb_1, c, at_c_1).
observes(share_e_sb_1, d, at_d_1).
observes(share_e_sb_1, e, at_e_1).


action(share_e_sb_2).
action_type(share_e_sb_2, announcement).
announces(share_e_sb_2, sb).
action_pre(share_e_sb_2, and(box(e,sb),at_e_2)).
observes(share_e_sb_2, a, at_a_2).
observes(share_e_sb_2, b, at_b_2).
observes(share_e_sb_2, c, at_c_2).
observes(share_e_sb_2, d, at_d_2).
observes(share_e_sb_2, e, at_e_2).


action(share_e_sc_1).
action_type(share_e_sc_1, announcement).
announces(share_e_sc_1, sc).
action_pre(share_e_sc_1, and(box(e,sc),at_e_1)).
observes(share_e_sc_1, a, at_a_1).
observes(share_e_sc_1, b, at_b_1).
observes(share_e_sc_1, c, at_c_1).
observes(share_e_sc_1, d, at_d_1).
observes(share_e_sc_1, e, at_e_1).


action(share_e_sc_2).
action_type(share_e_sc_2, announcement).
announces(share_e_sc_2, sc).
action_pre(share_e_sc_2, and(box(e,sc),at_e_2)).
observes(share_e_sc_2, a, at_a_2).
observes(share_e_sc_2, b, at_b_2).
observes(share_e_sc_2, c, at_c_2).
observes(share_e_sc_2, d, at_d_2).
observes(share_e_sc_2, e, at_e_2).


action(share_e_sd_1).
action_type(share_e_sd_1, announcement).
announces(share_e_sd_1, sd).
action_pre(share_e_sd_1, and(box(e,sd),at_e_1)).
observes(share_e_sd_1, a, at_a_1).
observes(share_e_sd_1, b, at_b_1).
observes(share_e_sd_1, c, at_c_1).
observes(share_e_sd_1, d, at_d_1).
observes(share_e_sd_1, e, at_e_1).


action(share_e_sd_2).
action_type(share_e_sd_2, announcement).
announces(share_e_sd_2, sd).
action_pre(share_e_sd_2, and(box(e,sd),at_e_2)).
observes(share_e_sd_2, a, at_a_2).
observes(share_e_sd_2, b, at_b_2).
observes(share_e_sd_2, c, at_c_2).
observes(share_e_sd_2, d, at_d_2).
observes(share_e_sd_2, e, at_e_2).


action(share_e_se_1).
action_type(share_e_se_1, announcement).
announces(share_e_se_1, se).
action_pre(share_e_se_1, and(box(e,se),at_e_1)).
observes(share_e_se_1, a, at_a_1).
observes(share_e_se_1, b, at_b_1).
observes(share_e_se_1, c, at_c_1).
observes(share_e_se_1, d, at_d_1).
observes(share_e_se_1, e, at_e_1).


action(share_e_se_2).
action_type(share_e_se_2, announcement).
announces(share_e_se_2, se).
action_pre(share_e_se_2, and(box(e,se),at_e_2)).
observes(share_e_se_2, a, at_a_2).
observes(share_e_se_2, b, at_b_2).
observes(share_e_se_2, c, at_c_2).
observes(share_e_se_2, d, at_d_2).
observes(share_e_se_2, e, at_e_2).




% *** INITIALLY ***

% ** initial pointed **
initially(at_a_1).
initially(neg(at_a_2)).
initially(at_b_1).
initially(neg(at_b_2)).
initially(at_c_1).
initially(neg(at_c_2)).
initially(at_d_1).
initially(neg(at_d_2)).
initially(at_e_1).
initially(neg(at_e_2)).
initially(sa).
initially(sb).
initially(sc).
initially(sd).
initially(se).

% ** initial beliefs **
agent_set(all_agents).
contains_ag(all_agents,a).
contains_ag(all_agents,b).
contains_ag(all_agents,c).
contains_ag(all_agents,d).
contains_ag(all_agents,e).
initially(c(all_agents,at_a_1)).
initially(c(all_agents,at_b_1)).
initially(c(all_agents,at_c_1)).
initially(c(all_agents,at_d_1)).
initially(c(all_agents,at_e_1)).
initially(c(all_agents,neg(at_a_2))).
initially(c(all_agents,neg(at_b_2))).
initially(c(all_agents,neg(at_c_2))).
initially(c(all_agents,neg(at_d_2))).
initially(c(all_agents,neg(at_e_2))).
initially(c(all_agents,or(box(a,sa),box(a,neg(sa))))).
initially(c(all_agents,or(box(b,sb),box(b,neg(sb))))).
initially(c(all_agents,or(box(c,sc),box(c,neg(sc))))).
initially(c(all_agents,or(box(d,sd),box(d,neg(sd))))).
initially(c(all_agents,or(box(e,se),box(e,neg(se))))).





% *** GOALS ***
goal(box(a,sb)).
goal(box(b,sc)).
goal(box(c,sa)).
goal(neg(box(a,sc))).
goal(neg(box(c,sb))).
goal(neg(box(b,or(box(c,sa),box(c,neg(sa)))))).


