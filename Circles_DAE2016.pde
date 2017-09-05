import oscP5.*;
import netP5.*;



OscP5 oscP5; // Define Osc object
NetAddress myRemoteLocation; // object to send data

float radius = 45;
float originX, originY;

//int frames = 155;
float theta;

int numCircles = 8;
float c1 = 1;
float c2 = 2;
float c3 = 3;
float c4 = 4;
float c5 = 5;
float c6 = 6;
float c7 = 7;
float c8 = 8;
float c9 = 9;
float c10 = 10;
float c11 = 11;
float c12 = 12;
float c13 = 13;
float c14 = 14;
float c15 = 15;
float c16 = 16;

//control buttons
int b1X, b1Y;//position or r1 up button
int b1S = 40;
int b2X, b2Y;//position or r2 up button
int b2S = 40;
int b3X, b3Y;//position or r3 up button
int b3S = 40;
int b4X, b4Y;//position or r4 up button
int b4S = 40;
int b5X, b5Y;//position or r5 up button
int b5S = 40;
int BpmX, BpmY;//position of bpm+ button
int BpmS = 40;

//ring buttons
//5
float ring5X, ring5Y;
float ring5Sx = 90*6.51;//diameter of ring across
float ring5Sy = 90*5.3;//diameter of ring vertically
//4
float ring4X, ring4Y;
float ring4Sx = 90*4.89;//diameter of ring across
float ring4Sy = 90*4.25;//diameter of ring vertically
//3
float ring3X, ring3Y;
float ring3Sx = 90*3.35;//diameter of ring across
float ring3Sy = 90*3.17;//diameter of ring vertically
//2
float ring2X, ring2Y;
float ring2Sx = 90*2.07;//diameter of ring across
float ring2Sy = 90*2.13;//diameter of ring vertically
//1
float ring1X, ring1Y;
float ring1Sx = 90*1.1;//diameter of ring across
float ring1Sy = 90*1.08;//diameter of ring vertically

float x;
float x2;
float x3; 
float x4; 
float x5; 

float y; 
float y2; 
float y3; 
float y4; 
float y5; 


//gate message variables
int rb1 = 0;
int rb2 = 0;
int rb3 = 0;
int rb4 = 0;
int rb5 = 0;
int rb6 = 0;



//initialize booleans as false
boolean b1Over = false;
boolean b2Over = false;
boolean b3Over = false;
boolean b4Over = false;
boolean b5Over = false;
boolean BpmOver = false;
boolean ring1Over =  false;
boolean ring2Over = false;
boolean ring3Over = false;
boolean ring4Over = false;
boolean ring5Over = false;

//variables to step through ring color array
int r1 = 1;
int r2 = 2;
int r3 = 3;
int r4 = 4;
int r5 = 5;


float bpm = 60;
//float bps = bpm/60.0;
float secondsPerBeat = 60/bpm;
float framesPerBeat;
float prevFrameRate = 0;

void setup() {
  size(800, 480, P3D);
  background(0);
  //frameRate(30);
  //smooth();

  oscP5 = new OscP5(this, 12001); // set port to Receive In
  myRemoteLocation = new NetAddress("127.0.0.1", 12000); // Sending out Port 

  originX = width*0.60;
  originY = height*0.5;

  b1X = 55-b1S+20;
  b1Y = 40+b1S/2-10;

  b2X = 55-b2S+20;
  b2Y = 80+b2S/2-10;

  b3X = 55-b3S+20;
  b3Y = 130+b3S/2-10;

  b4X = 55-b4S+20;
  b4Y = 175+b4S/2-10;

  b5X = 55-b5S+20;
  b5Y = 225+b5S/2-10;

  BpmX = 55-b5S+20;
  BpmY = 5+b5S/2-10;

  //rings
  ring5X = originX-ring5Sx/2;
  ring5Y = originY-ring5Sy/2;

  ring4X = originX-ring4Sx/2;
  ring4Y = originY-ring4Sy/2;

  ring3X = originX-ring3Sx/2;
  ring3Y = originY-ring3Sy/2;

  ring2X = originX-ring2Sx/2;
  ring2Y = originY-ring2Sy/2;

  ring1X = originX-ring1Sx/2;
  ring1Y = originY-ring1Sy/2;
  ellipseMode(CENTER);
  
  
}

