function dx=PID_ship(t,x)
    global track_num noise_num theta1 theta2 u_record_cmp;
    [yd,yd1,~]=caltrack(track_num,t);
    theta0 = cal_theta0(t);
    l1 = 0.008;
    l2 = 0.09;
    l3 = 0.03;
    kd = l1+l2+l3;
    kp = l1*l2+l2*l3+l1*l3;
    ki = l1*l2*l3;
    u = 1/(0.478/216)*(kd*(yd1-x(2))+kp*(yd-x(1))+ki*x(3));
    u_record_cmp = [u_record_cmp u];
    dx=zeros(3,1);
    dx(1)=cal_x1noise(x(2), t, noise_num);
    dx(2)=theta1*x(2)+theta2*x(2)*x(2)*x(2)+theta0*u;
    dx(3)=yd-x(1);
end
