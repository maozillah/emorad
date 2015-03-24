KinectPV2.BODY_COUNT

---
  // Since we are going to access the image's pixels too  
  img.loadPixels(); 
  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      int loc = x + y*width;
      
      // The functions red(), green(), and blue() pull out the 3 color components from a pixel.
      float r = red(img.pixels[loc]);
      float g = green(img.pixels[loc]);
      float b = blue(img.pixels[loc]);
      
      // Image Processing would go here
      
      //any non-white pixels
      
      // Set the display pixel to the image pixel
      pixels[loc] =  color(255,0,0);          
    }
  }
  updatePixels();


  --

PImage img;       // source image
PImage destination;  // Destination image

void setup() {
  size(200, 200);
  img = loadImage("sunflower.jpg");  
  // The destination image is created as a blank image the same size as the img.
  destination = createImage(img.width, img.height, RGB);
}

void draw() {  
  float threshold = 127;

  // We are going to look at both image's pixels
  img.loadPixels();
  destination.loadPixels();
  
  for (int x = 0; x < img.width; x++) {
    for (int y = 0; y < img.height; y++ ) {
      int loc = x + y*img.width;
      // Test the brightness against the threshold
      if (brightness(img.pixels[loc]) > threshold) {
        destination.pixels[loc]  = color(255);  // White
      }  else {
        destination.pixels[loc]  = color(0);    // Black
      }
    }
  }

  // We changed the pixels in destination
  destination.updatePixels();
  // Display the destination
  image(destination,0,0);
}

---
// draw circles
int pointillize = 16;

   int x = int(random(img.width));
  int y = int(random(img.height));
  int loc = x + y*img.width;
  
  // Look up the RGB color in the source image
  loadPixels();
  float r = red(img.pixels[loc]);
  float g = green(img.pixels[loc]);
  float b = blue(img.pixels[loc]);
  noStroke();
  
  // Draw an ellipse at that location with that color
  fill(r,g,b,100);
  ellipse(x,y,pointillize,pointillize);