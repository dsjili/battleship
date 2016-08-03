note
	description: "Summary description for {C_SINGLE_UNL}."
	author: "David Iliaguiev, Li Yin, Tin Feng Cheung"
	date: "$Date$"
	revision: "$Revision$"

class
	C_SINGLE_UNL

inherit

	CONTROLLER --C_SINGLE_UNL inherits from CONTROLLER class

feature

		--Single player interaction for battleship game with unlimited turns
		--Takes gameboard as input

	interact (g: BOARD)
		require
				--Requires that board is not void
			board_not_null: g /= VOID
				--Ensure that score is refreshed for each new game
			score_refresh: score1 = 0
		local
				--Local variables for X and Y matrix coordinates,
				--player output after each attack, and player turn
			attack: ATTACK_VIEW
			x: INTEGER
			y: CHARACTER
			output: STRING
			turn: INTEGER
			valid: BOOLEAN
		do
			create attack
			y := 'z' --Default y value

			from
			invariant
					--Ensure that player turn is always greater than or equal to 0
				check_turn: turn >= 0
					--display_output: ensure that correct user output is displayed after each
					--loop iteration
				check_y: y.is_alpha --Check that y is a character
				check_x: x >= 0 AND x <= 9 --Check that x is an integer greater than -1 and
				--less than 10
			until
				done
			loop
					--Display player attack prompt
				attack.display_attack

					--Loop will check if the user input is valid and within desired range of values
				from
					valid := false
				until
					valid
				loop
						--Read and store player y coordinate input information
					y := attack.get_char
						--Read and store player x coordinate input information
					x := attack.get_int
					valid := check_input (y, x)
				end

					--If user input is 's', forfeit current game and display current game results
				if y = 's' OR y = 'S' then
					print ("Results: ")
					display_result (score1, turn)
					g.display_solution
					done := true
				else
						--Send input information to attack function and store results
					output := g.attack (x + 2, y)

						--Checks if user has successfully beaten the game after each attack seqeuence
					if g.check_clear then
						print ("Congratulations! You have beaten the game!%N")
						display_result (score1, turn)
						g.display
						done := true
					else

							--Increment player turn
						turn := turn + 1
						print ("%N")

							--If attack is successful, increase player score
							--If unsuccessful, deduct 1 from score
						if output.is_equal ("Hit!") then
							score1 := score1 + 10
						elseif score1 > 0 then
							score1 := score1 - 1
						end

							--Display player results
						print (output)
						display_result (score1, turn)
						g.display
						print ("%N")
					end
				end
			end
		ensure
				--Ensure that done is true if game exits
			done_check: done = true
		end

end
