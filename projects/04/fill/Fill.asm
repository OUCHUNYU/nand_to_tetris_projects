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

		// create a variable to hold total pixle count
		// screen is 16 by 32 size
		@8191
		D=A
		@total_pixles
		M=D

	(INFINITE_LOOP)
		// temp counter for screen
		@pixle_counter
		M=0

		// assign screen address to a pointer 
		@SCREEN
		D=A
		@screen_address
		M=D

		// set default fill value to 0 which is white
		@fill_value
		M=0
		
		@KBD  // accesss keyboard input
		D=M
		
		// set the value to black if there is any keyboard input
		@BLACKEN
		D;JGT

		@FILL_LOOP
		0;JMP
		
	(BLACKEN)
		@fill_value
		M=-1

	(FILL_LOOP)
		// access the fill value and use it on the cuurent screen address
		@fill_value
		D=M
		@screen_address
		A=M
		M=D
		
		// if total - counter <= 0 jump back to INFINITE_LOOP
		@total_pixles
		D=M
		@pixle_counter
		D=D-M
		@INFINITE_LOOP
		D;JLE
		// else counter ++ and jump back to FILL_LOOP
		@pixle_counter
		M=M+1
		@screen_address
		M=M+1
		@FILL_LOOP
		0;JMP
