getr = @(x,t,d) (1-t.*x(1)).^x(2)-d;
getf = @(r) 0.5*(r'*r);
t = [2000;5000;10000;20000;30000;50000];
d = [0.9427;0.8616;0.7384;0.5362;0.3739;0.3096];
x = [-2;-2];
point_history = x;
rho = 0.01;
gamma = 0.5;
r = getr(x,t,d);
A = getA(x0,t);
f = getf(r0);
g = A'*r;
G = A'*A;
i = 1;
while (norm(g)>1e-4)&&(i<500)
    p = -(G^(-1)*g);
    a = armijo(g,p,x,f,rho,gamma,t,d,getf,getr);
    x = x + a*p;
    point_history = [point_history x];
    r = getr(x,t,d);
    A = getA(x,t);
    g = A'*r;
    G = A'*A;
    f = getf(r);
    i = i+1;
end
disp(sqrt(sum(r.^2)/5));
x1 = 1/96.05/(x(2)+1);
x2 = x1/x(1);
disp([x1 x2]);
scatter(point_history(1,:),point_history(2,:),10,colormap(cool(size(point_history,2))),'filled')
colormap default;
hold on;

function a = armijo(g,p,x,f,rho,gamma,t,d,getf,getr)
    phi_0 = f;
    phi_g_0 = g;
    a = 1;
    x_1 = x+a*p;
    r_1 = getr(x_1,t,d);
    phi_a = getf(r_1);
    k = 1;
    while phi_a>phi_0+rho*phi_g_0*a
        a = gamma*a;
        x_1 = x+a*p;
        r_1 = getr(x_1,t,d);
        phi_a = getf(r_1);
        k = k+1;
    end
    x_tmp = x+a*p;
    while ((1-50000*x_tmp(1))<=0)
        a = gamma*a;
        x_tmp = x+a*p;
    end
end

function A = getA(x,t)
    A = [];
    for i = 1:length(t)
        r_g1 = -x(2)*t(i)*(1-x(1)*t(i))^(x(2)-1);
        r_g2 = (1-x(1)*t(i))^(x(2))*log((1-x(1)*t(i)));
        r_g = [r_g1;r_g2];
        A = [A,r_g];
    end
    A = A';
end