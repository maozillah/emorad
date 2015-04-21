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
//            println(skelD);
            
            skelD= true;
            
            
            // use midpoint as attractor for particles
            PVector attractorn = new PVector(joints[KinectPV2.JointType_SpineMid]
                .getX(), joints[KinectPV2.JointType_SpineMid].getY());
            for (int k = 0; k < particle.length; k++) {
                particle[k].run(attractorn.x, attractorn.y); //run() method takes two arguments - x and y values to apply forces to
            }
        }
    }
    
    if (!skelD){
//      println(skelD);
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

void getStateTypeAsString(int state, int type) {
    if (type == KinectPV2.FaceProperty_Happy && state == KinectPV2.DetectionResult_Yes) {
        smiling = true;
    }
}
