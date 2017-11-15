% Inclass11
%GB comments
1) 100
2) 100
3) 100
4) 100
overall: 100

% You can find a multilayered .tif file with some data on stem cells here:
% https://www.dropbox.com/s/83vjkkj3np4ehu3/011917-wntDose-esi017-RI_f0016.tif?dl=0

% 1. Find out (without reading  the entire file) -  (a) the size of the image in
% x and y, (b) the number of z-slices, (c) the number of time points, and (d) the number of
% channels.

filename = '011917-wntDose-esi017-RI_f0016.tif';
reader = bfGetReader(filename);

% a) Get xsize and ysize
xsize = reader.getSizeX;
ysize = reader.getSizeY;

% b) Get the number of z-slices
zsize = reader.getSizeZ;

% c) Get the number time points
t_points = reader.getSizeT;

% d) Find the number of channels
channels = reader.getSizeC;

% 2. Write code which reads in all the channels from the 30th time point
% and displays them as a multicolor image.

% Define image info for the first channel
chan = 1;
t = 30;
zslice = 1;

% Get the image for the first channel
iplane1 = reader.getIndex(zslice - 1, chan - 1, t - 1)+1;
img1 = bfGetPlane(reader, iplane1);

% Get the image for the second channel
chan = 2;
iplane2 = reader.getIndex(zslice - 1, chan - 1, t - 1)+1;
img2 = bfGetPlane(reader, iplane2);

% Display the image
img2show = cat(3, imadjust(img1), imadjust(img2), zeros(size(img1)));
imshow(img2show)

% 3. Use the images from part (2). In one of the channels, the membrane is
% prominently marked. Determine the best threshold and make a binary
% mask which marks the membranes and displays this mask. 

% Define threshold and apply mask, displaying new image, to channel 1
threshold = 40000;
membrane_mask = img2show(:,:,1) > threshold;
figure
imshow(membrane_mask)

% 4. Run and display both an erosion and a dilation on your mask from part
% (3) with a structuring element which is a disk of radius 3. Explain the
% results.

% Show eroded and dilated images for the threshold mask
figure
imshow(imerode(membrane_mask, strel('disk', 3)))
figure
imshow(imdilate(membrane_mask, strel('disk', 3)))

% Neither the eroded nor the dilated image represents the membranes in
% channel 1 as well as the regular threshold mask. The dilation makes the
% membranes too thick and splotchy, putting circular shapes in place of
% lines. The erosion removes most of the membrane, leaving a meaningless
% collection of pixels that are not connected. The threshold mask
% effectively removes the noise of the image while preserving the shape of
% the original membranes.



