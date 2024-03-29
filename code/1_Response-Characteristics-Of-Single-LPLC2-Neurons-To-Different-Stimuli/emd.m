function [Fh, Fd_On, Fd_Off, He_Off, Hi_Off, Ve_Off, Vi_Off] = emd(EMD_nx, EMD_ny, a_low, b_high, Fh_before, Fd_On_before, Fd_Off_before, picture, newpicture)
%EMD Visual motion estimation by EMD array
%   Code written by Junyu Zhao.
%   December 20, 2022.

Fh = zeros(EMD_nx+1, EMD_ny+1);          % signals generated by high-pass filtering
Off = zeros(EMD_nx+1, EMD_ny+1);
Fd_Off=zeros(EMD_nx+1, EMD_ny+1);        % low-pass filtering

%------------OFF pathway---------
He_Off = zeros(EMD_nx, EMD_ny);           % the response in one arm of the motion detector
Hi_Off = zeros(EMD_nx, EMD_ny);           % the response in its mirror-symmetrical counterpart
Ve_Off = zeros(EMD_nx, EMD_ny);           % the response in one arm of the motion detector
Vi_Off = zeros(EMD_nx, EMD_ny);           % the response in its mirror-symmetrical counterpart

for i =1:(EMD_nx+1)
    for j =1:(EMD_ny+1)
        Fh(i, j) = b_high(1, 1)*(newpicture(i, j)-picture(i, j))+b_high(1, 2)*Fh_before(i, j);    % high-pass filtering
        Off(i, j) = OffRect(Fh(i, j), 0.05);
        Fd_Off(i, j) =a_low(1, 1)*Off(i, j)+a_low(1, 2)*Fd_Off_before(i, j);                      % low-pass filtering
    end
end

for i =1:EMD_nx
    for j =1:EMD_ny
        %------------OFF pathway---------
        He_Off(i, j)=Fd_Off(i, j)*Off(i, j+1);
        Hi_Off(i, j)=Off(i, j)*Fd_Off(i, j+1);
        
        Ve_Off(i, j)=Fd_Off(i, j)*Off(i+1, j);
        Vi_Off(i, j)=Off(i, j)*Fd_Off(i+1, j); 
    end
end
end
