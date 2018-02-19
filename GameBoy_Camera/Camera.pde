class Camera{
  Capture camera;
  Camera(Capture cam){ //Store Capture object in Camera
    camera=cam;
    camera.start();
    imgstr=new PImage();
  }
  void captureImage(){ //Capture a Camera Image
    if (camera.available() == true) { //If camera exists
      camera.read(); //Check for new image
      imgstr=camera; //Store new image
      newim=true; //if New Image let it know it's a new image
    }
  
    if(newim){ //if New Image Process Image cut it down to 7:8 aspect ratio
      if(((imgstr.width*7)/8)>imgstr.height){ //if it's wider than it is tall
        int newWidth=int((float(imgstr.height)/7)*8);
        int cutoff=(imgstr.width-newWidth)/2;
        imgstr=imgstr.get(cutoff,0,newWidth,imgstr.height);
      }
      else{ //if it's taller than it is wide
        int newHeight=int((float(imgstr.width)/8)*7);
        int cutoff=(imgstr.height-newHeight)/2;
        imgstr=imgstr.get(0,cutoff,imgstr.width,newHeight);
      }
    }
  }
}