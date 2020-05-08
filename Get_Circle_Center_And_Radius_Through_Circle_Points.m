function [Pupil_Center_Point,Radius] = Get_Circle_Center_And_Radius_Through_Circle_Points(Boundary_Points)
%%
% 找每個點的垂直平分線
% We can find vertical line with middle point between every two points
% 這些垂直平分線的相交點就是圓心
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
        m = (y2 - y1 / x2 - x1); % 原兩點斜率
        m_Verti = -(x2 - x1) / (y2 - y1); % 垂直平分線的斜率 = 原兩點斜率的負倒數
        % 垂直平分線的中點
        X_Middle_Point = (x1 + x2) / 2;
        Y_Middle_Point = (y1 + y2) / 2;
        
        % y = mx + b 移項後 Ax = B 
        % 會變為
        % mx - y = -b
        % A 為 x,y 的係數
        % x 則為 x,y
        % B 則為 -b
        b = Y_Middle_Point - m_Verti * X_Middle_Point;% Ax = B,B 的其中一項
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