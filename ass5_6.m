close all;clear;

q=@(x) sum((x'*[5 -4.5;-4.5 5])'.*x+[4;-15].*x+6.5);    %函数值 输入2*n 输出1*n
g=@(x) [10 -9;-9 10]*x+[4;-15];                         %梯度方向 输入输出2*n
G = [10 -9;-9 10];                      %海森矩阵
alpha=@(p) p'*p/(p'*G*p);               %步长 pg等效 防止混淆就换个字母 是单个常量

x = [0; 0];
p_history = [x];
while 1
    if norm(x-[5; 6])>0.1
        break;
    end
    g_now=g(x);
    alpha_now = alpha(g_now);
    x = x-g_now*alpha_now;
    p_history = [p_history x];
end

