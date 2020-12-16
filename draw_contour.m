function []=draw_contour(q,p_history,contour_num,margin_mul)
    %可以根据点的轨迹自动画出合适大小的轨迹图
    %限二维
    %输入：
    %   q: 可得函数值的匿名函数
    %   p_history: 点迭代记录，2*n
    %   contour_num: 等值线数量，默认50
    %   margin_mul: 边距倍数，默认2
    %输出：
    %   图
    
    % draw_contour(q,point_history);
    if ~exist('contour_num','var') || isempty('contour_num')
        contour_num=50;
    end
    if~exist('margin_mul','var') || isempty('margin_mul')
        margin_mul=2;
    end
    
    % 确定画图范围并画出等值线
    maxvalue=max(p_history,[],2);xmax=maxvalue(1);ymax=maxvalue(2);
    minvalue=min(p_history,[],2);xmin=minvalue(1);ymin=minvalue(2);
    length = max(ymax-ymin,xmax-xmin)*margin_mul; %留白多少是根据(最大-最小)*倍数
    xmid=(xmax+xmin)/2; ymid=(ymax+ymin)/2;
    interval = length/200;                 %200可调，看图想画多密，但是就为了画个等值线也没必要太密吧
    a = xmid-length/2:interval:xmid+length/2; %5_8_2调这个
    b = ymid-length/2:interval:ymid+length/2;
%     a = 0.001:interval:75; %5_8_2调这个 ctrl+r ctrl+t
%     b = 0.001:interval:100;
    [agrid, bgrid] = meshgrid(a,b);
    c = q(agrid, bgrid);
    c((imag(c)~=0)|(c>=inf&c<=inf))=0;
    contour(agrid,bgrid,c,contour_num);
    hold on;
    
    % 画出迭代点轨迹
    scatter(p_history(1,:),p_history(2,:),20,colormap(cool(size(p_history,2))),'filled')
    colormap default;
    plot(p_history(1,:),p_history(2,:),'-');
end