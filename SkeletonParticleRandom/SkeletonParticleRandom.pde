// http://www.openprocessing.org/sketch/18798 modified

import KinectPV2.KJoint;
import KinectPV2.*;
KinectPV2 kinect;
Skeleton[] skeleton;
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
        kinect.init();
        smooth(); //turn on anti-aliasing
        noStroke();
        background(255);
        //fill particle array with new Particle objects
        for (int i = 0; i < particle.length; i++) {
            particle[i] = new Particle(new PVector(random(0, width), random(0,
                height)), 2, 10, 10);
        }
    }
    //------------------------ DRAW ----------------------------------------
void draw() {
    skeleton = kinect.getSkeletonColorMap();
    text(frameRate, 50, 50);
    
    //draw trails, trail length can be altered by making alpha value in fill() lower
    fill(255, 55);
    rect(0, 0, width, height);
    //run all the particles in the array every frame
    
    for (int i = 0; i < skeleton.length; i++) {
        if (skeleton[i].isTracked()) {
            KJoint[] joints = skeleton[i].getJoints();
            // use midpoint as attractor for particles
            PVector attractor = new PVector(joints[KinectPV2.JointType_SpineMid]
                .getX(), joints[KinectPV2.JointType_SpineMid].getY());
            for (int j = 0; j < particle.length; j++) {
                particle[j].run(attractor.x, attractor.y); //run() method takes two arguments - x and y values to apply forces to
            }
        }
    }
}
