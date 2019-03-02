//class ParticleSystem{
//  PImage texture;
  
//  ArrayList<Particle> particles;
//  PVector origin;
  
//  //ParticleSystem(PVector location, PImage texture_){
//  //  origin = location;
//  //  particles = new ArrayList<Particle>();
//  //  texture = texture_;
//  //}
//  ParticleSystem(PImage texture_){
    
//    particles = new ArrayList<Particle>();
//    texture = texture_;
//  }
  
//  //void addParticle(){
//  //  for(int i = 0; i < 5; i++){
//  //    particles.add(new Particle2(origin, texture));
//  //  }
//  //}
//  void addParticle(){
//    for(int i = 0; i < 5; i++){
//      particles.add(new Particle(texture));
//    }
//    for(int i = 0; i < 5; i++){
//      particles.add(new Particle2(texture));
//    }
//  }
  
//  void run(){
//    for(int i = particles.size()-1; i >= 0; i--){
//      Particle p = particles.get(i);
//      p.fall();
//      p.display();
      
//      if(p.isDead()){
//        particles.remove(i);
//      }
//    }
//  }

  

//}
