
%redefine symbols, otherwise matlab somehow doesn't know they are real
syms I111 I112 I113 I122 I123 I133 real;
syms I211 I212 I213 I222 I223 I233 real;
syms I311 I312 I313 I322 I323 I333 real;

syms I411 I412 I413 I422 I423 I433 real;
syms I511 I512 I513 I522 I523 I533 real;
syms I611 I612 I613 I622 I623 I633 real;
syms q1 q2 q3 q4 q5 q6 real;
syms qp1 qp2 qp3 qp4 qp5 qp6 real;
syms qpp1 qpp2 qpp3 qpp4 qpp5 qpp6 real
syms l1 l2 l3 l4 l5 l6 real;
syms d1 d2 d4 d7 d8 d9 d10 real; 
syms m1 m2 m3 m4 m5 m6 real;
q=[q1;q2;q3;q4;q5;q6];
qp = [qp1;qp2;qp3;qp4;qp5;qp6];     %Vector of velocity of angle
qpp = [qpp1;qpp2;qpp3;qpp4;qpp5;qpp6];

load M
load C
load G

tau = M*qpp + C*qp + G;
simplify(Yr*Theta - tau)