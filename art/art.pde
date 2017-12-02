import processing.video.*;
PImage img;
PImage img2;
boolean takingPic;
Capture cam;

void setup() {
  //fullScreen();
  size(1920, 1080);
  cam = new Capture(this, 1920, 1080);
  cam.start();
  takingPic = true;
  img2 = loadImage("colors.jpg");
  
  noStroke();
  background(255);
  frameRate(60);
}

void draw() {
  if (takingPic && cam.available()) {
    cam.read();
    image(cam, 0, 0);
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
  //int i = round( map (value, 0, 255, 0, 700*700-1) );
  int i = (int)(Math.random() * (img2.width*img2.height-1));
  color c2 = pix + i;
  //color c2 = img2.pixels[i];
  //color c2 = color(red(pix) + random(50) - 25, green(pix) + random(50) - 25, blue(pix) + random(50) - 25);
  fill(c2, 128);
  rect(x, y, random(5,30), random(5,30));
}

void keyReleased(){
  if(key == ' '){
    takePic();
    background(255);
  }
}

void takePic(){
  println("saved");
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