void draw() {
 print("RB1",rb1,"RB2",rb2);

  updateb1(mouseX, mouseY);
  updateb2(mouseX, mouseY);
  updateb3(mouseX, mouseY);
  updateb4(mouseX, mouseY);
  updateb5(mouseX, mouseY);
  updateBpm(mouseX, mouseY);
  updateRing5(mouseX, mouseY);
  updateRing4(mouseX, mouseY);
  updateRing3(mouseX, mouseY);
  updateRing2(mouseX, mouseY);
  updateRing1(mouseX, mouseY);

  secondsPerBeat = 60/bpm;


  float[] notes = {c1, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16, c16, c16};


  if (BpmOver) {
    if (mousePressed) {
      bpm = bpm+1;
      if (bpm>160) {
        bpm = 60;
      }
    }
  }
  if (ring5Over) {
    if (mousePressed) {
      if(notes[r5] < 15) {
      print("ring5BANG");
      rb5 = 1;
      rb4 = 0;
      rb3 = 0;
      rb2 = 0;
      rb1 = 0;
        if(notes[r5] > 2.5){
      rb5 = 0;
    }
      }
    }
  
  }
  if (ring4Over) {
    if (mousePressed) {
      if(notes[r4] < 15){
      print("ring4BANG");
      rb5 = 0;
      rb4 = 1;
      rb3 = 0;
      rb2 = 0;
      rb1 = 0;
      if(notes[r4] > 3){
        rb4 = 0;
      }
      }
    }
  }
  if (ring3Over) {
    if (mousePressed) {
      if(notes[r3] <15){
      print("ring3BANG");
      rb5 = 0;
      rb4 = 0;
      rb3 = 1;
      rb2 = 0;
      rb1 = 0;
      if(notes[r3] > 3){
        rb3 = 0;
      }
    }
  }
  }
  if (ring2Over) {
    if (mousePressed) {
      if(notes[r2] < 15){
      print("ring2BANG");
      rb5 = 0;
      rb4 = 0;
      rb3 = 0;
      rb2 = 1;
      rb1 = 0;
      if(notes[r2] > 3){
       rb2 = 0; 
      }
    }
  }
  }
  if (ring1Over) {
    if (mousePressed) {
      if(notes[r1] < 15){
      print("ring1BANG");
      rb5 = 0;
      rb4 = 0;
      rb3 = 0;
      rb2 = 0;
      rb1 = 1;
      if(notes[r1] > 3) {
       rb1 = 0;
      }
      }
    }
  } 
  if (mousePressed == false) {
    rb5 = 0;
    rb4 = 0;
    rb3 = 0;
    rb2 = 0;
    rb1 = 0;
  }
  /*else {
   // r1 = r1;
   //r2 = r2;
   rb6 = 0;
   rb5 = 0;
   rb4 = 0;
   rb3 = 0;
   rb2 = 0;
   rb1 = 0;
   
   }*/
  //print("rb5", rb5);
 //print("C1",c1);
  //background(0);
  framesPerBeat = (frameRate*secondsPerBeat);
  //textSize(32);
  String ring1 = "Ring1";
  String ring2 = "Ring2";
  String ring3 = "Ring3";
  String ring4 = "Ring4";
  String ring5 = "Ring5";
  fill(255);
  //buttons
  //bpm
 /* fill(255);
  text("BPM", 10, 20);
  text(bpm, 80, 20);
  triangle(55, 40, 60, 10, 65, 40);//up(b1)
  fill(0, 0, 0, 50);
  rect(80, 10, 60, 20);//number display mask
  fill(c1*2, c1*1.5, c1*3, 20);
  rect(51, 10, 20, 30);//button
  */
  //ring display/adjust/tune
  //1
  fill(255);
  text(ring1, 10, 60);
  text(r1, 80, 60);
   triangle(55, 80, 60, 50, 65, 80);//up(b1)
  fill(0, 0, 0, 50);
  rect(80, 44, 20, 20);//number display mask
  fill((notes[r1]*1.05), (notes[r1]*3.0), (notes[r1]*1.1),20);
  rect(51, 50, 20, 30);//button
 

  //2
  fill(255);
  text(ring2, 10, 105);
  text(r2, 80, 105);
  triangle(55, 125, 60, 95, 65, 125);//up(b2)
  fill(0, 0, 0, 50);
  rect(80, 89, 20, 20);//number display mask
  fill((notes[r2]*0.8), (notes[r2]*3.2), (notes[r2]*3.0),20);
  rect(51, 95, 20, 30);//button

  //3
  fill(255);
  text(ring3, 10, 150);
  text(r3, 80, 150);
  triangle(55, 170, 60, 140, 65, 170);//up(b3)
  fill(0, 0, 0, 50);
  rect(80, 134, 20, 20);//number display mask
  fill((notes[r3]*1.2), (notes[r3]*1.5), (notes[r3]*5.3),20);
  rect(51, 140, 20, 30);//button

  //4
  fill(255);
  text(ring4, 10, 195);
  text(r4, 80, 195);
  triangle(55, 215, 60, 185, 65, 215);//up(b4)
  fill(0, 0, 0, 50);
  rect(80, 185, 20, 30);//number display mask
  fill(notes[r4]*5, notes[r4]*2.2, notes[r4]*3.5,20);
  rect(51, 185, 20, 30);//button

  //5
  fill(255);
  text(ring5, 10, 240);
  text(r5, 80, 240);
  triangle(55, 260, 60, 230, 65, 260);//up(b1)
  fill(0, 0, 0, 50);
  rect(80, 224, 20, 30);//number display mask
  fill((notes[r5]*3.75), (notes[r5]*4.75), (notes[r5]*5),20);
  rect(51, 230, 20, 30);//button

  //ring buttons
  //5
  fill(0, 0, 0, 1);
  ellipse(originX, originY, ring5Sx, ring5Sy);
  //2
  ellipse(originX, originY, ring4Sx, ring4Sy);
  //3
  ellipse(originX, originY, ring3Sx, ring3Sy);
  //4
  ellipse(originX, originY, ring2Sx, ring2Sy);
  //5
  ellipse(originX, originY, ring1Sx, ring1Sy);
  //fill(0);
  //rect(10,10,80,80);
  noStroke();
  //stroke(0.001);
  theta += radians(90/framesPerBeat);//speed
 //print("R1",notes[r1]);

  //draw rings

  fill((notes[r1]*1.05), (notes[r1]*3.0), (notes[r1]*1.1));//ring one whole notes
  ellipse(x, y, 10, 5);
  fill((notes[r2]*0.8), (notes[r2]*3.2), (notes[r2]*3.0));//ring two
  ellipse(x2, y2, 20, 10);
  fill((notes[r3]*1.2), (notes[r3]*1.5), (notes[r3]*5.3));//ring 3
  ellipse(x3, y3, 30, 15);
  fill(notes[r4]*5, notes[r4]*2.2, notes[r4]*3.5);//ring 4
  ellipse(x4, y4, 40, 20);
  fill((notes[r5]*3.75), (notes[r5]*4.75), (notes[r5]*5));//ring 5
  ellipse(x5, y5, 50, 25);


  //one "c" per ring. controls periodicity of blackout
  c1 = map(theta % TWO_PI, 0, TWO_PI, 0, 200);//wholeNotes 
  c2 = map(theta % PI, 0, TWO_PI, 0, 220);//halfNotes
  c3 = map(theta % (TWO_PI/3), 0, TWO_PI, 0, 255);//3rds
  c4 = map(theta % (PI/2.0), 0, TWO_PI, 0, 200);//4ths 
  c5 = map(theta % ((18*PI)/45.0), 0, TWO_PI, 0, 200);//5ths 
  c6 = map(theta % (PI/3), 0, TWO_PI, 0, 255);//6ths
  c7 = map(theta % (TWO_PI/7), 0, TWO_PI, 0, 255);//7ths
  c8 = map(theta % (TWO_PI/8), 0, TWO_PI, 0, 255);//8ths
  c9 = map(theta % (TWO_PI/9), 0, TWO_PI, 0, 255);//9ths
  c10 = map(theta % (TWO_PI/10), 0, TWO_PI, 0, 255);//10ths
  c11 = map(theta % (TWO_PI/11), 0, TWO_PI, 0, 255);//11ths
  c12 = map(theta % (TWO_PI/12), 0, TWO_PI, 0, 255);//12ths
  c13 = map(theta % (TWO_PI/13), 0, TWO_PI, 0, 255);//13ths
  c14 = map(theta % (TWO_PI/14), 0, TWO_PI, 0, 255);//14ths
  c15 = map(theta % (TWO_PI/15), 0, TWO_PI, 0, 255);//15ths
  c16 = map(theta % (TWO_PI/16), 0, TWO_PI, 0, 255);//16ths
  
   x = cos(theta) * radius + originX;
  x2 = cos(theta) * (radius*1.8) + originX;
  x3 = cos(theta) * (radius*3) + originX;
  x4 = cos(theta) * (radius*4.45) + originX;
  x5 = cos(theta) * (radius*6) + originX;

  y = sin(theta) * radius + originY;
  y2 = sin(theta) * (radius*2) + originY;
  y3 = sin(theta) * (radius*3) + originY;
  y4 = sin(theta) * (radius*4) + originY;
  y5 = sin(theta) * (radius*5) + originY;




  sendMasterOsc(bpm, r1, r2, r3, r4, r5, rb1, rb2, rb3, rb4, rb5);
  //sendRingsOsc(r1,r2,r3,r4,r5);/////////////////here
  prevFrameRate = frameRate;
  if (r1>16) {
    r1 =1;
  }
  if (r2>16) {
    r2 =1;
  }
  if (r3>16) {
    r3 =1;
  }
  if (r4>16) {
    r4 =1;
  }
  if (r5>16) {
    r5 =1;
  }
}

