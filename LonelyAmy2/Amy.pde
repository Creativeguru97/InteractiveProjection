class Amy{
  float x; //Location fo animation
  float y;
  
  float index = 0;
  
  float speedX = 1;
  
  PImage[] images;//Prepare a place to bring "run" image sequence.
  
  Amy(PImage[] AmyImages, float AmyX, float AmyY){
    images = AmyImages;
    x = AmyX;
    y = AmyY;
    
  }
  
  void display(){
    int imageIndex = int(index);
    image(images[imageIndex], x, y);
  }
  
  void run(){
    //if(x > width){
    //  x = -images[0].width;//0 - images[0].width
    //}
    float d1 = dist(x, 0, mouseX-100, 0);
    float d2 = dist(x, 0, mouseX+100, 0);
    
    
    if(mouseX-150 > x){
      speedX = d1/2;
      x = x + speedX/20;
    }
    if(mouseX+150 < x){
      speedX = d2/2;
      x = x - speedX/20;
    }
    if(mouseX-150 <= x && x <= mouseX+150){
      speedX = 0;
    }
    
  }
  
  void frameNext(){
    //Move the index forward

    index++;
    //If we are at the end of sequence, go back to the beginning
    if(index >= images.length){
      index -= images.length;
    }
  }
}
