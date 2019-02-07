class Girl{
  float AmyX;
  float AmyY;
  PShape Tolso;
  
  
  Girl(float GirlX, float GirlY){
    AmyX = GirlX;
    AmyY = GirlY;
  }
  
  void drawAmy(){
    float headX = width/2;
    float headY = height/2;
    float HairtailX = headX-28;
    float HairtailY = headY+6;
    float TolsoX = headX;
    float TolsoY = headY-5;
    //Head
    fill(0);
    //stroke(255,0,0);
    ellipse(headX, headY-8, 55, 45);
    ellipse(headX, headY, 50, 50);
    //Eyes
    fill(255);
    ellipse(headX-12, headY+5, 12, 12);
    ellipse(headX+12, headY+5, 12, 12);
    
    //Hairtail
    fill(0);
    ellipse(HairtailX, HairtailY, 10, 10);
    ellipse(Hairtail);
    
    //Tolso
    Tolso = createShape();
    Tolso.beginShape();
    fill(0);
    quad(TolsoX-20, TolsoY+50, TolsoX+20, TolsoY+50, TolsoX+25, TolsoY+125, TolsoX-25, TolsoY+125);
    rectMode(CENTER);
    rect(TolsoX, TolsoY+42.5, 15, 15);
    noStroke();
    arc(TolsoX-7, TolsoY+50, 25, 30, PI, PI+HALF_PI );
    arc(TolsoX+7, TolsoY+50, 25, 30, PI+HALF_PI,2*PI  );
    Tolso.endShape();
    
    shape(Tolso, 100,200);
  }

}
