note
	description: "Summary description for {C_MULTI}."
	author: "David Iliaguiev, Li Yin, Tin Feng Cheung"
	date: "$Date$"
	revision: "$Revision$"

class
	C_MULTI

inherit

	CONTROLLER --C_MULTI inherits from CONTROLLER class

feature

		--Multiplayer interaction for Battleship game
		--Takes two gameboards as input

	interact (g1: BOARD; g2: BOARD)
		require
				--Requires that both gameboards are not void
			boards_not_null: g1 /= VOID and g2 /= VOID
				--Ensure that score is refreshed for each new game
			score_refresh: score1 = 0 AND score2 = 0
		local
				--Local variables for X and Y matrix coordinates,
				--player outputs after each attack, and player turns
			x: INTEGER
			y: CHARACTER
			output1: STRING
			output2: STRING
			turn1: INTEGER
			turn2: INTEGER
			valid: BOOLEAN
		do
			y := 'z' --Default y value

			from
			invariant
					--Ensure that player turns are always greater than or equal to 0
				check_turn: turn1 >= 0 and turn2 >= 0
					--display_output: ensure that correct user output is displayed after each
					--loop iteration
				check_y: y.is_alpha --Check that y is a character
				check_x: x >= 0 AND x <= 9 --Check that x is an integer greater than -1 and
				--less than 10
			until
				done
			loop
					--Display P1 attack prompt
				print ("P1: Please select a cell to attack!%N")
				print ("P1: Please enter a letter from A-J followed by a number from 0-9 and the ENTER key:%N")
				print ("(Type S followed by any number and the ENTER key to forfeit current game)%N")

				--Loop will check if the user input is valid and within desired range of values
				from
					valid := false
				until
					valid
				loop
						--Read and store player y coordinate input information
					io.read_character
					y := io.last_character

						--Read and store player x coordinate input information
					io.read_integer
					x := io.last_integer
					valid := check_input (y, x)
				end

					--If user input is 's', forfeit current game and display current game results
				if y = 's' OR y = 'S' then
					print ("Player 1 has forfeited! Player 2 wins!%N")
					print ("Player 1 Results%N")
					display_result (score1, turn1)
					g2.display_solution
					print ("Player 2 Results%N")
					display_result (score2, turn2)
					g1.display_solution
					done := true
				else
						--Send input information to attack function and store results
					output1 := g2.attack (x + 2, y)

						--Increment P1 turn
					turn1 := turn1 + 1
					print ("%N")

						--If attack is successful, increase P1 score
					if output1.is_equal ("Hit!") then
						score1 := score1 + 1
					end

						--Display P1 results
					print("P1 Results: %N")
					print (output1)
					display_result (score1, turn1)
					g2.display
					print ("%N")

						--Display P2 attack prompt
					print ("P2: Please select a cell to attack!%N")
					print ("P2: Please enter a letter from A-J followed by a number from 0-9 and the ENTER key:%N")
					print ("(Type S followed by any number and the ENTER key to forfeit current game)%N")
					from
						valid := false
					until
						valid
					loop
							--Read and store player y coordinate input information
						io.read_character
						y := io.last_character

							--Read and store player x coordinate input information
						io.read_integer
						x := io.last_integer
						valid := check_input (y, x)
					end

						--If user input is 's', forfeit current game and display current game results
					if y = 's' OR y = 'S' then
						print ("Player 2 has forfeited! Player 1 wins!%N")
						print ("Player 1 Results%N")
						display_result (score1, turn1)
						g2.display_solution
						print ("Player 2 Results%N")
						display_result (score2, turn2)
						g1.display_solution
						done := true
					else
							--Send input information to attack function and store results
						output2 := g1.attack (x + 2, y)

							--Increment P2 turn
						turn2 := turn2 + 1
						print ("%N")

							--If attack is successful, increase P2 score
						if output2.is_equal ("Hit!") then
							score2 := score2 + 1
						end

							--Display P2 results
						print("P2 Results: %N")
						print (output2)
						display_result (score2, turn2)
						g1.display
						print ("%N")
					end
				end
			end
		ensure
				--Ensure that done is true if game exits
			done_check: done = true
		end

end
