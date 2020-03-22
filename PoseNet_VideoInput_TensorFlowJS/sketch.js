/*
  Tutorials to implement image feeding:
    Tutorial0: https://github.com/tensorflow/tfjs-models/tree/master/posenet
    Tutorial1: https://medium.com/tensorflow/real-time-human-pose-estimation-in-the-browser-with-tensorflow-js-7dd0bc881cd5

  Resource that help me a lot to implement video feeding:
    https://github.com/hpssjellis/beginner-tensorflowjs-examples-in-javascript/blob/master/tfjsv1/tfjs01-posenet-webcam.html
*/

//I think this is the simplest PoseNet Video feeding Implementation ever.

let flipHorizontal = false;
let element = document.getElementById('video');

let net;
let poses = [];//Must be array, because estimateMultiplePoses() returns array
let poseLength;//How many people detected?
let keypointsLength;//How many body key point detected?

const widthValue = element.width;
const heightValue = element.height;


async function loadPoseNet(){
  net = await posenet.load({
  architecture: 'MobileNetV1',
  outputStride: 16,
  inputResolution: { width: widthValue/2, height: heightValue/2 },
  multiplier: 0.75
  })
}

loadPoseNet();


navigator.mediaDevices.getUserMedia({video:{width: widthValue, height: heightValue }})
.then(mediaStream => {
  var video = document.querySelector('video');
  video.srcObject = mediaStream;
  // video.onloadedmetadata = function(e) {
  //   video.play();
  // };
})
.catch((err) => { console.log(err.name + ": " + err.message); });


element.addEventListener("play", () => {

  setInterval(async () => {
  poses = await net.estimateMultiplePoses(element, {
    flipHorizontal: false,
    maxDetections: 2,
    scoreThreshold: 0.8,
    nmsRadius: 20
  })

  poseLength = poses.length;
  keypointsLength = poses[0].keypoints.length;

  // console.log(poses);

}, 50)

})


// ----- Comfortable p5 world! -----

let canvas;

canvas = p => {
  p.setup = () => {
    p.createCanvas(widthValue, heightValue);
    // p.clear();
  }

  p.draw = () => {
    p.clear();
    if(poses != undefined){
      for(let i=0; i < poseLength; i++){
       for(let j=0; j < keypointsLength; j++){
         p.fill(255);
         p.stroke(255);

         //--- Draw points ---
         p.ellipse(
           poses[i].keypoints[j].position.x,
           poses[i].keypoints[j].position.y,
           2,
           2
         );

         //--- Draw lines ---

         //Shoulder
         p.line(
           poses[i].keypoints[5].position.x,
           poses[i].keypoints[5].position.y,
           poses[i].keypoints[6].position.x,
           poses[i].keypoints[6].position.y,
         );
         //TorsoLeft
         p.line(
           poses[i].keypoints[5].position.x,
           poses[i].keypoints[5].position.y,
           poses[i].keypoints[11].position.x,
           poses[i].keypoints[11].position.y,
         );
         //TorsoRight
         p.line(
           poses[i].keypoints[6].position.x,
           poses[i].keypoints[6].position.y,
           poses[i].keypoints[12].position.x,
           poses[i].keypoints[12].position.y,
         );
         //Hip
         p.line(
           poses[i].keypoints[11].position.x,
           poses[i].keypoints[11].position.y,
           poses[i].keypoints[12].position.x,
           poses[i].keypoints[12].position.y,
         );
         //LeftUpperArm
         p.line(
           poses[i].keypoints[5].position.x,
           poses[i].keypoints[5].position.y,
           poses[i].keypoints[7].position.x,
           poses[i].keypoints[7].position.y,
         );
         //LeftUpperArm
         p.line(
           poses[i].keypoints[6].position.x,
           poses[i].keypoints[6].position.y,
           poses[i].keypoints[8].position.x,
           poses[i].keypoints[8].position.y,
         );
         //LeftForeArm
         p.line(
           poses[i].keypoints[7].position.x,
           poses[i].keypoints[7].position.y,
           poses[i].keypoints[9].position.x,
           poses[i].keypoints[9].position.y,
         );
         //RightForeArm
         p.line(
           poses[i].keypoints[8].position.x,
           poses[i].keypoints[8].position.y,
           poses[i].keypoints[10].position.x,
           poses[i].keypoints[10].position.y,
         );
         //LeftThigh
         p.line(
           poses[i].keypoints[11].position.x,
           poses[i].keypoints[11].position.y,
           poses[i].keypoints[13].position.x,
           poses[i].keypoints[13].position.y,
         );
         //RightThigh
         p.line(
           poses[i].keypoints[12].position.x,
           poses[i].keypoints[12].position.y,
           poses[i].keypoints[14].position.x,
           poses[i].keypoints[14].position.y,
         );
         //LeftLeg
         p.line(
           poses[i].keypoints[13].position.x,
           poses[i].keypoints[13].position.y,
           poses[i].keypoints[15].position.x,
           poses[i].keypoints[15].position.y,
         );
         //RightLeg
         p.line(
           poses[i].keypoints[14].position.x,
           poses[i].keypoints[14].position.y,
           poses[i].keypoints[16].position.x,
           poses[i].keypoints[16].position.y,
         );

       }
      }
    }
    // console.log(p.frameRate());
  }
}

// ----- Comfortable p5 world! -----


let myp5 = new p5(canvas, 'canvas');
