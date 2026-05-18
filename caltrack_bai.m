function [y,yd1,yd2]=caltrack_bai(track_num,t)
switch track_num
    case 1
        %track x(1) to sin(t)
        xishu = 2*pi/0.15;
        y = (1e-5)*sin(xishu*t);
        yd1 = (1e-5)*xishu*cos(xishu*t);
        yd2 = -xishu^2*sin(xishu*t)*(1e-5);
    case 2
        y = 1;
        yd1 = 0;
        yd2 = 0;
    case 3
        coff = 0.85;
        if t<5
            y = -coff;
            yd1 = 0;
            yd2 = 0;
        elseif t<10
            y = coff;
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
        y = 0.9;
        yd1 = 0;
        yd2 = 0;
    case 6
        y = 0.5;
        yd1 = 0;
        yd2 = 0;
end
end
