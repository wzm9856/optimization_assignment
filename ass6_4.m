close all; clear;

% getf(x)
% getg(x)
% getG(x)
% solve_sub_problem(g,G,delta)
% G_not_positive(p,x,delta,g,G)
% outside_trust_region(p,x,delta)
getq = @(s,g,G) g'*s+s'*G*s*0.5;  % ������������f

n = 10;
delta = 1000;
delta_history = delta;
x = 2*ones(2*n,1);
point_history = x;
rho_history = 0;
s_history = zeros(2*n,1);
while 1
    f = getf(x);
    g = getg(x);
    G = getG(x);
    if norm(g,2)<1e-6
        break;
    end
    s = solve_sub_problem(g,G,delta);
    s_history = [s_history s];
    f_new = getf(x+s);
    q_new = getq(s,g,G);
    rho = (f-f_new)/(-q_new);      % ��������q�����Ͳ���f
    rho_history = [rho_history rho];
    if rho <= 0
        %x���䣬ֻ���Ժ����������
    else
        x = x + s;
    end
    point_history = [point_history x];
    if rho < 0.25
        delta = norm(s,2)/4;
    else
        if (rho > 0.75) && (abs(norm(s,2)-delta)<1e-12)
            delta = 2*delta;
        else
            % delta����
        end
    end
    delta_history = [delta_history delta];
end


function f = getf(x)
    x2i_1 = x(1:2:end);
    x2i = x(2:2:end);
    f = sum((1-x2i_1).^2) + 10*sum((x2i-x2i_1.^2).^2);
end

function g = getg(x)
    x2i_1 = x(1:2:end);
    x2i = x(2:2:end);
    g2i_1 = -2*(1-x2i_1) - 40*(x2i-x2i_1.^2).*x2i_1;
    g2i = 20*(x2i-x2i_1.^2);
    g = zeros(length(x),1);
    g(1:2:end) = g2i_1;
    g(2:2:end) = g2i;
end

function G = getG(x)
    % ��һ��n*n�ľ��󣬵�ֻ�жԽ��ϵ�����2*2С�������ֵ������Ϊ0
    n = length(x)/2;
    G = zeros(2*n,2*n);
    for i = 1:n
        G(2*i-1,2*i-1) = 2-40*x(2*i)+120*x(2*i-1)^2;
        G(2*i-1,2*i) = -40*x(2*i-1);
        G(2*i,2*i-1) = -40*x(2*i-1);
        G(2*i,2*i) = 20;
    end
end

function s = solve_sub_problem(g,G,delta)
    r = g; p = -g; r0 = g;
    x = zeros(length(g),1);
    while 1
        if g'*G*g <= 0
            s = G_not_positive(p,x,delta,g,G);
            disp("G��������");
            return
        end
        a = r'*r/(p'*G*p);
        x_new = x+a'*p;
        if norm(x_new,2) >= delta
            s = outside_trust_region(p,x,delta);
            disp("����������߽�");
            return
        end
        x = x_new;
        r_new = r+a*G*p;
        if norm(r_new,2)<1e-6*norm(r,2)
            s = x;
            disp("����ֹͣ����");
            return
        end
        b = r_new'*r_new/(r'*r);
        r = r_new;
        p = -r+b*p;
    end
end

function s = G_not_positive(p,x,delta,g,G)
    % Ѱ�ҵ�ǰ����p�������� ������߽��ϵ�q��Сֵλ��
    a = p'*p;
    b = p'*x;
    c = x'*x-delta^2;
    d = b^2-4*a*c;
    x_1 = (-b+d^(0.5))/(2*a);
    x_2 = (-b-d^(0.5))/(2*a);
    qs_1 = getq(x_1,g,G);
    qs_2 = getq(x_2,g,G);
    if qs_1<=qs_2
        t = x_1;
    else
        t = x_2;
    end
    s = x+t*p;
end

function s = outside_trust_region(p,x,delta)
    % �����㳬��������Χ����������p�����ߵ�������߽���
    a = p'*p;
    b = p'*x;
    c = x'*x-delta^2;
    d = b^2-4*a*c;
    x_1 = (-b+d^(0.5))/(2*a);
    x_2 = (-b-d^(0.5))/(2*a);
    if x_1>=0
        t = x_1;
    else
        if x_2>=0
            t = x_2;
        else
            disp("զ����");
            s = 1000000;
            return
        end
    end
    s = x+t*p;
end
