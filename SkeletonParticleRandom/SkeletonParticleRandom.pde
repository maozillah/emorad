/*
Copyright (C) 2014  Thomas Sanchez Lengeling.
 KinectPV2, Kinect for Windows v2 library for processing
 */
import KinectPV2.KJoint;
import KinectPV2.*;
KinectPV2 kinect;
// number of movers
Mover[] movers = new Mover[1000];

//Mover2[] movers2 = new Mover2[1000];
//Mover3[] movers3 = new Mover3[1000];
//Mover4[] movers4 = new Mover4[1000];
//Mover5[] movers5 = new Mover5[1000];
//Mover6[] movers6 = new Mover6[1000];
Skeleton[] skeleton;
void setup() {
    size(1920, 1080, P3D);
    kinect = new KinectPV2(this);
    kinect.enableSkeleton(true);
    // used for particles?
    kinect.enableSkeletonColorMap(true);
    kinect.init();
  
    setupFlowfield();
}
void draw() {
    background(250);
    skeleton = kinect.getSkeletonColorMap();
    drawParticles();
    fill(255, 0, 0);
    text(frameRate, 50, 50);
}
void setupFlowfield() {
    // loops to initialize particles 
    for (int i = 0; i < movers.length; i++) {
        movers[i] = new Mover(i/10000.0);
    }
//    for (int j = 0; j < movers2.length; j++) {
//        movers2[j] = new Mover2();
//    }
//    for (int k = 0; k < movers3.length; k++) {
//        movers3[k] = new Mover3();
//    }
//    for (int l = 0; l < movers4.length; l++) {
//        movers4[l] = new Mover4();
//    }
//    for (int m = 0; m < movers5.length; m++) {
//        movers5[m] = new Mover5();
//    }
//    for (int n = 0; n < movers6.length; n++) {
//        movers6[n] = new Mover6();
//    }
}
void drawParticles() {
    //individual JOINTS
    // i is number of people, initiate new movers when detected?
    for (int i = 0; i < skeleton.length; i++) {
        if (skeleton[i].isTracked()) {
            KJoint[] joints = skeleton[i].getJoints();
            
            // attractor for particles
            PVector attractor = new PVector(joints[KinectPV2.JointType_SpineMid]
                .getX(), joints[KinectPV2.JointType_SpineMid].getY());
//            if (i == 0) {
//                for (int j = 0; j < movers.length; j++) {
//                    movers[j].update(attractor.x, attractor.y);
//                    movers[j].display();
//                    //println(movers.length);
//                }
//            }
            
            for (Mover p : movers) {
              p.update(attractor.x, attractor.y);
              p.display();
            }
//            if (i == 1) {
//                for (int k = 0; k < movers2.length; k++) {
//                    movers2[k].update(attractor.x, attractor.y);
//                    movers2[k].display();
//                    //println(movers.length);
//                }
//            }
//            if (i == 2) {
//                for (int l = 0; l < movers3.length; l++) {
//                    movers3[l].update(attractor.x, attractor.y);
//                    movers3[l].display();
//                    //println(movers.length);
//                }
//            }
//            if (i == 3) {
//                for (int m = 0; m < movers4.length; m++) {
//                    movers4[m].update(attractor.x, attractor.y);
//                    movers4[m].display();
//                    //println(movers.length);
//                }
//            }
//            if (i == 4) {
//                for (int n = 0; n < movers5.length; n++) {
//                    movers5[n].update(attractor.x, attractor.y);
//                    movers5[n].display();
//                    //println(movers.length);
//                }
//            }
//            if (i == 5) {
//                for (int o = 0; o < movers6.length; o++) {
//                    movers6[o].update(attractor.x, attractor.y);
//                    movers6[o].display();
//                    //println(movers.length);
//                }
//            }
        }
    }
}
