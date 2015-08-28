%this function estimates the homographical transformation between the
%ground/floor of a video (in any desired units), and the camera's point of view (in pixels)
%%%% inputs:
%1/ fileIn : the name of the video input file for which you want to calibrate the
%ground
%%%% outputs:
%1/ H : the homography matrix. Additionally, this matrix is automatically
%saved in the 'models' directory

function[H] = calibrate_ground(fileIn)

    close all;
    addpath('2D_projection');
    
    vidIn = VideoReader(fileIn);
    imgSize = [get(vidIn,'height'),get(vidIn,'width')];
    
    imgIn = read(vidIn,1);
    figure;imshow(imgIn);
    
    %get the rectangle on the floor, starting from the (0,0) point
    [ptsX,ptsY] = getline();
    if(numel(ptsX)<4 || numel(ptsY)<4)
        error('Error, the homography estimation needs 4 points.');
    end
    ptsX = min(max(round(ptsX(1:4)),0),imgSize(2));
    ptsY = min(max(round(ptsY(1:4)),0),imgSize(1));
    
    xDistance = input('Please indicate the distance on the x axis : ');
    yDistance = input('Please indicate the distance on the y axis : ');
    
    landmarks = [ptsX ptsY];
    distances = [xDistance;yDistance];
    
    %real-world coordinates of the rectangle (in [x,y]):
    % [0 0 (top left); 0 yDistance (bottom left); xDistance yDistance (bottom right); yDistance 0 (top right)]
    [H] = estimate_homography(landmarks,[0 0; 0 distances(2);distances(1) distances(2);distances(1) 0]);
    
    %now show the 2D projection of the floor, using the estimated
    %homography
    imgProjected = create_2D_plane(H,imgIn,xDistance+1,yDistance+1);
    figure;imshow(uint8(imgProjected));
    title('Projection of the floor using the estimated homography.');
    
    %save the homography
    [~,fileName,~] = fileparts(fileIn);
    
    if (~exist('models','dir'))
        mkdir('models');
    end
    save(['models/' fileName '_homography.mat'],'H'); 
    disp('The homography estimation was carried out with success !');
end