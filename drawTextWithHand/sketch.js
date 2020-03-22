/*
This project is middle fo the way
*/

let pose;
let handPoses;

const widthValue = 640;
const heightValue = 480;

let isModelLoaded = false;

async function loadHandPose(){
  pose = await handpose.load();
  isModelLoaded = true;
}

loadHandPose();


navigator.mediaDevices.getUserMedia({video:{width: widthValue, height: heightValue }})
.then(mediaStream => {
  var video = document.querySelector('video');
  video.srcObject = mediaStream;
  // video.onloadedmetadata = function(e) {
  //   video.play();
  // };
})
.catch((err) => { console.log(err.name + ": " + err.message); });

let flipHorizontal = false;
let element = document.querySelector('video');


element.addEventListener("play", () => {

  setInterval(async () => {
    if(isModelLoaded == true){
      handPoses = await pose.estimateHands(element);
    }

  }, 50)

})


//----- Comfortable p5 world! -----

let canvas;

canvas = p => {
  p.setup = () => {
    p.createCanvas(widthValue, heightValue);//2D mode
    // p.createCanvas(widthValue, heightValue, p.WEBGL);//3D mode!!!
  }

  p.draw = () => {
    p.clear();

    p.fill(255);
    p.stroke(255);
    p.strokeWeight(8);

    if(isModelLoaded == true){
      if(handPoses != undefined){
        p.drawHand2D();
        // p.drawHand3D();

      }
    }

    // console.log(p.frameRate());
  }

  p.drawHand2D = () => {
    for(let i=0; i<handPoses.length; i++){

      //--- palm base ---
      for(let j=0; j<handPoses[0].annotations.palmBase.length; j++){
          p.point(
            handPoses[i].annotations.palmBase[j][0],
            handPoses[i].annotations.palmBase[j][1]
          );
      }

      //--- thumb ---
      for(let j=0; j<handPoses[0].annotations.thumb.length; j++){
          p.point(
            handPoses[i].annotations.thumb[j][0],
            handPoses[i].annotations.thumb[j][1]
          );
      }

      //--- index finger ---
      for(let j=0; j<handPoses[0].annotations.indexFinger.length; j++){
          p.point(
            handPoses[i].annotations.indexFinger[j][0],
            handPoses[i].annotations.indexFinger[j][1]
          );
      }

      //--- middle finger ---
      for(let j=0; j<handPoses[0].annotations.middleFinger.length; j++){
          p.point(
            handPoses[i].annotations.middleFinger[j][0],
            handPoses[i].annotations.middleFinger[j][1]
          );
      }

      //--- ring finger ---
      for(let j=0; j<handPoses[0].annotations.ringFinger.length; j++){
          p.point(
            handPoses[i].annotations.ringFinger[j][0],
            handPoses[i].annotations.ringFinger[j][1]
          );

      }

      //--- pinky ---
      for(let j=0; j<handPoses[0].annotations.pinky.length; j++){
          p.point(
            handPoses[i].annotations.pinky[j][0],
            handPoses[i].annotations.pinky[j][1]
          );

      }
    }//Hand drawing end
  }//Function end

  p.drawHand3D = () => {
    p.translate(-widthValue/2, -heightValue/2);//if 3D mode

    for(let i=0; i<handPoses.length; i++){

      //--- palm base ---
      for(let j=0; j<handPoses[0].annotations.palmBase.length; j++){
          p.point(
            handPoses[i].annotations.palmBase[j][0],
            handPoses[i].annotations.palmBase[j][1],
            handPoses[i].annotations.palmBase[j][2]
          );

      }

      //--- thumb ---
      for(let j=0; j<handPoses[0].annotations.thumb.length; j++){
            p.point(
              handPoses[i].annotations.thumb[j][0],
              handPoses[i].annotations.thumb[j][1],
              handPoses[i].annotations.thumb[j][2]
            );
      }

      //--- index finger ---
      for(let j=0; j<handPoses[0].annotations.indexFinger.length; j++){
            p.point(
              handPoses[i].annotations.indexFinger[j][0],
              handPoses[i].annotations.indexFinger[j][1],
              handPoses[i].annotations.indexFinger[j][2]
            );
      }

      //--- middle finger ---
      for(let j=0; j<handPoses[0].annotations.middleFinger.length; j++){
            p.point(
              handPoses[i].annotations.middleFinger[j][0],
              handPoses[i].annotations.middleFinger[j][1],
              handPoses[i].annotations.middleFinger[j][2]
            );
      }

      //--- ring finger ---
      for(let j=0; j<handPoses[0].annotations.ringFinger.length; j++){
            p.point(
              handPoses[i].annotations.ringFinger[j][0],
              handPoses[i].annotations.ringFinger[j][1],
              handPoses[i].annotations.ringFinger[j][2]
            );
      }

      //--- pinky ---
      for(let j=0; j<handPoses[0].annotations.pinky.length; j++){
            p.point(
              handPoses[i].annotations.pinky[j][0],
              handPoses[i].annotations.pinky[j][1],
              handPoses[i].annotations.pinky[j][2]
            );
      }
    }//Hand drawing end
  }//Function end

}//Canvas end

// ----- Comfortable p5 world! -----


let myp5 = new p5(canvas, 'canvas');
