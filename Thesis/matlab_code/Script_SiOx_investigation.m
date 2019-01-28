clear all
close all

%%%%%%%%%%%%%%%%%%%%%%
% SiOx Investigation %
%%%%%%%%%%%%%%%%%%%%%%

load Air_Cauchy_SiOx(30nm)_SI.xy

x = Air_Cauchy_SiOx_30nm__SI(:,1);
y = Air_Cauchy_SiOx_30nm__SI(:,2);

load Air_Cauchy_SiOx(4nm)_SI.xy

x1 = Air_Cauchy_SiOx_4nm__SI(:,1);
y1 = Air_Cauchy_SiOx_4nm__SI(:,2);

load Air_Cauchy_SiOx(3nm)_SI.xy

x2 = Air_Cauchy_SiOx_3nm__SI(:,1);
y2 = Air_Cauchy_SiOx_3nm__SI(:,2);

load Air_Cauchy_SiOx(2nm)_SI.xy

x3 = Air_Cauchy_SiOx_2nm__SI(:,1);
y3 = Air_Cauchy_SiOx_2nm__SI(:,2);

load Air_Cauchy_SiOx(1nm)_SI.xy

x4 = Air_Cauchy_SiOx_1nm__SI(:,1);
y4 = Air_Cauchy_SiOx_1nm__SI(:,2);


plot(x,y,x1,y1,x2,y2,x3,y3,x4,y4)
legend('30nm','4nm','3nm','2nm','1nm')



