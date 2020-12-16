q=@(x,y) (1-x).*(1-x)+100*(y-x.*x).^2;
g=@(x,y) ([2*(x-1)-400*x*(y-x*x); 200*(y-x*x)]);
G=@(x,y) ([2-400*y+1200*x*x -400*x*y;-400*x*y 200]);
data = [1.2 -1.2;1.2 1];
datanum = 2;                              %方便选择第几组数据
x = data(:,datanum);
rho=0.0001;
point_history=x;

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
%     if length(point_history)==160||length(point_history)==161
%         asdfadsfasdf=1;
%     end
    if norm(x-[1;1])<0.001
        break;
    end
end

draw_contour(q,point_history);
