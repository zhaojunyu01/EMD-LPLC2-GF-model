%ROS_AVOIDANCE EMD parameters setting & conversation between model and virtual robots in ROS virtual environment
%   Code written by Junyu Zhao
%   December 20,2022

clear;
close all;

STEP = 0.01;                                     % temporal resolution of EMD in seconds

%-------  low-pass filtering  -----------
tauL = 0.050;                                    % in seconds, the filter's time constant or the RC circuit's time constant
dL = tauL/STEP;                       

a_low(1, 1) = 1/(dL+1);
a_low(1, 2)= 1-a_low(1, 1);

%-------  high-pass filtering  -----------
tauH = 0.250;                                    % in seconds, the filter's time constant 
dH = tauH/STEP;                      

b_high(1, 1) = dH/(dH+1);
b_high(1, 2) = b_high(1, 1);

robot = rospublisher('/cmd_vel');
velmsg = rosmessage(robot);
camera_rgb=rossubscriber('/camera/rgb/image_raw');
pose = rossubscriber('/odom');
%laser = rossubscriber('/scan');
img = receive(camera_rgb);
picture = rgb2gray(readImage(img));
picture = imresize(picture, [250,300]);
picture = im2double(picture);

EMD_nx = size(picture, 1)-1;                     % row of the EMD array, according to the solution of picture from camera
EMD_ny = size(picture, 2)-1;                     % column of the EMD array

Fh_before = zeros(EMD_nx+1, EMD_ny+1);
Fd_On_before=zeros(EMD_nx+1, EMD_ny+1); 
Fd_Off_before=zeros(EMD_nx+1, EMD_ny+1); 


spinVelocity = 0.45;                             % Angular velocity (rad/s)
forwardVelocity = 0.1;                           % Linear velocity (m/s)
backwardVelocity = -0.02;                        % Linear velocity (reverse) (m/s)
distanceThreshold = 0.6;                         % Distance threshold (m) for turning
i = 1;
nums = [];
Threshold = 30;
path = [];
tic;
while toc < 60*10
img = receive(camera_rgb);

newpicture = rgb2gray(readImage(img));
newpicture = imresize(newpicture, [250,300]);
newpicture = im2double(newpicture);
figure(1)
imshow(newpicture);

% get the command from visual motion and related after-processing
luminance =mean(mean(newpicture));
[command, nums, Right_nums, Fh, Fd_On, Fd_Off] = GF(i, nums, EMD_nx, EMD_ny, a_low, b_high, Fh_before, Fd_On_before, Fd_Off_before, picture, newpicture);
i = i+1;
Fh_before = Fh;
Fd_On_before = Fd_On;
Fd_Off_before = Fd_Off; 
picture = newpicture;

% find the destination
Pose = receive(pose);
Loc = Pose.Pose.Pose.Position;
Ori = Pose.Pose.Pose.Orientation;
delta = quat2eul([Ori.W Ori.X Ori.Y Ori.Z]);     % delta=[yaw pitch roll]
Goal = [0 0 0];

path(i-1,1:2) = [Loc.X Loc.Y];
  
if command > 0.1
% If close to obstacle, back up slightly and spin
    velmsg.Linear.X = backwardVelocity; 
  if Right_nums == 0    
      velmsg.Angular.Z = -spinVelocity;
  elseif velmsg.Angular.Z < 0
      velmsg.Angular.Z = -spinVelocity;
  else
      velmsg.Angular.Z = spinVelocity;
  end 
  Threshold = 0;
elseif luminance>0.75
    % reach the boundary, turn around
    velmsg.Linear.X = backwardVelocity;
    velmsg.Angular.Z = 1;
    Threshold = 0;
else
    % Continue on forward path
    if Threshold <= 10
        Rotation = 0;
        Threshold = Threshold+1;
    else
        if Loc.X == 0
            theta = pi/2;
        else
            theta = atan(Loc.Y/Loc.X);
        end
        if Loc.X < 0
            Rotation = theta-delta(1);
        elseif delta > 0
            Rotation = theta-delta(1)+pi;
        else
            Rotation = theta-delta(1)-pi;
        end
    end
    distance = sqrt(Loc.Y^2+Loc.X^2);
    if distance < 1
        velmsg.Angular.Z = 0;
        velmsg.Linear.X = 0;
        send(robot,velmsg);
                
        %---graph---<
        figure(4);
        j = 1;
        for x = -24:8:24
         for y = -22:4:24
          obj(j,:) = [x y];
          j = j+1;
         end
        end

        for x = -20:8:20
         for y = -24:4:24
          obj(j,:) = [x y];
          j = j+1;
         end
        end
        plot(obj(:,1),obj(:,2),'ko','MarkerFaceColor','k');
        hold on

        plot(path(:,1),path(:,2),'b-');
        xlim([-24.5 24.5]);
        ylim([-24.5 24.5]);
        title('the trajectory of Robot ');
        set(gca,'xtick',[]);
        set(gca,'ytick',[]);
        return
        %---graph--->
        
    end
    
    if Rotation > pi
        Rotation = Rotation-2*pi;
    elseif Rotation < -pi
        Rotation = Rotation+2*pi;
    else
        Rotation = Rotation+0;
    end
    
    velmsg.Linear.X = forwardVelocity;
    velmsg.Angular.Z = Rotation;
    
end

send(robot,velmsg);

end

velmsg.Angular.Z = 0;
velmsg.Linear.X = 0;
send(robot,velmsg);

figure(4);

j = 1;
for x = -24:8:24
 for y = -22:4:24
  obj(j,:) = [x y];
  j = j+1;
 end
end

for x = -20:8:20
 for y = -24:4:24
  obj(j,:) = [x y];
  j = j+1;
 end
end
plot(obj(:,1),obj(:,2),'ko','MarkerFaceColor','k');
hold on

plot(path(:,1),path(:,2),'b-');
xlim([-24.5 24.5]);
ylim([-24.5 24.5]);
title('the trajectory of Robot ');
set(gca,'xtick',[]);
set(gca,'ytick',[]);
return