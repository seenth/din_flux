import processing.pdf.*;
import geomerative.*;
boolean record;
RFont font;
RGroup myGroup;
RPoint[] myPoints;
Walker[] w;
String myText = "explore";
float counter = 0;
void setup () {
  fullScreen();
  colorMode(HSB);
  smooth();
  frameRate(24);
  textAlign(LEFT);
  RG.init(this); 
  font = new RFont("DIN Alternate Bold.ttf", 350, CENTER);
  RCommand.setSegmentLength(10);
  RCommand.setSegmentator(RCommand.UNIFORMLENGTH);
  myGroup = font.toGroup(myText);
  myPoints = myGroup.getPoints();
  
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
  translate(width/2.1, height/1.6);
  background(0);
  
  if (myText.length() > 0) {
    RGroup myGroup = font.toGroup(myText); 
    myGroup = myGroup.toPolygonGroup();
    RPoint[] myPoints = myGroup.getPoints(); 
  
  for (int i=0; i<myPoints.length; i++) { 
    PVector geo = new PVector(myPoints[i].x, myPoints[i].y);
    PVector mouse = new PVector(mouseX-width/2.2, mouseY-height/1.3);
    w[i].step();
   // w[i].display();
    w[i].seek(geo);
    w[i].flee(mouse);
    
    for (int j = 0; j < myPoints.length; j++) {
      if (i > j) { // " if (i > j)" => to check one time distance between two stars
        float d = myPoints[i].dist(myPoints[j]); // Distance between two stars
        if (d <= width / 49) { // if d is less than width/10 px, we draw a line between the two stars
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
  saveFrame("name/name_####.png");
  if (record) {
    endRecord();
  record = false;
  }
}

void mousePressed() {
   record = true;
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

void timer() {
  
  counter ++;
  
  if(counter == 100) {
    myText = " ";
    myText = "design";
  }
  if(counter == 220) {
    myText = " ";
    myText = "think";
  }
  if(counter == 350) {
    myText = " ";
    myText = "play";
    
  }
  if(counter == 470) {
    myText = " ";
    myText = "explore";
    counter = 0;
  }
}