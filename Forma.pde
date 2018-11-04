class Forma { 
  
  float posX;
  float posY;
  float radius;
  float angleRotate;
  int sides; 
  
  void display(float tempPosX, float tempPosY, float tempradius, float tempAngleRotate, int tempsides){
    //  Los argumentos asignados son temporales y 
    posX = tempPosX;  
    posY = tempPosY;
    radius = tempradius;
    sides = tempsides;
    angleRotate = tempAngleRotate;
    
    //  Las transformaciones dentro entre push y pop Matrix()
    //  solo afectarán a los objetos que estén entre estas dos funciones
    pushMatrix(); 
    //  Traslada el objeto a la posición (x, y) asignada
    translate(posX, posY);
    //  Rota el objeto en función del ángulo asignado
    rotate(radians(angleRotate));
    float angle = TWO_PI/sides;
    stroke(250,80);
    noFill();
    beginShape();
    
    //  
    for (int i = 0; i <= sides; i++) {
       float xShape = 0 + cos(angle * i) * radius;
       float yShape = 0 + sin(angle * i) * radius;
       vertex(xShape, yShape);
    }
    
    endShape();
    popMatrix();
  }
}