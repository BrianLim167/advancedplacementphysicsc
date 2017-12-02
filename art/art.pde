import processing.video.*;
PImage img;
PImage img2;
boolean takingPic;
boolean titleScreen;
//HScrollbar hs1, hs2;
Capture cam;

void setup() {
  fullScreen();
  //size(1920, 1080);
  cam = new Capture(this, 1920, 1080);
  cam.start();
  takingPic = true;
  titleScreen = true;
  String str = Integer.toString((int)Math.random() * 20 +1);
  img2 = loadImage(str + ".png");
  
  //hs1 = new HScrollbar(width/2, height/2-20, 500, 30, 30);
  //hs2 = new HScrollbar(0, height/2+20, 0, 200, 400);
  noStroke();
  //stroke(0);
  //background(255);
  frameRate(60);
}

void draw() {
  //if(titleScreen){
  //  titleScreen();
  //}
  
  if (takingPic && cam.available()) {
    cam.read();
    image(cam, 0, 0, 2560, 1440);
  }
  
  if(!takingPic){
    monetize();
  }
}

void drawPoint() {
  int x = int(random(img.width));
  int y = int(random(img.height));
  color pix = img.get(x, y);

  float value = brightness (pix);
  int i = round( map (value, 0, 255, 0, img2.width*img2.height-1) );
  //int i = (int)(Math.random() * (img2.width*img2.height-1));
  //color c2 = pix + i;
  color c2 = img2.pixels[i];
  //color c2 = color(red(pix) + random(50) - 25, green(pix) + random(50) - 25, blue(pix) + random(50) - 25);
  fill(c2, 128);
  rect(x, y, random(5,30), random(5,30));
}

void keyReleased(){
  if(key == ' '){
    clear();
    takePic();
    background(255);
    if(!takingPic){
      String str = Integer.toString((int)Math.random() * 20 +1);
      img2 = loadImage(str + ".png");
    }
  }
}

void takePic(){
  saveFrame("img.png");
  img = loadImage("img.png");
  takingPic = false;
}

void monetize(){
  int i = 0;
  while (i <= 200) {
    drawPoint();
    i = i +1;
  }
} 

void titleScreen(){
  if(cam.available()){
    cam.read();
    //image(cam, 0, 0);
    //tint(255, 255);
    image(cam, 0, 0);
  }
  textAlign(CENTER);
  textSize(100);
  fill(255,0,0);
  text("Monetize", width/2, height/2 - 200);
  //hs1.update();
  //hs2.update();
  //hs1.display();
  //hs2.display();
}

class HScrollbar {
  int swidth, sheight;    // width and height of bar
  float xpos, ypos;       // x and y position of bar
  float spos, newspos;    // x position of slider
  float sposMin, sposMax; // max and min values of slider
  int loose;              // how loose/heavy
  boolean over;           // is the mouse over the slider?
  boolean locked;
  float ratio;

  HScrollbar (float xp, float yp, int sw, int sh, int l) {
    swidth = sw;
    sheight = sh;
    int widthtoheight = sw - sh;
    ratio = (float)sw / (float)widthtoheight;
    xpos = xp;
    ypos = yp-sheight/2;
    spos = xpos + swidth/2 - sheight/2;
    newspos = spos;
    sposMin = xpos;
    sposMax = xpos + swidth - sheight;
    loose = l;
  }

  void update() {
    if (overEvent()) {
      over = true;
    } else {
      over = false;
    }
    if (mousePressed && over) {
      locked = true;
    }
    if (!mousePressed) {
      locked = false;
    }
    if (locked) {
      newspos = constrain(mouseX-sheight/2, sposMin, sposMax);
    }
    if (abs(newspos - spos) > 1) {
      spos = spos + (newspos-spos)/loose;
    }
  }

  float constrain(float val, float minv, float maxv) {
    return min(max(val, minv), maxv);
  }

  boolean overEvent() {
    if (mouseX > xpos && mouseX < xpos+swidth &&
       mouseY > ypos && mouseY < ypos+sheight) {
      return true;
    } else {
      return false;
    }
  }

  void display() {
    noStroke();
    fill(204);
    rect(xpos, ypos, swidth, sheight);
    if (over || locked) {
      fill(0, 0, 0);
    } else {
      fill(102, 102, 102);
    }
    rect(spos, ypos, sheight, sheight);
  }

  float getPos() {
    // Convert spos to be values between
    // 0 and the total width of the scrollbar
    return spos * ratio;
  } 
}