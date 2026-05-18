clear;
close all;
clc;
format long;
current=cd;
global track_num noise_num M m g l u_record u_record_cmp coff_record;
u_record = [];
u_record_cmp = [];
coff_record = [];
% 仿真时间
T=5;
% 系统参数
M=1;
m=0.1;
g=9.8;
l=0.25;
% 初始条件
ori_cond = [0 0 0];
% ori_cond = [0 0 0];

track_num=2;
switch track_num
    case 1
        trackname='sin(0.2pit)';
    case 2
        trackname='const-1';
    case 3
        trackname='0-1--1';
    case 4
        trackname='expsin';
    case 5
        trackname='const-2';
    case 6
        trackname='const-3';
end
noise_num = 1;
switch noise_num
    case 1
        noisename='zero_noise';
    case 2
        noisename='0.5sin(t-1)_noise';
    case 3
        noisename='linear_0.1t';
    case 4
        noisename='const_-0.01';
    case 5
        noisename='random';
end

h_opt=odeset;
h_opt.MaxStep=0.001;

[t,x]=ode15s(@ZPID_bai,[0,T], ori_cond, h_opt);
t_length = length(t);
desired=zeros(t_length,1);
for j=1:t_length
    [desired(j),~,~]=caltrack_bai(track_num,t(j));
end
plot(t,desired,'-.k','linewidth', 1);
hold on;
plot(t,x(:,1),'linewidth', 1);

track_num=5;
[t,x]=ode15s(@ZPID_bai,[0,T], ori_cond, h_opt);
t_length = length(t);
desired=zeros(t_length,1);
for j=1:t_length
    [desired(j),~,~]=caltrack_bai(track_num,t(j));
end
plot(t,desired,'linewidth', 1);
plot(t,x(:,1),'linewidth', 1);

track_num=6;
[t,x]=ode15s(@ZPID_bai,[0,T], ori_cond, h_opt);
t_length = length(t);
desired=zeros(t_length,1);
for j=1:t_length
    [desired(j),~,~]=caltrack_bai(track_num,t(j));
end
plot(t,desired,'linewidth', 1);
plot(t,x(:,1),'linewidth', 1);


% legend('PID','Z-PID', 'Desired',Location='northeast');
xlabel('Time \rm(s)');
ylabel('System Output (rad)');
set(gca, 'FontName', 'times');
set(gca, 'fontsize', 12);
% set(gca, 'children', gca().Children([3 2 1]));
set(gcf,'Position', [500 250 550 325]);

figure;
track_num = 2;
[t,x]=ode15s(@PID_bai,[0,T], ori_cond, h_opt);
t_length = length(t);
desired=zeros(t_length,1);
for j=1:t_length
    [desired(j),~,~]=caltrack_bai(track_num,t(j));
end
plot(t,desired,'-.k','linewidth', 1);
hold on;
plot(t,x(:,1),'linewidth', 1);

track_num=5;
[t,x]=ode15s(@PID_bai,[0,T], ori_cond, h_opt);
t_length = length(t);
desired=zeros(t_length,1);
for j=1:t_length
    [desired(j),~,~]=caltrack_bai(track_num,t(j));
end
plot(t,desired,'linewidth', 1);
plot(t,x(:,1),'linewidth', 1);

track_num=6;
[t,x]=ode15s(@PID_bai,[0,T], ori_cond, h_opt);
t_length = length(t);
desired=zeros(t_length,1);
for j=1:t_length
    [desired(j),~,~]=caltrack_bai(track_num,t(j));
end
plot(t,desired,'linewidth', 1);
plot(t,x(:,1),'linewidth', 1);


% legend('PID','Z-PID', 'Desired',Location='northeast');
xlabel('Time \rm(s)');
ylabel('System Output (rad)');
set(gca, 'FontName', 'times');
set(gca, 'fontsize', 12);
% set(gca, 'children', gca().Children([3 2 1]));
set(gcf,'Position', [500 250 550 325]);
