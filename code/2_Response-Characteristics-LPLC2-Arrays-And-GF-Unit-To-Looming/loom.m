function [patt, nums] = loom(tao) 
%LOOM EMD parameters setting & looming object detection from the present stimulus
%   Code written by Junyu Zhao, Shengkai Xi.
%   December 20, 2022.

patt = loomingObject(tao); % pixel value in range 0~1; 600*800
patt = patt(1:4:end, 1:4:end,:);
tt = size(patt,3);
STEP = 0.01;                          % temporal resolution of EMD in seconds

figure(1)
colormap('gray');
for k = 1:tt
    imagesc(patt(:,:,k));
    pause(STEP);
end

tic;

%the first-order low-pass filter
tauL = 0.050;                         % in seconds, the filter's time constant or the RC circuit's time constant
dL = tauL/STEP;                       
a_low(1, 1) = 1/(dL+1);
a_low(1, 2)= 1-a_low(1, 1);

%the first-order high-pass filter
tauH = 0.250;                         % in seconds, the filter's time constant 
dH = tauH/STEP;                      
b_high(1, 1) = dH/(dH+1);
b_high(1, 2) = b_high(1, 1);

%EMD_array
EMD_nx=size(patt, 1)-1;  
EMD_ny=size(patt, 2)-1;  
Fh_before = zeros(EMD_nx+1, EMD_ny+1);
Fd_On_before=zeros(EMD_nx+1, EMD_ny+1); 
Fd_Off_before=zeros(EMD_nx+1, EMD_ny+1); 

newpicture = patt(:, :, 1); 
readed = 1;
count = 0;
for i = 1:size(patt, 3)-1
    picture = newpicture;
    readed = readed+1;
    newpicture = patt(:, :,readed );   
    [Fh, Fd_On, Fd_Off, He_On(:,:,i), Hi_On(:,:,i), Ve_On(:,:,i), Vi_On(:,:,i), He_Off(:,:,i), Hi_Off(:,:,i), Ve_Off(:,:,i), Vi_Off(:,:,i)] = emd(EMD_nx, EMD_ny, a_low, b_high, Fh_before, Fd_On_before, Fd_Off_before, picture, newpicture);
    
    LP(:,:,1,i) = Hi_On(:,:,i)+Hi_Off(:,:,i); % leftward motion
    LP(:,:,2,i) = He_On(:,:,i)+He_Off(:,:,i); % rightward motion
    LP(:,:,3,i) = Vi_On(:,:,i)+Vi_Off(:,:,i); % upward motion
    LP(:,:,4,i) = Ve_On(:,:,i)+Ve_Off(:,:,i); % downward motion
    
    LPLC2(:,:,i) = lplc2conv2(LP(:,:,:,i));

    Fh_before = Fh;
    Fd_On_before = Fd_On;
    Fd_Off_before = Fd_Off; 

    %collect the data from LPLC2
    count=count+1;
    nums(count)=numel(find(LPLC2(:,:,i)>0));
end
EMDLPLC_timing =toc;
end
