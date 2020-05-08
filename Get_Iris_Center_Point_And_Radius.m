function [Iris_Center_Point,Iris_Radius] = Get_Iris_Center_Point_And_Radius(im,Pupil_Boundary_Points,Pupil_Center_Point,Pupil_Radius)
%% Get pupil boundary
[Pupil_Boundary_Points] = Cut_Pupil_Boundary(im);
%Pupil_Boundary_Points = Pupil_Boundary_Points * Resize_Multi;

%% Get center point and radius
[Pupil_Center_Point,Pupil_Radius] = Get_Circle_Center_And_Radius_Through_Circle_Points(Pupil_Boundary_Points);

%% Set Scan angle
[Height,Width] = size(im);



Fra_Theta = - 2 * pi / 360;

Angle = [-30:30,150:210] * Fra_Theta; %Scan angle

%% Set Scan Length
Scan_Distance = Pupil_Radius * 2 : Pupil_Radius * 3.5;
%% Calculate Scan Area
for i = 1:length(Scan_Distance)
    for j = 1: length(Angle)
        Circle_X(i,j) = round(Pupil_Center_Point(1) + Scan_Distance(i) * cos(Angle(j)));
        Circle_Y(i,j) = round(Pupil_Center_Point(2) + Scan_Distance(i) * sin(Angle(j)));
    end
end

%% Show Scan Area
%{
imshow(im);
hold on;
plot(Circle_X,Circle_Y);
%}


Circle_X = transpose(Circle_X);
Circle_Y = transpose(Circle_Y);

[Circle_Height, Circle_Width] = size(Circle_X);

for i = 1:Circle_Height
    for j = 1:Circle_Width
        Table(i,j) = double(im(Circle_Y(i,j),Circle_X(i,j)));
    end
end

%% 
for i = 1:Circle_Height
    %Use medfilter to rise the visibility.
    MF_Circle = medfilt1(Table(i,:),10,'truncate'); 
    %Get the difference of neighboring two pixels
    Difference = diff(MF_Circle);
    %Sort the differences. The max difference be saw as the boundary of
    %iris
    [Difference_Sort(i,:),Difference_Sort_Idx(i,:)] = sort(Difference,'descend');
end
Difference_Sort_Maximum_Idx = Difference_Sort_Idx(:,1);

%% Find out pixils those are in the one std number.
Distance_Median = median(Difference_Sort_Maximum_Idx);

Distance_Std = std(Difference_Sort_Maximum_Idx);

Distance_In_One_Std = find(Difference_Sort_Maximum_Idx < Distance_Median + Distance_Std & Difference_Sort_Maximum_Idx > Distance_Median - Distance_Std);

for i = 1:length(Distance_In_One_Std)
    Iris_Boundary_Points_X(i) = Circle_X(Distance_In_One_Std(i),Difference_Sort_Maximum_Idx(Distance_In_One_Std(i)));
    Iris_Boundary_Points_Y(i) = Circle_Y(Distance_In_One_Std(i),Difference_Sort_Maximum_Idx(Distance_In_One_Std(i)));
end

Iris_Boundary_Points = [transpose(Iris_Boundary_Points_X),transpose(Iris_Boundary_Points_Y)];
[Iris_Center_Point,Iris_Radius] = Get_Circle_Center_And_Radius_Through_Circle_Points(Iris_Boundary_Points);
%% Draw

imshow(im);
hold on;
%plot(Pupil_Boundary_Points(1:end,1),Pupil_Boundary_Points(1:end,2),'r.');
plot(Iris_Center_Point(1),Iris_Center_Point(2),'r.');
t=0:0.01:2*pi;
%x_o and y_o = center of circle
x = Iris_Center_Point(1) + (Iris_Radius) * sin(t);
y = Iris_Center_Point(2) + (Iris_Radius) * cos(t);
plot(x,y,'r');
end