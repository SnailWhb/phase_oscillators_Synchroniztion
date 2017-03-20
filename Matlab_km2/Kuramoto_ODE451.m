function [x,Y]=Kuramoto_ODE451(interaction1,tspans,h,W,C,a,Y0,N)
%EuLer��ʽ,
%��ⷽ��y'=vectorfun(t,y);����t \in[a,b];Y0Ϊ��ʼֵ��nΪ�Ա�������ɢ������YΪ�����
%a1��ʾ����tǰ���ϵ����A��ʾYǰ���ϵ����N��ʾ���������ĸ�����
x=tspans(1):h:tspans(2);
n=length(x);
Y=zeros(N,n);%�����ֵ�Ľ�
x(1)=tspans(1);
Y(:,1)=Y0;
for i=1:n-1
K1=feval(interaction1,x(i),W,C,a,Y(:,i));
K2=feval(interaction1,x(i)+h/2,W,C,a,Y(:,i)+h/2.*K1);
K3=feval(interaction1,x(i)+h/2,W,C,a,Y(:,i)+h/2.*K2);%%Rugekutta�Ľ׸�ʽ
K4=feval(interaction1,x(i)+h,W,C,a,Y(:,i)+h.*K3);
Y(:,i+1)=Y(:,i)+(h/6).*(K1+2.*K2+2.*K3+K4);
end





