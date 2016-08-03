note
	description: "Summary description for {C_MULTI}."
	author: "David Iliaguiev, Li Yin, Tin Feng Cheung"
	date: "$Date$"
	revision: "$Revision$"

class
	C_MULTI

inherit

	CONTROLLER --C_MULTI inherits from CONTROLLER class


create
	make

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
				attack.display_attackp1

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

					--Checks if user has successfully beaten the game after each attack seqeuence
					if g2.check_clear then
						print ("Congratulations! Player 1 has won the game!%N")
						print ("Player 1 Results%N")
						display_result (score1, turn1)
						g2.display_solution
						print ("Player 2 Results%N")
						display_result (score2, turn2)
						g1.display_solution
						done := true
					else

						if output1.is_equal("You have already targeted this cell!") then
						else
							--Increment P1 turn
						turn1 := turn1 + 1
						print ("%N")

							--If attack is successful, increase P1 score
							--If unsuccessful, deduct 1 from score
						if output1.is_equal ("Hit!") then
							score1 := score1 + 10
						elseif score1 > 0 then
							score1 := score1 - 1
						end
						end
							--Display P1 results
						print ("P1 Results: %N")
						print (output1)
						display_result (score1, turn1)
						g2.display
						print ("%N")

							--Display P2 attack prompt
						attack.display_attackp2
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

							--Checks if user has successfully beaten the game after each attack seqeuence
							if g1.check_clear then
								print ("Congratulations! Player 2 has won the game%N")
								display_result (score2, turn2)
								print ("Player 1 Results%N")
								display_result (score1, turn1)
								g2.display_solution
								print ("Player 2 Results%N")
								display_result (score2, turn2)
								g1.display_solution
								done := true
							else

								if output2.is_equal("You have already targeted this cell!") then
								else
									--Increment P2 turn
								turn2 := turn2 + 1
								print ("%N")

									--If attack is successful, increase P2 score
									--If unsuccessful, deduct 1 from score
								if output2.is_equal ("Hit!") then
									score2 := score2 + 10
								elseif score2 > 0 then
									score2 := score2 - 1
								end
								end
									--Display P2 results
								print ("P2 Results: %N")
								print (output2)
								display_result (score2, turn2)
								g1.display
								print ("%N")
							end
						end
					end
				end
			end
		ensure
				--Ensure that done is true if game exits
			done_check: done = true
		end

end
