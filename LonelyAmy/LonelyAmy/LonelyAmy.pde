//Amy[] movingAmy = new Amy[1];
BodyMove bodyMove;
HeadMove headMove;

void setup(){
  size(1920, 540);
  frameRate(30);
  PImage[] move = new PImage[30];
  for(int i = 0; i < move.length; i++){
    move[i] = loadImage("WalkBody/WalkBody"+nf(i, 2)+".png");
  }
  PImage[] HeadTurn = new PImage[30];
  for(int i = 0; i < HeadTurn.length; i++){
    HeadTurn[i] = loadImage("HeadTurn/HeadTurn"+nf(i, 2)+".png");
  }
  
  
  //By defalut, move[0].height is 850 pixel but I made its half
   bodyMove = new BodyMove(move, width/2, height-move[0].height/4);
   headMove = new HeadMove(HeadTurn, width/2, height-HeadTurn[0].height/4);
   //println(HeadTurn[0].height);
   println(height-HeadTurn[0].height/4);
}

void draw(){
  background(135);
  
  //for (int i = 0; i < movingAmy.length; i ++ ) {
  //  movingAmy[i].display();
  //  movingAmy[i].move();
  //  movingAmy[i].frameNext();
  //}
  
  bodyMove.display();
  bodyMove.move();
  bodyMove.frameNext();
  headMove.display();
  headMove.move();
  headMove.frameNext();
 
}
