function [command, nums, Right_nums, Fh, Fd_On, Fd_Off] = GF(i, nums, EMD_nx, EMD_ny, a_low, b_high, Fh_before, Fd_On_before, Fd_Off_before, picture, newpicture)
%GF Integerate the inputs from LPLC2 array, and fire spikes when a looming object appear
%   Code written by Junyu Zhao, Shengkai Xi
%   December 20,2022

[Fh, Fd_On, Fd_Off, nums, Right_nums] = loom(i, nums, EMD_nx, EMD_ny, a_low, b_high, Fh_before, Fd_On_before, Fd_Off_before, picture, newpicture);

step = 0.01;                                      % GF neuron working-step in second
V0 = -60;                                         % start potential in voltage
Vth = -50;                                        % tuned threshold
Vre = -70;                                        % repolarization potential

h = step/20;
v(1) = V0;
w = 250;                                          % amplifier of I (current)
Normal_I1 = 2500;                                 % the normalization factor of I1: Here is the ceiling of LPLC2 activited number when RF_side is 100
I1_99_5ms = 2116/Normal_I1;                       % the LPLC2 activited number of the last frame for looming l/v is 5 ms(after normalization)
I1_98_5ms = 676/Normal_I1;
Normal_vel = (I1_99_5ms-I1_98_5ms)/step;          % the normalization factor of vel: Here is the last angular velocity for looming l/v is 5 ms

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
        command = 1;
        break;
    else
        v((i-1)*20+j+1) = V;
        command = 0;
    end
    V0 = V;
end

end
