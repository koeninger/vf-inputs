#include <VF.h>
// test pattern for controlling 2 players at once

void setup()                    // run once, when the sketch starts
{
  empty();
  wait_button( P );
}

void loop() // run over and over again
{
  move(L,L);
  frames(2);
  empty();
  frames(2);
  move(L,L);
  frames(2);
  empty();  
  frames(30);
  move(R,R);
  frames(2);
  empty();
  frames(2);
  move(R,R);
  frames(2);
  empty();  
  frames(30);
  move(D,D);
  frames(2);
  empty();
  frames(30);
  move(U,U);
  frames(2);
  empty();
  frames(30);
  buttons(P,P);
  frames(2);
  empty();
  frames(30);
  buttons(K,K);
  frames(2);
  empty();
  frames(30);
  buttons(G,G);
  frames(200);
  empty();
  frames(30);
}
