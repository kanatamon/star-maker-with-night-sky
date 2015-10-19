class Connector extends LivingEntity {
  Star star_1;
  Star star_2;
  
  private float lineSize;
 
  public Connector(Star _star_1, Star _star_2){
    super();
    
    star_1 = _star_1;
    star_2 = _star_2;
    
    lineSize = (star_1.radius + star_1.radius) / 4.0f;
  }

  public void display(){
    // update
    float alpha = noise(t) * 100;
    float currentLineSize = noise(t) * lineSize;
    
    stroke(255,255,255, alpha * lifeFactor);
    strokeWeight(currentLineSize);
    
    line(star_1.x, star_1.y, star_2.x, star_2.y );
  }
  
  public boolean hasConnectedWith(Star aStar){
    return aStar.equals(star_1) || aStar.equals(star_2);
  }
  
}