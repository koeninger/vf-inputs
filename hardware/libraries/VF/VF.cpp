#include "WProgram.h"
#include "VF.h"

// generally, when setting controls,
// pressed = output (DDRx bit set to 1), low (PORTx bit set to 0)
// unpressed = input (DDRx bit set to 0), low (PORTx bit set to 0)
// so, not really sure if we need to clear PORTx every time, but do it anyway.

// set player1 and player2 buttons on portd
void buttons(byte player1, byte player2)
{
  // shift player2 bits to appropriate pins
  byte val = player1 | ( player2 >> 4 );
  // set portd low without disturbing value of tx rx on pins 0 and 1 
  PORTD &= dmask;
  // clear whatever value was there, replace with desired value, 
  // without disturbing value of tx rx 
  DDRD = ( DDRD & dmask ) | ( val & ~dmask );  
}

// set player1 buttons
void buttons(byte player1 )
{
  byte val = player1;
  // set portd low without disturbing value of tx rx on pins 0 and 1 
  PORTD &= dmask;
  // clear whatever value was there, replace with desired value, 
  // without disturbing value of tx rx 
  DDRD = ( DDRD & dmask ) | ( val & ~dmask );  
}

// set directions for player1 on portb and player2 on portc
void move(byte player1, byte player2)
{
  PORTB &= bmask;
  DDRB = ( DDRB & bmask ) | ( player1 & ~bmask );
  // this pattern of operations is redundant, but short, so . . .
  PORTC &= cmask;
  DDRC = ( DDRB & cmask ) | ( player2 & ~cmask );    
}

// set directions for player1 on portb and player2 on portc
void move(byte player1)
{
  PORTB &= bmask;
  DDRB = ( DDRB & bmask ) | ( player1 & ~bmask );
}


// convenience to clear all button presses & directions
void empty()
{
  buttons( off, off );
  move( off, off ); 
}

// delay 1 frame, e.g. 1/60th of second. = 16.6_ milliseconds
// XXX: need to account for skipped frames, vs frames in which pins are manipulated
void frame()
{
  delay(16);
  delayMicroseconds(666);
}

void frames( int skip )
{
  for ( int i=0; i < skip; ++i ) {
    frame();
  }
}

// spin until given button changes state
// if this is the first thing called, need to clear everything with empty(); first,
// bc arduino starts up with lots of pins set as output (controller button pressed)
void wait_button( byte button )
{
 // set pin corresponding to button as input, dont change tx rx
 DDRD &= ( ~button | dmask );
 
 byte orig_state = ( PIND & button ); 
 
 while ( orig_state == ( PIND & button ) ) {
   delay(1);
 }
 
 DDRD &= dmask;
 PORTD &= dmask;
}
