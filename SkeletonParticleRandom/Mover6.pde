// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

class Mover6 {

  // The Mover tracks location, velocity, and acceleration 
  PVector location;
  PVector velocity;
  PVector acceleration;
  // The Mover's maximum speed
  float topspeed;
  int col;
  int col2;
  int col3;
  int col4;
  int col5;
  int col6;


  Mover6() {
    // Start in the center
    location = new PVector(random(width),random(height));
    velocity = new PVector(0,0);
    topspeed = 10;
    color[] colarray = new color[30];
 
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
    colarray[10] = color(62,18,58);
    colarray[11] = color(121,193,148);
    colarray[12] = color(240,238,215);
    colarray[13] = color(240,132,35);
    colarray[14] = color(191,56,39);
    colarray[15] = color(88,48,117);
    colarray[16] = color(173,127,243);
    colarray[17] = color(151,106,240);
    colarray[18] = color(68,162,215);
    colarray[19] = color(97,227,244);
    colarray[20] = color(237,252,236);
    colarray[21] = color(70,188,217);
    colarray[22] = color(74,218,214);
    colarray[23] = color(189,38,6);
    colarray[24] = color(113,21,2);
    colarray[25] = color(140,1,51);
    colarray[26] = color(115,18,78);
    colarray[27] = color(243,138,214);
    colarray[28] = color(241,184,238);
    colarray[29] = color(139,90,165);
    
    col = colarray[(int)random(0,4)];
    col2 = colarray[(int)random(5,9)];
    col3 = colarray[(int)random(10,14)];
    col4 = colarray[(int)random(15, 19)];
    col5 = colarray[(int)random(20,24)];
    col6 = colarray[(int)random(25,29)];
    fill(col6);
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
    fill(col6);
    ellipse(location.x,location.y,5,5);
  }

}


