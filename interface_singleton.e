note
	description: "Instance of interface singleton"
	author: "Li Yin, 211608973, yinl1"
	coauthor: "David Iliaguiev, Li Yin, Ting Fai Cheung"
	date: "$Date$"
	revision: "$Revision$"

class
	INTERFACE_SINGLETON

inherit
	C_INTERFACE

create
	make

feature
		--gameboards for single and multiplayer modes

	gameboard1: BOARD

	gameboard2: BOARD

		--control modules for the corresponding game modes and instructions

	csingleltd: C_SINGLE_LTD

	csingleunl: C_SINGLE_UNL

	cmulti: C_MULTI

	start: START_VIEW

		--Boolean variable to keep track of overall game status

	exit: BOOLEAN

	make
		local
			x: INTEGER --Local storage for user input
		do
				--Create gameboards and control modules
			create gameboard1.make
			create gameboard2.make


			create cmulti.make
			create csingleltd.make
			create csingleunl.make
			create start

			from
			until
				exit
			loop
				x := 0
				cmulti.refresh
				csingleltd.refresh
				csingleunl.refresh

					--Displays welcome and mode selection screen
					start.display_welcome

					--Reads and stores user selection
				x := start.get_start
				print ("%N")

					--Check the input with the available selections and
					--call appropriate control module to handle game state and
					--user interactions
					--Single player unlimited game mode
				if x = 1 then
					gameboard1.new_board
					csingleunl.interact (gameboard1)
						--Single player limited game mode
				elseif x = 2 then
					gameboard1.new_board
					csingleltd.interact (gameboard1)
						--Multiplayer game mode
				elseif x = 3 then
					gameboard1.new_board
					gameboard2.random_char
					gameboard2.new_board
					cmulti.interact (gameboard1, gameboard2)
						--Game instructions
				elseif x = 4 then
						start.display_instructions
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
	board_not_null: gameboard1 /= VOID and gameboard2 /= VOID
	controllers_not_null: cmulti /= VOID and csingleltd /= VOID and csingleunl /= VOID
	--not_exit: exit = false implies the game is still being played

end
