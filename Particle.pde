class Particle
{
  PVector[] history;
  int len;
  float alpha_span;
  float noise_valueX, noise_valueY, noise_valueZ;
  color body_color;
  
  Particle(int le)
  {
    noise_valueX = random(100);
    noise_valueY = random(100);
    noise_valueZ = random(100);
    body_color = color(random(255), 255, 255);
    len = le;
    alpha_span = 360 / len;
    history = new PVector[len];
    for(int i = 0; i < history.length; i++)
    {
      history[i] = new PVector(0, 0, 0);
    }
  }
  
  void update()
  {
    float x = history[0].x  + map(noise(noise_valueX), 0, 1, -10, 10);
    float y = history[0].y  + map(noise(noise_valueY), 0, 1, -10, 10);
    float z = history[0].z  + map(noise(noise_valueZ), 0, 1, -10, 10);
    
    PVector location = new PVector(x, y, z);
    if(PVector.dist(new PVector(0, 0, 0), location) > 512)
    {
      location = new PVector(0, 0, 0);
    }
    
    for(int i = history.length - 1; i > 0; i--)
    {
      history[i] = history[i - 1].copy();
    }
    history[0] = location.copy();
    
    noise_valueX += 0.05;
    noise_valueY += 0.05;
    noise_valueZ += 0.05;   
  }
  
  void display()
  {
    for(int i = history.length - 1; i >= 0; i--)
    {
      pushMatrix();
      translate(history[i].x, history[i].y, history[i].z);
      
      if(i == 0)
      {
        noStroke();
        fill(body_color, 256 - i * alpha_span);
        sphere(7);
      }else
      {
         PVector direction = PVector.sub(history[i], history[i - 1]);
         direction.normalize();
         rotateX(direction.heading());
         
         stroke(body_color, 256 - i * alpha_span);
         strokeWeight(2);
         noFill();
         ellipse(0, 0, len - i, len - i);
      }
      
      popMatrix();
    }
  }
}