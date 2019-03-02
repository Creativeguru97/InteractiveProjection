import KinectPV2.KJoint;
import KinectPV2.*;


KinectPV2 kinect;

float RightHandX;
float RightHandY;
float LeftHandX;
float LeftHandY;
float HeadX;
float HeadY;

int ignitionState;

PImage texture;
PImage BGimg;



//ParticleSystem ps;
//ArrayList<ParticleSystem> systems;
Particle p;
ArrayList<Particle> particles;

void setup(){
  size(1920, 1080, P3D);
  //ps = new ParticleSystem(new PVector(mouseX, mouseY), texture);
  p = new Particle(texture);

  particles = new ArrayList<Particle>();

  texture = loadImage("texture01.png");
  
  kinect = new KinectPV2(this);
  kinect.enableSkeletonColorMap(true);
  kinect.enableColorImg(true);
  kinect.init();
}

void draw(){
  background(0);
  frameRate(60);
  
  /*At void display in Particle2, 
    imageMode(CENTER);
    tint(R, G, B, lifespan);
    Without 2 raws below, ColorImg from Kinect get affected.
  */
  imageMode(CORNER);
  tint(255, 255);
  image(kinect.getColorImage(), 0, 0, width, height);
  
  blendMode(ADD);
  
  //pushMatrix();
  for(int i = particles.size()-1; i >= 0; i--){
      Particle p = particles.get(i);
      p.excute();
      
      if(p.isDead()){
        particles.remove(i);
      }
  }
  //popMatrix();
  
  ArrayList<KSkeleton> skeletonArray =  kinect.getSkeletonColorMap();
  //individual JOINTS
  for (int i = 0; i < skeletonArray.size(); i++) {
    KSkeleton skeleton = (KSkeleton) skeletonArray.get(i);
    if (skeleton.isTracked()) {
      KJoint[] joints = skeleton.getJoints();

      color col  = skeleton.getIndexColor();
      fill(col);
      stroke(col);
      drawBody(joints);

      //draw different color for each hand state
      drawHandState(joints[KinectPV2.JointType_HandRight]);
      drawHandState(joints[KinectPV2.JointType_HandLeft]);
      
      //Draw HeadParticle
      for(int j = 0; j < 15; j++){
        particles.add(new HeadParticle(texture));
      }
    }
  }
  
  

}


