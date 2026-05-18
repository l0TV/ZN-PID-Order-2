function dx=ZPID_bai(t,x)
    global track_num noise_num M m g l u_record coff_record;
    [yd,yd1,yd2]=caltrack_bai(track_num,t);
%     l1 = 7;
%     l2 = 9;
%     l3 = 3;
    l1 = 9+3i;
    l2 = 9-3i;
    l3 = 3;
    kd = l1+l2+l3;
    kp = l1*l2+l2*l3+l1*l3;
    ki = l1*l2*l3;
%     kd=21;
%     kp=200;
%     ki=270;
    coff = -l*(M+m*sin(x(1))^2)/cos(x(1));
    coff_record = [coff_record coff];
    md = ((M+m)*g*sin(x(1))-m*l*sin(x(1))*cos(x(1))*x(2)^2)/(l*(M+m*sin(x(1))^2));
    u = coff*(yd2-md+kd*(yd1-x(2))+kp*(yd-x(1))+ki*x(3));
    u_record = [u_record u];
    dx=zeros(3,1);
    dx(1)=cal_x1noise(x(2), t, noise_num);
    dx(2)=md+1/coff*u;
    dx(3)=yd-x(1);
end
