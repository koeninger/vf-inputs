#include <VF_int.h>

void setup()
{
  empty();
  //Start up the serial port
  Serial.begin(9600);
  Serial.println( F_CPU );
  wait_button( P );
}

void loop()
{
  // mash P at 1 frame intervals, see if frame delays are working co 
  for ( int i = 0; i < 1000; ++i ) {
//    Serial.println( "starting P");
    buttons( P );
    frame();
    empty();
    frame(); 
//    Serial.println( "finish P");
  }
  
  // mash PKG at 1 frame intervals, see if frame delays are working co 
  for ( int i = 0; i < 1000; ++i ) {
    buttons( P | K | G );
    frames(1);
    empty();
    frames(1); 
  }
}
