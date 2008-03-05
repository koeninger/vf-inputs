#include <VF.h>

void setup()                    // run once, when the sketch starts
{
  empty();
  wait_button( P );
}

void loop() // run over and over again
{
  buttons(P);
  frames(2);
  empty();
  buttons(G);
  frames(2);
  empty();  
  frames(18);
  move(U|R);
  buttons(P);
  frames(1);
  empty();
  
  // reset
  frames(150);
}