//DRAW BODY
void drawBody(KJoint[] joints) {
  drawBone(joints, KinectPV2.JointType_Head, KinectPV2.JointType_Neck);
  drawBone(joints, KinectPV2.JointType_Neck, KinectPV2.JointType_SpineShoulder);
  drawBone(joints, KinectPV2.JointType_SpineShoulder, KinectPV2.JointType_SpineMid);
  drawBone(joints, KinectPV2.JointType_SpineMid, KinectPV2.JointType_SpineBase);
  drawBone(joints, KinectPV2.JointType_SpineShoulder, KinectPV2.JointType_ShoulderRight);
  drawBone(joints, KinectPV2.JointType_SpineShoulder, KinectPV2.JointType_ShoulderLeft);
  drawBone(joints, KinectPV2.JointType_SpineBase, KinectPV2.JointType_HipRight);
  drawBone(joints, KinectPV2.JointType_SpineBase, KinectPV2.JointType_HipLeft);

  // Right Arm
  drawBone(joints, KinectPV2.JointType_ShoulderRight, KinectPV2.JointType_ElbowRight);
  drawBone(joints, KinectPV2.JointType_ElbowRight, KinectPV2.JointType_WristRight);
  drawBone(joints, KinectPV2.JointType_WristRight, KinectPV2.JointType_HandRight);
  drawBone(joints, KinectPV2.JointType_HandRight, KinectPV2.JointType_HandTipRight);
  drawBone(joints, KinectPV2.JointType_WristRight, KinectPV2.JointType_ThumbRight);
  //Set the right hand bubble break point
  RightHandX = joints[KinectPV2.JointType_HandRight].getX();
  RightHandY = joints[KinectPV2.JointType_HandRight].getY();
  
  

  // Left Arm
  drawBone(joints, KinectPV2.JointType_ShoulderLeft, KinectPV2.JointType_ElbowLeft);
  drawBone(joints, KinectPV2.JointType_ElbowLeft, KinectPV2.JointType_WristLeft);
  drawBone(joints, KinectPV2.JointType_WristLeft, KinectPV2.JointType_HandLeft);
  drawBone(joints, KinectPV2.JointType_HandLeft, KinectPV2.JointType_HandTipLeft);
  drawBone(joints, KinectPV2.JointType_WristLeft, KinectPV2.JointType_ThumbLeft);
  //Set the left hand bubble break point
  LeftHandX = joints[KinectPV2.JointType_HandLeft].getX();
  LeftHandY = joints[KinectPV2.JointType_HandLeft].getY();

  // Right Leg
  drawBone(joints, KinectPV2.JointType_HipRight, KinectPV2.JointType_KneeRight);
  drawBone(joints, KinectPV2.JointType_KneeRight, KinectPV2.JointType_AnkleRight);
  drawBone(joints, KinectPV2.JointType_AnkleRight, KinectPV2.JointType_FootRight);

  // Left Leg
  drawBone(joints, KinectPV2.JointType_HipLeft, KinectPV2.JointType_KneeLeft);
  drawBone(joints, KinectPV2.JointType_KneeLeft, KinectPV2.JointType_AnkleLeft);
  drawBone(joints, KinectPV2.JointType_AnkleLeft, KinectPV2.JointType_FootLeft);

  drawJoint(joints, KinectPV2.JointType_HandTipLeft);
  drawJoint(joints, KinectPV2.JointType_HandTipRight);
  drawJoint(joints, KinectPV2.JointType_FootLeft);
  drawJoint(joints, KinectPV2.JointType_FootRight);

  drawJoint(joints, KinectPV2.JointType_ThumbLeft);
  drawJoint(joints, KinectPV2.JointType_ThumbRight);

  drawJoint(joints, KinectPV2.JointType_Head);
  HeadX = joints[KinectPV2.JointType_Head].getX();
  HeadY = joints[KinectPV2.JointType_Head].getY();

}


//draw joint
void drawJoint(KJoint[] joints, int jointType) {
  pushMatrix();
  translate(joints[jointType].getX(), joints[jointType].getY(), joints[jointType].getZ());
  //ellipse(0, 0, 25, 25);
  popMatrix();
}

//draw bone
void drawBone(KJoint[] joints, int jointType1, int jointType2) {
  pushMatrix();
  translate(joints[jointType1].getX(), joints[jointType1].getY(), joints[jointType1].getZ());
  //ellipse(0, 0, 25, 25);
  popMatrix();
  //line(joints[jointType1].getX(), joints[jointType1].getY(), joints[jointType1].getZ(), joints[jointType2].getX(), joints[jointType2].getY(), joints[jointType2].getZ());
}

//draw hand state
void drawHandState(KJoint joint) {
  noStroke();
  handState(joint.getState());
  pushMatrix();
  translate(joint.getX(), joint.getY(), joint.getZ());
  //ellipse(0, 0, 50, 50);
  popMatrix();
  
  
  if(ignitionState == 0){
    for(int i = 0; i < 5; i++){
      particles.add(new Particle(texture));
    }
    for(int i = 0; i < 5; i++){
      particles.add(new Particle2(texture));
    }
  }
  
}

/*
Different hand state
 KinectPV2.HandState_Open
 KinectPV2.HandState_Closed
 KinectPV2.HandState_Lasso
 KinectPV2.HandState_NotTracked
 */
void handState(int handState) {
  switch(handState) {
  case KinectPV2.HandState_Open:
    fill(0, 255, 0);
    ignitionState = 0;
    break;
  case KinectPV2.HandState_Closed:
    fill(255, 0, 0);
    ignitionState = 1;
    break;
  case KinectPV2.HandState_Lasso:
    fill(0, 0, 255);
    ignitionState = 2;
    break;
  case KinectPV2.HandState_NotTracked:
    fill(255, 255, 255);
    ignitionState = 3;
    break;
  }
}
