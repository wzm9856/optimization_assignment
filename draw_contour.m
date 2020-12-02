function []=draw_contour(q,p_history,contour_num,margin_mul)
    %可以根据点的轨迹自动画出合适大小的轨迹图
    %输入：
    %   q: 可得函数值的匿名函数
    %   p_history: 点迭代记录，2*n
    %   contour_num: 等值线数量，默认50
    %   margin_mul: 边距倍数，默认2
    %输出：
    %   图
    if(nargin<3)
        contour_num=50;
    end
    if(nargin<4)
        margin_mul=2;
    end
    
    % 确定画图范围并画出等值线
    maxvalue=max(p_history,[],2);xmax=maxvalue(1);ymax=maxvalue(2);
    minvalue=min(p_history,[],2);xmin=minvalue(1);ymin=minvalue(2);
    length = max(ymax-ymin,xmax-xmin)*margin_mul; %留白多少是根据(最大-最小)*倍数
    xmid=(xmax+xmin)/2; ymid=(ymax+ymin)/2;
    interval = length/200;                 %200可调，看图想画多密，但是就为了画个等值线也没必要太密吧
    a = xmid-length/2:interval:xmid+length/2;
    b = ymid-length/2:interval:ymid+length/2;
    %为了画成 1 2 3 4 5 1 2 3 4 5 1 2 3 4 5
    %         1 1 1 1 1 2 2 2 2 2 3 3 3 3 3的矩阵塞进q里算函数值
    a1 = repmat(a,1,size(b,2));
    b1 = repmat(b,size(a,2),1);
    b1 = b1(:)';
    c = q([a1;b1]);
    a = repmat(a,size(b,2),1);
    b = repmat(b',1,size(a,2));
    c = reshape(c,size(a,2),size(a,1))';
    contour(a,b,c,contour_num);
    hold on;
    
    % 画出迭代点轨迹
    color = linspace(1,10,size(p_history,2));
    scatter(p_history(1,:),p_history(2,:),20,color,'filled')
end