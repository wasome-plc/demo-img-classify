# program to capture single image from webcam in python
  
# note: install opencv-python:
#       pip install opencv-python

# ModuleNotFoundError: No module named 'skbuild' in Python #
# To solve the Python "ModuleNotFoundError: No module named 'skbuild'", 
#   run the pip3 install --upgrade pip command to upgrade pip and 
#   then install the scikit-build module by running the pip install scikit-build command.

# importing OpenCV library
import cv2
import time
# initialize the camera
# If you have multiple camera connected with 
# current device, assign a value in cam_port 
# variable according to that
cam_port = 0
cam = cv2.VideoCapture(cam_port)
  
# reading the input using the camera
while True:
    result, image = cam.read()
    
    # If image will detected without any error, 
    # show result
    if result:
    
        # showing result, it take frame name and image 
        # output
        # cv2.imshow("GeeksForGeeks", image)
    
        # saving image in local storage
        cv2.imwrite("/wa-plc/images/photo.jpg", image)
    
        # If keyboard interrupt occurs, destroy image 
        # window
        #cv2.waitKey(0)
        #cv2.destroyWindow("GeeksForGeeks")
    
    # If captured image is corrupted, moving to else part
    else:
        print("No image detected. Please! try again")

    time.sleep(0.1)