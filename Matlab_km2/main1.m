%%%%%%�о���Ͼ���Ϊk(ij)=k*exp(-a*abs(i-j))ʱ��kuramotoģ�͵�����������k,aֱ�ӵĹ�ϵ��%%%%%
clc;clear;
tspans=[0,8*pi];%����˵�;
h=0.01;%����ȷ���Ŀ;
N=100;%���̵ĸ���;
w=linspace(-2,2,N);
W=(2./(1+w.^2))';%��ʾƵ�ʷֲ�
a=7;
k=30;%��ʾcoupling parameter
%Y0=1;
Y0=randi([1,10],N,1);%��ʼֵ;
[x,Y]=Kuramoto_ODE451('interaction1',tspans,h,W,k,a,Y0,N);
figure(k*1000+1);
plot(x,Y);
colorbar;
xlabel('t');
ylabel('\theta');
title('The numerical solution of kuramoto model');
%%%%%%%%%%%%%%%%%����kuramoto model ����ϳ̶�R(�����).
figure(100*k*a+2)
theta=0:0.01:2*pi;
x0=cos(theta);
y0=sin(theta);
plot(x0,y0,'r-','LineWidth',1);
hold on
Theta=Y(:,end);
rend=sqrt((sum(cos(Theta))/N).^2+(sum(sin(Theta))/N).^2); %
scatter(cos(Theta),sin(Theta),'filled','cdata',w);%ɢ��ͼ��
title(['order parameter r=',num2str(rend)]);
colorbar
%%%%%%%%%%%%%%%%%������r��ʱ��t�Ĺ�ϵ%%%%%%%%%%%%%
r=sqrt((sum(cos(Y))/N).^2+(sum(sin(Y))/N).^2);
figure(100*k*a+4);
plot(x,r);
colorbar;
xlabel('t');
ylabel('r');
title('������r��ʱ��t�Ĺ�ϵ');
%%%%%%%%%%%%%%%��Ƶ�ʷֲ�����Ϊg(w)=r/(pi*(r^2+w^2))ʱ��r=(-1+sqrt(1+k^2))/k;
% figure(100*k+3)
% k=0:0.01:20;
% rr=(-1+sqrt(1+k.^2))./k;
% plot(k,rr,'r-');
% xlabel('coupling parameter k');
% ylabel('order parameter r');

% figure(2)
% clc;clear;
% W=[1,2]';po=[1,1]';c=1;
% dpt=@(P,W,c)W+c*sum(sin(meshgrid(P)-meshgrid(P)'),2);
% [t,p]=ode45(@(t,p)dpt(p,W,c),[0,pi],po);
% plot(t,p)

