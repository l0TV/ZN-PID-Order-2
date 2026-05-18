function dx=PID_bai(t,x)
    global track_num noise_num M m g l u_record_cmp coff_record;
    [yd,yd1,~]=caltrack_bai(track_num,t);
%     l1 = 0.8;
%     l2 = 0.9;
%     l3 = 0.3;
%     kd = l1+l2+l3;
%     kp = l1*l2+l2*l3+l1*l3;
%     ki = l1*l2*l3;
    kp=100;
    kd=10;
    ki=40;
    coff = -l*(M+m*sin(x(1))^2)/cos(x(1));
    md = ((M+m)*g*sin(x(1))-m*l*sin(x(1))*cos(x(1))*x(2)^2)/(l*(M+m*sin(x(1))^2));
    u = -(kd*(yd1-x(2))+kp*(yd-x(1))+ki*x(3));
    u_record_cmp = [u_record_cmp u];
    coff_record = [coff_record coff];
    dx=zeros(3,1);
    dx(1)=cal_x1noise(x(2), t, noise_num);
    dx(2)=md+1/coff*u;
    dx(3)=yd-x(1);
end
