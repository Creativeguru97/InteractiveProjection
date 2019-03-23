class Particle{
  //PVector location;
  PVector RightHand = new PVector(RightHandX, RightHandY-60);
  //PVector RightHand = new PVector(width/2-200, height/2);

  PVector velocity;
  PVector acceleration;
  float lifespan;
  float lifespanOffset = 5.5;
  float R = 200;
  float G = 200;
  float B = 255;
  
  PImage texture;
  
  Particle(PImage EachTexture){
    velocity = new PVector(random(-1.8, 1.8), random(0, 1.5));
    acceleration = new PVector(0, -0.20);
    lifespan = 255;
    texture = EachTexture;
  }
  
  void excute(){
    fall();
    display();
  }
  
  void fall(){
    velocity.add(acceleration);
    RightHand.add(velocity);
    lifespan -= lifespanOffset;
    
    
  }

  void display(){
    imageMode(CENTER);
    tint(R, G, B, lifespan);
    G -= lifespanOffset/10.5;
    R -= lifespanOffset/1.5;
    image(texture, RightHand.x, RightHand.y, 50, 50);
    
  }
  
  boolean isDead(){
    if(lifespan <= 0.0){
      return true;
    }else{
      return false;
    }
  }
}
