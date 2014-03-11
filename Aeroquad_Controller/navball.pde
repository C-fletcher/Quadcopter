float Pitch;
float Bank;
float Azimuth;
float ArtificialHoizonMagnificationFactor=0.7;
float CompassMagnificationFactor=0.85;
float SpanAngle=120;
int NumberOfScaleMajorDivisions;
int NumberOfScaleMinorDivisions;

void navBall(float X, float Y, float size) {
  ArtificialHoizonMagnificationFactor=size;
  
  Pitch=attitude[YAXIS];
  Bank=attitude[XAXIS];
  translate(W*X, H*Y);  
  Horizon();
  rotate(-Bank); 
  PitchScale();
  Axis(); 
  rotate(Bank);
  Borders();
  Plane();
  translate(-W*X, -H*Y);
}


void Horizon()
{
  scale(ArtificialHoizonMagnificationFactor);
  noStroke();
  fill(0, 180, 255);
  rect(0, -100, 900, 1000);
  fill(95, 55, 40);
  rotate(-Bank);
  rect(0, 400+884*Pitch/PI, 900, 800); 
  rotate(Bank);
  rotate(-PI-PI/6);
  SpanAngle=120;
  NumberOfScaleMajorDivisions=12;
  NumberOfScaleMinorDivisions=24;  
  CircularScale(); 
  rotate(PI+PI/6);
  rotate(-PI/6);  
  CircularScale();
  rotate(PI/6);
}

//this is the stationary reference make better
void Plane()
{
  fill(0);
  strokeWeight(1);
  stroke(0, 255, 0);
  triangle(-20, 0, 20, 0, 0, 25); 
  rect(110, 0, 140, 20);
  rect(-110, 0, 140, 20);
}

void Axis()
{
  stroke(255, 0, 0);
  strokeWeight(3);
  line(-115, 0, 115, 0);
  line(0, 280, 0, -280);
  fill(100, 255, 100);
  stroke(0);
  triangle(0, -285, -10, -255, 10, -255);
  triangle(0, 285, -10, 255, 10, 255);
} 
void Borders()
{
  noFill();
  stroke(0);
  strokeWeight(400);
  rect(0, 0, 1100, 1100);
  strokeWeight(200);
  ellipse(0, 0, 1000, 1000); 
  fill(0);
  noStroke();
  rect(4*W/5, 0, W, 2*H);
  rect(-4*W/5, 0, W, 2*H);
}

void PitchScale()
{  
  stroke(255);
  fill(255);
  strokeWeight(3);
  textSize(24);
  textAlign(CENTER);
  for (int i=-4;i<5;i++)
  {  
    if ((i==0)==false)
    {
      line(110, 50*i, -110, 50*i);
    }  
    text(""+i*10, 140, 50*i, 100, 30);
    text(""+i*10, -140, 50*i, 100, 30);
  }
  textAlign(CORNER);
  strokeWeight(2);
  for (int i=-9;i<10;i++)
  {  
    if ((i==0)==false)
    {    
      line(25, 25*i, -25, 25*i);
    }
  }
} 

void CircularScale()
{
  float GaugeWidth=800;  
  textSize(GaugeWidth/30);
  float StrokeWidth=1;
  float an;
  float DivxPhasorCloser;
  float DivxPhasorDistal;
  float DivyPhasorCloser;
  float DivyPhasorDistal;
  strokeWeight(2*StrokeWidth);
  stroke(255);
  noFill();

  float DivCloserPhasorLenght=GaugeWidth/2-GaugeWidth/9-StrokeWidth;
  float DivDistalPhasorLenght=GaugeWidth/2-GaugeWidth/7.5-StrokeWidth;

  for (int Division=0;Division<NumberOfScaleMinorDivisions+1;Division++)
  {
    an=SpanAngle/2+Division*SpanAngle/NumberOfScaleMinorDivisions;  
    DivxPhasorCloser=DivCloserPhasorLenght*cos(radians(an));
    DivxPhasorDistal=DivDistalPhasorLenght*cos(radians(an));
    DivyPhasorCloser=DivCloserPhasorLenght*sin(radians(an));
    DivyPhasorDistal=DivDistalPhasorLenght*sin(radians(an));   
    line(DivxPhasorCloser, DivyPhasorCloser, DivxPhasorDistal, DivyPhasorDistal);
  }

  DivCloserPhasorLenght=GaugeWidth/2-GaugeWidth/10-StrokeWidth;
  DivDistalPhasorLenght=GaugeWidth/2-GaugeWidth/7.4-StrokeWidth;

  for (int Division=0;Division<NumberOfScaleMajorDivisions+1;Division++)
  {
    an=SpanAngle/2+Division*SpanAngle/NumberOfScaleMajorDivisions;  
    DivxPhasorCloser=DivCloserPhasorLenght*cos(radians(an));
    DivxPhasorDistal=DivDistalPhasorLenght*cos(radians(an));
    DivyPhasorCloser=DivCloserPhasorLenght*sin(radians(an));
    DivyPhasorDistal=DivDistalPhasorLenght*sin(radians(an));
    if (Division==NumberOfScaleMajorDivisions/2|Division==0|Division==NumberOfScaleMajorDivisions)
    {
      /*strokeWeight(15);
      stroke(0);
      line(DivxPhasorCloser, DivyPhasorCloser, DivxPhasorDistal, DivyPhasorDistal);
      strokeWeight(50);
      stroke(100, 255, 100);
      line(DivxPhasorCloser, DivyPhasorCloser, DivxPhasorDistal, DivyPhasorDistal);*/
    }
    else
    {
      strokeWeight(3);
      stroke(255);
      line(DivxPhasorCloser, DivyPhasorCloser, DivxPhasorDistal, DivyPhasorDistal);
    }
  }
}
