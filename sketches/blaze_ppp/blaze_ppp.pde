#include <VF.h>

// scenario to train 2 ETEG in a row
// cpu will lowpunch, you respond with elbow, which it will block
// then it will do jab (you evade) then elbow / throw

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
