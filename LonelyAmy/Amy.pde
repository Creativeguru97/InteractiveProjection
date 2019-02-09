class BodyMove{
  float BodyX; //Location fo animation
  float BodyY;
  float speedY;
  
  float index;
  
  float speedX;
  float frameSpeed;
  
  PImage[] images;//Prepare a place to bring "run" image sequence.
  
  BodyMove(PImage[] AmyImages, float AmyX, float AmyY){
    images = AmyImages;
    BodyX = AmyX;
    BodyY = AmyY;
    
  }
  
  void display(){
    int imageIndex = int(index);
    image(images[imageIndex], BodyX, BodyY, 200, 425);
    imageMode(CENTER);
  }
  
  void move(){
    
    //Acceleration factors
    float d = dist(BodyX, 0, mouseX, 0);
    float d1 = dist(BodyX, 0, mouseX-100, 0);
    float d2 = dist(BodyX, 0, mouseX+100, 0);
    
    
    if(mouseX-170 > BodyX){
      speedX = d1/2.5;
      BodyX = BodyX + speedX/20;

    }else if(mouseX+170 < BodyX){
      speedX = d2/2.5;
      BodyX = BodyX - speedX/20;
    
    }else if(mouseX-170 <= BodyX && BodyX <= mouseX+170){
      speedX = 0;
      
    }
    
    //Bouncing head along Y axis
    if(mouseX-170 > BodyX || mouseX+170 < BodyX){
      BodyY += speedY;
      if(BodyY >= 328){
        BodyY = 328;
        speedY = -d/600;
      }else if(BodyY <= 328-4){
        BodyY = 328-4;
        speedY = +d/600;
      }
    }
    
    //println(BodyY);
  }
  
  void frameNext(){
    float d = dist(BodyX, 0, mouseX, 0);
    //println(d);
    
    if(mouseX-170 <= BodyX && BodyX <= mouseX+170){
      speedX = 0;
      
      /*If I write "frameSpeed = 0;" at here, frame change gonna stop 
      when once enter this area and get out*/

    }else{
      index += frameSpeed;
      if(index >= images.length-1){
        index = images.length-1;
        frameSpeed = -d/120;
      }else if(index <= 1){
        index = 1;
        frameSpeed = +d/120;
      }
    }
    
  }
}
