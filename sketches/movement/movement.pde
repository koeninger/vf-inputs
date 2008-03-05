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
  //g_cancel();
  frames( wait );
  act_2(); 
}

// tap G
void g_cancel()
{
  // frame delay on either side may not be strictly necessary . . .
  frame();
  buttons(G);
  frame();
  empty();
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


// alternate given action with a DM in up direction
void stair_up( void( *act_1)(), int wait )
{
  act_1();
  frames(wait);
  dm_up();
  frames(wait);
}

// alternate given action with a DM in alternating directions
void square_wave( void( *act_1)(), int wait )
{
  act_1();
  frames(wait);
  dm_down();
  frames(wait);
  act_1();
  frames(wait);
  dm_up();
  frames(wait);  
}


void loop() // run over and over again
{
  for (int d = 1; d < 20; d += 2) {
    for (int i = 1; i < 10; ++i ) {
      stair_up( backdash, d );
    }
    for (int i = 1; i < 10; ++i ) {
      square_wave( dash, d );
    }
  }
}
