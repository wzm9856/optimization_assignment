function []=draw_contour(q,p_history,contour_num,margin_mul)
    %���Ը��ݵ�Ĺ켣�Զ��������ʴ�С�Ĺ켣ͼ
    %�޶�ά
    %���룺
    %   q: �ɵú���ֵ����������
    %   p_history: �������¼��2*n
    %   contour_num: ��ֵ��������Ĭ��50
    %   margin_mul: �߾౶����Ĭ��2
    %�����
    %   ͼ
    
    % draw_contour(q,point_history);
    if ~exist('contour_num','var') || isempty('contour_num')
        contour_num=50;
    end
    if~exist('margin_mul','var') || isempty('margin_mul')
        margin_mul=2;
    end
    
    % ȷ����ͼ��Χ��������ֵ��
    maxvalue=max(p_history,[],2);xmax=maxvalue(1);ymax=maxvalue(2);
    minvalue=min(p_history,[],2);xmin=minvalue(1);ymin=minvalue(2);
    length = max(ymax-ymin,xmax-xmin)*margin_mul; %���׶����Ǹ���(���-��С)*����
    xmid=(xmax+xmin)/2; ymid=(ymax+ymin)/2;
    interval = length/200;                 %200�ɵ�����ͼ�뻭���ܣ����Ǿ�Ϊ�˻�����ֵ��Ҳû��Ҫ̫�ܰ�
    a = xmid-length/2:interval:xmid+length/2; %5_8_2�����
    b = ymid-length/2:interval:ymid+length/2;
%     a = 0.001:interval:75; %5_8_2����� ctrl+r ctrl+t
%     b = 0.001:interval:100;
    [agrid, bgrid] = meshgrid(a,b);
    c = q(agrid, bgrid);
    c((imag(c)~=0)|(c>=inf&c<=inf))=0;
    contour(agrid,bgrid,c,contour_num);
    hold on;
    
    % ����������켣
    scatter(p_history(1,:),p_history(2,:),20,colormap(cool(size(p_history,2))),'filled')
    colormap default;
    plot(p_history(1,:),p_history(2,:),'-');
end