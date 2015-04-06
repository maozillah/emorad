//referenced from https://github.com/ThomasLengeling/KinectPV2/blob/master/KinectPV2/examples/OpenCV_Processing/FindContours/FindContours.pde
import KinectPV2.*;
KinectPV2 kinect;

//blob detection
import blobDetection.*; // blobs

// this is a regular java import so we can use and extend the polygon class (see PolygonBlob)
import java.awt.Polygon;
import processing.opengl.*; // opengl

// declare BlobDetection object
BlobDetection theBlobDetection;
// declare custom PolygonBlob object (see class for more info)
PolygonBlob poly = new PolygonBlob();

PImage blobs;
// to center and rescale from 640x480 to higher custom resolutions
float reScale;

int kinectWidth = 640;
int kinectHeight = 480;

color bgColor;

// three color palettes (artifact from me storing many interesting color palettes as strings in an external data file ;-)
String[] palettes = {
    "-1117720,-13683658,-8410437,-9998215,-1849945,-5517090,-4250587,-14178341,-5804972,-3498634",
    "-67879,-9633503,-8858441,-144382,-4996094,-16604779,-588031",
    "-16711663,-13888933,-9029017,-5213092,-1787063,-11375744,-2167516,-15713402,-5389468,-2064585"
};

// an array called flow of 2250 Particle objects (see Particle class)
Particle[] flow = new Particle[2250];
// global variables to influence the movement of all particles
float globalX, globalY;

// what does this really do?
int threshold = 10;

float maxD = 4.0;
float minD = 0.5;

//PImage img;
PImage cam;
PImage destination;

void setup() {
    // has to be this size
    //  size(512, 424, P3D);

    size(1280, 720, OPENGL);

    kinect = new KinectPV2(this);

    kinect.enableBodyTrackImg(true);
    kinect.init();

    // define images
    //  img = kinect.getBodyTrackImage();

    cam = kinect.getBodyTrackImage();
//    destination = createImage(img.width, img.height, RGB);


    reScale = (float) width / kinectWidth;
    // create a smaller blob image for speed and efficiency
    blobs = createImage(kinectWidth / 3, kinectHeight / 3, RGB);
    // initialize blob detection object to the blob image dimensions
    theBlobDetection = new BlobDetection(blobs.width, blobs.height);
    theBlobDetection.setThreshold(0.2);
    setupFlowfield();
}

void draw() {
    // fading background
    noStroke();
    fill(bgColor, 65);
    rect(0, 0, width, height);

    //  // pixels from kinect
    //  img.loadPixels();
    //  
    //  // new image
    //  destination.loadPixels();
    //  
    //  for (int x = 0; x < img.width; x++) {
    //    for (int y = 0; y < img.height; y++ ) {
    //      int loc = x + y*img.width;
    //
    //// working destination display
    //       float r = red(img.pixels[loc]);
    //      float g = green(img.pixels[loc]);
    //      float b = blue(img.pixels[loc]);
    //    
    //    if ( !(r+g+b == 765)) {
    //        destination.pixels[loc]  = color(255,0,0);
    //      }        
    //      else {
    ////        destination.pixels[loc]  = color(r,g,b);   
    //// background color
    //    destination.pixels[loc]  = color(255);  
    //      }
    //    }
    
//    destination.updatePixels();
//    // Display the destination
//    image(destination, 0, 0);
//
//    // box with attributes
//    noStroke();
//    fill(0);
//    rect(0, 0, 130, 100);
//    fill(255, 0, 0);
//    text("fps: " + frameRate, 20, 20);
//    text("threshold: " + threshold, 20, 40);
//    text("minD: " + minD, 20, 60);
//    text("maxD: " + maxD, 20, 80);
//
//    kinect.setLowThresholdPC(minD);
//    kinect.setHighThresholdPC(maxD);

///////////////////////////////////////////////////
    // copy the image into the smaller blob image 
    blobs.copy(cam, 0, 0, cam.width, cam.height, 0, 0, blobs.width, blobs.height);

    // blur the blob image
    blobs.filter(BLUR);
    // detect the blobs
    theBlobDetection.computeBlobs(blobs.pixels);
    // clear the polygon (original functionality)
    poly.reset();
    // create the polygon from the blobs (custom functionality, see class)
    poly.createPolygon();
    drawFlowfield();

    
    // screenshots, why does it save two
    if (keyPressed) {
        saveFrame("process/##.png");
    }
}

void setupFlowfield() {
  // set stroke weight (for particle display) to 2.5
  strokeWeight(2.5);
  // initialize all particles in the flow
  for(int i=0; i<flow.length; i++) {
    flow[i] = new Particle(i/10000.0);
  }
  // set all colors randomly now
  setRandomColors(1);
}

void drawFlowfield() {
  // center and reScale from Kinect to custom dimensions
  translate(0, (height-kinectHeight*reScale)/2);
  scale(reScale);
  // set global variables that influence the particle flow's movement
  globalX = noise(frameCount * 0.01) * width/2 + width/4;
  globalY = noise(frameCount * 0.005 + 5) * height;
  // update and display all particles in the flow
  for (Particle p : flow) {
    p.updateAndDisplay();
  }
  // set the colors randomly every 240th frame
  setRandomColors(240);
}

// sets the colors every nth frame
void setRandomColors(int nthFrame) {
  if (frameCount % nthFrame == 0) {
    // turn a palette into a series of strings
    String[] paletteStrings = split(palettes[int(random(palettes.length))], ",");
    // turn strings into colors
    color[] colorPalette = new color[paletteStrings.length];
    for (int i=0; i<paletteStrings.length; i++) {
      colorPalette[i] = int(paletteStrings[i]);
    }
    // set background color to first color from palette
    bgColor = colorPalette[0];
    // set all particle colors randomly to color from palette (excluding first aka background color)
    for (int i=0; i<flow.length; i++) {
      flow[i].col = colorPalette[int(random(1, colorPalette.length))];
    }
  }
}

void keyPressed() {

    if (key == 'a') {
        threshold += 1;
    }
    if (key == 's') {
        threshold -= 1;
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


