clear L
L{1} = link([ 0 1	0	0	0], 'standard');%alfa a theta d sigma              sigma=0-Rev, 1-Pris
L{2} = link([ 0 1	0	0	0], 'standard');%4    3  1    2
  

% L{1}.m = 0;%Masa eslabón 1
% L{2}.m = 17.4;%Masa eslabón 2
% 
% L{1}.r = [ 0    0	   0 ];%COG vector
% L{2}.r = [ -.3638  .006    .2275];
% 
% L{1}.I = [  0	 0.35	 0	 0	 0	 0];%Ixx Ixy Ixz Iyy Iyz Izz
% L{2}.I = [  .13	 .524	 .539	 0	 0	 0];
% 
% L{1}.Jm =  200e-6; %Inercia del motor
% L{2}.Jm =  200e-6;
% 
% 
% L{1}.G =  -62.6111; %Gear ratio
% L{2}.G =  107.815;
% 
% %viscous friction (motor referenced)
% L{1}.B =   1.48e-3; 
% L{2}.B =   .817e-3;
% 
% 
% % Coulomb friction (motor referenced)
% L{1}.Tc = [ .395	-.435];
% L{2}.Tc = [ .126	-.071];

R2GDL = robot(L, 'R2GDL1', 'Fabricante', 'params of 8/95');
clear L
% R2GDL.name = 'R2GDL1';
% R2GDL.manuf = 'Fabricante';