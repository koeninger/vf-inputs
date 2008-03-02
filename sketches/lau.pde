#include <VF.h>

// testing various moves into / out of lau's kokei stance

// 33 pp
void cd_pp()
{
  move( D | R );
  frames(2);
  empty();
  frames(2);
  move( D | R );
  frames(2);
  empty();
  frames(2);
  buttons( P );
  frames( 6 );
  empty();
  frames( 8 );
  buttons( P );
  frames( 6 );
  empty();
  frames( 9 );
  buttons( P | K | G );
  frames( 3 );
  empty();
  frames( 13 );
}

// 3k
void sidekick()
{
  move( D | R);
  buttons( K );
  frames( 6 );
  empty();
  frames( 11 );
  buttons( P );
  frames( 5 );
  empty();
  frames( 13 );
  buttons( P | K | G );
  frames( 3 );
  empty();
  frames( 14 );  
}

// 2_3PP
void upknife()
{
  move( D );
  frames( 10 );
  move( D | R );
  buttons( P );
  frames( 5 );
  empty();
  frames( 8 );
  buttons( P );
  frames( 4 );
  empty();
  frames( 12 );
  buttons( P | K | G );
  frames( 3 );
  empty();
  frames( 13 );
}

//6pp
void elbow_palm()
{
  move( R );
  buttons( P );
  frames( 4 );
  empty();
  frames( 4 ); 
  buttons( P );
  frames( 4 );
  empty();
  frames(20); 
  buttons( P | K | G );
  frames( 3 );
  empty();
  frames( 15 );
}

// pk
void pk()
{
  buttons( P );
  frames( 6 );
  empty();
  frames( 8 );
  buttons( K );
  frames( 4 );
  empty();
  frames( 15 );
  buttons( P | K | G ); 
  frames( 3 );
  empty();
  frames( 15 );
}

// 4P
void bk_p()
{
  move( L );
  buttons( P );
  frames( 3 );
  empty();
  frames( 30 );
}

// 4p+k p
void bk_pk_p()
{
  move( L );
  buttons( P | K );
  frames( 5 );
  empty();
  frames( 8 ); 
  buttons( P );
  frames( 5 );
  empty();
  frames(9); 
  buttons( P | K | G );
  frames( 3 );
  empty();
  frames( 15 );
}

// kokei k
void kok_k()
{
  buttons( K );
  frames( 5 );
  empty(); 
}

//kokei 4p
void kok_bk_p()
{
  buttons( P );
  move( L );
  frames( 3 );
  empty();
}

// kokei p
void kok_p()
{
  buttons( P );
  frames( 3 );
  empty();  
}

// guard cancel
void kok_g()
{
  buttons( G );
}

// kokei 6P+K
void kok_f_pk()
{
  move(R);
  buttons(P|K);
  frames(3);
  empty(); 
}

// mix different kokei followups after a given entry move
void mix_kokei( void( *entry )() )                     
{
  for ( int n = 0; n < 8; ++n ) {
    // enter into kokei stance using passed move
    entry();
    // exit kokei stance using selected moves
    switch( n ) {
    case 0:
    case 1:
      kok_p();
      break;
    case 2:
    case 3:
      kok_k();
      break;
    case 4:
    case 5:
      kok_bk_p();
      break;
    case 6:
    case 7:
      kok_f_pk();
      break;
    }
    // waste a bunch of time for situation to reset
    frames( 200 );
    empty();
  }
}

void setup()                    // run once, when the sketch starts
{
  empty();
  wait_button( P );
}

void loop() // run over and over again
{
  // mix_kokei( pk );
  // mix_kokei( elbow_palm );
  // mix_kokei( bk_pk_p );
  // mix_kokei( bk_p );
  mix_kokei( sidekick ); 
}
