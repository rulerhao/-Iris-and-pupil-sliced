clear;
Image_Dir = "example image\";
Total_Files = dir("example image\");
for i = 3:length(Total_Files)
    if Total_Files(i).name(1) == "L"
        First_im = imread(Image_Dir + Total_Files(i).name);
        Second_im = imread(Image_Dir + "Processed_" + Total_Files(i).name);
        Merged_im = [First_im,Second_im];
        imwrite(Merged_im,"example image\Merged_" + Total_Files(i).name);
    elseif Total_Files(i).name(1) == "R"
        First_im = imread(Image_Dir + Total_Files(i).name);
        Second_im = imread(Image_Dir + "Processed_" + Total_Files(i).name);
        Merged_im = [First_im,Second_im];
        imwrite(Merged_im,"example image\Merged_" + Total_Files(i).name);
    end
    
end