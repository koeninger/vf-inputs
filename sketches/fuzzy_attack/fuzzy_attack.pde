#include <VF.h>

void setup()                    // run once, when the sketch starts
{
  empty();
  wait_button( P );
}

void loop()
{
 
 buttons( P | K | G );
 frames( 2 );
 empty();
 frames( 10 );
 buttons( K );
 frames( 2 );
 frames( 40 );
 move( D );
 buttons( G );
 frames( 8 );
 move( off );
 frames( 4 );
 empty();
 frames( 2 );
 move( R );
 buttons( K );
 frames( 2 );
 empty();
 frames( 175 ); 
}
