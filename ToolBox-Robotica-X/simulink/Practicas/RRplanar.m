%RR planar
%Dario Mendoza gallegos.

clear L

%L = link([alpha, a, theta, d], convention)
L{1} = link([ 0 1	0	0	0], 'standard');
L{2} = link([ 0 1	0	0	0], 'standard');

%masa
L{1}.m = 5;
L{2}.m = 3;


L{1}.r = [ 0    0 ];
L{2}.r = [ -.3638  .006 ];

L{1}.I = [  0	 0.35 ];
L{2}.I = [  .13	 .524 ];

L{1}.Jm =  200e-6;
L{2}.Jm =  200e-6;

L{1}.G =  -62.6111;
L{2}.G =  107.815;

L{1}.B =   1.48e-3;
L{2}.B =   .817e-3;

L{1}.Tc = [ .395	-.435];
L{2}.Tc = [ .126	-.071];


%
% some useful poses
%
qz = [0 0]; % zero angles, L shaped pose
qr = [pi/2 -pi/2 ]; % ready pose, arm up
qs = [0 -pi/2];
qn=[pi/4 pi];


RR = robot(L, 'RRplanar', 'Unimation', 'params of 8/95');
clear L
RR.name = 'RRplanar';
RR.manuf = 'Unimation';

