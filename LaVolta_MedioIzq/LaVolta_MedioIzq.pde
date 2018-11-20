// Crea tus fuentes
PFont fuenteTitulares, fuenteTextoDemi, fuenteTextoBold;

// Inicia arrays de Strings para guardar los archivos de texto;
String[] participants, info;
// Inicia String para guardar un titular;
String titular1, titular2;

// Variables para parametrizar
float workHeight;
int margin = 20;
int bottomMargin = 90;

// Inicia la imagen de fondo
PImage bg;

// Inicia los logos
PShape logos;

// Inicia un array de cada tipo para guardar y clasificar las imágenes 
PImage[] arcadas = new PImage[3]; // Indica cuántas imágenes hay de cada tipo

//Colores textura
color yellow = color(255, 255, 0, 185);
color magenta = color(255, 0, 255, 185);
color cyan = color(0, 255, 255, 185);


void setup() {
  size(595, 842);
  pixelDensity(displayDensity());
  frameRate(1);

  // Carga la imagen de fondo
  bg = loadImage("img/backgroundLowLowRes.jpg");

  // Carga los logos
  logos = loadShape("logos.svg");

  // Crea las fuentes
  fuenteTitulares = createFont("fonts/NeutraTextTF Bold.otf", 40);
  fuenteTextoDemi = createFont("fonts/NeutraText DemiAlt.otf", 40);
  fuenteTextoBold = createFont("fonts/NeutraTextTF Bold.otf", 40);

  // Carga los textos
  // Usa loadStrings("file path") para cargar 
  participants = loadStrings("textos/participants.txt");
  info = loadStrings("textos/loc-date-web.txt");
  titular1 = "27è\nMERCAT\nDE LA\nVOLTA";
  titular2 = "DISSENY DE\nPRODUCTE I\nARTESANIA\nDIGITAL";

  workHeight = height - bottomMargin + margin;

  for ( int i = 0; i< arcadas.length; i++ ) {
    // asegúrate que las imagenes de la "0.png" a la "11.png" existen
    arcadas[i] = loadImage( "img/arcadas/color/" + i + ".png" );
  }
}

void draw() {

  // FONDO IMAGEN
  image(bg, 0, 0);
  shapeMode(CENTER);

  // Descomenta para ver margenes y guías
  //layout();


  // IMÁGENES ///////////////////////////////////////////////////////
  //Leyenda: testImg(galería, posX, posY, scaleFactor);

  int numImagenesCelda = 1;
  for (int i = 1; i <= numImagenesCelda; i++) {
    testImg(arcadas, random(width/2, width-100), random(workHeight/3*2 + 55, workHeight/3*2 - 50), 0.10);
    testImg(arcadas, random(width/2, width-100), random(-40, workHeight/3 - 180), 0.10);
  }


  // LOGOS ////////////////////////////////////////////////////////////
  shape(logos, width/2, height-50);

  fill(0);
  noStroke();
  // TITULARES ////////////////////////////////////////////////////////
  //Leyenda: tiutlar(message, posX, posY, mifuente, size, lineHeight);

  float tiraUnDado = random(6);
  // 50% probabilidad
  if (tiraUnDado < 3) {   // si es menor < 3 haz esto
    titular(titular1, margin, workHeight/3, fuenteTitulares, 40, 42);
    titular(titular2, margin, margin, fuenteTitulares, 40, 42);
  } else { // Si no es menor < 3 haz esto
    titular(titular1, margin, margin, fuenteTitulares, 40, 42);
    titular(titular2, margin, workHeight/3, fuenteTitulares, 40, 42);
  }


  // TEXTOS ///////////////////////////////////////////////////////

  // TEXTO 1
  texto(info, margin, workHeight/3 * 2 + 13, fuenteTextoBold, 14, 16);
  rect(margin, workHeight/3 * 2, 220, 2);
  rect(margin, workHeight/3 * 2 + 17*3, 220, 2);
  rect(margin, workHeight/3 * 2 + 19*6, 220, 2);

  // TEXTO 2  
  pushMatrix();
  translate(0, 0);
  texto(participants, width/2, workHeight/3, fuenteTextoDemi, 14, 16);
  rect(width/2, workHeight/3 + 20, 72, 2);
  popMatrix();
}



//////////////////////////  FUNCIONES  ////////////////////////////

void titular(String texto, float posX, float posY, PFont fuente, float size, float lineHeight) {
  rect(posX, posY, 70, 4);
  textFont(fuente, size);
  textLeading(lineHeight);
  text(texto, posX, posY + margin, width/2, workHeight/3);
}

void texto(String file[], float posX, float posY, PFont fuente, float size, float lineHeight ) {
  for (int i = 0; i < file.length; i++) {
    if (i == 0) textFont(fuenteTextoBold, size);
    else textFont(fuente, size);

    float posc = lineHeight * i;
    text(file[i], posX, posY + posc, width/2, workHeight/3);
  }
}


void testImg(PImage gallery[], float posX, float posY, float scaleFactor) {
  blendMode(NORMAL);
  // posición aleatoria del array de imágenes
  int imagenAleatoria = (int) random(gallery.length);
  float imgAncho = gallery[imagenAleatoria].width * scaleFactor;
  float imgAlto = gallery[imagenAleatoria].height * scaleFactor;
  image(gallery[imagenAleatoria], posX, posY, imgAncho, imgAlto);

  float offsetX = random(-20, 20);
  float offsetY = random(-20, 20);
  blendMode(BLEND);
  //efectoPuntos(gallery[imagenAleatoria], posX + offsetX, posY + offsetY, imgAncho, imgAlto, random(60, 100), random(1, 3), cyan);
  //efectoPuntos(gallery[imagenAleatoria], posX + offsetX, posY + offsetY, imgAncho, imgAlto, random(60, 100), random(1, 3), magenta);
  //efectoPuntos(gallery[imagenAleatoria], posX + offsetX, posY + offsetY, imgAncho, imgAlto, random(60, 100), random(1, 3), yellow);
  
};

void efectoPuntos (PImage base, float posX, float posY, float ancho, float alto, float space, float size, color f) {
  fill(f);
  strokeWeight(0.1);
  color c;
  for (int yy = 0; yy < base.height; yy += space) {
    for (int xx = 0; xx <base.width; xx += space) {
      int loc = xx + yy*base.width;  // Pixel array location
      c = base.pixels[loc];  // Grab the color
      if (alpha(c)>0) {
        ellipse(posX+xx/(base.width/ancho), posY+yy/(base.height/alto), size, size);
      }
    }
  }
}

void layout() {
  stroke(200, 0, 0);
  line(width/2, 0, width/2, height);
  line(0, workHeight/3, width, workHeight/3  );
  line(0, workHeight/3*2, width, workHeight/3*2 );
  noFill();
  rect(margin, margin, width - margin*2, height - 90 - margin);
}