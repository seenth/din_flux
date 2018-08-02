import processing.pdf.*;
import geomerative.*;
import org.openkinect.freenect.*;
import org.openkinect.processing.*;

//Kinect Stuff
KinectTracker tracker;
Kinect kinect;

boolean record;

//Geomerative Stuff
RFont font;
RGroup myGroup;
RPoint[] myPoints;
String myText = "ae";
float counter = 0;
//Physics Class
Walker[] w;

void setup () {
  fullScreen();
  colorMode(HSB);
  smooth();
  frameRate(24);
  //Initialize Kinect
  kinect = new Kinect(this);
  tracker = new KinectTracker();
  
  //Initialize Geomerative
  RG.init(this); 
  font = new RFont("DIN Alternate Bold.ttf", 750, CENTER);
  RCommand.setSegmentLength(28);
  RCommand.setSegmentator(RCommand.UNIFORMLENGTH);
  myGroup = font.toGroup(myText);
  myPoints = myGroup.getPoints();
  
  //Setup Walkers for every Geomerative Point
  w = new Walker[myPoints.length]; 
  for (int i=0; i<myPoints.length; i++) {
    w[i] = new Walker(new PVector(myPoints[i].x, myPoints[i].y));
  }
}

void draw() {
  if (record) {
    // Note that #### will be replaced with the frame number. Fancy!
    beginRecord(PDF, "frame-####.pdf"); 
  }
  background(0);
  
//----------kinectTracking-----------------------------------
  tracker.track();
  // Show the image
  tracker.display();  
   
  // Let's draw the "lerped" location
  PVector v2 = tracker.getLerpedPos();
  float xPos = map(v2.x, 0, 640, 0, displayWidth);
  float yPos = map(v2.y, 0, 640, 0, displayWidth);
  fill(100, 250, 50, 200);
  noStroke();
  ellipse(xPos, yPos, 20, 20);
  
  translate(width/2.6, height/1.3);

//----------Geomerative-----------------------------------
  if (myText.length() > 0) {
    RGroup myGroup = font.toGroup(myText); 
    myGroup = myGroup.toPolygonGroup();
    RPoint[] myPoints = myGroup.getPoints(); 
  
  //Nested for loop to draw lines between one another
  for (int i=0; i<myPoints.length; i++) { 
    PVector geo = new PVector(myPoints[i].x, myPoints[i].y);
    PVector mouse = new PVector(xPos-width/2.6, yPos-height/1.3);
    w[i].step();
   //w[i].display();
    w[i].seek(geo);
    w[i].flee(mouse);
    
    for (int j = 0; j < myPoints.length; j++) {
      if (i > j) { // " if (i > j)" => to check one time distance between points
        float d = myPoints[i].dist(myPoints[j]); // Distance between points
        if (d <= width / 13.8) { // if d is less than width/10 px, we draw a line between points
          noFill();
          stroke(255, 120); 
          strokeWeight(1);
          line(w[i].loc.x, w[i].loc.y, w[j].loc.x, w[j].loc.y);
          
        }
      }
    }
  
  }
  }
  timer();
  println(counter);
  //saveFrame("output/sept19_####.png");
  if (record) {
    endRecord();
  record = false;
  }
}

void mousePressed() {
   record = true;
}
  
void timer() {
  
  counter ++;
  
  if(counter == 300) {
    myText = " ";
    myText = "A";
  }
  if(counter == 600) {
    myText = " ";
    myText = "B";
  }
  if(counter == 900) {
    myText = " ";
    myText = "C";
  }
  if(counter == 1200) {
    myText = " ";
    myText = "D";
  }
  if(counter == 1500) {
    myText = " ";
    myText = "E";
  }
  if(counter == 1800) {
    myText = " ";
    myText = "F";
  }
  if(counter == 2100) {
    myText = " ";
    myText = "G";
  }
  if(counter == 2400) {
    myText = " ";
    myText = "H";
  }
  if(counter == 2700) {
    myText = " ";
    myText = "I";
  }
  if(counter == 3000) {
    myText = " ";
    myText = "J";
  }
  if(counter == 3300) {
    myText = " ";
    myText = "K";
  }
  if(counter == 3600) {
    myText = " ";
    myText = "L";
  }
  if(counter == 3900) {
    myText = " ";
    myText = "M";
  }
  if(counter == 4200) {
    myText = " ";
    myText = "N";
  }
  if(counter == 4500) {
    myText = " ";
    myText = "O";
  }
  if(counter == 4800) {
    myText = " ";
    myText = "P";
  }
  if(counter == 5100) {
    myText = " ";
    myText = "Q";
  }
  if(counter == 5400) {
    myText = " ";
    myText = "R";
  }
  if(counter == 5700) {
    myText = " ";
    myText = "S";
  }
  if(counter == 6000) {
    myText = " ";
    myText = "T";
  }
  if(counter == 6300) {
    myText = " ";
    myText = "U";
  }
  if(counter == 6600) {
    myText = " ";
    myText = "V";
  }
  if(counter == 6900) {
    myText = " ";
    myText = "W";
  }
  if(counter == 7200) {
    myText = " ";
    myText = "X";
  }
  if(counter == 7500) {
    myText = " ";
    myText = "Y";
  }
  if(counter == 7800) {
    myText = " ";
    myText = "Z";
  }
  if(counter == 8100) {
    counter = 0;
  }
}
void keyPressed() {
  
  if(key !=CODED) {
    myText = " ";
    switch(key) {
    case DELETE:
    case BACKSPACE:
      myText = myText.substring(0,max(0,myText.length()-1));
      break;
    case ENTER:
      break;
    default:
      myText +=key;
    }
  }
}  

/*void update(int x, int y) {
  if (overletter(startX, startY, startSizeX, startSizeY) ) {
    letterOver = true;
    
  } 
}

boolean overletter(int x, int y, int width, int height)  {
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}*/