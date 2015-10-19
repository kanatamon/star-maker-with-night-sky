public class Star extends LivingEntity  {
  
  public float x;
  public float y;
  public float radius;
  public float emissionRadius;
  
  //private float t;
  //private float age;
  //private float delay;
  //private LivingState life;

  public Star(float _x, float _y, float _radius,float _emissionRadius){
    super();
    
    x = _x;
    y = _y;
    radius = _radius;
    emissionRadius = _emissionRadius;
  }
  
  public void display(){ 
    float curEmissionRadius = noise(t) * (emissionRadius - radius) + radius;
    
    noStroke();
    ellipseMode(CENTER);
    
    // draw effect
    for(int i = (int)radius; i < (int)curEmissionRadius; i++){
      float alpha = (curEmissionRadius - i) / curEmissionRadius * 10;
      
      fill(199,246,231,alpha * lifeFactor);
      ellipse(x,y,i,i);
    }
    
    // draw the star
    fill(199,246,231, 255 * lifeFactor);
    ellipse(x,y,radius,radius);
  }
  
}