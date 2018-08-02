
class Walker {
  PVector loc;
  PVector vel;
  PVector acc;
  float maxForce;
  float maxSpeed;
  
  Walker(PVector l) {
    loc = l.copy();
    vel = new PVector(random(-1,1), random(-1,1));
    acc = new PVector(0, 0);
    maxSpeed = 15;
    maxForce = 15;
  }
  
   void seek(PVector target) {
   PVector desired = PVector.sub(target, loc);
   float d = desired.mag();
   float speed = maxSpeed;
   if (d < 100) {
    speed = map(d, 0 ,100, 0, maxSpeed); 
   } 
   desired.setMag(speed);
   PVector steer = PVector.sub(desired, vel);
   steer.limit(1);
   applyForce(steer);
 }
 
 void flee(PVector target) {
   PVector desired = PVector.sub(target, loc);
   float d = desired.mag();
   if (d < 70) {
     desired.setMag(maxSpeed);
     desired.mult(-1);
     PVector steer = PVector.sub(desired, vel);
     steer.limit(maxForce);
     applyForce(steer);  
     steer.mult(5);
   } else {
     desired = new PVector(0,0);
   }  
   

 }
  
  void display() {   
    fill(255);
    noStroke();    
    ellipse(loc.x,loc.y, 10, 10);       
  }
  
  void step() {
   loc.add(vel);
   vel.add(acc);
   vel.limit(maxSpeed);
   acc.mult(0);     
  }
  
  void applyForce(PVector force) {
    acc.add(force);
  }  
 
}