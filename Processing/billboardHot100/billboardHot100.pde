import processing.pdf.*;

String [] rawData;
int count;
// Define font later
PFont f;

// Positioning
int x, y;
int line;

// Danceability
String dance;
float danceability;
float danceEnd;

// Energy
String energy;
float energyFloat;
float energyEnd;

// Valence
String val;
float valence;
float valenceEnd;

// Acousticness
String acoust;
float acoustic;
float acousticEnd;

boolean savePDF = true;

void settings() {
  if (savePDF) {
    size(1000, 1000, PDF, "plot.pdf");
  } else {
    size(1000, 1000);
  }
} 

void setup() {
  colorMode(RGB);
  size(1000, 1000);
  // Read in raw data
  rawData = loadStrings("billboardHot100.csv");
  // Length of data
  count = rawData.length;
  // Run draw once
  noLoop();
  background(255);
}

void draw(){
  for (int i = 1; i < count; i++) {
    // Split data into circles
    String row [] =  split(rawData[i], ",");
    
    // Get numbers
    dance = row[7];
    energy = row[8];
    val = row[16];
    acoust = row[13];
    
    // Strings to float
    danceability = float(dance);
    energyFloat = float(energy);
    valence = float(val);
    acoustic = float(acoust);
    
    // Map values to 2PI Radians
    danceEnd = map(danceability, 0, 1, 0, TWO_PI);
    energyEnd = map(energyFloat, 0, 1, 0, TWO_PI);
    valenceEnd = map(valence, 0, 1, 0, TWO_PI);
    acousticEnd = map(acoustic, 0, 1, 0, TWO_PI);
    
    // Line styling
    strokeWeight(4);
    strokeCap(SQUARE);
    noFill();
    
    // New lines based on x and y position to create 10x10 grid
    int line = floor((i-1)/10) + 1;
    x = 50 + (((i - ((line - 1) * 10)) - 1) * 100);
    y = -50 + (line * 100);
    
    // Uncomment line below to test x and y values
    // println(i + " " + y + " " + line + " " + x);
    
    // Draw danceability circles
    stroke(26, 40, 114);
    arc(x, y, 80, 80, -HALF_PI, -HALF_PI+danceEnd);
    
    // Draw energy circles
    stroke(49, 99, 159);
    arc(x, y, 65, 65, -HALF_PI, -HALF_PI+energyEnd);
    
    // Draw loudness circles
    stroke(73, 167, 201);
    arc(x, y, 50, 50, -HALF_PI, -HALF_PI+valenceEnd);
    
    // Draw acousticness circles
    stroke(160, 213, 205);
    arc(x, y, 35, 35, -HALF_PI, -HALF_PI+acousticEnd);
  }
  if (savePDF) {
    exit();
  }
}