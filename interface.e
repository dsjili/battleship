note
	description: "Summary description for {INTERFACE}."
	author: "David Iliaguiev, Li Yin, Tin Feng Cheung"
	date: "$Date$"
	revision: "$Revision$"

class
	INTERFACE

create
	make

feature

	gameboard1: BOARD

	gameboard2: BOARD

	csingleltd:C_SINGLE_LTD
	csingleunl:C_SINGLE_UNL
	cmulti:C_MULTI

	exit: BOOLEAN

	make
		local
			x: INTEGER
		do
			create gameboard1.make
			create gameboard2.make
			create cmulti
			create csingleltd
			create csingleunl

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
				print ("Press 5 to exit%N")
				io.read_integer
				x := io.last_integer
				if x = 1 then
					gameboard1.new_board
					csingleunl.interact(gameboard1)
				elseif x = 2 then
					gameboard1.new_board
					csingleltd.interact(gameboard1)
				elseif x = 3 then
					gameboard1.new_board
					gameboard2.random_char
					gameboard2.new_board
					cmulti.interact(gameboard1,gameboard2)
				elseif x = 4 then
					print ("Instructions%N")
				elseif x = 5 then
					exit := true
				else
					print ("Invalid input!%N")
				end
			end
		end

invariant
	board_not_null:	gameboard1 /= VOID and gameboard2 /= VOID
	controllers_not_null:	cmulti /= VOID and csingleltd /= VOID and csingleunl /= VOID
	not_exit:	-- exit = false implies exit /= true and the game is still being played

end
