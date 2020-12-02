n=8;
a=1:n;b=a';
a=repmat(a,n,1);
b=repmat(b,1,n);
G=1./(a+b-1);
clear a
b=ones(n,1);
x=ones(n,1);
point_history=x;
g=G*x-b;
p=-g;
k=0;
while norm(g)>1e-6
    d=G*p;
    a=g'*g/(p'*d);
    x=x+a*p;
    point_history=[point_history x];
    g_new=g+a*d;
    beta=g_new'*g_new/(g'*g);
    g=g_new;
    p=-g+beta*p;
end