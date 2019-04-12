import org.openkinect.processing.*;

Kinect2 kinect2;

float minThresh;
float maxThresh;

float PersonX;
float PersonY;


PImage img;

BodyMove bodyMove;
HeadMove headMove;

import processing.sound.*;
SoundFile[] shoesSound = new SoundFile[6];


void setup(){
  size(512, 540);
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
   //headMove = new HeadMove(HeadTurn, width/2, height-HeadTurn[0].height/4);
   bodyMove = new BodyMove(move, width/2, height-move[0].height/4);
   headMove = new HeadMove(HeadTurn, width/2, height-HeadTurn[0].height/4);
   //println(HeadTurn[0].height);
   println(height-HeadTurn[0].height/4);
   
   //import sound file
  for(int i = 0; i < shoesSound.length; i++){
    shoesSound[i] = new SoundFile(this, "ShoesSound/"+i+".mp3");
    shoesSound[i].amp(0.03);
  }
  
  kinect2 = new Kinect2(this);
  kinect2.initDepth();
  kinect2.initDevice();
  img = createImage(kinect2.depthWidth, kinect2.depthWidth,RGB);
}

void draw(){
  background(255);
  img.loadPixels();
    //image(img, 0, 0);
  
  minThresh = 700;
  maxThresh = 1300;
  
  //minThresh = map(mouseX, 0, width, 0, 4500);
  //maxThresh = map(mouseY, 0, width, 0, 4500);
  
  //Get the raw depth 0-4500 as array of integers
  int[] depth = kinect2.getRawDepth();
  
  float sumX = 0;
  float sumY = 0;
  float totalPixels = 0;
  
  for(int x = 0; x < kinect2.depthWidth; x++){
    for(int y = 0; y < kinect2.depthHeight; y++){
      int offset = x + y * kinect2.depthWidth;//A paticular pixel
      int d = depth[offset];
      
      if(d > minThresh && d < maxThresh){
        img.pixels[offset] = color(137, 195, 235);
        
        //Watch every pixel to find out which are meets this if statement
        sumX += x;
        sumY += y;
        totalPixels++;
        
      }else{
        img.pixels[offset] = color(255);
      }
    }
  }
  
  img.updatePixels();
  image(img, 0, 0);
  
  PersonX= sumX / totalPixels;
  PersonY = sumY / totalPixels;
  fill(112,88,163);
  stroke(231, 96, 158);
  strokeWeight(4);
  ellipse(PersonX, PersonY, 64, 64);
  
  //background(135);
  //Draw Amy
  imageMode(CENTER);
  pushMatrix();
  bodyMove.display();
  bodyMove.move();
  bodyMove.frameNext();
  headMove.display();
  headMove.move();
  headMove.frameNext();
  popMatrix();
  imageMode(CORNER);
  
  //img.updatePixels();
  //image(img, 0, 0);
 
}
