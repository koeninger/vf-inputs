#include <VF.h>
// vane stance switch strings
// swap these to move to 2p side
byte F = L;
byte B = R;

void setup() {
  empty();
  wait_button( P );
}

// strings starting from ds, going to os
void ds() {
  choose(5, ds_1, ds_2, ds_3, ds_4, ds_5);
  buttons(G);
  frames(60);
  empty();
  frames(5);
  tap(N, P|K|G,4 );
  frames(60);
}

void ds_1(){
  tap(N, P, 5);
  tap(N, P, 5);
  tap(N, P|K|G,5);  
}

void ds_2(){
  tap(F,P,5);
  tap(N,K,5);
  tap(N, P|K|G,5);
  frames(50);
  tap(D,P,4);  
}

void ds_3(){
  tap(D|F,N,4);
  tap(D|F,P,6);
  tap(N, P|K|G,6);
  frames(10);
}

void ds_4(){
  tap(D,K,5);
  tap(N, P|K|G,5);
  frames(40);
  tap(D,P,4);  
}

void ds_5(){
  tap(N,P|K,5);
  tap(N,P|K|G,5);
}

// strings starting from os, going to ds
void os(){
  tap(N,P|K|G);
  frames(30);
  choose(9, is, os_1,os_2,os_3,os_4,os_5,os_6,os_7,os_8);
  buttons(G);
  frames(60);
  empty();
  frames(60);  
}

// intruder step
void is(){
  tap(B,K,4);
  tap(F);
  tap(N,P,4);
  tap(N,P|K|G,4);
  frames(60);
  tap(D,P,4);
  frames(10);
}

void os_1(){
  tap(N, P, 5);
  tap(N, P, 5);
  tap(N, P|K|G,5);  
  frames(35);
  tap(D,P,4);
  frames(10);
}

void os_2(){
  tap(F,P,5);
  tap(N, P|K|G,5);
  frames(26);
  tap(D,P,4);
  frames(10);  
}

void os_3(){
  tap(F,K,5);
  tap(N,K,5);
  tap(N,P,5);
  tap(N,P|K|G,5);
  frames(30); 
}

void os_4(){
  tap(D,K,5);
  tap(N,P,5);
  tap(N,P|K|G,5);
  frames(30); 
}

void os_5(){
  tap(D|F,K,5);
  tap(N,P,5);
  tap(N,P,5);
  tap(N,P|K|G,5);
  frames(40); 
}


void os_6(){
  tap(D|F,K,5);
  tap(N,P|K|G,5);
  frames(30);
  tap(D,P,4);
  frames(10);
}

void os_7(){
  tap(N,P|K,5);
  tap(N,P|K|G,5);
  frames(30);
  tap(D,P,4);
  frames(10);
}

void os_8(){
  tap(D|B,P|K,5);
  tap(N,P,5);
  tap(N,P|K|G,5);
  frames(30); 
}

void loop() {
  if ( is_pressed( K ) ) {
    byte temp;
    temp = F;
    F = B;
    B = temp;
  }

  choose(2, ds,os);

  empty();
  frames(60);  

}
