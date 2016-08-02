note
	description: "Summary description for {C_SINGLE_LTD}."
	author: "David Iliaguiev, Li Yin, Tin Feng Cheung"
	date: "$Date$"
	revision: "$Revision$"

class
	C_SINGLE_LTD

inherit
	CONTROLLER	--C_SINGLE_LTD inherits from CONTROLLER class

feature

	--Single player interaction for battleship game with limited turns
	--Takes gameboard as input
	interact (g: BOARD)
		require
			--Requires that board is not void
			board_not_null: g /= VOID
		local
			--Local variables for X and Y matrix coordinates,
			--player output after each attack, player turn, and remaining turns
			x: INTEGER
			y: CHARACTER
			output: STRING
			turn: INTEGER
			counter: INTEGER
		do
			counter := 50	--Set initial remaining turns to 50

			from
			invariant
				--Ensure that player turn is always greater than or equal to 0
				--Additionally ensure that turns remaining is greater than or equal to 0
				--and less than or equal to 50
				check_turn: turn >= 0
				check_counter: counter <= 50 and counter >= 0
			until
				done OR counter = 0
			loop
				--Display player attack prompt
				print ("Please select a cell to attack!%N")
				print ("Please enter a letter from A-J followed by a number from 0-9 and the ENTER key:%N")
				Print ("(Type S to forfeit current game)%N")

				--Read and store player y coordinate input information
				io.read_character
				y := io.last_character

				--If user input is 's', forfeit current game and display current game results
				if y = 's' OR y = 'S' then
					print ("Results: %N")
					display_result (score1, turn)
					print ("Turns Remaining: ")
					print (counter)
					print ("%N")
					g.display_solution
					done := true

				else
					--Read and store player x coordinate input information
					io.read_integer
					x := io.last_integer

					--Send input information to attack function and store results
					output := g.attack (x + 2, y)

					--Increment P1 turn
					turn := turn + 1

					print("%N")

					--If attack is successful, increase player score
					counter := counter - 1
					if output.is_equal ("Hit!") then
						score1 := score1 + 1
					end

					--Display player results	
					print (output)
					display_result (score1, turn)
					print ("Turns Remaining: ")
					print (counter)
					print ("%N")
					g.display
					print("%N")
				end
			end
		ensure
			--Ensure that done is true if game exits
			done_check: done = true
		end

end
