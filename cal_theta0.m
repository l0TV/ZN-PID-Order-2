function theta = cal_theta0(t)
% theta = 2+0.5*sin(t-1);
% theta = ((0.1/300 + 0.7/80)/2 + (0.7/80 - 0.1/300)/2*sin(t-1));
theta = 0.478/216+0.0005*sin(pi*t);
end

