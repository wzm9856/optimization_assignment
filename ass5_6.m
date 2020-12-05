close all;clear;

q = @(x,y) 5*x.*x-9*x.*y+5*y.*y+4*x-15*y+13;    %����ֵ
g = @(x,y) cat(3,10*x-9*y+4,-9*x+10*y-15);      %�ݶȷ��� ���Ϊ3ά����
G = [10 -9;-9 10];                              %��ɭ����
alpha=@(p) p'*p/(p'*G*p);                       %���� pg��Ч ��ֹ�����ͻ�����ĸ �ǵ�������

x = 0;
y = 0;
p_history = [x; y];
q_history = q(0,0);                           %����ֵ��ʷ ��������������
while 1
    if norm([x; y]-[5; 6])<1e-1
        break;
    end
    g_now=reshape(g(x, y),2,1);
    alpha_now = alpha(g_now);
    temp = [x; y] - g_now*alpha_now;
    x = temp(1); y = temp(2);
    p_history = [p_history [x; y]];
    q_history = [q_history q(x,y)];
end

draw_contour(q,p_history);
q_history_1 = [inf q_history(1:end-1)];
q_min = min(q_history);
F = max((q_history-q_min)./(q_history_1-q_min));