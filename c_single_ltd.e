note
	description: "Summary description for {C_SINGLE_LTD}."
	author: "David Iliaguiev, Li Yin, Tin Feng Cheung"
	date: "$Date$"
	revision: "$Revision$"

class
	C_SINGLE_LTD

inherit

	CONTROLLER --C_SINGLE_LTD inherits from CONTROLLER class

create
	make

feature

		--Single player interaction for battleship game with limited turns
		--Takes gameboard as input

	interact (g: BOARD)
		require
				--Requires that board is not void
			board_not_null: g /= VOID
				--Ensure that score is refreshed for each new game
			score_refresh: score1 = 0
		local
				--Local variables for X and Y matrix coordinates,
				--player output after each attack, player turn, and remaining turns
			x: INTEGER
			y: CHARACTER
			output: STRING
			turn: INTEGER
			counter: INTEGER
			valid: BOOLEAN
		do
			counter := 50 --Set initial remaining turns to 50
			y := 'z' --Default y value

			from
			invariant
					--Ensure that player turn is always greater than or equal to 0
					--Additionally ensure that turns remaining is greater than or equal to 0
					--and less than or equal to 50
				check_turn: turn >= 0
				check_counter: counter <= 50 and counter >= 0
					--display_output: ensure that correct user output is displayed after each
					--loop iteration
				check_y: y.is_alpha --Check that y is a character
				check_x: x >= 0 AND x <= 9 --Check that x is an integer greater than -1 and
				--less than 10
			until
				done OR counter = 0
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

						--Checks that input is valid
					valid := check_input (y, x)
				end

				print("%N")

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
						--Send input information to attack function and store results
					output := g.attack (x + 2, y)

						--Checks if user has successfully beaten the game after each attack seqeuence
					if g.check_clear then
						print ("Congratulations! You have beaten the game!%N")
						display_result (score1, turn)
						print ("Turns Remaining: ")
						print (counter)
						print ("%N")
						g.display
						done := true
					else
						if output.is_equal("You have already targeted this cell!") then
						else
							--Increment P1 turn
						turn := turn + 1
						print ("%N")

							--Decrement turn remaining
						counter := counter - 1

							--If attack is successful, increase player score
							--If unsuccessful, deduct 1 from score
						if output.is_equal ("Hit!") then
							score1 := score1 + 10
						elseif score1 > 0 then
							score1 := score1 - 1
						end
						end

							--Display player results
						print (output)
						display_result (score1, turn)
						print ("Turns Remaining: ")
						print (counter)
						print ("%N")
						g.display
						print ("%N")
					end
				end
			end
		ensure
				--Ensure that done is true or counter is 0 if game exits
				--done_check: done = true OR  counter = 0
		end

end
