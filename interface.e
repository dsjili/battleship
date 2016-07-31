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

	gameboard: BOARD

	exit: BOOLEAN

	make
		do
			create gameboard.make
			from
			until
				exit
			loop
				gameboard.new_board
				gameboard.display_solution
				exit := interact
			end
		end

	interact: BOOLEAN
		local
			x: INTEGER
			y: CHARACTER
			output: STRING
			done: BOOLEAN
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
				output := gameboard.attack (x + 2, y)
				print (output)
				print ("%N")
				gameboard.display
			end
		end

end
