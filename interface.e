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
				print ("Press 1 for single-player mode%N")
				print ("Press 2 for two-player mode%N")
				print ("Press 3 for instructions%N")
				io.read_integer
				x := io.last_integer
				if x = 1 then
					gameboard1.new_board
					gameboard1.display_solution
					exit := interact_solo
				elseif x = 2 then
					gameboard1.new_board
					gameboard1.display_solution
					gameboard2.random_char
					gameboard2.new_board
					gameboard2.display_solution
					exit := interact_multi
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
				print ("Please enter a number from 0-9 followed by the ENTER key:%N")
				io.read_integer
				x := io.last_integer
				print ("Please enter a letter from A-J followed by the ENTER key:%N")
				io.read_character
				y := io.last_character
				output := gameboard1.attack (x + 2, y)
				turn := turn + 1
				if
					output = "Hit!"
				then
					score := score + 1
				end
				print (output)
				print ("%N")
				print (score)
				print ("%N")
				print (turn)
				print ("%N")
				gameboard1.display
			end
		end

	interact_multi: BOOLEAN
		local
			x: INTEGER
			y: CHARACTER
			output1: STRING
			output2: STRING
			done: BOOLEAN
		do
			from
			until
				done
			loop
				print ("P1: Please select a cell to attack!%N")
				print ("P1: Please enter a number from 0-9 followed by the ENTER key:%N")
				io.read_integer
				x := io.last_integer
				print ("P1: Please enter a letter from A-J followed by the ENTER key:%N")
				io.read_character
				y := io.last_character
				output1 := gameboard2.attack (x + 2, y)
				print (output1)
				print ("%N")
				gameboard2.display
				print ("P2: Please select a cell to attack!%N")
				print ("P2: Please enter a number from 0-9 followed by the ENTER key:%N")
				io.read_integer
				x := io.last_integer
				print ("P2: Please enter a letter from A-J followed by the ENTER key:%N")
				io.read_character
				y := io.last_character
				output2 := gameboard1.attack (x + 2, y)
				print (output2)
				print ("%N")
				gameboard1.display
			end
		end

end
