import processing.video.*;
PImage img;
PImage img2;
Capture cam;

void setup() {
  size(1920, 1080);
  cam = new Capture(this, 1920, 1080);
  cam.start();
  
  noStroke();
  background(255);
  frameRate(60);
}

void draw() {
  if (cam.available() == true) {
    cam.read();
  }
  image(cam, 0, 0); 
}

void drawPoint() {
  int x = int(random(img.width));
  int y = int(random(img.height));
  color pix = img.get(x, y);

  float value = brightness (pix);
  int i = round( map (value, 0, 255, 0, 700*700-1) );
  //color c2 = img2.pixels[i];
  color c2 = color(red(pix) + random(50) - 25, green(pix) + random(50) - 25, blue(pix) + random(50) - 25);
  fill(c2, 128);
  rect(x, y, random(0,15), random(0,15));
}

void keyReleased(){
  if(key == ' '){
    takePic();
    //monetize();
  }
}

void takePic(){
  if (cam.available()) { 
    cam.read(); 
    image(cam, 0, 0);
    saveFrame("img.png");
    //img = loadImage("img.png");
  }
}

void monetize(){
  int i = 0;
  while (i <= 100) {
    drawPoint();
    i = i +1;
  }
}