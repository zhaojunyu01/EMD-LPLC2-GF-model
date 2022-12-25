close all;
clear;

xdata = cell(1,7);
ydata = cell(1,7);
name = {'side 40' 'side 50' 'side 60' 'side 70' 'side 80' 'side 90' 'side 100'};
for i = 1:7   
h = open([name{i}, '.fig']);
data = findall(h,'type','line');
xdata{i} = get(data, 'XData');
ydata{i} = get(data, 'YData');
end

for j = 1:7
    [~, index_Max] = max(ydata{j});
    Counts(j) = numel(index_Max);
    timeTag{j}(1,:) = 1000.*xdata{j}(index_Max)-1000;%  collision point is 0 ms
    timeTag{j}(2,:) = (1:Counts(j));
    Initial(j) = timeTag{j}(1,1);  
end    
initial = Initial./1000;

%-------------Equation: theta = 2*arctan(l/(v*t))---------------
RF = (40:10:100); %tau = L/v   in second
sz = numel(RF);
j = 1;
t = (0:0.01:1);
theta = zeros(1,101);

close all;
figure(1)
set(gca,'xdir','reverse','yaxislocation','right','XTicklabel',{'0','-0.1','-0.2','-0.3','-0.4','-0.5','-0.6','-0.7','-0.8','-0.9','-1'});% set the origin position
hold on;
tao = 0.050;
for i = 0:0.01:1
     theta(j) = (180/pi)*2*atan(tao/i);
     j =j+1;
end
hot = [0.8 0 0; 1 0 0; 1 0.2 0; 1 0.4 0; 1 0.6 0; 1 0.8 0; 1 1 0; 0.8 1 0.2; 0.6 1 0.4; 0.4 1 0.6; 0.2 1 0.8; 0 1 1; 0 0.8 1; 0 0.6 1; 0 0.4 1; 0 0.2 1; 0 0 1; 0 0 0.8; 0 0 0.6; 0 0 0.4; 0 0 0.2; 0 0 0];
plot(t,theta(:),'-', 'color', hot(1,:), 'LineWidth', 1.5);
hold on;
grid on;
for n = 1: sz
    index = (100-initial(n))/100;
    line([index,index],[0,180],'linestyle','--','color', hot(n+10,:));
    hold on;
end

xlabel('Time to Collision (s)');
ylabel('Projection Angle on Retina (degree) ');
set(gca, 'XTick', [0:0.1:1]);
title('l/v 50ms');
legend('l/v 50ms', 'side 40', 'side 50', 'side 60', 'side 70', 'side 80', 'side 90', 'side 100','Location','WestOutside');
hold off;