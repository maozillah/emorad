import KinectPV2.*;

KinectPV2 kinect;

FaceData [] faceData;

void setup() {
  size(1920, 1080, P2D);

  kinect = new KinectPV2(this);

  kinect.enableColorImg(true);
  kinect.enableFaceDetection(true);

  kinect.init();
}

void draw() {
  background(0);

  image(kinect.getColorImage(), 0, 0);

  faceData =  kinect.getFaceData();

  // up to six faces
  for (int i = 0; i < faceData.length; i++) {
    if (faceData[i].isFaceTracked()) {
      PVector [] facePointsColor = faceData[i].getFacePointsColorMap();

//      Rectangle rectFace = faceData[i].getBoundingRect();

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

  fill(255);
  text("frameRate "+frameRate, 50, 50);
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
    break;
  case KinectPV2.DetectionResult_Yes:
    str += ": Yes";
    break;  
  case KinectPV2.DetectionResult_No:
    str += ": No";
    break;
  }

  return str;
}
