function dx=PID_rlc(t,x)
    global track_num noise_num L0 C R alpha u_record_cmp t_record_cmp;
    [yd,yd1,~]=caltrack_rlc(track_num,t);
    y = cal_x1noise(x(1), t, noise_num);
    kp=50000;
    kd=500;
    ki=10000000;
%     kp=25000;
%     kd=300;
%     ki=50;
    coff = L0/(1+alpha*x(2)^2);
    md = -(1+alpha*x(2)^2)*(R*C*x(2)+x(1))/(L0*C);
    u = kd*(yd1-x(2))+kp*(yd-y)+ki*x(3);
%         u=1;
    t_record_cmp = [t_record_cmp t];
    u_record_cmp = [u_record_cmp u];
    dx=zeros(3,1);
    dx(1)=x(2);
    dx(2)=md+1/coff*u;
    dx(3)=yd-x(1);
end
