class HeadParticle extends Particle{
  //PVector Head = new PVector(random(HeadX-20, HeadX+20), random(HeadY-100, HeadY-80));
  PVector Head = new PVector(HeadX, HeadY-100);

  //PVector LeftHand = new PVector(width/2+200, height/2);

  float R = 255;
  float G = 200;
  float B = 200;
  
  HeadParticle(PImage EachTexture){
    super(EachTexture);
    //velocity = new PVector(random(-1.5, 1.5), random(-1.0, 1.0));
    //acceleration = new PVector(0, -0.15);
    velocity = new PVector(random(-1.8, 1.8), random(0, 1.5));
    acceleration = new PVector(0, -0.20);
  }
  
  void fall(){
    velocity.add(acceleration);
    Head.add(velocity);
    lifespan -= lifespanOffset;
  }
  
  void display(){
    //fill(100);
    imageMode(CENTER);
    tint(R, G, B, lifespan);
    G -= lifespanOffset/12;
    B -= lifespanOffset/1.5;
    //image(texture, Head.x, Head.y, 60, 60);
    image(texture, Head.x, Head.y, 50, 50);
  }
}
