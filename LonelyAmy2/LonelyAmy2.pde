//Amy[] movingAmy = new Amy[1];
Amy movingAmy;
void setup(){
  size(1920, 540);
  frameRate(30);
  PImage[] run = new PImage[40];
  for(int i = 0; i < run.length; i++){
    run[i] = loadImage("move1/stick"+nf(i+1, 2)+".png");
  }
  
  //for (int i = 0; i < movingAmy.length; i++){
  //  movingAmy[i] = new Amy(run, 0, height-58);
  //}
   movingAmy = new Amy(run, width/2, height-58);

}

void draw(){
  background(255);
  
  //for (int i = 0; i < movingAmy.length; i ++ ) {
  //  movingAmy[i].display();
  //  movingAmy[i].run();
  //  movingAmy[i].frameNext();
  //}
  
  movingAmy.display();
  movingAmy.run();
  movingAmy.frameNext();

}
