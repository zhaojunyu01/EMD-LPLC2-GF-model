function [Fh, Fd_On, Fd_Off, nums, Right_nums] = loom(i, nums, EMD_nx, EMD_ny, a_low, b_high, Fh_before, Fd_On_before, Fd_Off_before, picture, newpicture) 
%LOOM EMD parameters setting & looming object detection from the present stimulus
%   Code written by Junyu Zhao, Shengkai Xi.
%   December 20, 2022.

[Fh, Fd_On, Fd_Off, He_On(:,:,i), Hi_On(:,:,i), Ve_On(:,:,i), Vi_On(:,:,i), He_Off(:,:,i), Hi_Off(:,:,i), Ve_Off(:,:,i), Vi_Off(:,:,i)] = emd(EMD_nx, EMD_ny, a_low, b_high, Fh_before, Fd_On_before, Fd_Off_before, picture, newpicture);

LP(:,:,1,i) = Hi_On(:,:,i)+Hi_Off(:,:,i); % leftward motion
LP(:,:,2,i) = He_On(:,:,i)+He_Off(:,:,i); % rightward motion
LP(:,:,3,i) = Vi_On(:,:,i)+Vi_Off(:,:,i); % upward motion
LP(:,:,4,i) = Ve_On(:,:,i)+Ve_Off(:,:,i); % downward motion
LPLC2(:,:,i) = lplc2conv2(LP(:,:,:,i));
[~, Column] = size(LPLC2(:,:,i));
C = ceil(Column/2);
%collect the data from LPLC2
nums(i) = numel(find(LPLC2(:,:,i)>0));
Right_nums(i) = numel(find(LPLC2(:,end-C:end,i)>0));
end