void sendMasterOsc(float x, int v, int w, int xx, int y, int z, int rbb1, int rbb2, int rbb3, int rbb4, int rbb5)
{
  OscMessage myMessage = new OscMessage("/bpm");
  //info messages
  myMessage.add(x);
  myMessage.add(v);
  myMessage.add(w);
  myMessage.add(xx);
  myMessage.add(y);
  myMessage.add(z);

  //gate messages
  myMessage.add(rbb1);
  myMessage.add(rbb2);
  myMessage.add(rbb3);
  myMessage.add(rbb4);
  myMessage.add(rbb5);
  oscP5.send(myMessage, myRemoteLocation);
}

/*void sendRingsOsc(int v,int w, int x, int y,int z)
 {
 OscMessage myMessage = new OscMessage("/bpm");
 myMessage.add(v);
 myMessage.add(w);
 myMessage.add(x);
 myMessage.add(y);
 myMessage.add(z);
 oscP5.send(myMessage, myRemoteLocation);
 }
 */
void updateb1(int x, int y) {

  if ( overb1(b1X, b1Y, b1S, b1S) ) {
    b1Over = true;
    b2Over = false;
    b3Over = false;
    b4Over = false;
    b5Over = false;
    ring5Over = false;
  } else {
    b1Over = false;
  }
}

