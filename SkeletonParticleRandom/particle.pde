class Particle{
  /*
    PVector is a class in Processing that makes it easier to store
    values, and make calculations based on these values. It can make
    applying forces to objects much easier and more efficient!
  */
  PVector loc; //location vector
  PVector vel; //velocity vector
  PVector acc; //acceleration vector
  int sz;  //size of particle
  float gravity;  //gravity variable
  float mass;  //mass variable
  int velocityLimit = 5;  //the maximum velocity a particle can travel at
  float d;  //distance variable between particle and the target co-ordinates
 
  //CONSTRUCTOR
  Particle(PVector _loc, int _sz, float _gravity, float _mass){
    loc = _loc.get();  //when calling loc, return current location of the selected particle
    vel = new PVector(0, 0);  //set vel and acc vectors to 0 as default
    acc = new PVector(0, 0);
    sz = _sz;
    gravity = _gravity;
    mass = _mass;
  }
   
  //method to render the particle. control how it looks here!
  void display(){
    ellipseMode(CENTER);
    fill(d, 0, 255);
    ellipse(loc.x, loc.y, sz, sz);
  }
   
  //math for attraction and repulsion forces
  //tx and ty are the co-ordinates attraction/repulsion will be applied to
  void forces(float tx, float ty){
    PVector targetLoc = new PVector(tx, ty);  //creating new vector for attractive/repulsive x and y values
    PVector dir = PVector.sub(loc, targetLoc);  //calculate the direction between a particle and targetLoc
    d = dir.mag();  //calculate how far away the particle is from targetLoc
    dir.normalize();  //convert the measurement to a unit vector
     
    //calculate the strength of the force by factoring in a gravitational constant and the mass of a particle
    //multiply by distance^2
    float force = (gravity*mass) / (d*d);
     
    //if the mouse is pressed, turn on repulsion by multiplying direction by 1
    if(mousePressed){
      dir.mult(0.1);
    }
    //else multiply the direction by -1 to switch the direction the particle travels in (attraction)
    else{
      dir.mult(-1);
    }
     
    //apply directional vector
    applyForce(dir);
  }
   
  //method to apply a force vector to the particle
  void applyForce(PVector force){
    force.div(mass);
    acc.add(force);
  }
   
  //method to update the location of the particle, and keep its velocity within a set limit
  void update(){
    vel.add(acc);
    vel.limit(velocityLimit);
    loc.add(vel);
    acc.mult(0);
  }
   
  //method to bounce particles of canvas edges
  void bounds(){
    if(loc.y > height || loc.y < 0){
      vel.y *= -1;
    }
    if(loc.x > width || loc.x < 0){
      vel.x *= -1;
    }
  }
   
  //main method that combines all previous methods, and takes two arguments
  //tx and ty are inherited from forces(), and set the attractive/repulsive co-ords
  void run(float tx, float ty){
    forces(tx, ty);
    display();
    bounds();
    update();
  }
}
