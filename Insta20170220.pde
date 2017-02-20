ArrayList<Particle> _particles;
float _angle;

void setup()
{
  size(512, 512, P3D);
  colorMode(HSB);
  frameRate(30);
  
  _particles = new ArrayList<Particle>();
  
  for(int i = 0; i < 64; i+= 1)
  {
    _particles.add(new Particle(24));
  }
}

void draw()
{
  background(0);
  
  translate(width / 2, height / 2, 0);
  
  _angle = (_angle + 0.5) % 360;
  float x = 512 * cos(radians(_angle));
  float z = 512 * sin(radians(_angle));

  camera(z, 0, x, 
         0.0, 0.0, 0.0, 
         0.0, 1.0, 0.0);

  for(Particle p : _particles)
  {
    p.update();
    p.display();
  }
  
  stroke(255);
  fill(128);
  box(20);
  
  println(frameCount);
  saveFrame("screen-#####.png");
  if(frameCount > 900)
  {
     exit();
  }
}