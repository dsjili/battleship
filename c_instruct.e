note
	description: "Summary description for {C_INSTRUCT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	C_INSTRUCT

feature

	display
		do
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
			print ("Each 'X' or Hit will increase player score by 10, while player ")
			print ("score is deducted by 1 for every turn taken that does not result in a hit.%N")
			print ("%N")
			print ("How To Win:%N")
			print ("----- 1. Single-Player (Unlimited Mode)-----%N")
			print ("---The goal of this game mode is to destroy as many ships as possible.%N")
			print ("---Which means if you take less turns to destory all the ships, then you will have high score,%N")
			print ("   take too many turns then you will have a low score%N")
			print ("--------------------------------------------%N")
			print ("%N")
			print ("----- 2. Single-Player (Limited Mode)------%N")
			print ("---In this game mode you only have 50 turns to complete the game, if you can't destory all the ships within 50 turns, then you will lose%N")
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
		end

end
