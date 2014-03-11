//take ps3 controller input and send it to the AeroQuad reciever

import procontroll.*;
import java.io.*;

//make serial class
  Serial Robot;
  Comm com;



ControllIO controll;
ControllDevice device;
ControllSlider Y;
ControllSlider X;
ControllSlider Z;
ControllSlider Throttle;
ControllSlider left_trigger;
ControllSlider right_trigger;
ControllButton armMotor;
ControllButton disarmMotor;
ControllButton terminate;


PFont F;
int xvar=500;
void setup()
{
  size(W,H);
  rectMode(CENTER);
  smooth();
  background(0);
  F=createFont("arial",14, true);
  
  //initialize all arrays
  controllerInput = new float[5];
  commands = new byte[5];
  a_value = new float[4];
  attitude = new float[3];
  
  commands[XAXIS] = -3;
  commands[YAXIS] = -3;
  commands[ZAXIS] = -3;
  commands[THROTTLE] = -128;
  commands[AUX] = 'Q';
  
  a_value[XAXIS]=.2;
  a_value[YAXIS]=.2;
  a_value[ZAXIS]=.2;
  a_value[THROTTLE]=.2;
  
  //for ps3 controller
  controll = ControllIO.getInstance(this);
  device = controll.getDevice("Controller (Xbox 360 Wireless Receiver for Windows)");
  device.printSticks();
  device.printSliders();
  device.printButtons();
  device.setTolerance(0.05f);
  X= device.getSlider(3);
  Y= device.getSlider(2);
  Z= device.getSlider(1);
  Throttle= device.getSlider(0);
  //Z.setTolerance(.2f);
  //left_trigger= device.getSlider(3);
  //right_trigger= device.getSlider(4);
  armMotor= device.getButton(4);
  disarmMotor= device.getButton(5);
  terminate = device.getButton(6);
  
  //initilize the serial communications

   //list the available serial ports
   println(Serial.list());
   //open robot port
   Robot = new Serial(this, Serial.list()[0], Baud_Rate);
   
   com = new Comm(9600);
   com.start();
  
}

  //commands[AUX] = 'Q';

void draw()
{
  background(0);
  //just a test
  println(X.getValue()+" , "+Y.getValue()+" , "+Throttle.getValue()+"      "+altitude+"    "+terminate.pressed());
  
  //read controller values
  commands[XAXIS] = byte(X.getValue()*125+125);
  commands[YAXIS] = byte(Y.getValue()*125+125);
  commands[ZAXIS] = byte(Z.getValue()*125+125);
  if (Throttle.getValue()<0) {
    commands[THROTTLE] = byte(Throttle.getValue()*-250);
  }
  else {
    commands[THROTTLE] = byte(0);
  }
  if (armMotor.pressed()) {
    commands[AUX] = 'A';
  }
  if (disarmMotor.pressed()) {
    commands[AUX] = 'D';
  }
  if (terminate.pressed()&(commands[THROTTLE]==0)) {
    com.quit();
  }

  
  navBall(.2,.5,.4);
  
  //if (n==1000) {  com.quit(); }
}

void keyTyped() {
  switch (key) {
    case 'A':
    case 'a':
    commands[AUX] = 'A';
    break;
    case 'D':
    case 'd':
    commands[AUX] = 'D';
    break;
    case 'H':
    case 'h':
    commands[AUX] = 'H';
    break;
    case 't':
    commands[AUX] = 'T';
    case 'I':
    case 'i':
    commands[AUX] = 'I';
    break;
    case 'F':
    case 'f':
    commands[AUX] = 'F';
    break;
    case 'R':
    case 'r':
    commands[AUX] = 'R';
    break;
    case 'P':
    case 'p':
        commands[XAXIS] = 125;
        commands[YAXIS] = 125;
        commands[ZAXIS] = 125;
        commands[THROTTLE] = 0;
        commands[AUX] = 'D';
    break;

  }}
