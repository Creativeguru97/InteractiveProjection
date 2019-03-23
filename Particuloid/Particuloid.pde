import KinectPV2.KJoint;
import KinectPV2.*;
KinectPV2 kinect;


float HeadX, HeadY;
float NeckX, NeckY;
float SpineShoulderX, SpineShoulderY;
float SpineMidX, SpineMidY;
float SpineBaseX, SpineBaseY;
float RightHandX, RightHandY;
float LeftHandX, LeftHandY;
float ElbowRightX, ElbowRightY;
float ElbowLeftX, ElbowLeftY;
float ShoulderRightX, ShoulderRightY;
float ShoulderLeftX, ShoulderLeftY;
float HipLeftX, HipLeftY;
float HipRightX, HipRightY;
float KneeRightX, KneeRightY;
float KneeLeftX, KneeLeftY;
float FootRightX, FootRightY;
float FootLeftX, FootLeftY;

ArrayList<Vehicle> vehicles;

void setup() {
  size(1920,1080, P3D);
  // We are now making random vehicles and storing them in an ArrayList
  vehicles = new ArrayList<Vehicle>();
  for (int i = 0; i < 2000; i++) {
    vehicles.add(new Vehicle(random(width),random(height), random(255),random(5, 9)));
  }
  kinect = new KinectPV2(this);
  kinect.enableSkeletonColorMap(true);
  kinect.init();
}

void draw() {
  background(0);

  
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
    }
  }

  
  for (Vehicle v : vehicles) {
    // Path following and separation are worked on in this function
    v.applyBehaviors(vehicles);
    // Call the generic run method (update, borders, display, etc.)
    v.update();
    v.display();
    v.seek();
  }
  
  //fill(255);
  //text(frameRate, 10,height*2/3);
}

//void mousePressed() {
//  vehicles.add(new Vehicle(mouseX,mouseY, random(255), random(1, 3)));
//}

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
  NeckX = joints[KinectPV2.JointType_Neck].getX();
  NeckY = joints[KinectPV2.JointType_Neck].getY();
  SpineMidX = joints[KinectPV2.JointType_SpineMid].getX();
  SpineMidY = joints[KinectPV2.JointType_SpineMid].getY();
  SpineBaseX = joints[KinectPV2.JointType_SpineBase].getX();
  SpineBaseY = joints[KinectPV2.JointType_SpineBase].getY();
  ShoulderRightX = joints[KinectPV2.JointType_ShoulderRight].getX();
  ShoulderRightY = joints[KinectPV2.JointType_ShoulderRight].getY();
  ShoulderLeftX = joints[KinectPV2.JointType_ShoulderLeft].getX();
  ShoulderLeftY = joints[KinectPV2.JointType_ShoulderLeft].getY();
  SpineShoulderX = joints[KinectPV2.JointType_SpineShoulder].getX();
  SpineShoulderY = joints[KinectPV2.JointType_SpineShoulder].getY();
  HipLeftX = joints[KinectPV2.JointType_HipLeft].getX();
  HipLeftY = joints[KinectPV2.JointType_HipLeft].getY();
  HipRightX = joints[KinectPV2.JointType_HipRight].getX();
  HipRightY = joints[KinectPV2.JointType_HipRight].getY();
  


  // Right Arm
  drawBone(joints, KinectPV2.JointType_ShoulderRight, KinectPV2.JointType_ElbowRight);
  drawBone(joints, KinectPV2.JointType_ElbowRight, KinectPV2.JointType_WristRight);
  drawBone(joints, KinectPV2.JointType_WristRight, KinectPV2.JointType_HandRight);
  drawBone(joints, KinectPV2.JointType_HandRight, KinectPV2.JointType_HandTipRight);
  drawBone(joints, KinectPV2.JointType_WristRight, KinectPV2.JointType_ThumbRight);
  RightHandX = joints[KinectPV2.JointType_HandRight].getX();
  RightHandY = joints[KinectPV2.JointType_HandRight].getY();
  ElbowRightX = joints[KinectPV2.JointType_ElbowRight].getX();
  ElbowRightY = joints[KinectPV2.JointType_ElbowRight].getY();
  
  // Left Arm
  drawBone(joints, KinectPV2.JointType_ShoulderLeft, KinectPV2.JointType_ElbowLeft);
  drawBone(joints, KinectPV2.JointType_ElbowLeft, KinectPV2.JointType_WristLeft);
  drawBone(joints, KinectPV2.JointType_WristLeft, KinectPV2.JointType_HandLeft);
  drawBone(joints, KinectPV2.JointType_HandLeft, KinectPV2.JointType_HandTipLeft);
  drawBone(joints, KinectPV2.JointType_WristLeft, KinectPV2.JointType_ThumbLeft);
  LeftHandX = joints[KinectPV2.JointType_HandLeft].getX();
  LeftHandY = joints[KinectPV2.JointType_HandLeft].getY();
  ElbowLeftX = joints[KinectPV2.JointType_ElbowLeft].getX();
  ElbowLeftY = joints[KinectPV2.JointType_ElbowLeft].getY();
  
 
  // Right Leg
  drawBone(joints, KinectPV2.JointType_HipRight, KinectPV2.JointType_KneeRight);
  drawBone(joints, KinectPV2.JointType_KneeRight, KinectPV2.JointType_AnkleRight);
  drawBone(joints, KinectPV2.JointType_AnkleRight, KinectPV2.JointType_FootRight);
  KneeRightX = joints[KinectPV2.JointType_KneeRight].getX();
  KneeRightY = joints[KinectPV2.JointType_KneeRight].getY();
  FootRightX = joints[KinectPV2.JointType_FootRight].getX();
  FootRightY = joints[KinectPV2.JointType_FootRight].getY();

  // Left Leg
  drawBone(joints, KinectPV2.JointType_HipLeft, KinectPV2.JointType_KneeLeft);
  drawBone(joints, KinectPV2.JointType_KneeLeft, KinectPV2.JointType_AnkleLeft);
  drawBone(joints, KinectPV2.JointType_AnkleLeft, KinectPV2.JointType_FootLeft);
  KneeLeftX = joints[KinectPV2.JointType_KneeLeft].getX();
  KneeLeftY = joints[KinectPV2.JointType_KneeLeft].getY();
  FootLeftX = joints[KinectPV2.JointType_FootLeft].getX();
  FootLeftY = joints[KinectPV2.JointType_FootLeft].getY();


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
    break;
  case KinectPV2.HandState_Closed:
    fill(255, 0, 0);
    break;
  case KinectPV2.HandState_Lasso:
    fill(0, 0, 255);
    break;
  case KinectPV2.HandState_NotTracked:
    fill(255, 255, 255);
    break;
  }
}
