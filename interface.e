note
	description: "Summary description for {INTERFACE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	INTERFACE

create
	make

feature

	gameboard1: BOARD

	gameboard2: BOARD

	exit: BOOLEAN

	make
		local
			x: INTEGER
		do
			create gameboard1.make
			create gameboard2.make
			from
			until
				exit
			loop
				print ("Welcome to the Battleship Game!%N")
				print ("Please select a game mode followed by the ENTER key%N")
				print ("Press 1 for single-player mode (UNLIMITED MODE)%N")
				print ("Press 2 for single-player mode (LIMITED MODE)%N")
				print ("Press 3 for two-player mode%N")
				print ("Press 4 for instructions%N")
				io.read_integer
				x := io.last_integer
				if x = 1 then
					gameboard1.new_board
					exit := interact_solo
				elseif x = 2 then
					gameboard1.new_board
					exit := interact_solo_limited
				elseif x = 3 then
					gameboard1.new_board
					gameboard2.random_char
					gameboard2.new_board
					exit := interact_multi
				end
			end
		end

	interact_solo_limited: BOOLEAN
		local
			x: INTEGER
			y: CHARACTER
			output: STRING
			done: BOOLEAN
			score: INTEGER
			turn: INTEGER
			counter: INTEGER
		do
			counter := 50
			from
			until
				done OR counter = 0
			loop
				print ("Please select a cell to attack!%N")
				print ("Please enter a letter from A-J followed by a number from 0-9 and the ENTER key:%N")
				io.read_character
				y := io.last_character
				if y = 's' OR y = 'S' then
					print("Results: %N")
					display_result(score,turn)
					print ("Turns Remaining: ")
					print (counter)
					print ("%N")
					gameboard1.display_solution
					done := true
				else
					io.read_integer
					x := io.last_integer
					output := gameboard1.attack (x + 2, y)
					turn := turn + 1
					counter := counter - 1
					if output.is_equal ("Hit!") then
						score := score + 1
					end
					print (output)
					display_result(score, turn)
					print ("Turns Remaining: ")
					print (counter)
					print ("%N")
					gameboard1.display
				end
			end
		end

	interact_solo: BOOLEAN
		local
			x: INTEGER
			y: CHARACTER
			output: STRING
			done: BOOLEAN
			score: INTEGER
			turn: INTEGER
		do
			from
			until
				done
			loop
				print ("Please select a cell to attack!%N")
				print ("Please enter a letter from A-J followed by a number from 0-9 and the ENTER key:%N")
				io.read_character
				y := io.last_character
				if y = 's' OR y = 'S' then
					print("Results: %N")
					display_result(score,turn)
					gameboard1.display_solution
					done := true
				else
					io.read_integer
					x := io.last_integer
					output := gameboard1.attack (x + 2, y)
					turn := turn + 1
					if output.is_equal ("Hit!") then
						score := score + 1
					end
					print (output)
					display_result(score, turn)
					gameboard1.display
				end
			end
		end

	interact_multi: BOOLEAN
		local
			x: INTEGER
			y: CHARACTER
			output1: STRING
			output2: STRING
			done: BOOLEAN
			score1: INTEGER
			score2: INTEGER
			turn1: INTEGER
			turn2: INTEGER
		do
			from
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
					display_result(score1,turn1)
					gameboard2.display_solution
					print ("Player 2 Results%N")
					display_result(score2,turn2)
					gameboard1.display_solution
					done := true
				else
					io.read_integer
					x := io.last_integer
					output1 := gameboard2.attack (x + 2, y)
					turn1 := turn1 + 1
					if output1.is_equal ("Hit!") then
						score1 := score1 + 1
					end
					print (output1)
					display_result(score1, turn1)
					gameboard2.display
					print ("P2: Please select a cell to attack!%N")
					print ("Please enter a letter from A-J followed by a number from 0-9 and the ENTER key:%N")
					io.read_character
					y := io.last_character
					if y = 's' OR y = 'S' then
						print ("Player 2 has forfeited! Player 1 wins!%N")
						print ("Player 1 Results%N")
						display_result(score1,turn1)
						gameboard2.display_solution
						print ("Player 2 Results%N")
						display_result(score2,turn2)
						gameboard1.display_solution
						done := true
					else
						io.read_integer
						x := io.last_integer
						output2 := gameboard1.attack (x + 2, y)
						turn2 := turn2 + 1
						if output2.is_equal ("Hit!") then
							score2 := score2 + 1
						end
						print (output2)
						display_result(score2, turn2)
						gameboard1.display
					end
				end
			end
		end

		display_result(score: INTEGER; turn: INTEGER)
		do
			print ("%NScore: ")
			print (score)
			print ("%NTurn: ")
			print (turn)
			print ("%N")
		end

end
