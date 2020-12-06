close all;clear;

q = @(x) 9*x-4*log(x-7);
g = @(x) 9-4*(x-7).^-1;
G = @(x) 4*(x-7).^-2;

x = 7.1;
p_history = x;
g_now = 10;
while abs(g_now)>1e-6
    q_now = q(x);
    g_now = g(x);
    G_now = G(x);
    s = -G_now^(-1)*g_now;        % 步长  
    x = x+s;
    p_history = [p_history x];
    if x<=7                     % x超出定义域 无法继续迭代
        disp('超出定义域');
        break;
    end
end

a = max([(min(p_history)-0.1) 7]):0.01:(max(p_history)+0.1);
plot(a,q(a));
hold on;
scatter(p_history, q(p_history));
% plot(p_history, q(p_history));