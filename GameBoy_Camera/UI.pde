class UI{ //Object that holds UI elements
  ArrayList<UIObject>ImageTiles; //List of UI elements
  
  UI(){ //Begin creation of UI element list on creation of UI object
    ImageTiles=new ArrayList<UIObject>();
  }
  void AddUIObject(UIObject UI){ //Adds a UIObject to the list of UI elements
    ImageTiles.add(UI);
  }
  void DrawUI(){ //Draws all UI to screen
    for(int i=0; i<ImageTiles.size();i++){
      ImageTiles.get(i).disp(); //runs UI display command
    }
  }
  void MoveUI(int index, PVector loc){ //Allows moving of a UI element
    ImageTiles.get(index).SetLoc(loc);
  }
}

class UIObject{
  PImage Image; //storage of image
  PVector Location; //storage of UI element's location
  boolean stretch=false; //if UI image has to be stretched
  PVector StLocation; //where to stretch it to
  UIObject(PImage img, PVector loc){ //Begin creation of standard UI element
    Image=img;
    Location=loc;
  }
  UIObject(PImage img, PVector loc, PVector str){ //Begin creation of stretched UI element
    stretch=true; //make sure it knows it's gonna be stretched
    Image=img;
    Location=loc;
    StLocation=str;
  }
  void SetLoc(PVector loc){ //Set location at any point
    Location=loc;
  }
  void disp(){ //Display
    if(stretch){ //If stretched, print stretched
      image(Image,Location.x,Location.y,StLocation.x,StLocation.y);
    }
    else{
      image(Image,Location.x,Location.y);
    }
  }
}