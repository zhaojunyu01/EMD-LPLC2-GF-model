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

for x = -24:8:24
 for y = -22:4:24
  spawnModel(gazebo,pin,[x,y,0.5]);
 end
end

for x = -20:8:20
 for y = -24:4:24
  spawnModel(gazebo,pin,[x,y,0.5]);
 end
end
