close all;clear;

q=@(x) sum((x'*[5 -4.5;-4.5 5])'.*x+[4;-15].*x+6.5);    %����ֵ ����2*n ���1*n
g=@(x) [10 -9;-9 10]*x+[4;-15];                         %�ݶȷ��� �������2*n
G = [10 -9;-9 10];                      %��ɭ����
alpha=@(p) p'*p/(p'*G*p);               %���� pg��Ч ��ֹ�����ͻ�����ĸ �ǵ�������

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

