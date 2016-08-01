note
	description: "Summary description for {C_SINGLE_UNL}."
	author: "David Iliaguiev, Li Yin, Tin Feng Cheung"
	date: "$Date$"
	revision: "$Revision$"

class
	C_SINGLE_UNL

inherit
	CONTROLLER

feature

	interact (g: BOARD)
		require
			board_not_null: g /= VOID
		local
			x: INTEGER
			y: CHARACTER
			output: STRING
			turn: INTEGER
		do
			from
			invariant
				check_turn: turn >= 0
			until
				done
			loop
				print ("Please select a cell to attack!%N")
				print ("Please enter a letter from A-J followed by a number from 0-9 and the ENTER key:%N")
				io.read_character
				y := io.last_character
				if y = 's' OR y = 'S' then
					print ("Results: %N")
					display_result (score1, turn)
					g.display_solution
					done := true
				else
					io.read_integer
					x := io.last_integer
					output := g.attack (x + 2, y)
					turn := turn + 1
					if output.is_equal ("Hit!") then
						score1 := score1 + 1
					end
					print (output)
					display_result (score1, turn)
					g.display
				end
			end
		ensure
			done_check: done = true
		end

end
