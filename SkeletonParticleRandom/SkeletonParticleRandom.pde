/*
Copyright (C) 2014  Thomas Sanchez Lengeling.
 KinectPV2, Kinect for Windows v2 library for processing
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

import KinectPV2.KJoint;
import KinectPV2.*;

KinectPV2 kinect;
Mover[] movers = new Mover[3000];
Mover2[] movers2 = new Mover2[3000];
Mover3[] movers3 = new Mover3[3000];
Mover4[] movers4 = new Mover4[3000];
Mover5[] movers5 = new Mover5[3000];
Mover6[] movers6 = new Mover6[3000];



Skeleton [] skeleton;

void setup() {
  size(1920, 1080, P3D);
    for (int i = 0; i < movers.length; i++) {
    
    movers[i] = new Mover(); 
    fill(255, 0, 0);
  }
      for (int j = 0; j < movers2.length; j++) {
    
    movers2[j] = new Mover2(); 
   
  }
  
      for (int k = 0; k < movers3.length; k++) {
    
    movers3[k] = new Mover3(); 
   
  }
  
      for (int l = 0; l < movers4.length; l++) {
    
    movers4[l] = new Mover4(); 
   
  }

      for (int m = 0; m < movers5.length; m++) {
    
    movers5[m] = new Mover5(); 
   
  }
  
      for (int n = 0; n < movers6.length; n++) {
    
    movers6[n] = new Mover6(); 
   
  }

  kinect = new KinectPV2(this);

  kinect.enableSkeleton(true);
  kinect.enableSkeletonColorMap(true);
  kinect.enableColorImg(true);

  kinect.init();
}

void draw() {
  background(250);

  //image(kinect.getColorImage(), 0, 0, width, height);

  skeleton =  kinect.getSkeletonColorMap();

  //individual JOINTS
  for (int i = 0; i < skeleton.length; i++) {
    if (skeleton[i].isTracked()) {
      KJoint[] joints = skeleton[i].getJoints();
      
      PVector attractor = new PVector( joints[KinectPV2.JointType_Head].getX(), joints[KinectPV2.JointType_Head].getY() ); 
      PVector attractorHand = new PVector( joints[KinectPV2.JointType_WristRight].getX(), joints[KinectPV2.JointType_WristRight].getY() );
      PVector attractorHandLeft = new PVector( joints[KinectPV2.JointType_WristLeft].getX(), joints[KinectPV2.JointType_WristLeft].getY() );
     
      if(i == 0){
        for (int j = 0; j < movers.length; j++) {
      
          //movers[j].update(attractor.x, attractor.y);
          movers[j].update(attractorHand.x, attractorHand.y);
//          movers[j].update(attractorHandLeft.x, attractorHandLeft.y);
          //movers[j].update(attractorHand.x, attractorHand.y);
          movers[j].display(); 
          //println(movers.length);
        }
//        for (int j = 0; j < movers.length; j++) {
//      
//          movers[j].update(attractorHand.x, attractorHand.y);
//          //movers[j].update(attractorHand.x, attractorHand.y);
//          movers[j].display(); 
//          //println(movers.length);
//        }
//        for (int j = 0; j < movers.length; j++) {
//      
//          movers[j].update(attractorHandLeft.x, attractorHandLeft.y);
//          //movers[j].update(attractorHand.x, attractorHand.y);
//          movers[j].display(); 
//          //println(movers.length);
//        }
      }
      
      if(i == 1){
        for (int k = 0; k < movers2.length; k++) {
          
//         movers2[k].update(attractor.x, attractor.y);
          movers2[k].update(attractorHand.x, attractorHand.y);
//          movers2[k].update(attractorHandLeft.x, attractorHandLeft.y);
          movers2[k].display(); 
          //println(movers.length);
        }
//         for (int k = 0; k < movers2.length; k++) {
//          
//          movers2[k].update(attractorHand.x, attractorHand.y);
//          movers2[k].display(); 
//          //println(movers.length);
//        }
//        for (int k = 0; k < movers2.length; k++) {
//          
//          movers2[k].update(attractorHandLeft.x, attractorHandLeft.y);
//          movers2[k].display(); 
//          //println(movers.length);
//        }
      }
      
      if(i == 2){
        for (int l = 0; l < movers3.length; l++) {
          
//          movers3[l].update(attractor.x, attractor.y);
          movers3[l].update(attractorHand.x, attractorHand.y);
//          movers3[l].update(attractorHandLeft.x, attractorHandLeft.y);
          movers3[l].display(); 
          //println(movers.length);
        }
//        for (int l = 0; l < movers3.length; l++) {
//          
//          movers3[l].update(attractorHand.x, attractorHand.y);
//          movers3[l].display(); 
//          //println(movers.length);
//        }
//        for (int l = 0; l < movers3.length; l++) {
//          
//          movers3[l].update(attractorHandLeft.x, attractorHandLeft.y);
//          movers3[l].display(); 
//          //println(movers.length);
//        }
      }
      
      if(i == 3){
        for (int m = 0; m < movers4.length; m++) {
          
//          movers4[m].update(attractor.x, attractor.y);
          movers4[m].update(attractorHand.x, attractorHand.y);
//          movers4[m].update(attractorHandLeft.x, attractorHandLeft.y);
          movers4[m].display(); 
          //println(movers.length);
        }
//        for (int m = 0; m < movers4.length; m++) {
//          
//          movers4[m].update(attractorHand.x, attractorHand.y);
//          movers4[m].display(); 
//          //println(movers.length);
//        }
//        for (int m = 0; m < movers4.length; m++) {
//          
//          movers4[m].update(attractorHandLeft.x, attractorHandLeft.y);
//          movers4[m].display(); 
//          //println(movers.length);
//        }
      }
      
      if(i == 4){
        for (int n = 0; n < movers5.length; n++) {
          
//         movers5[n].update(attractor.x, attractor.y);
          movers5[n].update(attractorHand.x, attractorHand.y);
//          movers5[n].update(attractorHandLeft.x, attractorHandLeft.y);
          movers5[n].display(); 
          //println(movers.length);
        }
//        for (int n = 0; n < movers5.length; n++) {
//          
//          movers5[n].update(attractorHand.x, attractorHand.y);
//          movers5[n].display(); 
//          //println(movers.length);
//        }
//        for (int n = 0; n < movers5.length; n++) {
//          
//          movers5[n].update(attractorHandLeft.x, attractorHandLeft.y);
//          movers5[n].display(); 
//          //println(movers.length);
//        }
      }
      
      if(i == 5){
        for (int o = 0; o < movers6.length; o++) {
          
//         movers6[o].update(attractor.x, attractor.y);
          movers6[o].update(attractorHand.x, attractorHand.y);
//          movers6[o].update(attractorHandLeft.x, attractorHandLeft.y);
          movers6[o].display(); 
          //println(movers.length);
        }
//        for (int o = 0; o < movers6.length; o++) {
//          
//          movers6[o].update(attractorHand.x, attractorHand.y);
//          movers6[o].display(); 
//          //println(movers.length);
//        }
//        for (int o = 0; o < movers6.length; o++) {
//          
//          movers6[o].update(attractorHandLeft.x, attractorHandLeft.y);
//          movers6[o].display(); 
//          //println(movers.length);
//        }
      }
      
      color col  = getIndexColor(i);
      fill(col);
      stroke(col);
      drawBody(joints);
      
      
      //draw different color for each hand state
      //drawHandState(joints[KinectPV2.JointType_HandRight]);

     
    }
  }

  fill(255, 0, 0);
  text(frameRate, 50, 50);
  
  if ( keyPressed ) {
    saveFrame("process/##.png");
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

void drawHandState(KJoint joint) {
  noStroke();
  handState(joint.getState());
  
//  for (int i = 0; i < movers.length; i++) {
//    
//    movers[i].update(joint.getX(), joint.getY());
//    movers[i].display(); 
//    //println(movers.length);
//  }
//  for (int i = 0; i < movers2.length; i++) {
//    
//    movers2[i].update(joint.getX(), joint.getY());
//    movers2[i].display(); 
//    //println(movers.length);
//  }
  //update the location
//  movers[i].update(joint.getX(), joint.getY());
  
  //display the mover
//  movers[i].display();
//  pushMatrix();
//  translate(joint.getX(), joint.getY(), joint.getZ());
//  ellipse(0, 0, 70, 70);
//  popMatrix();
}

  


//void draw

/*
Different hand state
 KinectPV2.HandState_Open
 KinectPV2.HandState_Closed
 KinectPV2.HandState_Lasso
 KinectPV2.HandState_NotTracked
 */
void handState(int handState) {
  switch(handState) {
  case KinectPV2.HandState_Open:
    fill(0, 255, 0);
    break;
  case KinectPV2.HandState_Closed:
    fill(255, 0, 0);
    break;
  case KinectPV2.HandState_Lasso:
    fill(0, 0, 255);
    break;
  case KinectPV2.HandState_NotTracked:
    fill(255, 255, 255);
    break;
  
  }
  

}

