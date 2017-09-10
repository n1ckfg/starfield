// https://www.youtube.com/watch?v=17WoOqgXsRM

int numStars = 5000;
int speed = 10;
int alpha = 20;
int size = 16;

int numSeekers = 50;
Seeker[] seekers = new Seeker[numSeekers];

PShader bloom_apples;
float intensity = 0.00005;

Star[] stars = new Star[numStars];

void setup() {
  size(800, 600, P3D);
  smooth();
  
  bloom_apples = loadShader("bloom_apples.glsl");
  bloom_apples.set("intensity", intensity);
  
  for (int i=0; i < stars.length; i++) {
    stars[i] = new Star();
  }

  for (int i=0; i< seekers.length; i++) {
    seekers[i] = new Seeker();
  }
  
  background(0);
}

void draw() {
  fill(0, alpha);
  noStroke();
  rect(0, 0, width, height);
  
  pushMatrix();
  translate(width/2, height/2);
  for (int i=0; i < stars.length; i++) {
    stars[i].run();
  }
  popMatrix();
  
  for (int i=0; i<seekers.length; i++) {
    seekers[i].run();
  }
    
  filter(bloom_apples);
}

class Star {
  
  float x;
  float y;
  float z;
  float pz;
  
  Star() {
    init();
  }
  
  void init() {
    x = random(-width, width);
    y = random(-height, height);
    z = random(width);
    pz = z;
  }
  
  void update() {
    z -= speed;
    if (z < 1) {
      init();
    }
  }
  
  void draw() {
    float sx = map(x / z, 0, 1, 0, width);
    float sy = map(y / z, 0, 1, 0, height);
    float r = map(z, 0, width, size, 0);

    noStroke();
    fill(255, 127);
    ellipse(sx, sy, r, r);
    fill(255);
    ellipse(sx, sy, r/2, r/2);
    
    float px = map(x / pz, 0, 1, 0, width);
    float py = map(y / pz, 0, 1, 0, height);
    
    stroke(200, 200, 255, random(100, 127));
    line(px, py, sx, sy);
  }
  
  void run() {
    update();
    draw();
  }
  
}