q=@(x,y) (1-x).*(1-x)+100*(y-x.*x).^2;
g=@(x,y) ([2*(x-1)-400*x*(y-x*x); 200*(y-x*x)]);
G=@(x,y) ([2-400*y+1200*x*x -400*x*y;-400*x*y 200]);
x=[1.2;1.2];
rho=0.0001;
point_history=x;
a=0.5:0.01:1.5;
a = repmat(a,101,1);
b=0.5:0.01:1.5;
b = repmat(b,101,1)';
c=(1-a).^2+100*(b-a.^2).^2;
contour(a,b,c,50);
hold on;
while 1
    alpha = 1;
    q_now = q(x(1),x(2));
    g_now = g(x(1),x(2));
    p_now = -g_now./norm(g_now);
    g_1d_now = g_now'*p_now;
    while 1
        x_new = x+p_now*alpha;
        q_new = q(x_new(1),x_new(2));
        l = q_now+rho*g_1d_now*alpha;
        if q_new < l
            break;
        end
        alpha = alpha * 0.1;
    end
    x = x_new;
    point_history = [point_history x];
    if norm(x-[1;1])<0.001
        break;
    end
end
scatter(point_history(1,:),point_history(2,:),10);
