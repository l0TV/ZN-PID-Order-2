function dx=ZPID_rlc(t,x)
    global track_num noise_num L0 C R alpha u_record coff_record;
    [yd,yd1,yd2]=caltrack_rlc(track_num,t);
    y = cal_x1noise(x(1), t, noise_num);
%     l1 = 0.8;
%     l2 = 0.9;
%     l3 = 0.3;
    l1 = 150+50i;
    l2 = 150-50i;
    l3 = 1e2;
    kd = l1+l2+l3;
    kp = l1*l2+l2*l3+l1*l3;
    ki = l1*l2*l3;
    coff = L0/(1+alpha*x(2)^2);
    coff_record = [coff_record coff];
    md = -(1+alpha*x(2)^2)*(R*C*x(2)+x(1))/(L0*C);
    u = coff*(yd2-md+kd*(yd1-x(2))+kp*(yd-y)+ki*x(3));
    u_record = [u_record u];
    dx=zeros(3,1);
    dx(1)=x(2);
    dx(2)=md+1/coff*u;
    dx(3)=yd-x(1);
end
