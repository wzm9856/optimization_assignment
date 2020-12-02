fun = @(x)(x(1)-2)^2 + (x(2)-1)^2;
A = [1,1];
b = 2;
Aeq = [];
beq = [];
lb=[];
ub=[];
x0 = [0,1];
nonlcon = @circlecon;
x = fmincon(fun,x0,A,b,Aeq,beq,lb,ub,nonlcon);
function [c,ceq] = circlecon(x)
    c = x(1)^2 -x(2);
    ceq = [];
end