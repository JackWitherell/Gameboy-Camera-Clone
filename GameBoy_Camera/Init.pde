void settings(){
  int a=int(gbscreen.x*scale); //set image size to be based on scale of gameboy screen
  int b=int(gbscreen.y*scale);
  size(a, b);
}

PImage numbers [];
Camera webcam; //webcam object

void setup() {
  String[] cameras = Capture.list(); //get list of cameras
  if (cameras.length == 0) { //if no cameras
    println("There are no cameras available for capture.");
    exit();
  } 
  else {
    println("Available cameras:"); //print cameras
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }
    webcam=new Camera(new Capture(this,cameras[3])); //select camera
  }
      
  
  numbers=new PImage[10]; //hold number images in array
  PImage num=loadImage("numbers.bmp"); //grab number image
  for(int i=0; i<10; i++){ //store them in array
    numbers[i]=num.get(i*6,0,6,12); //insert images of numbers into array
  }
  
  
  ScreenUI=new UI();
  
  PImage contrastbar=loadImage("contrast.bmp");
  ScreenUI.AddUIObject(new UIObject(contrastbar.get(0,0,15,11), new PVector(16,131))); //Left side of Contrast Bar
  ScreenUI.AddUIObject(new UIObject(contrastbar.get(52,0,15,11), new PVector(129,131))); //Right side of Contrast Bar
  ScreenUI.AddUIObject(new UIObject(contrastbar.get(18,7,32,6), new PVector(63,138)));//Contrast Word
  ScreenUI.AddUIObject(new UIObject(contrastbar.get(15,0,4,6), new PVector(31,131)));//Contrast Slider
  ScreenUI.AddUIObject(new UIObject(contrastbar.get(15,8,1,3), new PVector(31,139), new PVector(30,3)));//Left Part of Bar
  ScreenUI.AddUIObject(new UIObject(contrastbar.get(15,8,1,3), new PVector(96,139), new PVector(33,3)));//Right Part of Bar
  
  PImage brightnessbar=loadImage("brightness.bmp");
  ScreenUI.AddUIObject(new UIObject(brightnessbar.get(0,0,11,15), new PVector(147,16))); //Upper Part of Brightness Bar
  ScreenUI.AddUIObject(new UIObject(brightnessbar.get(0,57,11,15), new PVector(147,113))); //Lower Part of Brightness Bar
  ScreenUI.AddUIObject(new UIObject(brightnessbar.get(6,17,6,38), new PVector(153,49)));//Brightness Word
  ScreenUI.AddUIObject(new UIObject(brightnessbar.get(0,15,6,4), new PVector(147,31)));//Brightness Slider
  ScreenUI.AddUIObject(new UIObject(brightnessbar.get(8,15,3,1), new PVector(155,31), new PVector(3,17)));//Upper Part of Bar
  ScreenUI.AddUIObject(new UIObject(brightnessbar.get(8,15,3,1), new PVector(155,88), new PVector(3,25)));//Lower Part of Bar
  
  PImage left=loadImage("left.bmp");
  ScreenUI.AddUIObject(new UIObject(left,new PVector(124,5))); //"left" text
   
}