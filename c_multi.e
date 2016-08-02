note
	description: "Summary description for {C_MULTI}."
	author: "David Iliaguiev, Li Yin, Tin Feng Cheung"
	date: "$Date$"
	revision: "$Revision$"

class
	C_MULTI

inherit
	CONTROLLER	--C_MULTI inherits from CONTROLLER class

feature

	--Multiplayer interaction for Battleship game
	--Takes two gameboards as input
	interact (g1: BOARD; g2: BOARD)
		require
			--Requires that both gameboards are not void
			boards_not_null: g1 /= VOID and g2 /= VOID
		local
			--Local variables for X and Y matrix coordinates,
			--player outputs after each attack, and player turns
			x: INTEGER
			y: CHARACTER
			output1: STRING
			output2: STRING
			turn1: INTEGER
			turn2: INTEGER
		do
			from
			invariant
				--Ensure that player turns are always greater than or equal to 0
				check_turn: turn1 >= 0 and turn2 >= 0
			until
				done
			loop
				--Display P1 attack prompt
				print ("P1: Please select a cell to attack!%N")
				print ("P1: Please enter a letter from A-J followed by a number from 0-9 and the ENTER key:%N")
				Print ("(Type S to forfeit current game)%N")

				--Read and store P1 y coordinate input information
				io.read_character
				y := io.last_character

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
					--Read and store P1 x coordinate input information
					io.read_integer
					x := io.last_integer

					--Send input information to attack function and store results
					output1 := g2.attack (x + 2, y)

					--Increment P1 turn
					turn1 := turn1 + 1

					print("%N")

					--If attack is successful, increase P1 score
					if output1.is_equal ("Hit!") then
						score1 := score1 + 1
					end

					--Display P1 results
					print (output1)
					display_result (score1, turn1)
					g2.display

					print("%N")

					--Display P2 attack prompt
					print ("P2: Please select a cell to attack!%N")
					print ("P2: Please enter a letter from A-J followed by a number from 0-9 and the ENTER key:%N")
					Print ("(Type S to forfeit current game)%N")

					--Read and store P2 y coordinate input information
					io.read_character
					y := io.last_character

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
						--Read and store P2 x coordinate input information
						io.read_integer
						x := io.last_integer

						--Send input information to attack function and store results
						output2 := g1.attack (x + 2, y)

						--Increment P2 turn
						turn2 := turn2 + 1

						print("%N")

						--If attack is successful, increase P2 score
						if output2.is_equal ("Hit!") then
							score2 := score2 + 1
						end

						--Display P2 results
						print (output2)
						display_result (score2, turn2)
						g1.display
						print("%N")
					end
				end
			end
		ensure
			--Ensure that done is true if game exits
			done_check: done = true
		end

end
