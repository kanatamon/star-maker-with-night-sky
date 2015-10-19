class LivingEntity implements ITimeable {
  protected float t;
  protected float age;
  protected LivingState life;
  protected float delay;
  protected float lifeFactor;
  
  public LivingEntity(){
    t = 0.0f;
    age = millis();
    life = LivingState.Birth;
    delay = random(4000f,6000f);
    lifeFactor = 1f;
  }
  
  public void update(){
    lifeFactor = 1f;
    
    if(life == LivingState.Birth){
      life = millis() - age > delay ? LivingState.Life : LivingState.Birth;
    }
    
    if(life == LivingState.Birth){
      lifeFactor = (millis() - age) / delay;
    }
    else if(life == LivingState.Death){
      lifeFactor = 1f - ((millis() - age) / delay);
    }
    
    t += 0.01f;
  }
  
  public void display(){
  
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