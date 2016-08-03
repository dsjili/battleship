note
	description: "Summary description for {INTERFACE}."
	author: "David Iliaguiev, Li Yin, Tin Feng Cheung"
	date: "$Date$"
	revision: "$Revision$"

class
	INTERFACE

create
	make

feature

	--gameboards for single and multiplayer modes
	gameboard1: BOARD
	gameboard2: BOARD

	--control modules for the corresponding game modes
	csingleltd:C_SINGLE_LTD
	csingleunl:C_SINGLE_UNL
	cmulti:C_MULTI

	--Boolean variable to keep track of overall game status
	exit: BOOLEAN

	make
		local
			x: INTEGER	--Local storage for user input
		do
			--Create gameboards and control modules
			create gameboard1.make
			create gameboard2.make
			create cmulti
			create csingleltd
			create csingleunl

			from
			until
				exit
			loop
				x := 0
				cmulti.refresh
				csingleltd.refresh
				csingleunl.refresh

				--Displays welcome and mode selection screen
				print ("%N------------------------------------------------------%N")
				print ("%NWelcome to the Battleship Game!%N")
				print ("Please select a game mode followed by the ENTER key%N")
				print ("Press 1 for single-player mode (UNLIMITED MODE)%N")
				print ("Press 2 for single-player mode (LIMITED MODE)%N")
				print ("Press 3 for two-player mode%N")
				print ("Press 4 for instructions%N")
				print ("Press 5 to exit%N")

				--Reads and stores user selection
				io.read_integer
				x := io.last_integer

				print("%N")

				--Check the input with the available selections and
				--call appropriate control module to handle game state and
				--user interactions
				--Single player unlimited game mode
				if x = 1 then
					gameboard1.new_board
					csingleunl.interact(gameboard1)
				--Single player limited game mode
				elseif x = 2 then
					gameboard1.new_board
					csingleltd.interact(gameboard1)
				--Multiplayer game mode
				elseif x = 3 then
					gameboard1.new_board
					gameboard2.random_char
					gameboard2.new_board
					cmulti.interact(gameboard1,gameboard2)
				--Game instructions
				elseif x = 4 then
					print ("The First Time You Play:%N")
					print ("Each player board contains 5 different ships%N")
					print ("Carrier    - 6 holes%N")
					print ("Battleship - 5 holes%N")
					print ("Cruiser    - 4 holes%N")
					print ("Submarine  - 3 holes%N")
					print ("Destroyer  - 2 holes%N")
					print ("%N")
					print ("The board is a 10X10 Martrix %N")
					print ("%N")
					print ("The system will place 5 ships on the board randomly%N")
					print ("%N")
					print ("The player will need to call the location base on row and column%N")
					print ("%N")
					print ("Column Range is A-J%N")
					print ("Row Range is 0-9%N")
					print ("%N")
					print ("For Example:%N")
					print ("%N")
					print ("'A9' it means attack the column A and row 9%N")
					print ("%N")
					print ("Once attacked that location it will display '*' or 'X'%N")
					print ("If the attack hit the part of the ship it will display 'X'%N")
					print ("If the attack is missed it will display '*'%N")
					print ("%N")
					print ("How To Win:%N")
					print ("----- 1. Single-Player (Unlimited Mode)-----%N")
					print ("---When you destroied 5 ships completely, and the score is base on how many turns you took to complete the game%N")
					print ("---Which means if you take less turns to destory all the ships, then you will have high score,%N")
					print ("   took too much turns then you will have a low score%N")
					print ("--------------------------------------------%N")
					print ("%N")
					print ("----- 2. Single-Player (Limited Mode)------%N")
					print ("---This game mode you only have 50 turns to complete the game, if you can't destory all the ships within 50 turns, then you will lose%N")
					print ("---if you take less turns to destoried all the ships, then you will have a high score, took too much turns then you will have a low score%N")
					print ("-------------------------------------------%N")
					print ("%N")
					print ("----- 3. Two-Player Mode------%N")
					print ("---This game mode is for 2 players, each player has a own board%N")
					print ("---The player 1 will go first to do the attack and switch to the player 2%N")
					print ("---The player who destoried all the ships, that player will be the winner%N")
					print ("---The score will base on the how many turn did the player took to destoried all the ships%N")
					print ("---if the player took less turns to destoried all the ships, then the player will have high score,%N")
					print ("   took too much turns then the player will have low score%N")
					print ("%N")
				--Exit game
				elseif x = 5 then
					exit := true
				--Deal with invalid input
				else
					print ("Invalid input!%N")
				end
			end
		end

invariant

	--Class invariants to ensure that gameboards and control modules are not void
	board_not_null:	gameboard1 /= VOID and gameboard2 /= VOID
	controllers_not_null:	cmulti /= VOID and csingleltd /= VOID and csingleunl /= VOID
	not_exit:	-- exit = false implies the game is still being played

end
