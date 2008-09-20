#include <VF.h>

// swap these to move to 2p side
byte F = L;
byte B = R;

void setup() {
  empty();
  wait_button( P );
}

// do nothing option,eg finish string instead of cancceling
void wait () {
  frames( 20 );
}

void jab() {
  tap( N, P );
  tap( N, G );
  frames( 12 ); 
}

void elbow() {
  tap( F, P );
  frames( 8 );
  tap( N, P );
  frames( 10 );  
  choose( 3, wait, cancel, cancel );
}

void df_thrw() {
  tap( D|F, P|G); 
}

void f_thrw() {
  tap( B );
  tap( F, P|G); 
}

void db_thrw() {
  tap( D|B, P|G ); 
}

void b_thrw() {
  move( D );
  frames( 2 );
  move( F );
  frames( 2 ); 
  move( U );
  frames( 2 ); 
  move( B );
  frames( 2 ); 
  buttons(P|G);
  frames( 2 );
  empty();
}

void thrw() {
  frames( 6 );
  choose( 4, f_thrw, df_thrw, db_thrw, b_thrw );
  frames( 12 );  
}

void jab_thrw() {
  jab();
  thrw();
}

void jab_elbow() {
  jab();
  frames( 5 );
  elbow();
}

void nutcheck() {
  tap( B );
  tap( D|F, P); 
}

void cancel() {
  tap( N , G );
  frames( 8 );
  choose( 2, nutcheck, thrw );
}

// cancelling 1st elbow after pp 
void elbow_c() {
  tap( F, P );
  frames( 8 );
  cancel(); 
}

void evade_p() {
  tap(U,P);
  tap(N,P);
  frames( 6 );
  choose( 2, wait, cancel );
}

void pp() {
  tap( N, P );
  frames( 10 );
  tap( N, P );
  frames( 6 );
  choose( 3, elbow_c, elbow, evade_p ); 
}

void db_lthrw() {
   tap( D|B, P|K|G );
   frames( 12 );
}

void d_lthrw() {
   tap( D, P|K|G );
   frames( 12 );
}

// need a long delay after eg ppp for lowthrow to come out
void lthrw(){
  empty();
  frames(38);
  choose( 2, db_lthrw, d_lthrw ); 
}

void tenchi_evade(){
  empty();
  frames(2);
  tap( D );
  tap( F, P|G );
  tap( P ); 
}

void tenchi(){
  buttons( P|K|G );
  move( B );
  frames( 70 );
}

// sweeping from ppp string only uses K; from neutral use K+G
void _sweep(int ppp_ing){
  tap( D, ppp_ing ? K : K|G );
  frames( 6 );
  choose( 2, tenchi, cancel );   
}

void sweep(){
  _sweep(0); 
}

void sweep_ppp(){
  _sweep(1); 
}

void jab_sweep(){
  jab();
  frames(8);
  sweep(); 
}

void knee(){
  tap( F, K );
  frames( 6 );
  tenchi(); 
}

void ppp(){
  tap( N, P, 4 );
  tap( N, P, 4 );
  tap( N, P, 4 );
  choose( 3, lthrw, sweep_ppp, knee );
}

void loop() {
  if ( is_pressed( K ) ) {
    byte temp;
    temp = F;
    F = B;
    B = temp;
  }
  choose( 7 ,jab_elbow, jab_thrw, jab_sweep, pp, pp, ppp, ppp );
  tap(D,P);
  frames( 50 );
  tap( N, G );
  frames( random( 50 ) );
  empty();
  frames(2);
}
