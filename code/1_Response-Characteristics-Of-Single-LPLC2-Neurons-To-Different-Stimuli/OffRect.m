function  OffR = OffRect(input, thresthold)
%OFFRECT Threshold operation for the luminance decrement
%   Code written by Junyu Zhao.
%   December 20, 2022.

if input<thresthold
    OffR = abs(input-thresthold);
else
    OffR = 0;
end
end
