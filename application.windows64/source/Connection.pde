class Connection{
  Star star_1;
  Star star_2;
  
  private float lineSize;
  private float t;
  private float age;
  private LivingState life;
  private float delay;
  
  public Connection(Star _star_1, Star _star_2){
    star_1 = _star_1;
    star_2 = _star_2;
    
    lineSize = (star_1.radius + star_1.radius) / 4.0f;
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
    
    println(life);
    println(lifeFac);
    // update
    t += 0.01f;
    float alpha = noise(t) * 100;
    float currentLineSize = noise(t) * lineSize;
    
    stroke(255,255,255, alpha * lifeFac);
    strokeWeight(currentLineSize);
    
    line(star_1.x, star_1.y, star_2.x, star_2.y );
  }
  
  public boolean hasConnectionWith(Star aStar){
    return aStar.equals(star_1) || aStar.equals(star_2);
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