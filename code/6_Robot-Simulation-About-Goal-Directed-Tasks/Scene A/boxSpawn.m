%BOXSPAWN Create my gazebo world
%   Code written by Junyu Zhao, Shengkai Xi
%   December 20,2022

gazebo = ExampleHelperGazeboCommunicator;
boxWall = ExampleHelperGazeboModel('box');
spherelink = addLink(boxWall,'box',1,'color',[1 1 1 1]);
pin = ExampleHelperGazeboModel('bowlPin');
cylinderlink = addLink(pin,'cylinder',[0.5 0.25],'position',[0,0,0.25], 'color', [0 0 0 1]);

for x = [25,-25]
 for y =-25:1:25
 spawnModel(gazebo,boxWall,[x,y,0.5]);
 end
end

for x = -24:1:24
 for y =[-25,25]
 spawnModel(gazebo,boxWall,[x,y,0.5]);
 end
end

rng(5);
x = randi([-9, 9], 1, 80);
X = kron(x,2);
y = randi([-9, 9], 1, 80);
Y = kron(y,2);

for i = 1:numel(x)
 spawnModel(gazebo,pin,[X(i),Y(i),0.5]);
end
