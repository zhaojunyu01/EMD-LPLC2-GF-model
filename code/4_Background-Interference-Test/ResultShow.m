%RESULTSHOW Batch test different stimuli
%   Code written by Junyu Zhao, Shengkai Xi
%   December 20,2022

close all;
clear;

tao =[0.050 0.035 0.020 0.005];
s = 1;
for i = 1:length(tao)
    [patt,T(i,:),v(i,:)] = GF(tao(i));
    Scene(:,:,i) = [patt(:,:,18),patt(:,:,38),patt(:,:,58),patt(:,:,78),patt(:,:,98)];
    Scene(:,399:402,i) = 1;
    Scene(:,799:802,i) = 1;
    Scene(:,1199:1202,i) = 1;
    Scene(:,1599:1602,i) = 1;
    Tag1(i) = 1-T(i,18*20);
    Tag2(i) = 1-T(i,38*20);
    Tag3(i) = 1-T(i,58*20);
    Tag4(i) = 1-T(i,78*20);
    Tag5(i) = 1-T(i,98*20);    
end

figure(2)
set(gcf,'Units','normalized','Position',[0.2 0.02 0.3 0.9]);
colormap('gray');
set(gcf, 'color', 'w');
%============================================
subplot(8,5,1:5)
k = 1;
imshow(Scene(:,:,k));
text(200,330,[num2str(Tag1(k)),'s'],'horiz','center','color','k');
text(600,330,[num2str(Tag2(k)),'s'],'horiz','center','color','k');
text(1000,330,[num2str(Tag3(k)),'s'],'horiz','center','color','k');
text(1400,330,[num2str(Tag4(k)),'s'],'horiz','center','color','k');
text(1800,330,[num2str(Tag5(k)),'s'],'horiz','center','color','k');
%---------------
subplot(8,5,6:10)
plot(T(k,:),v(k,:),'k', 'LineWidth', 1);
grid on;
xlim([0 1]);
set(gca,'XTicklabel',{'-1','-0.9','-0.8','-0.7','-0.6','-0.5','-0.4','-0.3','-0.2','-0.1','0'}, 'fontsize', 10);
ylabel('GF (mV)');
set(gca,'Ylim',[-90,50]);
string = append('l/v = ',num2str(1000*tao(k)),' ms');
text(0.03, 30, string);
text(-0.1,400, 'A', 'Fontname', 'Arial', 'Fontsize', 15);
%============================================
subplot(8,5,11:15)
k = 2;
imshow(Scene(:,:,k));
text(200,330,[num2str(Tag1(k)),'s'],'horiz','center','color','k');
text(600,330,[num2str(Tag2(k)),'s'],'horiz','center','color','k');
text(1000,330,[num2str(Tag3(k)),'s'],'horiz','center','color','k');
text(1400,330,[num2str(Tag4(k)),'s'],'horiz','center','color','k');
text(1800,330,[num2str(Tag5(k)),'s'],'horiz','center','color','k');
%---------------
subplot(8,5,16:20)
plot(T(k,:),v(k,:),'k', 'LineWidth', 1);
grid on;
xlim([0 1]);
set(gca,'XTicklabel',{'-1','-0.9','-0.8','-0.7','-0.6','-0.5','-0.4','-0.3','-0.2','-0.1','0'});
ylabel('GF (mV)');
set(gca,'Ylim',[-90,50]);
string = append('l/v = ',num2str(1000*tao(k)),' ms');
text(0.03, 30, string);
%============================================
subplot(8,5,21:25)
k = 3;
imshow(Scene(:,:,k));
text(200,330,[num2str(Tag1(k)),'s'],'horiz','center','color','k');
text(600,330,[num2str(Tag2(k)),'s'],'horiz','center','color','k');
text(1000,330,[num2str(Tag3(k)),'s'],'horiz','center','color','k');
text(1400,330,[num2str(Tag4(k)),'s'],'horiz','center','color','k');
text(1800,330,[num2str(Tag5(k)),'s'],'horiz','center','color','k');
%---------------
subplot(8,5,26:30)
plot(T(k,:),v(k,:),'k', 'LineWidth', 1);
grid on;
xlim([0 1]);
set(gca,'XTicklabel',{'-1','-0.9','-0.8','-0.7','-0.6','-0.5','-0.4','-0.3','-0.2','-0.1','0'});
ylabel('GF (mV)');
set(gca,'Ylim',[-90,50]);
string = append('l/v = ',num2str(1000*tao(k)),' ms');
text(0.03, 30, string);
%============================================
subplot(8,5,31:35)
k = 4;
imshow(Scene(:,:,k));
text(200,330,[num2str(Tag1(k)),'s'],'horiz','center','color','k');
text(600,330,[num2str(Tag2(k)),'s'],'horiz','center','color','k');
text(1000,330,[num2str(Tag3(k)),'s'],'horiz','center','color','k');
text(1400,330,[num2str(Tag4(k)),'s'],'horiz','center','color','k');
text(1800,330,[num2str(Tag5(k)),'s'],'horiz','center','color','k');
%---------------
subplot(8,5,36:40)
plot(T(k,:),v(k,:),'k', 'LineWidth', 1);
grid on;
xlim([0 1]);
set(gca,'XTicklabel',{'-1','-0.9','-0.8','-0.7','-0.6','-0.5','-0.4','-0.3','-0.2','-0.1','0'});
ylabel('GF (mV)');
set(gca,'Ylim',[-90,50]);
string = append('l/v = ',num2str(1000*tao(k)),' ms');
text(0.03, 30, string);
xlabel('Time to collision (s)');