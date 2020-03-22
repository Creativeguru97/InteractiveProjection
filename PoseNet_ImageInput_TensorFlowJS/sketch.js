/*
  Tutorial0: https://github.com/tensorflow/tfjs-models/tree/master/posenet
  Tutorial1: https://medium.com/tensorflow/real-time-human-pose-estimation-in-the-browser-with-tensorflow-js-7dd0bc881cd5
*/
let flipHorizontal = false;
let imageElement = document.getElementById('image');

let poseLength;//How many people detected?
let keypointsLength;//How many body key point detected?
let allPoses = [];
let p5Width = imageElement.width;
let p5Height = imageElement.height;

/*
   More about PoseNet and the parameters:
     Tutorial0: https://github.com/tensorflow/tfjs-models/tree/master/posenet
     Tutorial1: https://medium.com/tensorflow/real-time-human-pose-estimation-in-the-browser-with-tensorflow-js-7dd0bc881cd5
*/

// ----- Single pose estimation -----
// posenet.load({
//   architecture: 'MobileNetV1',
//   outputStride: 16,
//   // inputResolution: { width: 640, height: 480 },
//   multiplier: 0.5
// }).then(function(net) {
//   const pose = net.estimateSinglePose(imageElement, {
//     flipHorizontal: false,
//     imageScaleFactor:0.5
//   });
//   return pose;
// }).then(function(pose){
//   console.log(pose);
// })

// ----- Multi-pose estimation -----

async function loadPoseNet(){
  posenet.load({
  //High speed, less accurate model
    architecture: 'MobileNetV1',
    outputStride: 16,
    inputResolution: { width: p5Width, height: p5Height },
    multiplier: 1.0

  //High accuracy, cost of speed model
    // architecture: 'ResNet50',
    // outputStride: 16,
    // inputResolution: { width: 640, height: 480 },
    // quantBytes: 2
  }).then(function(net){
       return net.estimateMultiplePoses(imageElement, {
         flipHorizontal: false,
         maxDetections: 5,
         scoreThreshold: 0.5,
         nmsRadius: 20})
     }).then(function(poses){
       allPoses = poses;
       poseLength = poses.length;
       keypointsLength = poses[0].keypoints.length;

       console.log(allPoses);
     })
}

loadPoseNet();

let canvas;

canvas = p => {
 p.setup = () => {
   p.createCanvas(p5Width, p5Height);
   p.clear();
   // p.ellipse(p.width/2, p.height/2, 100, 100);


 }

 p.draw = () => {
   p.drawSkeleton();
   // console.log(p.frameRate());
 }


 p.drawSkeleton = () => {
   if(allPoses != undefined){
     for(let i=0; i < poseLength; i++){
       for(let j=0; j < keypointsLength; j++){

         p.fill(255);
         p.stroke(255);
         //--- Draw points ---
         p.ellipse(
           allPoses[i].keypoints[j].position.x,
           allPoses[i].keypoints[j].position.y,
           2,
           2
         );

         //--- Draw lines ---

         //Shoulder
         p.line(
           allPoses[i].keypoints[5].position.x,
           allPoses[i].keypoints[5].position.y,
           allPoses[i].keypoints[6].position.x,
           allPoses[i].keypoints[6].position.y,
         );
         //TorsoLeft
         p.line(
           allPoses[i].keypoints[5].position.x,
           allPoses[i].keypoints[5].position.y,
           allPoses[i].keypoints[11].position.x,
           allPoses[i].keypoints[11].position.y,
         );
         //TorsoRight
         p.line(
           allPoses[i].keypoints[6].position.x,
           allPoses[i].keypoints[6].position.y,
           allPoses[i].keypoints[12].position.x,
           allPoses[i].keypoints[12].position.y,
         );
         //Hip
         p.line(
           allPoses[i].keypoints[11].position.x,
           allPoses[i].keypoints[11].position.y,
           allPoses[i].keypoints[12].position.x,
           allPoses[i].keypoints[12].position.y,
         );
         //LeftUpperArm
         p.line(
           allPoses[i].keypoints[5].position.x,
           allPoses[i].keypoints[5].position.y,
           allPoses[i].keypoints[7].position.x,
           allPoses[i].keypoints[7].position.y,
         );
         //LeftUpperArm
         p.line(
           allPoses[i].keypoints[6].position.x,
           allPoses[i].keypoints[6].position.y,
           allPoses[i].keypoints[8].position.x,
           allPoses[i].keypoints[8].position.y,
         );
         //LeftForeArm
         p.line(
           allPoses[i].keypoints[7].position.x,
           allPoses[i].keypoints[7].position.y,
           allPoses[i].keypoints[9].position.x,
           allPoses[i].keypoints[9].position.y,
         );
         //RightForeArm
         p.line(
           allPoses[i].keypoints[8].position.x,
           allPoses[i].keypoints[8].position.y,
           allPoses[i].keypoints[10].position.x,
           allPoses[i].keypoints[10].position.y,
         );
         //LeftThigh
         p.line(
           allPoses[i].keypoints[11].position.x,
           allPoses[i].keypoints[11].position.y,
           allPoses[i].keypoints[13].position.x,
           allPoses[i].keypoints[13].position.y,
         );
         //RightThigh
         p.line(
           allPoses[i].keypoints[12].position.x,
           allPoses[i].keypoints[12].position.y,
           allPoses[i].keypoints[14].position.x,
           allPoses[i].keypoints[14].position.y,
         );
         //LeftLeg
         p.line(
           allPoses[i].keypoints[13].position.x,
           allPoses[i].keypoints[13].position.y,
           allPoses[i].keypoints[15].position.x,
           allPoses[i].keypoints[15].position.y,
         );
         //RightLeg
         p.line(
           allPoses[i].keypoints[14].position.x,
           allPoses[i].keypoints[14].position.y,
           allPoses[i].keypoints[16].position.x,
           allPoses[i].keypoints[16].position.y,
         );
       }
     }
   }
 }
}

// ----- Comfortable p5 world! -----


let myp5 = new p5(canvas, 'canvas');
