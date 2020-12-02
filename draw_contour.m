function []=draw_contour(q,p_history,contour_num,margin_mul)
    %���Ը��ݵ�Ĺ켣�Զ��������ʴ�С�Ĺ켣ͼ
    %���룺
    %   q: �ɵú���ֵ����������
    %   p_history: �������¼��2*n
    %   contour_num: ��ֵ��������Ĭ��50
    %   margin_mul: �߾౶����Ĭ��2
    %�����
    %   ͼ
    if(nargin<3)
        contour_num=50;
    end
    if(nargin<4)
        margin_mul=2;
    end
    
    % ȷ����ͼ��Χ��������ֵ��
    maxvalue=max(p_history,[],2);xmax=maxvalue(1);ymax=maxvalue(2);
    minvalue=min(p_history,[],2);xmin=minvalue(1);ymin=minvalue(2);
    length = max(ymax-ymin,xmax-xmin)*margin_mul; %���׶����Ǹ���(���-��С)*����
    xmid=(xmax+xmin)/2; ymid=(ymax+ymin)/2;
    interval = length/200;                 %200�ɵ�����ͼ�뻭���ܣ����Ǿ�Ϊ�˻�����ֵ��Ҳû��Ҫ̫�ܰ�
    a = xmid-length/2:interval:xmid+length/2;
    b = ymid-length/2:interval:ymid+length/2;
    %Ϊ�˻��� 1 2 3 4 5 1 2 3 4 5 1 2 3 4 5
    %         1 1 1 1 1 2 2 2 2 2 3 3 3 3 3�ľ�������q���㺯��ֵ
    a1 = repmat(a,1,size(b,2));
    b1 = repmat(b,size(a,2),1);
    b1 = b1(:)';
    c = q([a1;b1]);
    a = repmat(a,size(b,2),1);
    b = repmat(b',1,size(a,2));
    c = reshape(c,size(a,2),size(a,1))';
    contour(a,b,c,contour_num);
    hold on;
    
    % ����������켣
    color = linspace(1,10,size(p_history,2));
    scatter(p_history(1,:),p_history(2,:),20,color,'filled')
end