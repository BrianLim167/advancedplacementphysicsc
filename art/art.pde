PImage img;
PImage img2;

void setup() {
  size(1920, 1080);
  img = loadImage("physicists.jpg");
  img2 = loadImage("colors.jpg");
  img2.resize(700,700);
  imageMode(CENTER);
  noStroke();
  background(255);
  frameRate(480);
}

void draw() { 
  int i = 0;
  while (i <= 25) {
    drawPoint();
    i = i +1;
  }
}

void drawPoint() {
  int x = int(random(img.width));
  int y = int(random(img.height));
  color pix = img.get(x, y);

  float value = brightness (pix);
  int i = round( map (value, 0, 255, 0, 700*700-1) );
  //color c2 = img2.pixels[i];
  color c2 = color(red(pix) + random(50) - 25, green(pix) + random(50) - 25, blue(pix) + random(50) - 25);

  fill(c2);
  rect(x, y, random(30), random(30));
}