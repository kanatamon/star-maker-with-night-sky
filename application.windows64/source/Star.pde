public class Star{
  
  public float x;
  public float y;
  public float radius;
  public float emissionRadius;
  
  private float t;
  private float age;
  private float delay;
  private LivingState life;

  public Star(float _x, float _y, float _radius,float _emissionRadius){
    x = _x;
    y = _y;
    radius = _radius;
    emissionRadius = _emissionRadius;
    
    t = 0.0f;
    
    age = millis();
    life = LivingState.Birth;
    delay = random(4000f,6000f);
  }
  
  public void update(){
    if(life == LivingState.Birth){
      life = millis() - age > delay ? LivingState.Life : LivingState.Birth;
    }
     
  }
  
  public void display(){ 
    float lifeFac = 1f;
    
    if(life == LivingState.Birth){
      lifeFac = (millis() - age) / delay;
    }
    
    if(life == LivingState.Death){
      lifeFac = 1f - ((millis() - age) / delay);
    }
    
    t += 0.01f;
    float curEmissionRadius = noise(t) * (emissionRadius - radius) + radius;
    
    noStroke();
    ellipseMode(CENTER);
    
    // draw effect
    for(int i = (int)radius; i < (int)curEmissionRadius; i++){
      float alpha = (curEmissionRadius - i) / curEmissionRadius * 10;
      
      fill(199,246,231,alpha * lifeFac);
      ellipse(x,y,i,i);
    }
    
    // draw the star
    fill(199,246,231, 255 * lifeFac);
    ellipse(x,y,radius,radius);
  }
  
  public void dead(){
    if(life == LivingState.Death)
      return;
      
    life = LivingState.Death;
    age = millis();
    delay = random(4000f,6000f);
  }
  
   public boolean isDead(){
     if(life == LivingState.Death)
       return millis() - age > delay;
     
     return false;
  }

}