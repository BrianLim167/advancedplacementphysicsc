import processing.video.*;
PImage img;
PImage img2;
boolean takingPic;
boolean titleScreen;
int W, L;
boolean def;
Capture cam;

void setup() {
  fullScreen();
  //size(1920, 1080);
  cam = new Capture(this, 1920, 1080);
  cam.start();
  takingPic = false;
  titleScreen = true;
  String str = Integer.toString((int)Math.random() * 20 +1);
  img2 = loadImage(str + ".png");
  W = 30;
  L = 30; 
  def = false;
  noStroke();
  frameRate(60);
}

void draw() {
  if(titleScreen){
    titleScreen();
  }
  
  if (takingPic && cam.available()) {
    cam.read();
    image(cam, 0, 0, 2560, 1440);
  }
  
  if(!takingPic && !titleScreen){
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
  color c2;
  if(def){
    c2 = pix;
  }
  else{
    c2 = img2.pixels[i];
  }
  fill(c2, 128);
  rect(x, y, random(5,W), random(5,L));
}

void keyReleased(){
  if(key == CODED){
    if(keyCode == UP){
      W += 5;
      L += 5;
    }
    if(keyCode == DOWN){
      W -= 5;
      L -= 5;
    }
  }
  if(key == 'w'){
    def = false;
    clear();
    background(255);
    takePic();
    if(!takingPic){
      String str = Integer.toString((int)(Math.random() * 20) +1);
      img2 = loadImage(str + ".png");
    }
  }
  if(key == 's'){
    def = false;
    clear();
    stroke(0);
    background(255);
    takePic();
    if(!takingPic){
      String str = Integer.toString((int)(Math.random() * 20) +1);
      img2 = loadImage(str + ".png");
    }
  }
  if(key == 'd'){
    if(Math.random() < 0.5){
      stroke(0);
    }
    else{
      noStroke();
    }
    def = true;
    clear();
    background(255);
    takePic();
  }
  if(key == ' '){
    titleScreen = false;
    takingPic = true;
  }
}

void takePic(){
  clear();
  cam.read();
  image(cam, 0, 0, 2560, 1440);
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
  background(0);
  textAlign(CENTER);
  textSize(100);
  fill(255,0,0);
  text("Monetize", width/2, height/2 - 200);
  text("Press W for watercolor", width/2, height/2 - 100);
  text("Press S for stained glass", width/2, height/2);
  text("Press D for default colors and random style", width/2, height/2 + 100);
  text("Press up and down arrow keys to blur/focus", width/2, height/2 + 200);
  text("Press space to continue", width/2, height/2 + 300);
}