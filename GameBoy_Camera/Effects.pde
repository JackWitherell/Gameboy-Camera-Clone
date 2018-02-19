
void greyScale(int _x, int _y, int _width, int _height){ //Quantizes color to 0,3 and then dithers it
  for(int x=0; x<_width; x++){ //for x and y of image canvas
    for(int y=0; y<_height; y++){
      color temp=pixels[((y+_y)*width)+x+_x]; //store focused pixel
      float aver=((red(temp)+green(temp)+blue(temp))/3); //Get average of RGB (a.k.a. brightness value)
      int val=(int(map(aver,0,255,0,3.999))*85); //map that average between 0,4 and do an int cutoff, then mult by 85
      int err=int(aver)-val; //Calculate difference in adjustment
      if(contrast>-1){ //Dithering algorithm toggle
        color tempdither=pixels[xy(_x+x+1,_y+y)]; //hold pixel for beginning of dithering algorithm
        int newerr=int(err*(7/16.0));
        pixels[xy(_x+x+1,_y+y)]=  color(red(tempdither)+newerr,green(tempdither)+newerr,blue(tempdither)+newerr); //right pix
        tempdither=pixels[xy(_x+x-1,_y+y+1)];
        newerr=int(err*(3/16.0));
        //Error when changing this, writes to unecessary values.
        //pixels[xy(_x+x-1,_y+y+1)]=color(red(tempdither)+newerr,green(tempdither)+newerr,blue(tempdither)+newerr); //bleft pix
        tempdither=pixels[xy(_x+x,_y+y+1)];
        newerr=int(err*(5/16.0));
        pixels[xy(_x+x,_y+y+1)]=  color(red(tempdither)+newerr,green(tempdither)+newerr,blue(tempdither)+newerr); //b pix
        tempdither=pixels[xy(_x+x+1,_y+y+1)];
        newerr=int(err*(1/16.0));
        pixels[xy(_x+x+1,_y+y+1)]=color(red(tempdither)+newerr,green(tempdither)+newerr,blue(tempdither)+newerr); //bright pix
      }
      temp=color(val); //Bake color to object
      pixels[(xy(_x+x,_y+y))]=temp; //Set new color to focused pixel
      
    }
  }
}

void brightcontscale(int _x, int _y, int _width, int _height){
  for(int x=0; x<_width; x++){ //for x and y of image canvas
    for(int y=0; y<_height; y++){
      color temp=pixels[xy(x+_x,y+_y)]; //store focused pixel
      float s=saturation(temp); //grab saturation
      float b=brightness(temp); //grab brightness
      s+=(contrast-7)*12; //tweak saturation
      b+=(-(brightness-6))*8; //tweak brightness
      if(s>256.0){ //cutoff protect saturation
        s=256.0;
      }
      else if(s<0.0){
        s=0.0;
      }
      if(b>256.0){ //cutoff protect brightness
        b=256.0;
      }
      else if(b<0.0){
        b=0.0;
      }
      temp=color(hue(temp),s,b); //Bake color to object
      pixels[xy(x+_x,y+_y)]=temp; //Set new color to focused pixel
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