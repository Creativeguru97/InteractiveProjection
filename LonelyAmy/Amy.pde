class Girl{
  float AmyX;
  float AmyY;
  
  
  
  Girl(){
    AmyX = mouseX;
    AmyY = 200;
  }
  
  void display(){
    fill(0);
    rectMode(CENTER);
    ellipse(AmyX, AmyY, 50, 50);
  }
}

  
  
//class Head extends Girl{
//  float headX;
//  float headY;
    
//  Head(){
//    headX = AmyX;
//    headY = AmyY;
//  }
    
//  void display(){
//    fill(0);
//    ellipse(AmyX, 60, 10,100);
//  }
//}
  

  
  //class Hairtail{
  //  float tailbubbleX;
  //  float tailbubbleY;
  //  float radius;
    
  //  Hairtail(float EachBubbleX, float EachBubbleY, float EachRadius){
  //    tailbubbleX = EachBubbleX;
  //    tailbubbleY = EachBubbleY;
  //    radius = EachRadius;
  //  }
    
  //  void display(){
  //    ellipse(tailbubbleX, tailbubbleY, radius, radius);
  //  }
  //}
  
    
  //class Tolso{
  //  float TolsoX;
  //  float TolsoY;
    
  //}
