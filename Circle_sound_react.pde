//Created by Jobin
//www.jobinbennykutty.com
//Creative Commons Attribution-NonCommercial 4.0 International Public License

//You will need Minim - http://code.compartmental.net/minim/

import ddf.minim.*;
Minim minim;

AudioInput input;

float magnitude;
int widths = 100;
int heights = 40;
float speed = 50.0;
float factor;
float amplitude = 25;

float amplitude3 = 200;

//change the number at the end to change the width of the bars
float step_multiple3 = 3;

float[] peaks = new float[1024];
float[] last_peaks = new float[1024];

float rad1, rad2, rad3;

float step = TWO_PI/340;
float min;

void setup() {
  //change for screen size//
  size(1920, 1080);
  //change for frame rate//
  frameRate(15);
  minim = new Minim(this);
  input = minim.getLineIn(Minim.MONO, 1024);
  factor = float(width)/input.bufferSize();
}

void draw() { 
  background(42, 48, 128);
  blendMode(ADD);
  colorMode(HSB, 255);
  colorMode(RGB, 255);



  for (int i = 0; i < input.bufferSize() - 1; i++) {
    peaks[i] = lerp(last_peaks[i], (input.left.get(i)*amplitude), 0.05);


    last_peaks[i] = peaks[i];
  }


  rad1 = 0;
  rad1 += frameCount/125.0;
  rad2 = TWO_PI/3;
  rad2 += frameCount/200.0;
  rad3 = 2*(TWO_PI/3);
  rad3 -= frameCount/100.0;
  min = 200;
  for (int i = 0; i < 340; i++) {
    rad1 += step;
    rad2 += step;
    rad3 += step;
    if (i % 5 == 0) {
      beginShape(TRIANGLES);
      //change the number at the end to change the colours of the stroke
      stroke(0, 0, 0);
      //change the number at the end to change the colours of the bar
      fill(255, 220, 0);
      vertex(width/2, height/2);
      vertex(width/2 + sin(rad3)*(peaks[i]*amplitude3 + min), height/2 + cos(rad3)*(peaks[i]*amplitude3 + min));
      vertex(width/2 + sin(rad3 + step*step_multiple3)*(peaks[i]*amplitude3 + min), height/2 + cos(rad3 + step*step_multiple3)*(peaks[i]*amplitude3 + min));
      endShape();
    }
  }
}
