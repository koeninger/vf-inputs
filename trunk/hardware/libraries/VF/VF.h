#ifndef VF
#define VF

#include "WConstants.h"

// constants relating controls to pins
// player1 and player 2 movement directions are on different headers,
// (portb and portc) so up right down left are same pins on each
#define U      B00100000
#define R      B00010000
#define D      B00001000
#define L      B00000100
// player1 and player2 buttons are on single header (portd)
// so can distinguish punch player1 vs punch player2
// but will abstract this out with a bit shift for the second arg to
// buttons(player1, player2)
#define P      B10000000
#define K      B01000000
#define G      B00100000
#define P2     B00010000
#define K2     B00001000
#define G2     B00000100

// clear pins
#define off  B00000000

// masks off unused pins
#define bmask  B11000000  // for portb and portc, top 2 pins unavailable
#define cmask  B11000000  // for portb and portc, top 2 pins unavailable
#define dmask  B00000011  // for portd, pins 0 1 are rx tx, will break usb

// generally, when setting controls,
// pressed = output (DDRx bit set to 1), low (PORTx bit set to 0)
// unpressed = input (DDRx bit set to 0), low (PORTx bit set to 0)
// so, not really sure if we need to clear PORTx every time, but do it anyway.

// set player1 and player2 buttons on portd
void buttons(byte player1, byte player2);
void buttons(byte player1 );

// set directions for player1 on portb and player2 on portc
void move(byte player1, byte player2);
void move(byte player1 );


// convenience to clear all button presses & directions
void empty();

// delay 1 frame, e.g. 1/60th of second. = 16.6_ milliseconds
// XXX: need to account for skipped frames, vs frames in which pins are manipulated
void frame();

// delay x number of frames
void frames( int skip );

// spin until given button changes state
// if this is the first thing called, need to clear everything with empty(); first,
// bc arduino starts up with lots of pins set as output (controller button pressed)
void wait_button( byte button );

#endif
