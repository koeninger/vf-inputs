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

// press and then release move /buttons for given number of frames (default 2 )
void tap( byte mov, byte but, int frm ){
  move( mov );
  buttons( but );
  frames( frm );
  empty();
  frames( frm ); 
}

void tap( byte mov, byte but ){
  tap( mov, but, 2 );
}
void tap( byte mov ){
  tap( mov, off, 2 );
}

// randomly choose among variable num of actions (void functions)
void choose( int num, ... ) {
   va_list args;
   
   int choice = random( num ) + 1;
   
   va_start( args, num );
   for(  ; num > 0 ; --num ) {
     action f = va_arg( args, action );
     if ( num == choice ) { f(); } 
   }
   va_end( args ); 
}

//  TIMING CODE

boolean is_setup;  // flag whether prescale & timer has been initialized
int frame_count;  // incremented by interrupt once a frame has passed
 
// interrupt handler
ISR(TIMER1_COMPA_vect) 
{
  frame_count++;
} 

// setup interrupt timer
void setup_timer() 
{
  // disable interrupts
  cli();

  // Set CTC mode (Clear Timer on Compare Match) (p.133)
  // Have to set OCR1A *after*, otherwise it gets reset to 0!
  TCCR1B = (TCCR1B & ~_BV(WGM13)) | _BV(WGM12);
  TCCR1A = TCCR1A & ~(_BV(WGM11) | _BV(WGM10));

  // 8 prescaler (p.134)
  TCCR1B = (TCCR1B & ~( _BV(CS12) | _BV(CS10))) | _BV(CS11);

  // = 16666 microseconds (each count is .5 us)  
  OCR1A = 33333;  

  // Enable interrupt when TCNT1 == OCR1A (p.136)
  TIMSK1 |= _BV(OCIE1A);

  frame_count = 0;

  // enable interrupts 
  sei();

  is_setup = true;
}

// wait for 1 frame, e.g. 1/60th of second. = 16.6_ milliseconds
void frame()
{
  // kinda silly to check this every time, but avoids breaking old sketches
  // by making users setup the timer manually
  if ( ! is_setup ) {
    setup_timer();
  }

  // dunno if spinning until the flag is set by interrupt is the best way to do this . . .
  while( frame_count < 1 ) {
    ;
  }
  frame_count = 0;

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
    frame();
  }
 
  DDRD &= dmask;
  PORTD &= dmask;
}
