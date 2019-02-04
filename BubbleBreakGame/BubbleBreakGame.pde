import KinectPV2.*;

KinectPV2 kinect;

float minThresh;
float maxThresh;

PImage img;

float ColiPixX;
float ColiPixY;

Bubble[] bubbles = new Bubble[20];
//Means, I will have an integer array called "bubbles" and there I'll create two of that.

//float BubbleDiameter;
float BubbleX;
float BubbleY;

int leftChances = 10;



boolean going=false;

void setup(){
  size(512,424);
  
  for(int i=0; i<bubbles.length; i++){
  bubbles[i] = new Bubble(random(30,60), random(255),random(255),random(255));
  }
  
  kinect = new KinectPV2(this);
  kinect.enableDepthImg(true);
  //kinect.enablePointCloud(true);
  kinect.init();
  img = createImage(kinect.WIDTHDepth, kinect.HEIGHTDepth,RGB);
  
}

void draw(){
  frameRate(30);
  
  img.loadPixels();
  image(img, 0, 0);
  
  minThresh = 550;
  maxThresh = 1000;
  
  //Get the raw depth 0-4500 as array of integers
  int[] depth = kinect.getRawDepthData();
  
  float sumX = 0;
  float sumY = 0;
  float totalPixels = 0;
  
  for(int x = 0; x < kinect.WIDTHDepth; x++){
    for(int y = 0; y < kinect.HEIGHTDepth; y++){
      int offset = x + y * kinect.WIDTHDepth;//A paticular pixel
      int d = depth[offset];
      
      if(d > minThresh && d < maxThresh){
        img.pixels[offset] = color(137, 195, 235);
        
        //Watch every pixel to find out which are meets this if statement
        sumX += x;
        sumY += y;
        totalPixels++;
        ColiPixX = x;
        ColiPixY = y;
        
      }else{
        img.pixels[offset] = color(255);
      }
      
     
    }
  }
  
  
  
  //img.updatePixels();
  //image(img, 0, 0);
  
  float avgX = sumX / totalPixels;
  float avgY = sumY / totalPixels;
  //fill(112,88,163);
  //stroke(231, 96, 158);
  //strokeWeight(4);
  //ellipse(avgX, avgY, 5, 5);
  
  for(int i=0; i<bubbles.length; i++){
    bubbles[i].display();//Call each object through dot syntax
    if(going){
      bubbles[i].ascend();
    }
    bubbles[i].top();
    bubbles[i].touch();
    //line(BubbleX, BubbleY, avgX, avgY);
    
  }
  
  ColiPixX = avgX;
  ColiPixY = avgY;
  
  leftChances();
  
  if(leftChances == 0){
    GameOver();
  }
  
  img.updatePixels();
}

void mousePressed(){
  going=!going;
}

void GameOver(){
  going = false;
  textSize(60);
  fill(255,0,0);
  textAlign(CENTER, CENTER);
  text("GAME"+" "+"OVER",width/2,height/2);
}

void leftChances(){
  textSize(24);
  fill(0);
  textAlign(10, 390);
  text("Left"+" "+"chances"+" "+":"+" "+leftChances, 10,390);
}
