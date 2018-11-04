//  Incluye librería para exportar en PDF
import processing.pdf.*;


//  Configuración de página
//  Tamaños en pixels
int anchoPagina = 595;
int altoPagina = 842;

//  Configuración baseline
float lineHeightBS = 12.027;
int totalLines =  altoPagina / (int) lineHeightBS;

//  Configuración márgenes
float margin = lineHeightBS * 2;

//  Variables para guardar PDF
boolean savePDF = false;
int counter = 0;

//  Número de diseños quieres guardar
int numCopias = 10;

//  Declara la variable PFont (variable para fuentes)
PFont miFuenteRegular;
PFont miFuenteBold;

// Textos 
//  "\n" es un carácter para un salto de línea
String titular = "Esto Es\nUn Titular";
String subtitulo = "Mi posición está subordinada\na la posición del titular : )";
String texto1 = "Mi posX está restringida a la mitad de la página y mi posición Y a la mitad de la atura";
String texto2 = "Mi posX está restringida a la mitad de la página y mi posición Y a la mitad de la atura";

//  Formas
//  Determina la dimensión del array
Forma [] misFormas = new Forma[15];

void settings() {
  //  Determina el tamaño del sketch
  size(anchoPagina, altoPagina);
  
  //  Si trabajas en retina: 
  //  pixelDensity(2) multiplica los pixeles del sketch x2 para verlos correctamente
  pixelDensity(2);
}


void setup() {
  
  //  Especifica el número de frames por segundo
  //  Cuántos más frames más rápido irá el sketch
  frameRate(1);
  
  //  CREAR UNA FUENTE
  //  En la carpeta del sketch crea una nueva carpeta y llámala data
  //  Aquí pondremos todos los recuerso externos (tipografías, audios, videos imágenes)
  //  Los archivos tipográficos compatibles son .ttf o .otf
  //  Crea tu fuente escribiendo: createFont("nombre del archivo", tamaño, true si quieres antialiasing)
  //  El tamaño puede cambiarse más adelante para cada caso
  miFuenteRegular = createFont("TradeGothicLTStd-Extended.otf", 40, true); 
  miFuenteBold = createFont("TradeGothicLTStd-BoldExt.otf", 40, true); 

  for (int i = 0; i < misFormas.length; i ++){
    misFormas[i] = new Forma();
  }
}



void draw() {
  //  Cuenta cuántas copias
  //  Para de guardar cuando llega al número indicado
  //  Tiene que ir en primer lugar
  contadorCopias();
  
  // Guarda PDF mientras savePDF sea verdadera
  if(savePDF == true) {
    beginRecord(PDF, "miNombre_###" + ".pdf");
    println("Copia", frameCount);
  }
  
  background(10); 
  
  //  FORMAS
  //  Asigna un valor a los argumentos de cada objetos
  //  Argumentos: (float tempPosX, float tempPosY, float tempradius, float tempAngleRotate, int tempsides)
  for (int i = 0; i < misFormas.length; i ++){
    misFormas[i].display(random(0, width), random(0, height), random(10, 250), random(360), (int) random(3, 10));
  }
 
 
  //  TEXTOS
  //  Asigna un valor a los argumentos de cada texto
  //  Argumentos: (String mensaje, float lineHeight, float posicionX, float posicionY, float anchoCaja, float altoCaja)
  textFont(miFuenteRegular, 14.024);
  dibujaTexto(texto1, lineHeightBS * 2, random(width/2, width*0.6), lineHeightBS * ((int)random(44,totalLines - 7)), 190, 90);
  dibujaTexto(texto2, lineHeightBS * 2, random(margin, width*0.17), lineHeightBS * ((int)random(44,totalLines - 7)), 190, 90);  
  
  
  //  Para dar a dos textos un mismo argumento aleatorio es necesario definir el argumento fuera del objeto
  float titularPosX = random(margin, width * 0.4);
  float titularPosY = lineHeightBS*((int)random(6,29));
  textFont(miFuenteBold, 55);
  dibujaTexto(titular, lineHeightBS * 5, titularPosX, titularPosY, 320, 120);
  textFont(miFuenteRegular, 20);
  dibujaTexto(subtitulo, lineHeightBS * 2.3, titularPosX, titularPosY + lineHeightBS * 11, 360, 60);
  
  
  //  Para de guardar PDF cuando savePDF sea Falsa
  if(savePDF == true) {
    endRecord();
  }
  
  //  Contador de copias (Iteraciones del draw())
  counter += 1;
}




//  Función para crear titulares
void dibujaTexto(String mensaje, float lineHeight, float posicionX, float posicionY, float anchoCaja, float altoCaja){
  
  textLeading(lineHeight);
  textAlign(LEFT);
  
  //  Dibuja las cajas de texto
  //  Comenta las siguientes lineas para ocultar las cajas
  rectMode(CORNER);
  noFill();
  stroke(180,0, 90);
  rect(posicionX, posicionY, anchoCaja, altoCaja);
  
  //  Dibuja el texto
  fill(255);
  text(mensaje, posicionX, posicionY, anchoCaja, altoCaja);
}




// Función para activar y desactivar el guardado en PDF
void contadorCopias(){
  if (counter < numCopias){
    savePDF = true;
  } else {
    savePDF = false;
  }
}