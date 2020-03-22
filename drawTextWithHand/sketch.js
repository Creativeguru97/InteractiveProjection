/*
This project is middle fo the way
*/

let pose;
let handPoses;

const widthValue = document.querySelector('video').width;
const heightValue = document.querySelector('video').height;


let isModelLoaded = false;

async function loadHandPose(){
  pose = await handpose.load({
    detectionConfidence:0.75
  });
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
      handPoses = await pose.estimateHands(element, {
        flipHorizontal:false
      });
    }

  }, 50)

})


//----- Comfortable p5 world! -----

let canvas;

let x = 0;
let y = 0;

let stepSize = 5.0;

let font;
let letters = "Coding is very fun, why you still haven't started?  ";
let fontSizeMin = 3;
let angleDistortion = 0.0;

let counter = 0;

let fingerPositions = [];
let isDrawingNow = false;

canvas = p => {
  p.setup = () => {
    p.createCanvas(p.displayWidth, p.displayHeight);
    // p.background(255);
    p.clear();
    p.smooth();
    p.cursor(p.CROSS);

    p.textFont("Helvetica", fontSizeMin);
    p.textAlign(p.LEFT);
    p.fill(0);
  }

  p.draw = () => {

    if(isModelLoaded == true){
      if(handPoses != undefined){
        p.calculateFingerPos();
        p.drawState();
        p.drawText();
      }
    }

    // console.log(p.frameRate());
  }

  p.calculateFingerPos = () => {
    for(let i=0; i<handPoses.length; i++){
      let fingerX = p.int(p.map(
        handPoses[i].annotations.indexFinger[0][0], 20, widthValue-20, p.displayWidth, 0
      ));
      let fingerY = p.int(p.map(
        handPoses[i].annotations.indexFinger[0][1], 20, heightValue-20, 0, p.displayHeight
      ));

      let position = [fingerX, fingerY];

      //Store the coordinates to array.
      fingerPositions.unshift(position);

      //For debug
      p.point(
        fingerPositions[i][0],
        fingerPositions[i][1],
      );

      // console.log(fingerPositions);

    }//Hand drawing end
  }//Function end

  p.drawState = () => {
    //Calculate distance between root and tip of index finger.
    for(let i=0; i<handPoses.length; i++){
      let d = p.dist(
        handPoses[i].annotations.indexFinger[0][0],
        handPoses[i].annotations.indexFinger[0][1],
        handPoses[i].annotations.indexFinger[3][0],
        handPoses[i].annotations.indexFinger[3][1],
      );

      if(d > 35){//This is depend on input resolution
        isDrawingNow = false;
      }else{
        isDrawingNow = true;
      }

      console.log("--------");
      console.log("distance: "+d);
      console.log("isDrawingNow: "+isDrawingNow);
      console.log("--------");
    }
  }

  p.drawText = () => {
    if(isDrawingNow == true){
      for(let i=0; i<handPoses.length; i++){
        let d = p.dist(x, y, fingerPositions[i][0], fingerPositions[i][1]);//Calsulete distance mouse moved since last frame.
        p.textFont('Helvetica', fontSizeMin+d/2);//Decide size from the distance.
        let newLetter = letters.charAt(counter);//A "counter"-th character in the "letters" sentence.
        stepSize = p.textWidth(newLetter);

        if(d > stepSize){
          let angle = p.atan2(fingerPositions[i][1]-y, fingerPositions[i][0]-x);//I love this function, Very intersting!!!

          p.push();
          p.translate(x, y);//Move coordinate origin
          p.rotate(angle + p.random(angleDistortion));
          p.text(newLetter, 0, 0);//Draw a character on the new origin.
          p.pop();

          counter++;
          if(counter > letters.length-1) counter = 0;//If reached to end of the sentence, go back to the head.

          x = x + p.cos(angle)*stepSize;
          y = y + p.sin(angle)*stepSize;
        }

        fingerPositions.pop();
      }//For loop end
    }else{

    }//If statement end
  }//Function end

  p.keyReleased = () => {
  // if(key == 's') saveFrame(timestamp()+"_##.png");

  if (p.keyCode == p.DELETE || p.keyCode == p.BACKSPACE) p.clear();//Erase all
  // if (p.keyCode == p.DELETE || p.keyCode == p.BACKSPACE) p.background(255);//Erase all

}

}//Canvas end

// ----- Comfortable p5 world! -----


let myp5 = new p5(canvas, 'canvas');
