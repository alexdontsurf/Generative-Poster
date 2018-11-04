// imágrenes ordenadas y cargadas //<>//
PImage[] facadeImages, streetImages, roofImages;

int anchoPagina = 595;
int altoPagina = 842;

//posiciones de la cuadrícula
int[][] p = {{0, 0}, {anchoPagina/2, 0}, {0, altoPagina/3}, {anchoPagina/2, altoPagina/3}, {0, altoPagina/3*2}, {anchoPagina/2, altoPagina/3*2}};

// 
String[] textos = {"27è\nMercat de\nLa Volta", "Disseny de\nproducte i\nartesania\ndigital", "20 i 23 desembre\n10-20 h.\n \nPlaça Assumpció\nSt Narcís Girona"};

// 1 - roof ; 2 - facade ; 3 - street
int[] tipo1 = {1, 1, 2, 2, 2, 2};
int[] tipo2 = {2, 2, 2, 2, 2, 2};
int[] tipo3 = {2, 2, 2, 2, 3, 3};

// 1 - pinta texto ; 0 - no pinta texto 
int[] ordenTextos = {1, 1, 1, 0, 0, 0};
int indexTextos = 0;

PFont miFuenteBold, miFuenteRegular;

// switcher
int cartel = 1;

void settings() {
  size(anchoPagina, altoPagina);
  pixelDensity(2);
}


void setup() {

  background(250);
  frameRate(1);
  
  miFuenteBold = createFont("HelveticaLTStd-Bold.otf", 40);
  miFuenteRegular = createFont("HelveticaLTStd-Roman.otf", 40);
  

  // Carga las imágenes
  File dirFacade = new File(sketchPath(""), "/facade");
  String[] facadeContents = dirFacade.list();
  facadeImages = new PImage[facadeContents.length];
  for (int i = 0; i < facadeContents.length; i++) {
    if (facadeContents[i].charAt(0) == '.') continue;
    File childFile = new File(dirFacade, facadeContents[i]);        
    facadeImages[i] = loadImage(childFile.getPath());
  }

  File dirRoof = new File(sketchPath(""), "/roof");
  String[] roofContents = dirRoof.list();
  roofImages = new PImage[roofContents.length];
  for (int i = 0; i < roofContents.length; i++) {
    if (roofContents[i].charAt(0) == '.') continue;
    File childFile = new File(dirRoof, roofContents[i]);        
    roofImages[i] = loadImage(childFile.getPath());
  }

  File dirStreet = new File(sketchPath(""), "/street");
  String[] streetContents = dirStreet.list();
  streetImages = new PImage[streetContents.length];
  for (int i = 0; i < streetContents.length; i++) {
    if (streetContents[i].charAt(0) == '.') continue;
    File childFile = new File(dirStreet, streetContents[i]);        
    streetImages[i] = loadImage(childFile.getPath());
  }

  println("roofImages: " + roofImages.length + " " + facadeImages.length + " " + streetImages.length);
}

void draw() {
  background(255);
  switch(cartel) {
  case 1:
    cartel(tipo1);
    break;
  case 2:
    cartel(tipo2);
    break;
  case 3:
    cartel(tipo3);
    break;
  }
}


void cartel (int[] tipo) {
  
  // cambia las posiciones dónde s epueden dibujar textos
  shuffleTexts();

  // 
  for (int bloqueCartel = 0; bloqueCartel <= 5; bloqueCartel ++) {
    // para definir rangos diferentes podría hacer un [][] de rangos  
    // random num imágenes por bloque
    int ni = (int)random(1, 1);

    //scale random
    int xs = (int)random(0, 60);
    int ys = (int)random(0, 30);

    //rotation random
    int xr = (int)random(0, 60);
    int yr = (int)random(0, 30);

    //render at position
    //int xImg = p[bloqueCartel][0] + (int)random(0, 60);
    //int yImg = p[bloqueCartel][1] + (int)random(0, 30);
    int x = p[bloqueCartel][0];
    int y = p[bloqueCartel][1];



    for (int i = 0; i < ni; i ++) {
      pushMatrix();
      //type image
      // roof
      if (tipo[bloqueCartel] == 1) {
        image(roofImages[(int) random(roofImages.length)], x, y);
      }
      // facade
      else if (tipo[bloqueCartel] == 2) {
        image(facadeImages[(int) random(facadeImages.length)], x, y);
      }
      // street
      else if (tipo[bloqueCartel] == 3) {
        image(streetImages[(int) random(streetImages.length)], x, y);
      }

      popMatrix();
    }
    
    // dibuja texto si 
    if (ordenTextos[bloqueCartel] == 1) {
      fill(0);
      if (indexTextos == 0 || indexTextos == 1) {
        textFont(miFuenteBold, 34);
      } else {
        textFont(miFuenteRegular, 22);
      }
      float randomOffsetX = random(50, 100);
      float randomOffsetY = random(50, 150);
      rect(x + randomOffsetX , y + randomOffsetY - textAscent() - 15, 100, 3);
      text(textos[indexTextos], x + randomOffsetX, y + randomOffsetY);
      indexTextos ++;
    } else {
    }
  }

  indexTextos = 0;
}


void shuffleTexts() {
  IntList il = new IntList(ordenTextos);
  il.shuffle();
  ordenTextos = il.array();
}


void keyPressed() {
  cartel += 1;
  if (cartel > 3) cartel = 1;
}

//void keyPressed() {
//  if (key == '1') cartel(tipo1);
//  if (key == '2') cartel(tipo2);
//  if (key == '3') cartel(tipo3);
//}