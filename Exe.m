clear;
%% Load Image
img = imread('Cartesian2\R\947_02.jpg');
im = img(:,:,1);
im = imresize(im,[480 640]);
Resize_Multi = length(img) / 640;
%% Get pupil boundary
[Pupil_Boundary_Points] = Cut_Pupil_Boundary(im);
Pupil_Boundary_Points = Pupil_Boundary_Points * Resize_Multi;

%% Get center point and radius
[Pupil_Center_Point,Pupil_Radius] = Get_Circle_Center_And_Radius_Through_Circle_Points(Pupil_Boundary_Points);

%% Find Iris
[Iris_Center_Point,Iris_Radius] = Get_Iris_Center_Point_And_Radius(im,Pupil_Boundary_Points,Pupil_Center_Point,Pupil_Radius);

Pupil_Center_Point;
Pupil_Radius;
Iris_Center_Point;
Iris_Radius;
%% Draw

imshow(img);
hold on;
%plot(Pupil_Boundary_Points(1:end,1),Pupil_Boundary_Points(1:end,2),'r.');
t=0:0.01:2*pi;
%x_o and y_o = center of circle
x_P = [Pupil_Center_Point(1) + Pupil_Radius * sin(t)];
y_P = [Pupil_Center_Point(2) + Pupil_Radius * cos(t)];
x_I = [Iris_Center_Point(1) + Iris_Radius * sin(t)];
Y_I = [Iris_Center_Point(2) + Iris_Radius * cos(t)];
plot(x_P,y_P,'r');
plot(x_I,Y_I,'b');

