function v = LIF(v, h, I)
%LIF Leaky integrate-and-fire model
%   Code written by Junyu Zhao.
%   December 20, 2022.

%Four-order Runge-Kutta
k1 = f(v, I);
k2 = f(v+k1*h/2, I);
k3 = f(v+k2*h/2, I);
k4 = f(v+k3*h, I);
v = v+(k1+2*k2+2*k3+k4)*h/6;
end
 
 function dy = f(y, I)
 %integrate and fire neuron model
 %¦Ó*dV/dt = -V+L+R*I(t)
 L = -60; % resting potential
 R = 10;
 tau = 0.30;
 dy = (-y+L+R*I)/tau;
 end
 