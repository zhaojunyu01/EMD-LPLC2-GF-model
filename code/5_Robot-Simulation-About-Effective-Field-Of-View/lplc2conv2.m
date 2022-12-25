function LPLC2 = lplc2conv2(LP)
%LPLC2CONV2 LPLC2 array extracts looming feature based on the visual-motions inputs estimated by EMD array
%   Code written by Junyu Zhao.
%   December 20,2022. 

threshold_1 = 1.5;
threshold_2 = -2.0;
% define convolution kernel
side = 100;                                      % should be positive even number:2n
Hside =side/2;                                   % half width,must be positive integer
kernel = zeros(side,side,4);

kernel(Hside-19:Hside+20, Hside+1:end,1) = 1;
kernel(Hside-19:Hside+20, 1:Hside,2) = 1;
kernel(Hside+1:end, Hside-19:Hside+20,3) = 1;
kernel(1:Hside, Hside-19:Hside+20,4) = 1;

pre_LPLC2(:,:,1) = conv2(LP(:,:,1)-LP(:,:,2),kernel(:,:,1),'same');
pre_LPLC2(:,:,2) = conv2(LP(:,:,2)-LP(:,:,1),kernel(:,:,2),'same');
pre_LPLC2(:,:,3) = conv2(LP(:,:,3)-LP(:,:,4),kernel(:,:,3),'same');
pre_LPLC2(:,:,4) = conv2(LP(:,:,4)-LP(:,:,3),kernel(:,:,4),'same');

pre_LPLC2_L = pre_LPLC2>threshold_1;
pre_LPLC2 = pre_LPLC2.*(pre_LPLC2>threshold_2);
LPLC2 = abs(pre_LPLC2(:,:,1).*pre_LPLC2(:,:,2).*pre_LPLC2(:,:,3).*pre_LPLC2(:,:,4));

pre_LPLC2_LLe = sum(pre_LPLC2_L,3);
pre_LPLC2_Index = pre_LPLC2_LLe>=3;
LPLC2 = LPLC2.*pre_LPLC2_Index;
end