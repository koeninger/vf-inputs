#include <VF.h>

void setup()                    // run once, when the sketch starts
{
  empty();
  wait_button( P );
}

// do motion 1, delay wait frames, do motion 2
void after(  void( *act_1 )(), int wait, void( *act_2 )() )
{
  act_1();
  frames( wait );
  act_2(); 
}

void backdash()
{
  empty();
  move( L );
  frame();
  empty();
  frame();
  move( L );
  frame();
  empty(); 
}

void dash()
{
  empty();
  move( R );
  frame();
  empty();
  frame();
  move( R );
  frame();
  empty(); 
}

void cd()
{
  empty();
  move( R | D );
  frame();
  empty();
  frame();
  move( R | D );
  frame();
  empty(); 
}

void cd_back()
{
  empty();
  move( L | D );
  frame();
  empty();
  frame();
  move( L | D );
  frame();
  empty(); 
}

void dm_up()
{
  empty();
  move( U );
  frame();
  empty();
  frame();
}

void dm_down()
{
  empty();
  move( D );
  frame();
  empty();
  frame();
}

// try cancelling w all possible motions after given motion, wait
void cancel( void( *act_1)(), int wait )
{
  for (int n = 0; n < 6; n++) {
    switch(n) {
      case 0:
      after( act_1, wait, dash );
      break;
      case 1:
      after( act_1, wait, backdash );
      break;
      case 2:
      after( act_1, wait, cd );
      break;
      case 3:
      after( act_1, wait, cd_back );
      break;
      case 4:
      after( act_1, wait, dm_up );
      break;
      case 5:
      after( act_1, wait, dm_down );
      break;
    }
    frames( 100 );
  }  
}


void loop() // run over and over again
{
  for (int d = 10; d < 20; ++d ) {
    cancel( dm_down, d );
  }   
}
