function [patt,T,v] = GF(tao)
%GF Integerate the inputs from LPLC2 array, and fire spikes when a looming object appear
%   Code written by Junyu Zhao, Shengkai Xi
%   December 20,2022

[patt, nums] = loom(tao);

tic;
step = 0.01;                                      % GF Unit working-step in second
t0 = 0;                                           % start time in second
N = numel(nums);
t = N*step;                                       % end time in second
V0 = -60;                                         % start potential
Vth = -50;                                        % threshold potential
Vre = -70;                                        % repolarization potential

h = step/20;
T = t0:h:t;
v(1) = V0;
w = 250;                                          % amplifier of I (current)
Normal_I1 = 2500;                                 % the normalization factor of I1: Here is the ceiling of LPLC2 activited number when RF_side is 100
I1_99_5ms = 2116/Normal_I1;                       % the LPLC2 activited number of the last frame for looming L/v is 5 ms(after normalization)
I1_98_5ms = 676/Normal_I1;
Normal_vel = (I1_99_5ms-I1_98_5ms)/step;          %the normalization factor of vel: Here is the last angular velocity for looming L/v is 5 ms

for i = 1:N
    if i == 1
        I1 = nums(i)/Normal_I1;
        I2 = I1;
    else
        I1 = nums(i)/Normal_I1;
        I2 = nums(i-1)/Normal_I1;
    end
    vel(i) = ((I1-I2)/step)/Normal_vel;
    if I2 == 0
        I(i) = 0;
    else
        I(i) = w*I1*vel(i);
    end
    
    for j = 1:20
        V = LIF(V0,h,I(i));
        if V > Vth
            v((i-1)*20+j+1) = 20;
            V = Vre;
        else
            v((i-1)*20+j+1) = V;
        end
        V0 = V;
    end
    
end
ODE_timing = toc;
end
