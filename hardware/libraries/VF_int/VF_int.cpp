#include "WProgram.h"
#include "VF_int.h"
#include <avr/interrupt.h>

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
  buttons( player1, off );
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

// set directions for player1
void move(byte player1)
{
  move( player1, off );
}

// convenience to clear all button presses & directions
void empty()
{
  buttons( off, off );
  move( off, off ); 
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


//  TIMING CODE

unsigned int latency;
unsigned int latencySum;
unsigned int sampleCount;
unsigned char timerLoadValue;
float timerClockFrequency;  // effective frequency after prescale
boolean doneSetup;  // flag whether prescale & timer has been initialized
int frameCnt;  // incremented by interrupt once a frame has passed


void SetPrescale( int scale ) {
  TCCR2A = 0;  // not using output compare
  switch ( scale ) {
    case 8: // prescale /8
    TCCR2B = 0<<CS22 | 1<<CS21 | 0<<CS20;
    break;
    case 32: // prescale /32
    TCCR2B = 0<<CS22 | 1<<CS21 | 1<<CS20; 
    break;    
    case 64: // prescale /64
    TCCR2B = 1<<CS22 | 0<<CS21 | 0<<CS20;   
    break;
    case 128: // prescale /128
    TCCR2B = 1<<CS22 | 0<<CS21 | 1<<CS20;    
    break;
    case 256: // prescale /256
    TCCR2B = 1<<CS22 | 1<<CS21 | 0<<CS20;    
    break;
    case 1024: // prescale /1024
    TCCR2B = 1<<CS22 | 1<<CS21 | 1<<CS20;   
    break;    
    default:  // no prescale 
    scale = 1.0; // make sure it's sane
    TCCR2B = 0<<CS22 | 0<<CS21 | 1<<CS20; 
  } 
  timerClockFrequency = F_CPU / scale;
}

//Setup Timer2.
//Configures the ATMegay168 8-Bit Timer2 to generate an interrupt at the specified frequency.
//Returns the time load value which must be loaded into TCNT2 inside your ISR routine.
//See the example usage below.
unsigned char SetupTimer2(float timeoutFrequency, int scale){
  unsigned char result; //The value to load into the timer to control the timeout interval.

  // set the prescale & effective clock frequency appropriately
  SetPrescale( scale );
  
  //Calculate the timer load value
  result=(int)((257.0-(timerClockFrequency/timeoutFrequency))+0.5); //the 0.5 is for rounding;
  //The 257 really should be 256 but I get better results with 257, dont know why.

  //Timer2 Overflow Interrupt Enable   
  TIMSK2 = 1<<TOIE2;

  //load the timer for its first cycle
  TCNT2=result; 
  
  return(result);
}

//Timer2 overflow interrupt vector handler
ISR(TIMER2_OVF_vect) {

  // set flag to indicate that a frame has passed
  frameCnt++;
   
  //Capture the current timer value. This is how much error we have
  //due to interrupt latency and the work in this function
  latency=TCNT2;

  //Reload the timer and correct for latency.  //Reload the timer and correct for latency.  //Reload the timer and correct for latency.
  TCNT2=latency+timerLoadValue; 
}

// wait for 1 frame, e.g. 1/60th of second. = 16.6_ milliseconds
void frame()
{
  // kinda silly to check this every time, but avoids breaking old sketches
  // by making users setup the timer manually
  if ( ! doneSetup ) {
    //Start the timer and get the timer reload value.
    // even with biggest prescale, interrupt doesnt seem to work @ 60hz,
    // so do 120 and skip twice . . .
    timerLoadValue=SetupTimer2(120, 1024);
    doneSetup = true;
  }

  // dunno if spinning until the flag is set by interrupt is the best way to do this . . .
  while( frameCnt < 2 ) {
    ;
  }
  frameCnt = 0;

}

void frames( int skip )
{
  for ( int i=0; i < skip; ++i ) {
    frame();
  }
}


