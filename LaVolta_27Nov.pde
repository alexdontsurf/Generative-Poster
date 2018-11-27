// Tamaño Cartel
int anchoPagina = 3508;
int altoPagina = 4960;

// Posiciones celdas de la cuadrícula 2x3
int[][] p = {{0, 0}, {anchoPagina/2, 0}, {0, altoPagina/3}, {anchoPagina/2, altoPagina/3}, {0, altoPagina/3*2}, {anchoPagina/2, altoPagina/3*2}};

// imágrenes ordenadas y cargadas
PImage[] bajosGallery, mediosGallery, tejadosGallery;
PImage[] copy = new PImage[5];
PImage[] fondos = new PImage[8]; 

// Fuente
PFont fuenteVolta;

// Orden elementos
int[] ordenCopy = {0, 1, 2, 3, 4, 5}; // todos los copies
int[] ordenImagenes = {2, 2, 2, 2, 3, 3}; // 2 = medios 3 = bajos

// para navegar por el array de copy
int indexCopy = 0;

// ocultar previsualización
boolean hidden = false;

void settings() {
  size(anchoPagina, altoPagina);
}

void setup() {
  
  fuenteVolta = createFont("fonts/NeutraText DemiAlt.otf",40);
  
  fill(0);
  textAlign(CENTER);
  textFont(fuenteVolta, 50);
  

  for ( int i = 0; i< copy.length; i++ ) {
    // asegúrate que las imagenes de la "0.png" a la "11.png" existen 
    copy[i] = loadImage( "copy/" + i + ".png" );
  }

  //Carga la imagen de fondo
  for ( int i = 0; i< fondos.length; i++ ) {
    // asegúrate que las imagenes de la "0.png" a la "11.png" existen 
    fondos[i] = loadImage( "fondos/" + i + ".JPG" );
  }

  // Carga las imágenes
  File dirMedios = new File(sketchPath(""), "/medios");
  String[] mediosContents = dirMedios.list();
  mediosGallery = new PImage[mediosContents.length];
  for (int i = 0; i < mediosContents.length; i++) {
    if (mediosContents[i].charAt(0) == '.') continue;
    File childFile = new File(dirMedios, mediosContents[i]);        
    mediosGallery[i] = loadImage(childFile.getPath());
  }

  //File dirTejados = new File(sketchPath(""), "/tejados");
  //String[] tejadosContents = dirTejados.list();
  //tejadosGallery = new PImage[tejadosContents.length];
  //for (int i = 0; i < tejadosContents.length; i++) {
  //  if (tejadosContents[i].charAt(0) == '.') continue;
  //  File childFile = new File(dirTejados, tejadosContents[i]);        
  //  tejadosGallery[i] = loadImage(childFile.getPath());
  //}

  File dirBajos = new File(sketchPath(""), "/bajos");
  String[] bajosContents = dirBajos.list();
  bajosGallery = new PImage[bajosContents.length];
  for (int i = 0; i < bajosContents.length; i++) {
    if (bajosContents[i].charAt(0) == '.') continue;
    File childFile = new File(dirBajos, bajosContents[i]);        
    bajosGallery[i] = loadImage(childFile.getPath());
  }

  println("bajos: " + bajosGallery.length, "medios: " + mediosGallery.length);
}

void draw() {

  // No ver previsualización
  if (!hidden) {
    surface.setVisible(false); //This is what you're looking for.
    hidden = true;
  }

  //Coloca fondos
  int imagenAleatoria = (int) random(fondos.length);
  image(fondos[imagenAleatoria], 0, 0, width, height);

  // Baraja orden de textos
  shuffleTexts();

  // Loopea por las celdas del cartel posiciones
  for (int celdaCartel = 0; celdaCartel <= 5; celdaCartel ++) {
    // Posiciones celdas
    int x = p[celdaCartel][0];
    int y = p[celdaCartel][1];
    
    // Coloca imágenes
    tint(255, 120);
    if (ordenImagenes[celdaCartel] == 2) {
      if (random(2)>1) {
        image(mediosGallery[(int) random(mediosGallery.length)], x, y);
      }
    }  
    if (ordenImagenes[celdaCartel] == 3) {
      image(bajosGallery[(int) random(bajosGallery.length)], x, y + 115);
    } 
    noTint();

    //Coloca textos
    if (ordenCopy[celdaCartel] == 0) {
      image(copy[0], x, y);
    }
    if (ordenCopy[celdaCartel] == 1) {
      image(copy[1], x, y);
    }
    if (ordenCopy[celdaCartel] == 2) {
      image(copy[2], x, y);
    }
    if (ordenCopy[celdaCartel] == 3) {
      image(copy[3], x, y);
    }
    if (ordenCopy[celdaCartel] == 4) {
      image(copy[4], x, y);
    } 

    indexCopy ++;
  }
  indexCopy = 0;
  
  // Depósito legal + nºcartel
  pushMatrix();  
  translate(width - 60, height/2);
  rotate(radians(-90));
  if (frameCount < 10) {
    text("Direcció d’art de Quelic Berga | Disseny d’Etervisual | Depòsit legal: GI1843-2018 | Cartel Nº 00" + frameCount, 0, 0);
  } 
  if (frameCount >= 10 && frameCount<100) {
    text("Direcció d’art de Quelic Berga | Disseny d’Etervisual | Depòsit legal: GI1843-2018 | Cartel Nº 0" + frameCount, 0, 0);
  } 
  if (frameCount>=100) {
    text("Direcció d’art de Quelic Berga | Disseny d’Etervisual | Depòsit legal: GI1843-2018 | Cartel Nº " + frameCount, 0, 0);
  }
  popMatrix();


  // Exporta jpg
  if (frameCount < 5) {
    saveFrame("Volta_###.jpg");
    println("COPY" + frameCount);
  } 
}

void shuffleTexts() {
  IntList il = new IntList(ordenCopy);
  il.shuffle();
  ordenCopy = il.array();
}