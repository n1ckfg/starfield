class Seeker {

  PVector p;
  PVector pp;
  PVector t;
  float s;
  float scaler;
  PVector speed;
  float spread;
  
  Seeker() {
    p = new PVector(width/2, height/2);
    pp = p;
    t = new PVector(random(width), random(height));
    speed = new PVector(random(0.025, 0.1), random(0.025, 0.1));
    scaler = random(2, 5);
    spread = random(1, 3);
  }
  
  void update() {
    p.x = lerp(p.x, t.x, speed.x);
    p.y = lerp(p.y, t.y, speed.y);
    if (p.x < t.x + spread && p.x > t.x - spread && p.y < t.y + spread && p.y > t.y - spread) t = new PVector(random(width), random(height));
    s = dist(p.x, p.y, pp.x, pp.y) * scaler;  
    pp = new PVector(p.x, p.y);
  }
  
  void draw() {
    fill(0);
    ellipse(p.x, p.y, s, s);
  }
  
  void run() {
    update();
    draw();
  }
  
}