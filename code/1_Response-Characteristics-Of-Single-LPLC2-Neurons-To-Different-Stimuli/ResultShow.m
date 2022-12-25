%RESULTSHOW Batch test of different stimuli
%   Code written by Junyu Zhao, Shengkai Xi
%   December 20, 2022

close all;
clear;
addpath(genpath(pwd));
stimulus = {'Looming_50ms.mat','Square_expanded-motion.mat','Bar_horizontal-motion.mat','Edge_horizontal-motion.mat','Bar_vertical-motion.mat','Edge_vertical-motion.mat','Grating_horizontal-motion.mat','Grating_vertical-motion.mat','Cross_centrifugal-motion.mat','Cross_concentric-motion.mat'};
for n=1:2 % 1~multiplicative intrgration; 2~addtive intrgration;
    for i = 1:length(stimulus)
        LPLC2_core{i} = loom(stimulus{i},n);
    end
    
    Max=0;
    for i=1:length(LPLC2_core)
        Maxi=max(LPLC2_core{i});
        Max=max(Max,Maxi);
    end
    
    for i=1:length(LPLC2_core)
        LPLC2_core_Normal{n,i}=LPLC2_core{i}./Max;
    end
end

figure(2)
set(gcf,'Units','normalized','Position',[0.3 0.3 0.5 0.5]);
colormap('gray');
subplot(2,5,1)
plot(LPLC2_core_Normal{2,1},'k','LineWidth',1);
hold on
plot(LPLC2_core_Normal{1,1},'r','LineWidth',1);
xlim([1,500])
ylim([-0.2 1])

subplot(2,5,2)
plot(LPLC2_core_Normal{2,2},'k','LineWidth',1);
hold on
plot(LPLC2_core_Normal{1,2},'r','LineWidth',1);
xlim([1,500])
ylim([-0.2 1])

subplot(2,5,3)
plot(LPLC2_core_Normal{2,3},'k','LineWidth',1);
hold on
plot(LPLC2_core_Normal{1,3},'r','LineWidth',1);
xlim([1,500])
ylim([-0.2 1])
title('the Response of LPLC2 to Different Stimuli','Position',[250,1.1],'Fontsize',12)

subplot(2,5,4)
plot(LPLC2_core_Normal{2,4},'k','LineWidth',1);
hold on
plot(LPLC2_core_Normal{1,4},'r','LineWidth',1);
ylabel('the Activity in normalized','Position',[-50,0.4],'Fontsize',12);
xlim([1,500])
ylim([-0.2 1])

subplot(2,5,5)
plot(LPLC2_core_Normal{2,5},'k','LineWidth',1);
hold on
plot(LPLC2_core_Normal{1,5},'r','LineWidth',1);
xlim([1,500])
ylim([-0.2 1])

subplot(2,5,6)
plot(LPLC2_core_Normal{2,6},'k','LineWidth',1);
hold on
plot(LPLC2_core_Normal{1,6},'r','LineWidth',1);
xlim([1,500])
ylim([-0.2 1])

subplot(2,5,7)
plot(LPLC2_core_Normal{2,7},'k','LineWidth',1);
hold on
plot(LPLC2_core_Normal{1,7},'r','LineWidth',1);
xlim([1,500])
ylim([-0.2 1])

subplot(2,5,8)
plot(LPLC2_core_Normal{2,8},'k','LineWidth',1);
hold on
plot(LPLC2_core_Normal{1,8},'r','LineWidth',1);
xlim([1,500])
ylim([-0.2 1])
xlabel('Time (frame)','Position',[250,-0.4],'Fontsize',12);

subplot(2,5,9)
plot(LPLC2_core_Normal{2,9},'k','LineWidth',1);
hold on
plot(LPLC2_core_Normal{1,9},'r','LineWidth',1);
xlim([1,500])
ylim([-0.2 1])

subplot(2,5,10)
plot(LPLC2_core_Normal{2,10},'k','LineWidth',1);
hold on
plot(LPLC2_core_Normal{1,10},'r','LineWidth',1);
xlim([1,500])
ylim([-0.2 1])