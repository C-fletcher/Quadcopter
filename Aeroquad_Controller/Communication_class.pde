import processing.serial.*;
class Comm extends Thread {
  boolean running=false;
  byte Yaw, Pitch, Roll, Throttle, command='t';
  int time;
  public float frequency;
  int comcheck=0;
  public int commandcheck;
  float low, high;
  //byte[] inBuffer = new byte[NUMBER_BYTES];
  //int[] sensors = new int[NUMBER_OF_SENSORS];


  Comm(int Baud_Rate) {/*
    //make a serial class Robot
   Serial Robot;
   //list the available serial ports
   println(Serial.list());
   //open robot port
   Robot = new Serial(this, Serial.list()[1], Baud_Rate);*/
  }

  void start() {
    Robot.clear();
    Robot.write("S");
    running=true;
    delay(1);
    super.start();
  }

  //This get triggered by start
  void run() {
        Robot.write("#");
        Robot.write(commands[XAXIS]);
        Robot.write(commands[YAXIS]);
        Robot.write(commands[ZAXIS]);
        Robot.write(commands[THROTTLE]);
        Robot.write(commands[AUX]);
        
        //time =millis();
    
    while (running) {

        
        //delay(10);
        
      if (Robot.available()>=8){
          //commandcheck=Robot.read();
      low = float(Robot.read());
      high = float(Robot.read());
      attitude[XAXIS]=(256.*high+low-31416.)/10000.0;
      
      low = float(Robot.read());
      high = float(Robot.read());
      attitude[YAXIS]=(256.*high+low-31416.)/20000.0;
      
      low = float(Robot.read());
      high = float(Robot.read());
      attitude[ZAXIS]=(256.*high+low-31416.)/10000.0;
      
      low = float(Robot.read());
      high = float(Robot.read());
      altitude=(256.*high+low-100.)/100.0;
      n++;
      Robot.clear();
      
        Robot.write("#");
        Robot.write(commands[XAXIS]);
        Robot.write(commands[YAXIS]);
        Robot.write(commands[ZAXIS]);
        Robot.write(commands[THROTTLE]);
        Robot.write(commands[AUX]);
        
        comcheck=millis();
        
        //frequency=n/((comcheck-time+1)/1000);
      
      }
      else if ((millis()-comcheck)>500) {
        Robot.write("#");
        Robot.write(commands[XAXIS]);
        Robot.write(commands[YAXIS]);
        Robot.write(commands[ZAXIS]);
        Robot.write(commands[THROTTLE]);
        Robot.write(commands[AUX]);
        comcheck = millis();
      }
      
  }
  //disable the aeroquad and stop communication
        Robot.write(125);
        Robot.write(125);
        Robot.write(125);
        Robot.write(0);
        Robot.write("D");
        
        Robot.write(125);
        Robot.write(125);
        Robot.write(125);
        Robot.write(0);
        Robot.write("T");
}

  void quit() {
   running = false;
   }
}


