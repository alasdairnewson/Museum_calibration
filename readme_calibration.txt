This is the README file for the calibration code. The goal is to create a homography from four points representing a rectangle on the floor (or a certain plane). 


*****************************************************************
*******		  	    CODE USAGE 			  *******
*****************************************************************


Open Matlab, and navigate to the folder with the code. Then, in the command window, type :

>> calibrate_ground(fileName)

replacing fileName with the video file which you wish to analyse.

The first image of the video should appear. You now need to create a poylgon on the image which corresponds to a RECTANGLE on the floor. You can do this by left clicking successively on the corners of the rectangle. For the code to execute successfully, you must click on the corners in the following order :

- Top left
- Bottom left
- Bottom right
- Top right

Once you have clicked these points, you should right click to finish the rectangle description.

Now, the command line terminal will ask you the lengths of the rectangle. You need to put the distance on the x axis (from left to right) and then on the y axis (from up to down). You may put the distance in any units you wish.

*****************************************************************
*******		  	    OUTPUT			  *******
*****************************************************************

The code will output the image of the floor (or whichever plane you choose), warped to an 'above' view. The output homography will be written in the 'models' directory. 

