% ����������ţ�ٷ�
close all;clear;
check = @(x,y) (x>0&&y>0&&(x+y)<100&&(x-y)<50);
x = 10; y = 20;
p_history = [x; y];
mu = 0.1;                                   %mu��ȡ0.1��1
q = str2func(['q_mu' '0'*(mu==0.1) '1']);   %���������������q����

g_now = 100;
while norm(g_now)>1e-6
    q_now = q(x,y);
    g_now = g(x,y,mu);
    G_now = G(x,y,mu);
    s = -G_now^(-1)*g_now;
    
    x_new = x + s(1); y_new = y + s(2);
    while 1
        q_new = q(x_new,y_new);
        armijo = q_now+0.01*g_now'*s;           %armijo�е�rho
        if ~check(x_new,y_new)||(armijo<=q_new)
            s = s*0.1;                          %armijo�е�gamma
        else
            break;
        end
        x_new = x + s(1); y_new = y + s(2);
    end
    
    x = x + s(1); y = y + s(2);
    p_history = [p_history [x; y]];
end

draw_contour(q, p_history, 20);

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

function q = q_mu01(x,y)        % mu = 0.1�������Ϊ�˷������ҵĻ�ͼ������
    q = -9*x-10*y-0.1*(log(100-x-y)+log(x)+log(y)+log(50-x+y));
end

function q = q_mu1(x,y)
    q = -9*x-10*y-(log(100-x-y)+log(x)+log(y)+log(50-x+y));
end