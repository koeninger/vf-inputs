#include <VF.h>

// swap these to move to 2p side
#define F L
#define B R

void setup() {
  empty();
  wait_button( P );
}

void jab_throw() {
  tap( N, P );
  frames( 18 );
  tap( N, P|G);
  frames( 8 );
}

void jab_elbow() {
  tap( N, P );
  tap( N, G );
  frames( 12 );
  tap( F, P );
  frames( 8 );
}

void loop() {
  choose( 2, jab_elbow, jab_throw );
  buttons( G );
  frames( 50 );
  frames( random( 100 ) );
  empty();
  frames(2);
}
