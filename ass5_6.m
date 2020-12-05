close all;clear;

q = @(x,y) 5*x.*x-9*x.*y+5*y.*y+4*x-15*y+13;    %函数值
g = @(x,y) cat(3,10*x-9*y+4,-9*x+10*y-15);      %梯度方向 输出为3维向量
G = [10 -9;-9 10];                              %海森矩阵
alpha=@(p) p'*p/(p'*G*p);                       %步长 pg等效 防止混淆就换个字母 是单个常量

x = 0;
y = 0;
p_history = [x; y];
while 1
    if norm([x; y]-[5; 6])<0.1
        break;
    end
    g_now=reshape(g(x, y),2,1);
    alpha_now = alpha(g_now);
    temp = [x; y] - g_now*alpha_now;
    x = temp(1); y = temp(2);
    p_history = [p_history [x; y]];
end

