class HeadMove {
  float HeadX;
  float HeadY;
  float speedY;
  
  float index;
  
  float speedX;
  float frameSpeed;
  
  PImage[] HeadImages;
  
  HeadMove(PImage[] HeadImages_, float HeadX_, float HeadY_){
    HeadImages = HeadImages_;
    HeadX = HeadX_;
    HeadY = HeadY_;
  }
  
  void display(){
    int imageIndex = int(index);
    image(HeadImages[imageIndex], HeadX, HeadY, 200, 425);
    //imageMode(CENTER);
  }
  
  void move(){
    //Acceleration factors
    float d = dist(HeadX, 0, PersonX, 0);
    float d1 = dist(HeadX, 0, PersonX-100, 0);
    float d2 = dist(HeadX, 0, PersonX+100, 0);
    
    
    if(PersonX-170 > HeadX){
      speedX = d1/2.5;
      HeadX = HeadX + speedX/20;
    }else if(PersonX+170 < HeadX){
      speedX = d2/2.5;
      HeadX = HeadX - speedX/20;
    }else if(PersonX-170 <= HeadX && HeadX <= PersonX+170){
      speedX = 0;
    }
    
    //Bouncing head along Y axis
    if(PersonX-170 > HeadX || PersonX+170 < HeadX){
      HeadY += speedY;
      if(HeadY >= 328){
        HeadY = 328;
        speedY = -d/600;
      }else if(HeadY <= 328-4){
        HeadY = 328-4;
        speedY = +d/600;
      }
    }
    //println(HeadY);
    
  }
  
  void frameNext(){
    
    index += frameSpeed;
    if(PersonX-130 > HeadX){
      frameSpeed =-2;
      if(index <= 1){
      frameSpeed = 0;
      }
      
    }else if(PersonX-130 <= HeadX && PersonX > HeadX){
      frameSpeed = 0.8;
      if(index >= 14){
        frameSpeed = 0;
        index = 14;
      }
    }else if(PersonX+130 >= HeadX && PersonX <= HeadX){
      frameSpeed = -0.8;
      if(index <= 14){
        frameSpeed = 0;
        index = 14;
      }
    }else if(PersonX+130 < HeadX){
      frameSpeed =2;
      if(index >= HeadImages.length-2){
      frameSpeed = 0;
      }
      
    }
    println(index);
  }

}
