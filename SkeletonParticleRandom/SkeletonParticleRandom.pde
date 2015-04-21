import KinectPV2.KJoint;
import KinectPV2.*;
KinectPV2 kinect;
Skeleton[] skeleton;
boolean smiling;
boolean skelD = false;
FaceData[] faceData;
//------------------------ INITIALISE VARIABLES ------------------------
int num = 1000; //how many particles we'll have in the system. More particles = slower sketch.
Particle[] particle = new Particle[num]; //Initialise array of particles of length "num"
//------------------------ SETUP ---------------------------------------
void setup() {
        size(1920, 1080, P3D);
        kinect = new KinectPV2(this);
        kinect.enableSkeleton(true);
        // used for particles?
        kinect.enableSkeletonColorMap(true);
        kinect.enableFaceDetection(true);
        kinect.init();
        smooth(); //turn on anti-aliasing
        noStroke();
        background(255);

      intializeParticles();
    }
    //------------------------ DRAW ----------------------------------------
void draw() {
    // refresh detection of smiling
    skelD=false;

    smiling = false;
    skeleton = kinect.getSkeletonColorMap();
    //facial detection
    faceData = kinect.getFaceData();
    for (int i = 0; i < faceData.length; i++) {
        if (faceData[i].isFaceTracked()) {
            PVector[] facePointsColor = faceData[i].getFacePointsColorMap();
            Rectangle rectFace = faceData[i].getBoundingRect();
            FaceFeatures[] faceFeatures = faceData[i].getFaceFeatures();
            for (int j = 0; j < 8; j++) {
                int st = faceFeatures[j].getState();
                int type = faceFeatures[j].getFeatureType();
                getStateTypeAsString(st, type);
            }
        }
    }
    
    //draw trails, trail length can be altered by making alpha value in fill() lower
    fill(255, 50);
    rect(0, 0, width, height);
    
    //run all the particles in the array every frame
    for (int i = 0; i < skeleton.length; i++) {
        if (skeleton[i].isTracked()) {
            KJoint[] joints = skeleton[i].getJoints();
            println(skelD);
            
            skelD= true;
            
            color col  = getIndexColor(i);
            fill(col);
            stroke(col);
            drawBody(joints);
            
            // use midpoint as attractor for particles
            PVector attractorn = new PVector(joints[KinectPV2.JointType_SpineMid]
                .getX(), joints[KinectPV2.JointType_SpineMid].getY());
            for (int k = 0; k < particle.length; k++) {
                particle[k].run(attractorn.x, attractorn.y); //run() method takes two arguments - x and y values to apply forces to
            }
        }
    }
    
    if (!skelD){
      println(skelD);
       PVector attractor = new PVector(width/2, height/2);
      for (int j = 0; j < particle.length; j++) {
                particle[j].run(attractor.x, attractor.y); //run() method takes two arguments - x and y values to apply forces to
            }
    }
    
     if ( keyPressed ) {
    saveFrame("process/##.png");
  }
}

void intializeParticles() {
  
  for (int i = 0; i < particle.length; i++) {
            particle[i] = new Particle(new PVector(random(0, width), random(0,
                height)), 3, 10, 10);
        }
}

//use different color for each skeleton tracked
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

//DRAW BODY
void drawBody(KJoint[] joints) {
  drawBone(joints, KinectPV2.JointType_Head, KinectPV2.JointType_Neck);
  drawBone(joints, KinectPV2.JointType_Neck, KinectPV2.JointType_SpineShoulder);
  drawBone(joints, KinectPV2.JointType_SpineShoulder, KinectPV2.JointType_SpineMid);
  drawBone(joints, KinectPV2.JointType_SpineMid, KinectPV2.JointType_SpineBase);
  drawBone(joints, KinectPV2.JointType_SpineShoulder, KinectPV2.JointType_ShoulderRight);
  drawBone(joints, KinectPV2.JointType_SpineShoulder, KinectPV2.JointType_ShoulderLeft);
  drawBone(joints, KinectPV2.JointType_SpineBase, KinectPV2.JointType_HipRight);
  drawBone(joints, KinectPV2.JointType_SpineBase, KinectPV2.JointType_HipLeft);

  // Right Arm    
  drawBone(joints, KinectPV2.JointType_ShoulderRight, KinectPV2.JointType_ElbowRight);
  drawBone(joints, KinectPV2.JointType_ElbowRight, KinectPV2.JointType_WristRight);
  drawBone(joints, KinectPV2.JointType_WristRight, KinectPV2.JointType_HandRight);
  drawBone(joints, KinectPV2.JointType_HandRight, KinectPV2.JointType_HandTipRight);
  drawBone(joints, KinectPV2.JointType_WristRight, KinectPV2.JointType_ThumbRight);

  // Left Arm
  drawBone(joints, KinectPV2.JointType_ShoulderLeft, KinectPV2.JointType_ElbowLeft);
  drawBone(joints, KinectPV2.JointType_ElbowLeft, KinectPV2.JointType_WristLeft);
  drawBone(joints, KinectPV2.JointType_WristLeft, KinectPV2.JointType_HandLeft);
  drawBone(joints, KinectPV2.JointType_HandLeft, KinectPV2.JointType_HandTipLeft);
  drawBone(joints, KinectPV2.JointType_WristLeft, KinectPV2.JointType_ThumbLeft);

  // Right Leg
  drawBone(joints, KinectPV2.JointType_HipRight, KinectPV2.JointType_KneeRight);
  drawBone(joints, KinectPV2.JointType_KneeRight, KinectPV2.JointType_AnkleRight);
  drawBone(joints, KinectPV2.JointType_AnkleRight, KinectPV2.JointType_FootRight);

  // Left Leg
  drawBone(joints, KinectPV2.JointType_HipLeft, KinectPV2.JointType_KneeLeft);
  drawBone(joints, KinectPV2.JointType_KneeLeft, KinectPV2.JointType_AnkleLeft);
  drawBone(joints, KinectPV2.JointType_AnkleLeft, KinectPV2.JointType_FootLeft);

  drawJoint(joints, KinectPV2.JointType_HandTipLeft);
  drawJoint(joints, KinectPV2.JointType_HandTipRight);
  drawJoint(joints, KinectPV2.JointType_FootLeft);
  drawJoint(joints, KinectPV2.JointType_FootRight);

  drawJoint(joints, KinectPV2.JointType_ThumbLeft);
  drawJoint(joints, KinectPV2.JointType_ThumbRight);

  drawJoint(joints, KinectPV2.JointType_Head);
}

void drawJoint(KJoint[] joints, int jointType) {
  pushMatrix();
  translate(joints[jointType].getX(), joints[jointType].getY(), joints[jointType].getZ());
  ellipse(0, 0, 25, 25);
  popMatrix();
}

void drawBone(KJoint[] joints, int jointType1, int jointType2) {
  pushMatrix();
  translate(joints[jointType1].getX(), joints[jointType1].getY(), joints[jointType1].getZ());
  ellipse(0, 0, 25, 25);
  popMatrix();
  line(joints[jointType1].getX(), joints[jointType1].getY(), joints[jointType1].getZ(), joints[jointType2].getX(), joints[jointType2].getY(), joints[jointType2].getZ());
}

void getStateTypeAsString(int state, int type) {
    if (type == KinectPV2.FaceProperty_Happy && state == KinectPV2.DetectionResult_Yes) {
        smiling = true;
    }
}
