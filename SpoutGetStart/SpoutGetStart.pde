import KinectPV2.*;
import spout.*;
Spout spout;


KinectPV2 kinect;

float minThresh;
float maxThresh;

PImage img;

String sendername;

void setup() {
  size(512, 424, P3D);

  kinect = new KinectPV2(this);
  kinect.enableDepthImg(true);
  //kinect.enablePointCloud(true);
  kinect.init();
  img = createImage(kinect.WIDTHDepth, kinect.HEIGHTDepth,RGB);
  spout = new Spout(this);
  sendername = "Spoutbox";
  spout.createSender(sendername, width, height);
}

void draw() {
  background(0);
  
  img.loadPixels();
  
  minThresh = map(mouseX, 0, width, 0, 4500);
  maxThresh = map(mouseY, 0, width, 0, 4500);
  
  //Get the raw depth 0-4500 as array of integers
  int[] depth = kinect.getRawDepthData();
  
  for(int x = 0; x < kinect.WIDTHDepth; x++){
    for(int y = 0; y < kinect.HEIGHTDepth; y++){
      int offset = x + y * kinect.WIDTHDepth;
      int d = depth[offset];
      
      if(d > minThresh && d < maxThresh){
        img.pixels[offset] = color(0, 255, 0);
      }else{
        img.pixels[offset] = color(0);
      }
    }
  }
  
  img.updatePixels();
  image(img, 0, 0);
  
  spout.sendTexture();
}
