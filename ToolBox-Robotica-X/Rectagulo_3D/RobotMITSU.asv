clear L
L{1} = link([ pi/2   0	0           1.5     0], 'standard');
L{2} = link([ 0      1	pi/2        0   	0], 'standard');
L{3} = link([ 0      1	-pi/2       0       0], 'standard');

%L{1}.m = U(1);
L{1}.m = 5;
L{2}.m = 5;
L{3}.m = 5;

L{1}.r = [ 0    0	   0 ];
L{2}.r = [ -.3638  .006    .2275];
L{3}.r = [ -.3638  .006    .2275];

L{1}.I = [  0	 0.35	 0	 0	 0	 0];
L{2}.I = [  .13	 .524	 .539	 0	 0	 0];
L{3}.I = [  .13	 .524	 .539	 0	 0	 0];

L{1}.Jm =  200e-6;
L{2}.Jm =  200e-6;
L{3}.Jm =  200e-6;


L{1}.G =  -62.6111;
L{2}.G =  107.815;
L{3}.G =  107.815;

% viscous friction (motor referenced)
L{1}.B =   1.48e-3;
L{2}.B =   .817e-3;
L{3}.B =   .817e-3;


% Coulomb friction (motor referenced)
L{1}.Tc = [ .395	-.435];
L{2}.Tc = [ .126	-.071];
L{3}.Tc = [ .126	-.071];

RMITSU = robot(L, 'MITSUBISHI', 'Unimation', 'params of 8/95');
clear L
RMITSU.name = 'MITSUBISHI';
RMITSU.manuf = 'Unimation';