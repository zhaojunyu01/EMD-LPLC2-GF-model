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
tauH = 0.250;                                    %  in seconds, the filter's time constant
dH = tauH/STEP;

b_high(1, 1) = dH/(dH+1);
b_high(1, 2) = b_high(1, 1);


%---------------------/tb3_0/----<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
robot = rospublisher('/tb3_0/cmd_vel');
velmsg = rosmessage(robot);
camera_rgb=rossubscriber('/tb3_0/camera/rgb/image_raw');
pose = rossubscriber('/tb3_0/odom');
img = receive(camera_rgb);
picture = rgb2gray(readImage(img));
picture = imresize(picture, [250,300]);
picture = im2double(picture);

i = 1;
nums = [];
path = [];
%---------------------/tb3_0/---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>



%---------------------/tb3_1/----<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
robot_1 = rospublisher('/tb3_1/cmd_vel');
velmsg_1 = rosmessage(robot_1);
camera_rgb_1=rossubscriber('/tb3_1/camera/rgb/image_raw');
pose_1 = rossubscriber('/tb3_1/odom');
img_1 = receive(camera_rgb_1);
picture_1 = rgb2gray(readImage(img_1));
picture_1 = imresize(picture_1, [250,300]);
picture_1 = im2double(picture_1);

i_1 = 1;
nums_1 = [];
path_1 = [];
%---------------------/tb3_1/---->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>



EMD_nx = size(picture, 1)-1;                             % row of the EMD array, according to the solution of picture from camera
EMD_ny = size(picture, 2)-1;                             % column of the EMD array

Fh_before = zeros(EMD_nx+1, EMD_ny+1);
Fd_On_before=zeros(EMD_nx+1, EMD_ny+1);
Fd_Off_before=zeros(EMD_nx+1, EMD_ny+1);

Fh_before_1 = zeros(EMD_nx+1, EMD_ny+1);
Fd_On_before_1=zeros(EMD_nx+1, EMD_ny+1);
Fd_Off_before_1=zeros(EMD_nx+1, EMD_ny+1);

Fh_before_2 = zeros(EMD_nx+1, EMD_ny+1);
Fd_On_before_2=zeros(EMD_nx+1, EMD_ny+1);
Fd_Off_before_2=zeros(EMD_nx+1, EMD_ny+1);

spinVelocity = 0.45;                                    % Angular velocity (rad/s)
forwardVelocity = 0.1;                                  % Linear velocity (m/s)
backwardVelocity = -0.02;                               % Linear velocity (reverse) (m/s)
distanceThreshold = 0.6;                                % Distance threshold (m) for turning


tic;
deadline=2;                                             %in minutes
while toc < 60*deadline
    
    img = receive(camera_rgb);
    newpicture = rgb2gray(readImage(img));
    newpicture = imresize(newpicture, [250,300]);
    newpicture = im2double(newpicture);
    figure(1)
    imshow(newpicture);
    luminance =mean(mean(newpicture));
    [command, nums, Right_nums, Fh, Fd_On, Fd_Off] = GF(i, nums, EMD_nx, EMD_ny, a_low, b_high, Fh_before, Fd_On_before, Fd_Off_before, picture, newpicture);
    i = i+1;
    Fh_before = Fh;
    Fd_On_before = Fd_On;
    Fd_Off_before = Fd_Off;
    picture = newpicture;
    Pose = receive(pose);
    Loc = Pose.Pose.Pose.Position;%Type?1*1 Point
    path(i-1,1:2) = [Loc.X Loc.Y];
    
    i_1 = i_1+1;
    
    % find the destination
    Pose_1 = receive(pose_1);
    Loc_1 = Pose_1.Pose.Pose.Position;
    Ori_1 = Pose_1.Pose.Pose.Orientation;
    delta = quat2eul([Ori_1.W Ori_1.X Ori_1.Y Ori_1.Z]);% delta=[yaw pitch roll]
    Goal = [0 0 0];
    path_1(i_1-1,1:2) = [Loc_1.X Loc_1.Y];
    
    if command > 0.1
        % If close to obstacle, back up slightly and spin
        velmsg.Linear.X = 10*backwardVelocity;
        if Right_nums == 0
            velmsg.Angular.Z = -spinVelocity;
        elseif velmsg.Angular.Z < 0
            velmsg.Angular.Z = -spinVelocity;
        else
            velmsg.Angular.Z = spinVelocity;
        end
    elseif luminance>0.75
        % reach the boundary, turn around
        velmsg.Linear.X = backwardVelocity;
        velmsg.Angular.Z = 1;
    else
        % Continue on forward path
        velmsg.Linear.X = 0*forwardVelocity;
        velmsg.Angular.Z = 0;
    end
    
    send(robot,velmsg);
    
    
    if Loc_1.X == 0
        theta = pi/2;
    else
        theta = atan(Loc_1.Y/Loc_1.X);
    end
    if Loc_1.X < 0
        Rotation = theta-delta(1);
    elseif delta > 0
        Rotation = theta-delta(1)+pi;
    else
        Rotation = theta-delta(1)-pi;
    end
    distance = sqrt(Loc_1.Y^2+Loc_1.X^2);
    if distance < 0.3
        velmsg.Angular.Z = 0;
        velmsg.Linear.X = 0;
        send(robot,velmsg);
        velmsg_1.Angular.Z = 0;
        velmsg_1.Linear.X = 0;
        send(robot_1,velmsg_1);
        figure(4);
        g1 = plot(path(:,1),path(:,2),'b-');
        hold on
        g2 = plot(path_1(:,1),path_1(:,2),'g-');
        hold on
        g11 = plot(path(1,1),path(1,2),'bo');
        hold on
        g22 = plot(path_1(1,1),path_1(1,2),'g*');
        xlim([-5 5]);
        ylim([-5 5]);
        title('the trajectory of Robot ');
        legend([g1,g2,g11,g22],'tb3_0','tb3_1','goal','start location');
        return
    end
    if Rotation > pi
        Rotation = Rotation-2*pi;
    elseif Rotation < -pi
        Rotation = Rotation+2*pi;
    else
        Rotation = Rotation+0;
    end
    velmsg_1.Linear.X = forwardVelocity;
    velmsg_1.Angular.Z = Rotation;
    send(robot_1,velmsg_1);
    
end

velmsg.Angular.Z = 0;
velmsg.Linear.X = 0;
send(robot,velmsg);

velmsg_1.Angular.Z = 0;
velmsg_1.Linear.X = 0;
send(robot_1,velmsg_1);

figure(4);

g1 = plot(path(:,1),path(:,2),'b-');
hold on
g2 = plot(path_1(:,1),path_1(:,2),'g-');
hold on
g11 = plot(path(1,1),path(1,2),'bo');
hold on
g22 = plot(path_1(1,1),path_1(1,2),'g*');
xlim([-5 5]);
ylim([-5 5]);
title('the trajectory of Robot ');
legend([g1,g2,g11,g22],'tb3_0','tb3_1','start location','goal')
return