void updateb2(int x, int y) {

  if ( overb2(b2X, b2Y, b2S, b2S) ) {
    b2Over = true;
    b1Over = false;
    b3Over = false;
    b4Over = false;
    b5Over = false;
    ring5Over = false;
  } else {
    b2Over = false;
  }
}

void updateb3(int x, int y) {

  if ( overb3(b3X, b3Y, b3S, b3S) ) {
    b3Over = true;
    b1Over = false;
    b2Over = false;
    b4Over = false;
    b5Over = false;
    ring5Over = false;
  } else {
    b3Over = false;
  }
}

void updateb4(int x, int y) {

  if ( overb4(b4X, b4Y, b4S, b4S) ) {
    b4Over = true;
    b1Over = false;
    b3Over = false;
    b2Over = false;
    b5Over = false;
    ring5Over = false;
  } else {
    b4Over = false;
  }
}

void updateb5(int x, int y) {

  if ( overb5(b5X, b5Y, b5S, b5S) ) {
    b5Over = true;
    b1Over = false;
    b3Over = false;
    b4Over = false;
    b2Over = false;
  } else {
    b5Over = false;
  }
}

void updateRing5(int x, int y) {

  if ( overRing5(ring5X, ring5Y, ring5Sx, ring5Sy) ) {
    ring5Over = true;
    ring1Over = false;
    ring2Over = false;
    ring3Over = false;
    ring4Over = false;
  } else {
    ring5Over = false;
  }
}
void updateRing4(int x, int y) {

  if ( overRing4(ring4X, ring4Y, ring4Sx, ring4Sy) ) {
    ring4Over = true;
    ring1Over = false;
    ring2Over = false;
    ring3Over = false;
    ring5Over = false;
  } else {
    ring4Over = false;
  }
}
void updateRing3(int x, int y) {

  if ( overRing3(ring3X, ring3Y, ring3Sx, ring3Sy) ) {
    ring3Over = true;
    ring1Over = false;
    ring2Over = false;
    ring4Over = false;
    ring5Over = false;
  } else {
    ring3Over = false;
  }
}
void updateRing2(int x, int y) {

  if ( overRing2(ring2X, ring2Y, ring2Sx, ring2Sy) ) {
    ring2Over = true;
    ring1Over = false;
    ring3Over = false;
    ring4Over = false;
    ring5Over = false;
  } else {
    ring2Over = false;
  }
}
void updateRing1(int x, int y) {

  if ( overRing1(ring1X, ring1Y, ring1Sx, ring1Sy) ) {
    ring1Over = true;
    ring2Over = false;
    ring3Over = false;
    ring4Over = false;
    ring5Over = false;
  } else {
    ring1Over = false;
  }
}

