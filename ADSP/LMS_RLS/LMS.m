function [LMS_a1]=LMS(xn,dn,M,mu)
% LMS(Least Mean Squre)算法
% 	输入参数:
% 	xn	输入的信号序列	(列向量)
% 	dn	所期望的响应序列	(列向量)
% 	M	滤波器的阶数	(标量)
% 	mu	收敛因子(步长)	(标量)	要求大于0,小于xn的相关矩阵最大特征值的倒数
% 	itr	迭代次数	(标量)默认为xn的长度,M<itr<length(xn)
% 输出参数:
%	W	滤波器的权值矩阵	(矩阵)
%	大小为M x itr,
%	en	误差序列(itrx1)	(列向量)	
%	yn	实际输出序列	(列向量)

% 初始化参数
itr = length(xn);
en = zeros(itr,1);	% 误差序列,en(k)表示第k次迭代时预期输出与实际输入的误差
W = zeros(M,itr);	% 每一行代表一个加权参量,每一列代表-次迭代,初始为0

% 迭代计算
for k = M:itr	% 第k次迭代
    x = xn(k:-1:k-M+1);	% 滤波器M个抽头的输入
    y = W(:,k-1).'*x;	% 滤波器的输出
    en(k) = dn(k)-y;	% 第k次迭代的误差

% 滤波器权值计算的迭代式
    W(:,k) = W(:,k-1) + 2*mu*en(k)*x;
end

% 求最优时滤波器的输出序列
yn = inf * ones(size(xn));
for k = M:length(xn)
    x = xn(k:-1:k-M+1);
    yn(k) = W(:,end).'*x;
end
LMS_a1 = -W(2,:);
end
