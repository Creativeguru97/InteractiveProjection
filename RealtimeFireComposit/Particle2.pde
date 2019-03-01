class Particle2 extends Particle{
  PVector LeftHand = new PVector(LeftHandX, LeftHandY-60);
  //PVector LeftHand = new PVector(width/2+200, height/2);

  float R = 255;
  float G = 200;
  float B = 200;
  
  Particle2(PImage EachTexture){
    super(EachTexture);
  }
  
  void fall(){
    velocity.add(acceleration);
    LeftHand.add(velocity);
    lifespan -= lifespanOffset;
  }
  
  void display(){
    //fill(100);
    imageMode(CENTER);
    tint(R, G, B, lifespan);
    B -= lifespanOffset/12;
    G -= lifespanOffset/1.5;
    image(texture, LeftHand.x, LeftHand.y, 50, 50);
  }
}
