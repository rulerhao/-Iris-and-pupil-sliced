function [Boundary_Points] = Cut_Pupil_Boundary(im)
%% Load Image
%im = imread('C:\Users\Tsao Jia Hao\Desktop\�Ҧ����\20180626���i\20180626���i\IrisCollection\IrisCollection\Cartesian2\L\068_07.jpg');
%im = imresize(im, 0.5); % resize the image to reduce computation
%imshow(im);
%% Setting
Padding_Length = 10;
Sensitivity = 0.8;
Resize_Multi = 1;
im = imresize(im, Resize_Multi);
%% Find Pupillary Component
Logical_Image = Set_Image_To_Logical(im,Padding_Length,Sensitivity); %���� Sensitivity value �p�G�ണ����䤤���I���󰪮ĪG

Imcomplement_Logical_Image = imcomplement(Logical_Image);

Logical_Image_Connected_Components = bwconncomp(Imcomplement_Logical_Image); %�D�X�h�ӳs��������

List = Logical_Image_Connected_Components.PixelIdxList;

[~,Size_Of_List] = size(List);

for i = 1 : Size_Of_List
    [Size_Of_Connected_Components(i),~] = size(List{1,i});
end
[~, Idx] = max(Size_Of_Connected_Components); %�D�X�̤j�s��������

Imcomplement_Logical_Image(1:end) = 0;
Imcomplement_Logical_Image(Logical_Image_Connected_Components.PixelIdxList{Idx}) = 1;

[Im_Height,Im_Width] = size(im)
%{
BW_Pupil_Img = zeros(Im_Height,Im_Width,'logical');
BW_Pupil_Img(BW_Connected_Components.PixelIdxList{Idx}) = 1; 
imshow(BW_Pupil_Img);
%}

BW_X_Axis_Value = ceil(Logical_Image_Connected_Components.PixelIdxList{Idx} / Im_Height);
BW_Y_Axis_Value = mod(Logical_Image_Connected_Components.PixelIdxList{Idx},Im_Height);
BW_Pupil_Img = zeros(Im_Height,Im_Width,'logical');
for i = 1:size(BW_Y_Axis_Value)
    BW_Pupil_Img(BW_Y_Axis_Value(i),BW_X_Axis_Value(i)) = 1;
end
%imshow(BW_Pupil_Img);
%% Get Pupillary Center and Radius and Boundary
BW_Y_Axis_Value_Diff = diff(BW_Y_Axis_Value);
Jump_Index = find(BW_Y_Axis_Value_Diff < 0);

%��W��
Higher_Boundary_Points_X_Axis = [BW_X_Axis_Value(1);BW_X_Axis_Value(Jump_Index + 1)];
Higher_Boundary_Points_Y_Axis = [BW_Y_Axis_Value(1);BW_Y_Axis_Value(Jump_Index + 1)];

%��U��
Lower_Boundary_Points_X_Axis = [BW_X_Axis_Value(Jump_Index);BW_X_Axis_Value(end)];
Lower_Boundary_Points_Y_Axis = [BW_Y_Axis_Value(Jump_Index);BW_Y_Axis_Value(end)];

%�W�U���զX
Boundary_Points_X_Axis = [Higher_Boundary_Points_X_Axis;Lower_Boundary_Points_X_Axis];
Boundary_Points_Y_Axis = [Higher_Boundary_Points_Y_Axis;Lower_Boundary_Points_Y_Axis];

%����I�ର��
%{
Boundary_Points_Im = zeros(Im_Height,Im_Width,'logical');
for i = 1:size(Boundary_Points_X_Axis)
    Boundary_Points_Im(Boundary_Points_Y_Axis(i),Boundary_Points_X_Axis(i)) = 1;
end

%imshow(im);
%hold on;
%plot(Boundary_Points_X_Axis,Boundary_Points_Y_Axis,'r.');
%}

Boundary_Points = [Boundary_Points_X_Axis Boundary_Points_Y_Axis] / Resize_Multi;
end
