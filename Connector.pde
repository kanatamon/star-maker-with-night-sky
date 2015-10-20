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
    float dirStar1to2X = (star_2.x - star_1.x) / m;
    float dirStar1to2Y = (star_2.y - star_1.y) / m;
    
    // calculate related life factor
    //float relatedLifeFactor = (star_1.getLifeFactor() + star_2.getLifeFactor()) / 2f; 
    float relatedLifeFactor1 = star_1.getLifeFactor();
    float relatedLifeFactor2 = star_2.getLifeFactor();
    
    if(star_1.getLifeFactor() + star_2.getLifeFactor() == 1f){
      println("Collised");
    }
    
    // calculate desired point
    //float curStar1X =  (1f - star_1.getLifeFactor()) * m * dirStar1to2X + star_1.x;
    //float curStar1Y =  (1f - star_1.getLifeFactor()) * m * dirStar1to2Y + star_1.y;
    
    //float curStar2X =  star_2.getLifeFactor() * m * dirStar1to2X + star_1.x;
    //float curStar2Y =  star_2.getLifeFactor() * m * dirStar1to2Y + star_1.y;
    float curStar1X =  (1f - lifeFactor) * m * dirStar1to2X + star_1.x;
    float curStar1Y =  (1f - lifeFactor) * m * dirStar1to2Y + star_1.y;
    
    float curStar2X =  lifeFactor * m * dirStar1to2X + star_1.x;
    float curStar2Y =  lifeFactor * m * dirStar1to2Y + star_1.y;
    
    // update
    float alpha = noise(t) * 100;
    float currentLineSize = noise(t) * lineSize;
    
    stroke(255,255,255, alpha * lifeFactor);
    strokeWeight(currentLineSize);
    
    //line(star_1.x, star_1.y, star_2.x, star_2.y );
    line(curStar1X, curStar1Y, curStar2X, curStar2Y);
  }
  
  public boolean hasConnectedWith(Star aStar){
    return aStar.equals(star_1) || aStar.equals(star_2);
  }
  
}