global nvars nbits lb ub

nvars=4; 
nbits=[5 5 5 5]; 
lb=5*ones(1,nvars); 
ub=9*ones(1,nvars); 

individuo = [0 0 0 0 0 0 0 0 0 1 0 0 0 1 0 0 0 0 1 1];
x=bin2real(individuo)