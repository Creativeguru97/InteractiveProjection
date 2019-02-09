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
    float d = dist(BodyX, 0, PersonX, 0);
    float d1 = dist(BodyX, 0, PersonX-100, 0);
    float d2 = dist(BodyX, 0, PersonX+100, 0);
    
    
    if(PersonX-170 > BodyX){
      speedX = d1/2.5;
      BodyX = BodyX + speedX/20;

    }else if(PersonX+170 < BodyX){
      speedX = d2/2.5;
      BodyX = BodyX - speedX/20;
    
    }else if(PersonX-170 <= BodyX && BodyX <= PersonX+170){
      speedX = 0;
      
    }
    
    //Bouncing head along Y axis
    if(PersonX-170 > BodyX || PersonX+170 < BodyX){
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
    float d = dist(BodyX, 0, PersonX, 0);
    //println(d);
    
    if(PersonX-170 <= BodyX && BodyX <= PersonX+170){
      speedX = 0;
      
      /*If I write "frameSpeed = 0;" at here, frame change gonna stop 
      when once enter this area and get out*/

    }else{
      index += frameSpeed;
      if(index >= images.length-1){
        index = images.length-1;
        //play sound randomly
        shoesSound[int(random(0, shoesSound.length))].play();
        frameSpeed = -d/120;
      }else if(index <= 1){
        index = 1;
        //play sound randomly
        shoesSound[int(random(0, shoesSound.length))].play();
        frameSpeed = +d/120;
      }
    }
    
  }
}
