#include <VF.h>

// el blaze ppp normal hit mixups

// swap these to move to 2p side
byte F = L;
byte B = R;

void setup() {
  empty();
  wait_button( P );
}

// random delay finishing pppk string
void finish_k(){
  frames( 16 + random( 18 ) );
  tap( N, K );
}

void jump_hammer(){
  frames( 30 );
  tap( U, P|K, 3 );
  frames( 20 );
} 

void loop() {
  if ( is_pressed( K ) ) {
    byte temp;
    temp = F;
    F = B;
    B = temp;
  }

  tap(N, P, 4);
  tap(N, P, 4);
  tap(N, P, 4);
  choose( 2, finish_k, jump_hammer );
  buttons( G );
  frames( 50 );
  frames( random( 50 ) );
  empty();
  frames(2);
}
