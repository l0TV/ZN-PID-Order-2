clear;
close all;
clc;
format long;
current=cd;
global track_num noise_num theta1 theta2 u_record u_record_cmp;
u_record = [];
u_record_cmp = [];
% 仿真时间
T=1800;
% 系统参数
theta1=-1/216;
theta2=-30/216;

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
        trackname='sine-smooth-piecewise-linear(0/1/-1/0)';
    case 6
        trackname='sine-smooth-piecewise-linear(0/1/-1)';
    case 7
        trackname='polynomial-smooth-piecewise-linear(0/1/-1)';
end
noise_num = 2;
switch noise_num
    case 1
        noisename='zero_noise';
    case 2
        noisename='0.5sin(t-1)_noise';
    case 3
        noisename='linear_0.1t';
    case 4
        noisename='const_0.01';
    case 5
        noisename='t^2';
    case 6
        noisename='random';
end

h_opt=odeset;
h_opt.MaxStep=0.01;
[t,x]=ode15s(@ZPID_ship,[0,T],[0 0 0], h_opt);
[t_cmp,x_cmp]=ode15s(@PID_ship,[0,T],[0 0 0], h_opt);

t_length = length(t);
t_cmp_length = length(t_cmp);
desired=zeros(t_length,1);
desired_cmp=zeros(t_cmp_length,1);
yd1_cmp=zeros(t_cmp_length,1);
yd1=zeros(t_length,1);
yd2_cmp=zeros(t_cmp_length,1);
yd2=zeros(t_length,1);
theta0=zeros(t_length,1);
for j=1:t_length
    [desired(j),yd1(j),yd2(j)]=caltrack(track_num,t(j));
    theta0(j) = cal_theta0(t(j));
end
for j=1:t_cmp_length
    [desired_cmp(j),yd1_cmp(j),yd2_cmp(j)]=caltrack(track_num,t_cmp(j));
end
error=x(:,1)-desired;
error_cmp=x_cmp(:,1)-desired_cmp;
disp(['MSE of ZPID:', num2str(sqrt((norm(error))^2/length(desired)))]);
disp(['MSE of PID:', num2str(sqrt((norm(error_cmp))^2/length(desired_cmp)))]);
% error_abs=abs(error);
% steady=1;
% for j=1:t_length
%     if error_abs(j)<10^(-5)
%         steady=j;
%         break;
%     end
% end
% MSSRE=max(error_abs(j:t_length));

mu = cal_mu(t, error);
% u = 1/(0.478/216)*(yd2-theta1*x(2)-theta2*x(2).^3-3*mu.*(x(2)-yd1)-3*mu.^2.*(x(1)-desired)-mu.^3.*x(3));

