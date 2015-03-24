//referenced from https://github.com/ThomasLengeling/KinectPV2/blob/master/KinectPV2/examples/OpenCV_Processing/FindContours/FindContours.pde

import KinectPV2.*;
KinectPV2 kinect;

// what does this really do?
int threshold = 200;

float maxD = 4.0f;
float minD = 0.5f;

PImage img;
PImage destination;

void setup() { 
  // has to be this size
  size(512, 424, P3D);

  kinect = new KinectPV2(this);

  kinect.enableBodyTrackImg(true);
  kinect.init();
  
  // define images
  img = kinect.getBodyTrackImage();
  destination = createImage(img.width, img.height, RGB);
}

void draw() {
//  background(255);

  // pixels from kinect
  img.loadPixels();
  
  // new image
  destination.loadPixels();
  
  for (int x = 0; x < img.width; x++) {
    for (int y = 0; y < img.height; y++ ) {
      int loc = x + y*img.width;

// working destination display
       float r = red(img.pixels[loc]);
      float g = green(img.pixels[loc]);
      float b = blue(img.pixels[loc]);
    
    if ( !(r+g+b == 765)) {
        destination.pixels[loc]  = color(255,0,0);
      }        
      else {
//        destination.pixels[loc]  = color(r,g,b);   
// background color
    destination.pixels[loc]  = color(255);  
      }
    }
  }

  destination.updatePixels();
  // Display the destination
  image(destination,0,0);
  
  // crazy lag if blur
//  filter(BLUR, 6);
  
  // box with attributes
  noStroke();
  fill(0);
  rect(0, 0, 130, 100);
  fill(255, 0, 0);
  text("fps: "+frameRate, 20, 20);
  text("threshold: "+threshold, 20, 40);
  text("minD: "+minD, 20, 60);
  text("maxD: "+maxD, 20, 80);

  kinect.setLowThresholdPC(minD);
  kinect.setHighThresholdPC(maxD);
  
  // screenshots
   if ( keyPressed ) {
    saveFrame("process/##.png");
  }
}

void keyPressed() {
  
  if (key == 'a') {
    threshold+=1;
  }
  if (key == 's') {
    threshold-=1;
  }

  if (key == '1') {
    minD += 0.01;
  }

  if (key == '2') {
    minD -= 0.01;
  }

  if (key == '3') {
    maxD += 0.01;
  }

  if (key == '4') {
    maxD -= 0.01;
  }
}


