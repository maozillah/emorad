// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

class Mover {

  // The Mover tracks location, velocity, and acceleration 
  PVector location;
  PVector velocity;
  PVector acceleration;
  // The Mover's maximum speed
  float topspeed;
  int col;
  int col2;


  Mover() {
    // Start in the center
    location = new PVector(random(width),random(height));
    velocity = new PVector(0,0);
    topspeed = 5;
    color[] colarray = new color[10];
 
    colarray[0] = color(125,190,167);
    colarray[1] = color(243,227,172);
    colarray[2] = color(246,160,54);
    colarray[3] = color(242,107,24);
    colarray[4] = color(91,58,44);
    colarray[5] = color(240,74,91);
    colarray[6] = color(241,4,89);
    colarray[7] = color(88,11,74);
    colarray[8] = color(4,100,142);
    colarray[9] = color(244,224,196);
    
    col = colarray[(int)random(0,4)];
    col2 = colarray[(int)random(5,9)];
    fill(col);
  }

  void update(float x, float y) {
    
    // Compute a vector that points from location to mouse
    PVector mouse = new PVector(x,y);
    PVector acceleration = PVector.sub(mouse,location);
    // Set magnitude of acceleration
    //acceleration.setMag(0.2);
    acceleration.normalize();
    acceleration.mult(0.2);
    
    // Velocity changes according to acceleration
    velocity.add(acceleration);
    // Limit the velocity by topspeed
    velocity.limit(topspeed);
    // Location changes by velocity
    location.add(velocity);
  }

  void display() {
   noStroke();
    fill(col);
    ellipse(location.x,location.y,5,5);
  }

}


