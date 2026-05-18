function [y,yd1,yd2]=caltrack(track_num,t)
switch track_num
    case 1
        %track x(1) to sin(t)
        y=0.5*sin(2*pi*t/300);
        yd1 =0.5*2*pi/300*cos(2*pi*t/300);
        yd2 =-0.5*(2*pi/300)^2*sin(2*pi*t/300);
    case 2
        y = 1;
        yd1 = 0;
        yd2 = 0;
    case 3
        if t<300
            y = 1;
            yd1 = 0;
            yd2 = 0;
        elseif t<600
            y = -1;
            yd1 = 0;
            yd2 = 0;
        else
            y = 0;
            yd1 = 0;
            yd2 = 0;
        end
    case 4
        y = exp(-0.004*t)*sin(2*pi*t/250);
        yd1 = 2*pi/250*exp(-0.004*t)*cos(2*pi*t/250)-0.004*exp(-0.004*t)*sin(2*pi*t/250);
        yd2 = -(2*pi/250)^2*exp(-0.004*t)*sin(2*pi*t/250)-0.004*2*pi/250*exp(-0.004*t)*cos(2*pi*t/250)+0.004^2*exp(-0.004*t)*sin(2*pi*t/250)-2*pi/250*0.004*exp(-0.004*t)*cos(2*pi*t/250);
    case 5
        td = 20;
        tc1=50;
        tc2=500;
        tc3=900;
        y1 = 0;
        y2 = 1;
        y3 = -1;
        y4 = 0;
        if t<=tc1-td/2
            y = y1;
            yd1 = 0;
            yd2 = 0;
        elseif t<tc1+td/2
            y = (y2-y1)/2*sin(pi*t/td-tc1*pi/td)+(y1+y2)/2;
            yd1 = (y2-y1)/2*pi/td*cos(pi*t/td-tc1*pi/td);
            yd2 = -(y2-y1)/2*(pi/td)^2*sin(pi*t/td-tc1*pi/td);
        elseif t<=tc2-td/2
            y = y2;
            yd1 = 0;
            yd2 = 0;
        elseif t<tc2+td/2
            y = (y3-y2)/2*sin(pi*t/td-tc2*pi/td)+(y2+y3)/2;
            yd1 = (y3-y2)/2*pi/td*cos(pi*t/td-tc2*pi/td);
            yd2 = -(y3-y2)/2*(pi/td)^2*sin(pi*t/td-tc2*pi/td);
        elseif t<=tc3-td/2
            y = y3;
            yd1 = 0;
            yd2 = 0;
        elseif t<tc3+td/2
            y = (y4-y3)/2*sin(pi*t/td-tc3*pi/td)+(y3+y4)/2;
            yd1 = (y4-y3)/2*pi/td*cos(pi*t/td-tc3*pi/td);
            yd2 = -(y4-y3)/2*(pi/td)^2*sin(pi*t/td-tc3*pi/td);
        else
            y = y4;
            yd1 = 0;
            yd2 = 0;
        end
    case 6
        td=20;
        tc1=50;
        tc2=900;
        y1 = 0;
        y2 = 1;
        y3 = -1;
        if t<=tc1-td/2
            y = y1;
            yd1 = 0;
            yd2 = 0;
        elseif t<tc1+td/2
            y = (y2-y1)/2*sin(pi*t/td-tc1*pi/td)+(y1+y2)/2;
            yd1 = (y2-y1)/2*pi/td*cos(pi*t/td-tc1*pi/td);
            yd2 = -(y2-y1)/2*(pi/td)^2*sin(pi*t/td-tc1*pi/td);
        elseif t<=tc2-td/2
            y = y2;
            yd1 = 0;
            yd2 = 0;
        elseif t<tc2+td/2
            y = (y3-y2)/2*sin(pi*t/td-tc2*pi/td)+(y2+y3)/2;
            yd1 = (y3-y2)/2*pi/td*cos(pi*t/td-tc2*pi/td);
            yd2 = -(y3-y2)/2*(pi/td)^2*sin(pi*t/td-tc2*pi/td);
        else
            y = y3;
            yd1 = 0;
            yd2 = 0;
        end
    case 7
        td = 20;
        tc1 = 50;
        tc2 = 900;
        y1 = 0;
        y2 = 1;
        y3 = -1;
        
        % 计算五次多项式系数
        % 对于第一个过渡段 (y1 -> y2)
        tau1 = t - (tc1 - td/2); % 局部时间变量
        if t <= tc1 - td/2
            y = y1;
            yd1 = 0;
            yd2 = 0;
        elseif t < tc1 + td/2
            % 五次多项式系数 (基于边界条件计算)
            % 边界条件: 
            % f(0)=y1, f(td)=y2, f'(0)=0, f'(td)=0, f''(0)=0, f''(td)=0
            % 解方程组得到系数
            a0 = y1;
            a1 = 0;
            a2 = 0;
            a3 = 10*(y2-y1)/(td^3);
            a4 = -15*(y2-y1)/(td^4);
            a5 = 6*(y2-y1)/(td^5);
            
            % 计算位置、速度和加速度
            y = a0 + a1*tau1 + a2*tau1^2 + a3*tau1^3 + a4*tau1^4 + a5*tau1^5;
            yd1 = a1 + 2*a2*tau1 + 3*a3*tau1^2 + 4*a4*tau1^3 + 5*a5*tau1^4;
            yd2 = 2*a2 + 6*a3*tau1 + 12*a4*tau1^2 + 20*a5*tau1^3;
        elseif t <= tc2 - td/2
            y = y2;
            yd1 = 0;
            yd2 = 0;
        elseif t < tc2 + td/2
            % 对于第二个过渡段 (y2 -> y3)
            tau2 = t - (tc2 - td/2); % 局部时间变量
            
            % 五次多项式系数
            a0 = y2;
            a1 = 0;
            a2 = 0;
            a3 = 10*(y3-y2)/(td^3);
            a4 = -15*(y3-y2)/(td^4);
            a5 = 6*(y3-y2)/(td^5);
            
            % 计算位置、速度和加速度
            y = a0 + a1*tau2 + a2*tau2^2 + a3*tau2^3 + a4*tau2^4 + a5*tau2^5;
            yd1 = a1 + 2*a2*tau2 + 3*a3*tau2^2 + 4*a4*tau2^3 + 5*a5*tau2^4;
            yd2 = 2*a2 + 6*a3*tau2 + 12*a4*tau2^2 + 20*a5*tau2^3;
        else
            y = y3;
            yd1 = 0;
            yd2 = 0;
        end
end
end
