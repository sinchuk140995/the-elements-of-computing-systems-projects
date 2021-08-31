// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// Put your code here.
    @SCREEN
    D=A
    @8192
    D=D+A
    @R3  // screen end address [exclusive]
    M=D
(MAIN)
    // set pointer to the screen start
    @SCREEN
    D=A
    @R1  // screen's current word pointer
    M=D

    // store the current KBD state
    @KBD
    D=M
    @R4
    M=D

    @R0  // color register
    M=0  // white
    @COLOR_SCREEN
    D;JEQ

    @R0
    M=-1  // black
    @COLOR_SCREEN
    0;JMP
(COLOR_SCREEN)
    // check if KBD state has changed
    @KBD
    D=M
    @R4
    D=D-M
    @MAIN
    D;JNE

    // colorize
    @R0
    D=M
    @R1
    A=M
    M=D

    // move pointer by one word
    @1
    D=A
    @R1
    D=D+M
    M=D
    // if the new pointer is less than the screen end - continue COLOR_SCREEN
    @R3
    D=D-M
    @COLOR_SCREEN
    D;JLT
    // else - come back to main
    @MAIN
    0;JMP
