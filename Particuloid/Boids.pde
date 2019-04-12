class Vehicle {
  
  // All the usual stuff
  PVector position;
  PVector velocity;
  PVector acceleration;
  float r;
  float maxforce;    // Maximum steering force
  float maxspeed;    // Maximum speed
  float hue;
  
  

    // Constructor initialize all values
  Vehicle(float x, float y, float hue_, float r_) {
    position = new PVector(x, y);
    r = r_;
    maxspeed = 10;
    maxforce = 0.15;
    acceleration = new PVector(0, 0);
    velocity = new PVector(0, 0);
    hue = hue_;
  }

  void applyForce(PVector force) {
    // We could add mass here if we want A = F / M
    acceleration.add(force);
  }
  
  void applyBehaviors(ArrayList<Vehicle> vehicles) {
     PVector separateForce = separate(vehicles);
     PVector seekForce = seek();
     //We weight those behaviors at here.
     separateForce.mult(3);
     seekForce.mult(2);
     applyForce(separateForce);
     applyForce(seekForce);
  }
  
  // A method that calculates a steering force towards a target
  // STEER = DESIRED MINUS VELOCITY
  PVector seek() {
    //Define each vector of body part 
    PVector head = new PVector(HeadX, HeadY);
    PVector neck = new PVector(NeckX, NeckY);
    PVector spineShoulder = new PVector(SpineShoulderX, SpineShoulderY);
    PVector shoulderRight = new PVector(ShoulderRightX+40, ShoulderRightY);
    PVector shoulderLeft = new PVector(ShoulderLeftX-40, ShoulderLeftY);
    PVector spineMid = new PVector(SpineMidX, SpineMidY);
    PVector spineBase = new PVector(SpineBaseX, SpineBaseY);
    PVector leftHand = new PVector(LeftHandX, LeftHandY);
    PVector rightHand = new PVector(RightHandX, RightHandY);
    PVector elbowRight = new PVector(ElbowRightX, ElbowRightY);
    PVector elbowLeft = new PVector(ElbowLeftX, ElbowLeftY);
    PVector hipRight = new PVector(HipRightX, HipRightY);
    PVector hipLeft = new PVector(HipLeftX, HipLeftY);
    PVector kneeRight = new PVector(KneeRightX, KneeRightY);
    PVector kneeLeft = new PVector(KneeLeftX, KneeLeftY);
    PVector footRight = new PVector(FootRightX, FootRightY);
    PVector footLeft = new PVector(FootLeftX, FootLeftY);
    
    
    //Calculate distance from each parts to each particle
    PVector distHead = PVector.sub(head, position);
        float dHead = distHead.mag();
    PVector distNeck = PVector.sub(neck, position);
        float dNeck = distNeck.mag();
    PVector distSpineShoulder = PVector.sub(spineShoulder, position);
        float dSpineShoulder = distSpineShoulder.mag();
    PVector distShoulderRight = PVector.sub(shoulderRight, position);
        float dShoulderRight = distShoulderRight.mag();
    PVector distShoulderLeft = PVector.sub(shoulderLeft, position);
        float dShoulderLeft = distShoulderLeft.mag();
    PVector distSpineMid = PVector.sub(spineMid, position);
        float dSpineMid = distSpineMid.mag();
    PVector distSpineBase = PVector.sub(spineBase, position);
        float dSpineBase = distSpineBase.mag();
    PVector distElbowRight = PVector.sub(elbowRight, position);
        float dElbowRight = distElbowRight.mag();
    PVector distElbowLeft = PVector.sub(elbowLeft, position);
        float dElbowLeft = distElbowLeft.mag();
    PVector distLeftHand = PVector.sub(leftHand, position);
        float dLeftHand = distLeftHand.mag();
    PVector distRightHand = PVector.sub(rightHand, position);
        float dRightHand = distRightHand.mag();
    PVector distHipRight = PVector.sub(hipRight, position);
        float dHipRight = distHipRight.mag();
    PVector distHipLeft = PVector.sub(hipLeft, position);
        float dHipLeft = distHipLeft.mag();
    PVector distKneeRight = PVector.sub(kneeRight, position);
        float dKneeRight = distKneeRight.mag();
    PVector distKneeLeft = PVector.sub(kneeLeft, position);
        float dKneeLeft = distKneeLeft.mag();
    PVector distFootRight = PVector.sub(footRight, position);
        float dFootRight = distFootRight.mag();
    PVector distFootLeft = PVector.sub(footLeft, position);
        float dFootLeft = distFootLeft.mag();
    
    
    //Decide which body part should be target
    float[] bodyDist = {dHead, dNeck, dSpineShoulder, dShoulderRight, dShoulderLeft, dSpineMid, dElbowRight, dElbowLeft, dLeftHand, dRightHand, dHipRight, dHipLeft, dKneeRight, dKneeLeft, dFootRight, dFootLeft};
    PVector target = new PVector();
    float nearestParts = min(bodyDist);
    if(nearestParts == dHead){
      target = head.get();
    }else if(nearestParts == dNeck){
      target = neck.get();
    }else if(nearestParts == dSpineShoulder){
      target = spineShoulder.get();
    }else if(nearestParts == dShoulderRight){
      target = shoulderRight.get();
    }else if(nearestParts == dShoulderLeft){
      target = shoulderLeft.get();
    }else if(nearestParts == dSpineMid){
      target = spineMid.get();
    }else if(nearestParts == dElbowRight){
      target = elbowRight.get();
    }else if(nearestParts == dElbowLeft){
      target = elbowLeft.get();
    }else if(nearestParts == dLeftHand){
      target = leftHand.get();
    }else if(nearestParts == dRightHand){
      target = rightHand.get();
    }else if(nearestParts == dHipRight){
      target = hipRight.get();
    }else if(nearestParts == dHipLeft){
      target = hipLeft.get();
    }else if(nearestParts == dKneeRight){
      target = kneeRight.get();
    }else if(nearestParts == dKneeLeft){
      target = kneeLeft.get();
    }else if(nearestParts == dFootRight){
      target = footRight.get();
    }else if(nearestParts == dFootLeft){
      target = footLeft.get();
    }

    PVector desired = PVector.sub(target,position);  // A vector pointing from the position to the target
    
    // Normalize desired and scale to maximum speed
    desired.normalize();
    desired.mult(maxspeed);
    // Steering = Desired minus velocity
    PVector steer = PVector.sub(desired,velocity);
    steer.limit(maxforce);  // Limit to maximum steering force
    //steer.mult(1);// weight
    //applyForce(steer);
    return steer;
  }
  
  // Separation
  // Method checks for nearby vehicles and steers away
  PVector separate (ArrayList<Vehicle> vehicles) {
    float desiredseparation = r*2;
    PVector sum = new PVector();
    int count = 0;
    // For every boid in the system, check if it's too close
    for (Vehicle other : vehicles) {
      float d = PVector.dist(position, other.position);
      // If the distance is greater than 0 and less than an arbitrary amount (0 when you are yourself)
      if ((d > 0) && (d < desiredseparation)) {
        // Calculate vector pointing away from neighbor
        PVector diff = PVector.sub(position, other.position);
        diff.normalize();
        diff.div(d);        // Weight by distance
        sum.add(diff);
        count++;            // Keep track of how many
      }
    }
    // Average -- divide by how many
    if (count > 0) {
      sum.div(count);
      // Our desired vector is the average scaled to maximum speed
      sum.normalize();
      sum.mult(maxspeed);
      // Implement Reynolds: Steering = Desired - Velocity
      sum.sub(velocity);
      sum.limit(maxforce);
    }
    return sum;
  }


  // Method to update position
  void update() {
    // Update velocity
    velocity.add(acceleration);
    // Limit speed
    velocity.limit(maxspeed);
    position.add(velocity);
    // Reset accelertion to 0 each cycle
    acceleration.mult(0);
  }

  void display() {
    colorMode(HSB);
    noStroke();
    pushMatrix();
    translate(position.x, position.y);
    //fill(hue, 200, 255);
    //ellipse(0, 0, r, r);
 
    imageMode(CENTER);
    tint(hue, 200, 255);
    image(textureB, 0, 0, r*2.5, r*2.5);
    tint(hue, 0, 255);
    image(textureF, 0, 0, r*1.8, r*1.8);
    popMatrix();
  }

}
