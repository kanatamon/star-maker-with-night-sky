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
    // vector operation
    float m = dist(star_1.x, star_1.y, star_2.x, star_2.y);
    
    float startX = 0f;
    float startY = 0f;
    float endX = 0f;
    float endY = 0f;
    
    // select start point and calculate end point
    if(star_1.getLifeFactor() <= star_2.getLifeFactor()){
      
      float dirX = (star_2.x - star_1.x) / m;
      float dirY = (star_2.y - star_1.y) / m;
      
      startX = star_1.x;
      startY = star_1.y;
      endX = dirX * m * lifeFactor + star_1.x;
      endY = dirY * m * lifeFactor + star_1.y;
    } else {
      
      float dirX = (star_1.x - star_2.x) / m;
      float dirY = (star_1.y - star_2.y) / m;
      
      startX = star_2.x;
      startY = star_2.y;
      endX = dirX * m * lifeFactor + star_2.x;
      endY = dirY * m * lifeFactor + star_2.y;
    }
    
    // update
    float alpha = noise(t) * 100;
    float currentLineSize = noise(t) * lineSize;
    
    stroke(255,255,255, alpha * lifeFactor);
    strokeWeight(currentLineSize * lifeFactor);
    
    //line(star_1.x, star_1.y, star_2.x, star_2.y );
    line(startX, startY, endX, endY);
  }
  
  public boolean hasConnectedWith(Star aStar){
    return aStar.equals(star_1) || aStar.equals(star_2);
  }
  
}