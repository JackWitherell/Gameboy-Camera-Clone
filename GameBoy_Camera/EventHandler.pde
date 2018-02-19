void keyPressed(){ //event handler handles keypresses of up down left and right
  if (keyCode==UP){
    if (brightness!=0) brightness--; //Lower brightness (not if at 0)
  }
  else if(keyCode==DOWN){
    if (brightness!=15) brightness++; //raise brightness (not if at 15)
  }
  if(keyCode==LEFT){
    if (contrast!=0) contrast--; //lower contrast (not if at 0)
  }
  else if(keyCode==RIGHT){
    if (contrast!=15) contrast++; //raise brightness (not if at 15)
  }
}