note
	description: "Summary description for {C_MULTI}."
	author: "David Iliaguiev, Li Yin, Tin Feng Cheung"
	date: "$Date$"
	revision: "$Revision$"

class
	C_MULTI

inherit
	CONTROLLER

feature

	interact (g1: BOARD; g2: BOARD)
		require
			boards_not_null: g1 /= VOID and g2 /= VOID
		local
			x: INTEGER
			y: CHARACTER
			output1: STRING
			output2: STRING
			turn1: INTEGER
			turn2: INTEGER
		do
			from
			invariant
				check_turn: turn1 >= 0 and turn2 >= 0
			until
				done
			loop
				print ("P1: Please select a cell to attack!%N")
				print ("Please enter a letter from A-J followed by a number from 0-9 and the ENTER key:%N")
				io.read_character
				y := io.last_character
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
					io.read_integer
					x := io.last_integer
					output1 := g2.attack (x + 2, y)
					turn1 := turn1 + 1
					if output1.is_equal ("Hit!") then
						score1 := score1 + 1
					end
					print (output1)
					display_result (score1, turn1)
					g2.display
					print ("P2: Please select a cell to attack!%N")
					print ("Please enter a letter from A-J followed by a number from 0-9 and the ENTER key:%N")
					io.read_character
					y := io.last_character
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
						io.read_integer
						x := io.last_integer
						output2 := g1.attack (x + 2, y)
						turn2 := turn2 + 1
						if output2.is_equal ("Hit!") then
							score2 := score2 + 1
						end
						print (output2)
						display_result (score2, turn2)
						g1.display
					end
				end
			end
		ensure
			done_check: done = true
		end

end
