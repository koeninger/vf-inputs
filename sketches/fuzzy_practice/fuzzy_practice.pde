#include <VF.h>

// swap these to move to 2p side
byte F = L;
byte B = R;

void setup() {
  empty();
  wait_button( P );
}

void jab() {
  tap( N, P );
  tap( N, G );
  frames( 12 ); 
}

void elbow() {
  tap( F, P );
  frames( 25 );
}

void df_thrw() {
  tap( D|F, P|G); 
}

void f_thrw() {
  tap( F, P|G); 
}

void thrw() {
  choose( 2, f_thrw, df_thrw );
  frames( 12 );  
}

void jab_thrw() {
  jab();
  thrw();
}

void jab_elbow() {
  jab();
  elbow();
}

void lp_lp() {
  tap( D, P );
  frames( 20 );
  tap( D, P );
  frames( 8 ); 
}

void lp_grd() {
  tap( D, P );
  frames( 20 );
  buttons( G );
  move( D );
  frames( 12 );
  move( N );
  frames( 20 );
  empty();
  frames( random(15) );
  choose( 2, thrw, elbow ); 
}


void loop() {
  if ( is_pressed( K ) ) {
    byte temp;
    temp = F;
    F = B;
    B = temp;
  }
  //choose( 4, jab_elbow, jab_thrw, lp_lp, lp_grd );
  choose( 3, lp_lp, lp_grd, lp_grd );
  buttons( G );
  frames( 50 );
  frames( random( 50 ) );
  empty();
  frames(2);
}
