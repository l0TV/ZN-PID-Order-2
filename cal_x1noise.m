function x1_noise = cal_x1noise(x1, t, noise_num)
switch noise_num
    case 1
        x1_noise = x1+0*t;
    case 2
        x1_noise = x1+0.005*sin(2*pi/300*t);
%         x1_noise = x1+0.1*sin(2*t);
    case 3
%         x1_noise = x1+t*(1e-5);
        x1_noise = x1+t;
    case 4
%         x1_noise = x1-0.01;
        x1_noise = x1-0.1;
    case 5
        x1_noise = x1+0.01*t*t;
end
end

