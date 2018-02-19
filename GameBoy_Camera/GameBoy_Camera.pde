import processing.video.*;

Capture cam;       //camera device
PImage imgstr;     //storage for video
boolean newim;     //whether or not a new image is ready
PVector gbscreen=new PVector(160,144);
int scale=5;       //pixel scale value (scale each pixel up by this value)
int picsLeft=30;   //images left in buffer
int digMax=3;      //maximum amount of images digit value
int brightness=6;  //setting default brightness
int contrast=7;    //setting default contrast
UI ScreenUI;       //UI image store

void draw() {
  background(0);                                            //blank out background
  
  webcam.captureImage();                                    //get image from capture device (Conditional, only gets image if there's a new image)
  image(imgstr, 16, 16, 128, 112);                          //draw image to the screen
  
  ScreenUI.MoveUI(3,new PVector(31+(contrast*6.3),131));    //Move the UI object for the contrast slider
  ScreenUI.MoveUI(9,new PVector(147,31+(brightness*5.2)));  //Move the UI object for the brightness slider
  ScreenUI.DrawUI();                                        //Draw all UI
  
  for(int i=0;i<digMax;i++){                                //Print "pics left" to top right
    image(numbers[int((picsLeft%(int(pow(10,i+1))))/pow(10,i))],113-(i*8),3);
  }
  
  loadPixels();
    colorMode(HSB,256); //convert colormode to hsb
    brightcontscale(16,16,128,112);
    colorMode(RGB,256);
    greyScale(16,16,128,112);                               //Image effect (apply quantization and dithering)
    scale(scale);                                           //Apply scale based on scale size of program
  updatePixels();
  newim=false;                                              //wait for next image from capture device
}