//bpm
void updateBpm(int x, int y) {

  if ( overBpm(BpmX, BpmY, BpmS, BpmS) ) {
    BpmOver = true;
    b1Over = false;
    b3Over = false;
    b4Over = false;
    b2Over = false;
    b5Over = false;
  } else {
    BpmOver = false;
  }
}
//void mouseReleased() {
//framesPerBeat = 0;
//]
void mousePressed() { //actions for buttons
  if (b1Over) {
    //add one to r1(b1)
    r1 = r1+ 1;
  }

  if (b2Over) {
    //add one to r2(b2)
    r2 = r2+ 1;
  }

  if (b3Over) {
    //add one to r3(b3)
    r3 = r3+ 1;
  }

  if (b4Over) {
    //add one to r4(b4)
    r4 = r4+ 1;
  }
  if (b5Over) {
    //add one to r5(b5)
    r5 = r5+ 1;
  }
  if (BpmOver) {
    //add one to bpm
    bpm = bpm + 1;
  }
  //loop();
}

boolean overb1(int x, int y, int width, int height) {
  if (mouseX >= x && mouseX <= x+width && 
    mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

boolean overb2(int x, int y, int width, int height) {
  if (mouseX >= x && mouseX <= x+width && 
    mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

boolean overb3(int x, int y, int width, int height) {
  if (mouseX >= x && mouseX <= x+width && 
    mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

boolean overb4(int x, int y, int width, int height) {
  if (mouseX >= x && mouseX <= x+width && 
    mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

boolean overb5(int x, int y, int width, int height) {
  if (mouseX >= x && mouseX <= x+width && 
    mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

boolean overBpm(int x, int y, int width, int height) {
  if (mouseX >= x && mouseX <= x+width && 
    mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

boolean overRing5(float x, float y, float width, float height) {
  if (mouseX >= x && mouseX <= x+width && 
    mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}
boolean overRing4(float x, float y, float width, float height) {
  if (mouseX >= x && mouseX <= x+width && 
    mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}
boolean overRing3(float x, float y, float width, float height) {
  if (mouseX >= x && mouseX <= x+width && 
    mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}
boolean overRing2(float x, float y, float width, float height) {
  if (mouseX >= x && mouseX <= x+width && 
    mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}
boolean overRing1(float x, float y, float width, float height) {
  if (mouseX >= x && mouseX <= x+width && 
    mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}