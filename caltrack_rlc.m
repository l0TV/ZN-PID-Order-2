function [y,yd1,yd2]=caltrack_rlc(track_num,t)
switch track_num
    case 1
        %track x(1) to sin(t)
        xishu = 2*pi/0.15;
        y = (1e-5)*sin(xishu*t);
        yd1 = (1e-5)*xishu*cos(xishu*t);
        yd2 = -xishu^2*sin(xishu*t)*(1e-5);
    case 2
        y = 1e-5;
        yd1 = 0;
        yd2 = 0;
    case 3
        if t<0.1
            y = 1e-5;
            yd1 = 0;
            yd2 = 0;
        elseif t<0.2
            y = -1e-5;
            yd1 = 0;
            yd2 = 0;
        else
            y = 0;
            yd1 = 0;
            yd2 = 0;
        end
    case 4
        y = exp(-0.24*t)*sin(2*pi*t/3);
        yd1 = 2*pi/3*exp(-0.24*t)*cos(2*pi*t/3)-0.24*exp(-0.24*t)*sin(2*pi*t/3);
        yd2 = -(2*pi/3)^2*exp(-0.24*t)*sin(2*pi*t/3)-0.24*2*pi/3*exp(-0.24*t)*cos(2*pi*t/3)+0.24^2*exp(-0.24*t)*sin(2*pi*t/3)-2*pi/3*0.24*exp(-0.24*t)*cos(2*pi*t/3);
    case 5
        td=0.05;
        tc1=0.1;
        tc2=0.5;
        y1 = 0;
        y2 = 1e-5;
        y3 = -1e-5;
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
end
end
