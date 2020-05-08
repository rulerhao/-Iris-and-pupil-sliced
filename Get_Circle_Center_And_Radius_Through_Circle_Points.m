function [Pupil_Center_Point,Radius] = Get_Circle_Center_And_Radius_Through_Circle_Points(Boundary_Points)
%%
% ��C���I�����������u
% We can find vertical line with middle point between every two points
% �o�ǫ��������u���ۥ��I�N�O���
% The two lines intersect point between two lines is the circle point.

A = [];
B = [];

[Size_Boundary_Points,~] = size(Boundary_Points);

for i = 1:Size_Boundary_Points
    for j = (i + 1):Size_Boundary_Points
        x1 = Boundary_Points(i,1); y1 = Boundary_Points(i,2);
        x2 = Boundary_Points(j,1); y2 = Boundary_Points(j,2);
        
        % We need to set Ax = B to get the x
        if abs(y2 - y1) < 1
            
        elseif abs(x2 - x1) < 1
            
        else
        m = (y2 - y1 / x2 - x1); % ����I�ײv
        m_Verti = -(x2 - x1) / (y2 - y1); % ���������u���ײv = ����I�ײv���t�˼�
        % ���������u�����I
        X_Middle_Point = (x1 + x2) / 2;
        Y_Middle_Point = (y1 + y2) / 2;
        
        % y = mx + b ������ Ax = B 
        % �|�ܬ�
        % mx - y = -b
        % A �� x,y ���Y��
        % x �h�� x,y
        % B �h�� -b
        b = Y_Middle_Point - m_Verti * X_Middle_Point;% Ax = B,B ���䤤�@��
        A = [A; m_Verti, -1];
        B = [B; -b];
        end
    end
end

Pupil_Center_Point = mldivide(A,B);

%% Get Radius
Total_R = 0;
for i = 1:Size_Boundary_Points
    R = (...
         (Boundary_Points(i,1) - Pupil_Center_Point(1)) ^ 2 + ...
         (Boundary_Points(i,2) - Pupil_Center_Point(2)) ^ 2 ...
        ) ^ (1 / 2);
        
    Total_R = Total_R + R;
end
Radius = Total_R / Size_Boundary_Points;
end