% Draw pics
tracking_plot=figure(1);
plot(t,x(:,1),'Color',[0.30,0.75,0.93],'linewidth', 2);
hold on;
plot(t_cmp,x_cmp(:,1),'--','Color',[1.00,0.41,0.16],'linewidth', 2);
hold on;
plot(t,desired,'-.k','linewidth', 1);
[max_value, idx] = max(x(:,1));
hold on;
% stem(t(idx), max_value,'--',"Marker",'.','LineWidth',0.7,'MarkerSize',10, BaseValue=-10);
% stem(198.43, x_cmp(19844,1),'--',"Marker",'.','LineWidth',0.7,'MarkerSize',10, BaseValue=-10);
% stem(680, 1.2,'--',"Marker",'.','LineWidth',0.7,'MarkerSize',10, BaseValue=-10);
stem(t(173873), 0.8731,'--',"Marker",'.','LineWidth',0.7,'MarkerSize',10, BaseValue=-10);
% handle = legend('$y_{\mathrm{ZD-PD}}$','$y_{\mathrm{ZD-PID}}$', '$y_d$',Location='southeast');
% set(handle,'Interpreter','latex');
legend('Z-PID', 'PID', 'Desired', Location='northeast');
% anno = annotation('textarrow', [0.45, 0.3], [0.84, 0.84], 'String', ' (114.8, 1.253)');
% anno.FontName = 'times';
% anno.FontSize = 11;
% anno.HeadStyle = 'hypocycloid';
% anno.HeadWidth = 7;
% anno = annotation('textarrow', [0.5, 0.36], [0.5, 0.67], 'String', ' (198.4, 0.950)');
% anno.FontName = 'times';
% anno.FontSize = 11;
% anno.HeadStyle = 'hypocycloid';
% anno.HeadWidth = 7;
% anno = annotation('textarrow', [0.75, 0.86], [0.55, 0.73], 'String', '(680.0, 1.200) ');
% anno.FontName = 'times';
% anno.FontSize = 11;
% anno.HeadStyle = 'hypocycloid';
% anno.HeadWidth = 7;
xlabel('Time \rm(s)');
ylabel('System Output (rad)');
set(gca, 'FontName', 'times');
set(gca, 'fontsize', 12);
% set(gca, 'children', gca().Children([1 2 5 4 3]));
% set(gca, 'children', gca().Children([1 4 3 2]));
% set(gca, 'children', gca().Children([3 2 1]));
set(gcf,'Position', [500 250 550 325]);
% xlim([0 500]);
% ylim([-0.1 1.3]);
% ylim([0 1.4]);


% [~, pos] = max(error);
% pos = pos-165;
error_plot=figure(2);
% semilogy(t_cmp, abs(error_cmp),t(pos:t_length),error(pos:t_length), 'linewidth', 1);
semilogy(t,abs(error),'g', t_cmp, abs(error_cmp),'--b', 'linewidth', 1);
% plot(t_cmp, error_cmp,t,error, 'linewidth', 1);
% xlim([0 500]);
hold on;
% stem(109.29, abs(error(10930)),'--',"Marker",'.','LineWidth',0.7,'MarkerSize',10,'Color','#7E2F8E');
% anno = annotation('textarrow', [0.36, 0.27], [0.5, 0.8], 'String', ' (109.3, 0.243)');
% stem(160.16, abs(error(16017)),'--',"Marker",'.','LineWidth',0.7,'MarkerSize',10,'Color','#7E2F8E');
% anno = annotation('textarrow', [0.49, 0.39], [0.4, 0.7], 'String', ' (160.2, 0.037)');
% anno.FontName = 'times';
% anno.FontSize = 11;
% anno.HeadStyle = 'hypocycloid';
% anno.HeadWidth = 7;
legend('Z-PID','PID',Location='southeast');
xlabel('Time \rm(s)');
ylabel('Absolute tracking error (rad)');
set(gca, 'FontName', 'times');
set(gca, 'fontsize', 12);
set(gcf,'Position', [500 250 550 325]);
% ylim([9*1e-8,max(abs(error))*1.8]);
xlim([41 T]);

all_pic=figure(3);
plot(t, x(:,2),'g',t_cmp,x_cmp(:,2),'--b', 'linewidth', 1);
% set(gca,'FontSize',FontSize);
legend('ZD-PID','ZD-PD');
xlabel('Time \rm(s)');
ylabel('Angular velocity (rad/s)');
% xlim([0 500]);
% xlim([0,10]);
% ylim([-4 23]*1e-3);
set(gca, 'FontName', 'times');
set(gca, 'fontsize', 12);
set(gcf,'Position', [500 250 550 325]);

u_pic = figure(4);
plot(t,u_record(1:t_length),'g',t_cmp, u_record_cmp(1:t_cmp_length),'--b', 'linewidth', 1);
% set(gca,'FontSize',FontSize);
legend('ZD-PID','ZD-PD');
xlabel('Time \rm(s)');
ylabel('Rudder angle (rad)');
set(gca, 'FontName', 'times');
set(gca, 'fontsize', 12);
set(gcf,'Position', [500 250 550 325]);
% xlim([0 500]);
% ylim([-0.3 1.2]);

