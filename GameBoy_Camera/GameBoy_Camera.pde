import processing.video.*;

Capture cam;
PImage contrastLeft, contrastRight, barHorizontal, contrastWord, contrastControl, imgstr;
PImage brightnessUp, brightnessDown, barVertical, brightnessWord, brightnessControl;
PImage left;
PImage numbers [];
boolean newim;
PVector gbscreen=new PVector(160,144);
int scale=3;
int picsLeft=30;
int digMax=3;
int brightness=6;
int contrast=7;

int error[]=new int[120*112];

int dither(float amount, int values, int dither, int output, int index){
  if (dither!=0) dither++;
  int tiers=(output+(dither*(output-1)));
  if(dither==0){
    tiers=output;
  }
  float percentage=amount/values;//128/256=.50
  float odf=1.0f/tiers;//four colors would make this .25
  int sector=PApplet.parseInt(percentage/odf);
  if(sector%(dither+1)==0){
    return PApplet.parseInt(map(PApplet.parseFloat(sector)/(tiers-1),0,1,0,255));
  }
  else{
    int higher;
    int lower;
    lower=higher=sector;
    
    while(lower%(dither+1)!=0){
      lower--;
    }
    while(higher%(dither+1)!=0){
      higher++;
    }
    
    int first=higher-sector;
    int second=sector-lower;
    index=index+((index/width)*(tiers/2));
    if(first>second){
      if(index%first==0){
        return PApplet.parseInt(map(PApplet.parseFloat(higher)/(tiers-1),0,1,0,255));
      }
      return PApplet.parseInt(map(PApplet.parseFloat(lower)/(tiers-1),0,1,0,255));
    }
    else{
      if(index%second==0){
        return PApplet.parseInt(map(PApplet.parseFloat(lower)/(tiers-1),0,1,0,255));
      }
      return PApplet.parseInt(map(PApplet.parseFloat(higher)/(tiers-1),0,1,0,255));
    }
  }
}

int xy(int x, int y){
  return x+(width*y);
}

void greyScale(int _x, int _y, int _width, int _height){
  for(int x=0; x<_width; x++){
    for(int y=0; y<_height; y++){
      color temp=pixels[((y+_y)*width)+x+_x];
      float aver=((red(temp)+green(temp)+blue(temp))/3);
      int val=(int(map(aver,0,255,0,4))*85);
      int err=int(aver)-val;
      color tempdither=pixels[xy(_x+x+1,_y+y)];
      int newerr=int(err*(7/16.0));
      if(contrast==6){
        pixels[xy(_x+x+1,_y+y)]=  color(red(tempdither)+newerr,green(tempdither)+newerr,blue(tempdither)+newerr);
        tempdither=pixels[xy(_x+x-1,_y+y+1)];
        newerr=int(err*(3/16.0));
        pixels[xy(_x+x-1,_y+y+1)]=color(red(tempdither)+newerr,green(tempdither)+newerr,blue(tempdither)+newerr);
        tempdither=pixels[xy(_x+x,_y+y+1)];
        newerr=int(err*(5/16.0));
        pixels[xy(_x+x,_y+y+1)]=  color(red(tempdither)+newerr,green(tempdither)+newerr,blue(tempdither)+newerr);
        tempdither=pixels[xy(_x+x+1,_y+y+1)];
        newerr=int(err*(1/16.0));
        pixels[xy(_x+x+1,_y+y+1)]=color(red(tempdither)+newerr,green(tempdither)+newerr,blue(tempdither)+newerr);
      }
      temp=color(val);
      pixels[(xy(_x+x,_y+y))]=temp;
      
    }
  }
}

void scale(int scale){
  for(int x=width-1; x>-1; x--){
    for(int y=height-1; y>-1; y--){
      pixels[x+(y*(width))]=pixels[int(x/scale)+int(int(y/scale)*width)];
    }
  }
}

void keyPressed(){
  if (keyCode==UP){
    if (brightness!=0) brightness--;
  }
  else if(keyCode==DOWN){
    if (brightness!=15) brightness++;
  }
  if(keyCode==LEFT){
    if (contrast!=0) contrast--;
  }
  else if(keyCode==RIGHT){
    if (contrast!=15) contrast++;
  }
}

void settings(){
  int a=int(gbscreen.x*scale);
  int b=int(gbscreen.y*scale);
  size(a, b);
}

void setup() {
  numbers=new PImage[10];
  for(int i=0;i<120*112;i++){
    error[i]=0;
  }
  PImage num=loadImage("numbers.bmp");
  for(int i=0; i<10; i++){
    numbers[i]=num.get(i*6,0,6,12);
  }
  
  PImage contrastbar=loadImage("contrast.bmp");
  contrastLeft=contrastbar.get(0,0,15,11);
  contrastRight=contrastbar.get(52,0,15,11);
  barHorizontal=contrastbar.get(15,8,1,3);
  contrastWord=contrastbar.get(18,7,32,6);
  contrastControl=contrastbar.get(15,0,4,6);
  
  PImage brightnessbar=loadImage("brightness.bmp");
  brightnessUp=brightnessbar.get(0,0,11,15);
  brightnessDown=brightnessbar.get(0,57,11,15);
  barVertical=brightnessbar.get(8,15,3,1);
  brightnessWord=brightnessbar.get(6,17,6,38);
  brightnessControl=brightnessbar.get(0,15,6,4);
  
  left=loadImage("left.bmp");

  String[] cameras = Capture.list();
  
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }
    imgstr=new PImage();
    cam = new Capture(this, cameras[1]);
    cam.start();     
  }      
}

void draw() {
  background(0);
  if (cam.available() == true) {
    cam.read();
    imgstr=cam;
    newim=true;
  }
  
  if(newim){
    if(((imgstr.width*7)/8)>imgstr.height){
      int newWidth=int((float(imgstr.height)/7)*8);
      int cutoff=(imgstr.width-newWidth)/2;
      imgstr=imgstr.get(cutoff,0,newWidth,imgstr.height);
    }
    else{
      int newHeight=int((float(imgstr.width)/8)*7);
      int cutoff=(imgstr.height-newHeight)/2;
      imgstr=imgstr.get(0,cutoff,imgstr.width,newHeight);
    }
  }
  image(imgstr, 16, 16, 128, 112);
  
  
  image(contrastLeft,16,131);
  image(contrastRight,129,131);
  image(barHorizontal,31,139,30,3);
  image(barHorizontal,96,139,33,3);
  image(contrastWord,63,138);
  image(contrastControl,31+(contrast*6.3),131);
  
  image(brightnessUp,147,16);
  image(brightnessDown,147,113);
  image(barVertical,155,31,3,17);
  image(barVertical,155,88,3,25);
  image(brightnessWord,153,49);
  image(brightnessControl,147,31+(brightness*5.2));
  
  for(int i=0;i<digMax;i++){
    image(numbers[int((picsLeft%(int(pow(10,i+1))))/pow(10,i))],113-(i*8),3);
  }
  image(left,124,5);
  
  loadPixels();
  greyScale(16,16,128,112);
  scale(scale);
  updatePixels();
  
  newim=false;
  // The following does the same, and is faster when just drawing the image
  // without any additional resizing, transformations, or tint.
  //set(0, 0, cam);
}