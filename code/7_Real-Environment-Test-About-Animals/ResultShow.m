 %RESULTSHOW Batch test of different stimuli
%   Code written by Junyu Zhao, Shengkai Xi
%   December 20, 2022

close all;
clear;
addpath(genpath(pwd));
stimulus = {'video_S5.mp4','video_S6.mp4','video_S7.mp4','video_S8.mp4','video_S9.mp4','video_S10.mp4'};
for i = 1:length(stimulus) 
    [patt,v{i}] = GF(stimulus{i});
end

figure(2)
set(gcf,'Units','normalized','Position',[0.2 0.02 0.6 0.5]);
colormap('gray');
set(gcf, 'color', 'w');
%============================================
subplot(3,11,1:5)
k = 1;
stamp=1:length(v{k});
stamp=stamp/(20*100);
plot(stamp,v{k},'k', 'LineWidth', 1);
ylabel('GF (mV)');
set(gca,'Ylim',[-90,50]);
set(gca,'Xlim',[0,stamp(end)]);
%---------------
subplot(3,11,12:16)
k = 2;
stamp=1:length(v{k});
stamp=stamp/(20*100);
plot(stamp,v{k},'k', 'LineWidth', 1);
ylabel('GF (mV)');
set(gca,'Ylim',[-90,50]);
set(gca,'Xlim',[0,stamp(end)]);
%============================================
subplot(3,11,23:27)
k = 3;
stamp=1:length(v{k});
stamp=stamp/(20*100);
plot(stamp,v{k},'k', 'LineWidth', 1);
ylabel('GF (mV)');
xlabel('Time (s)');
set(gca,'Ylim',[-90,50]);
set(gca,'Xlim',[0,stamp(end)]);
%---------------
subplot(3,11,7:11)
k = 4;
stamp=1:length(v{k});
stamp=stamp/(20*100);
plot(stamp,v{k},'k', 'LineWidth', 1);
ylabel('GF (mV)');
set(gca,'Ylim',[-90,50]);
set(gca,'Xlim',[0,stamp(end)]);
%============================================
subplot(3,11,18:22)
k = 5;
stamp=1:length(v{k});
stamp=stamp/(20*100);
plot(stamp,v{k},'k', 'LineWidth', 1);
ylabel('GF (mV)');
set(gca,'Ylim',[-90,50]);
set(gca,'Xlim',[0,stamp(end)]);
%---------------
subplot(3,11,29:33)
k = 6;
stamp=1:length(v{k});
stamp=stamp/(20*100);
plot(stamp,v{k},'k', 'LineWidth', 1);
ylabel('GF (mV)');
xlabel('Time (s)');
set(gca,'Ylim',[-90,50]);
set(gca,'Xlim',[0,stamp(end)]);
