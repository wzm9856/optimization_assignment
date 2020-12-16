% 用线搜索的牛顿法
close all;clear;
check = @(x,y) (x>0&&y>0&&(x+y)<100&&(x-y)<50);
x = 1; y = 40;
p_history = [x; y];
mu = 0.1;                                   %mu可取0.1或1
q = str2func(['q_mu' '0'*(mu==0.1) '1']);   %就替代了下面两个q函数

g_now = 100;
while 1
    q_now = q(x,y);
    g_now = g(x,y,mu);
    G_now = G(x,y,mu);
    if norm(g_now)<1e-6
        break;
    end
    s = -G_now^(-1)*g_now;
    
    x_new = x + s(1); y_new = y + s(2);
    while 1
        q_new = q(x_new,y_new);
        armijo = q_now+0.01*g_now'*s;           %0.01 armijo中的rho
        if ~check(x_new,y_new)||(armijo<=q_new)
            s = s*0.1;                          %armijo中的gamma
        else
            break;
        end
        x_new = x + s(1); y_new = y + s(2);
    end
    
    x = x + s(1); y = y + s(2);
    p_history = [p_history [x; y]];
end

draw_contour(q, p_history, 20,1.3);

function gg = g(x,y,mu)
    g1 = -9-mu*(-1/(100-x-y)+1/x-1/(50-x+y));
    g2 = -10-mu*(-1/(100-x-y)+1/y+1/(50-x+y));
    gg = [g1;g2];
end

function H = G(x,y,mu)
    H11 = 1/(100-x-y)^2+1/x^2+1/(50-x+y)^2;
    H12 = 1/(100-x-y)^2-1/(50-x+y)^2;
    H21 = 1/(100-x-y)^2-1/(50-x+y)^2;
    H22 = 1/(100-x-y)^2+1/y^2+1/(50-x+y)^2;
    H  = mu*[H11,H12;H21,H22];
end

function q = q_mu01(x,y)        % mu = 0.1的情况（为了方便用我的画图函数）
    q = -9*x-10*y-0.1*(log(100-x-y)+log(x)+log(y)+log(50-x+y));
end

function q = q_mu1(x,y)
    q = -9*x-10*y-(log(100-x-y)+log(x)+log(y)+log(50-x+y));
end