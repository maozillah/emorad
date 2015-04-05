//referenced from https://github.com/ThomasLengeling/KinectPV2/blob/master/KinectPV2/examples/OpenCV_Processing/FindContours/FindContours.pde

import KinectPV2.*;
KinectPV2 kinect;
FaceData [] faceData;

// what does this really do?
int threshold = 10;

float maxD = 4.0f;
float minD = 0.5f;

PImage img;
PImage destination;

void setup() { 
  // has to be this size
  size(512, 424, P3D);

  kinect = new KinectPV2(this);

  kinect.enableBodyTrackImg(true);
  kinect.enableColorImg(true);
  kinect.enableFaceDetection(true);
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
  


  //shows background image
  //image(kinect.getColorImage(), 0, 0);
  faceData =  kinect.getFaceData();
  
   // up to six faces
  for (int i = 0; i < faceData.length; i++) {
    if (faceData[i].isFaceTracked()) {
      PVector [] facePointsColor = faceData[i].getFacePointsColorMap();

      FaceFeatures [] faceFeatures = faceData[i].getFaceFeatures();

      PVector nosePos = new PVector();
      noStroke();

      color col = getIndexColor(i);

      fill(col);   
      for (int j = 0; j < facePointsColor.length; j++) {
        if (j == KinectPV2.Face_Nose)
          nosePos.set(facePointsColor[j].x, facePointsColor[j].y);

        ellipse(facePointsColor[j].x, facePointsColor[j].y, 15, 15);
      }

      if (nosePos.x != 0 && nosePos.y != 0)
        for (int j = 0; j < 1; j++) {
          int st   = faceFeatures[j].getState();
          int type = faceFeatures[j].getFeatureType();

          String str = getStateTypeAsString(st, type);

          fill(255);
          text(str, nosePos.x + 150, nosePos.y - 70 + j*25);
        }
      stroke(255, 0, 0);
//      noFill();
//      rect(rectFace.getX(), rectFace.getY(), rectFace.getWidth(), rectFace.getHeight());
    }
  }
}

color getIndexColor(int index) {
  color col = color(255);
  if (index == 0)
    col = color(255, 0, 0);
  if (index == 1)
    col = color(0, 255, 0);
  if (index == 2)
    col = color(0, 0, 255);
  if (index == 3)
    col = color(255, 255, 0);
  if (index == 4)
    col = color(0, 255, 255);
  if (index == 5)
    col = color(255, 0, 255);

  return col;
}

String getStateTypeAsString(int state, int type) {
  String  str ="";
  switch(type) {
  case KinectPV2.FaceProperty_Happy:
    str = "Happy";
    break;
  }

  switch(state) {
  case KinectPV2.DetectionResult_Unknown:
    str += ": Unknown";
    fill(255, 0, 0);
    ellipse(width/2, 100, 70, 70);
    break;
  case KinectPV2.DetectionResult_Yes:
    str += ": Yes";
    fill(0, 255, 0);
    ellipse(width/2, 100, 70, 70);
    break;  
  case KinectPV2.DetectionResult_No:
    str += ": No";
    fill(255, 0, 0);
    ellipse(width/2, 100, 70, 70);
    break;
  }

  return str;
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


