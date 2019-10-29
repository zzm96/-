clear;%����ڴ����
clc;%����
close;

%���ɶ����Իع�ģ��
N=1000;
en = randn(1,N)';
a1 = -1.6; a2 = 0.8;
x = zeros(1,N)';
x(1) = en(1);
x(2) = -a1*x(1)+en(2);
for i=3:N 
    x(i)=-a1*x(i-1)-a2*x(i-2)+en(i);
end

%LMS�㷨
LMS_a1 = LMS(en,x,2,0.002);
%RLS�㷨  ��=1
RLS_a1 = RLS(x, 1);
%RLS�㷨  ��=0.98
RLS_a = RLS(x, 0.98);

%����ͼ��
x_label = linspace(0,999,1000);
a1 = zeros(1, 1000) - 1.6 ;
subplot(1,2,1);
plot(RLS_a1);hold on;
plot(LMS_a1, ':');hold on;
plot( a1);
legend('RLS a1', 'LMS a1');title('LMS��RLS a1 ����');axis([0 1000 -2 0]); 

subplot(1,2,2);
plot( RLS_a);hold on;
plot(a1);
title('RLS ��=0.98 ʱ a1 ����');axis([0 1000 -2 0]); 


