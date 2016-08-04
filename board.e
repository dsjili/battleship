note
	description: "Summary description for {BOARD}."
	author: "David Iliaguiev, Li Yin, Ting Fai Cheung"
	date: "$Date$"
	revision: "$Revision$"

class
	BOARD

create
	make

feature

	--Temporary integers representing x and y coordinates on the matrix
	tmp_x, tmp_y: INTEGER

	--Constant for 'empty' character
	Empty: CHARACTER
		once
			Result := ' '
		end

	--Constant for 'occupied' character
	Occupied: CHARACTER
		once
			Result := '#'
		end

	--Constant for 'hit' character
	Hit: CHARACTER
		once
			Result := 'x'
		end

	--Constant for 'marked' character
	Marked: CHARACTER
		once
			Result := '*'
		end

	--New random sequence consisting of random integers
	random_sequence: RANDOM

	--New two-dimensional array consisting of characters
	board: ARRAY2 [CHARACTER]

	--Make function for BOARD class
	make

		local
			l_time: TIME
			l_seed: INTEGER
		do
				-- This computes milliseconds since midnight.
				-- Milliseconds since 1970 would be even better.
			create l_time.make_now
			l_seed := l_time.hour
			l_seed := l_seed * 60 + l_time.minute
			l_seed := l_seed * 60 + l_time.second
			l_seed := l_seed * 1000 + l_time.milli_second
			create random_sequence.set_seed (l_seed)
				-- Now you can use the random_sequence and it will be different each time

			--Creates a new board of empty spaces
			create board.make_filled (' ', 11, 11)
		end

	--This function generates a new battleship board with randomized ship locations
	new_board
		do
			board.fill_with (' ')
			board.put (' ', 1, 1)
			board.put ('A', 1, 2)
			board.put ('B', 1, 3)
			board.put ('C', 1, 4)
			board.put ('D', 1, 5)
			board.put ('E', 1, 6)
			board.put ('F', 1, 7)
			board.put ('G', 1, 8)
			board.put ('H', 1, 9)
			board.put ('I', 1, 10)
			board.put ('J', 1, 11)
			board.put ('0', 2, 1)
			board.put ('1', 3, 1)
			board.put ('2', 4, 1)
			board.put ('3', 5, 1)
			board.put ('4', 6, 1)
			board.put ('5', 7, 1)
			board.put ('6', 8, 1)
			board.put ('7', 9, 1)
			board.put ('8', 10, 1)
			board.put ('9', 11, 1)

			--Calls random_char to generate random ships
			random_char
		end

	--This functions checks whether player has cleared the game or not
	check_clear: BOOLEAN
	local
			i, j: INTEGER	--Local loop counters
		do
			Result:= true
			--Two-level loop ensures all cells are checked
			from
				i := 1
			until
				i > 11
			loop
				from
					j := 1
				until
					j > 11
				loop

					--Checks if board at current cell is occupied, if so,
					--
					if board.item (i, j) = Occupied then
						Result:= false
					end
					j := j + 1
				end
				i := i + 1
			end
		end

	--This function displays the contents of the board for players with the ships hidden
	display
		local
			i, j: INTEGER	--Local loop counters
		do
			--Two-level loop ensures all cells are printed
			from
				i := 1
			until
				i > 11
			loop
				from
					j := 1
				until
					j > 11
				loop

					--Checks if board at current cell is occupied, if not,
					--then display cell contents, otherwise display empty.
					if board.item (i, j) /= Occupied then
						print (board.item (i, j))
					else
						print (Empty)
					end
					print (Empty)
					j := j + 1
				end
				print ("%N")
				i := i + 1
			end
		ensure
			--ensure_display: ensure that the right result is printed to the board
			--				  and that no occupied cell is printed.
		end

	--This function displays the contents of the board with the ship locations revealed
	display_solution
		local
			i, j: INTEGER	--Local loop counters
		do
			--Two-level loop ensures all cells are printed
			from
				i := 1
			until
				i > 11
			loop
				from
					j := 1
				until
					j > 11
				loop
					--Displays all items in the matrix
					print (board.item (i, j))
					print (Empty)
					j := j + 1
				end
				print ("%N")
				i := i + 1
			end
		ensure
			--ensure_display: ensure that all cells of the board are displayed correctly
		end

	--This function returns a random integer from the random sequence and
	--increments random sequence index
	random_int: INTEGER
		do
			random_sequence.forth	--Increment random_sequence index
			Result := random_sequence.item	--Return current item in sequence
		ensure
			result_check: Result >= 0	--Check to ensure result is integer greater than 0
		end

	--This function randomly generates the location for the head of a ship and
	--ensures that the ship will be confined to the size of the matrix
	random_char
		local
			i: INTEGER	--Local loop counter representing length of ship not including the head
		do
			from
				i := 1
			until
				i > 5
			loop
				--Randomly generates a X and Y coordinates in which to place the new ship head
				--X and Y values restricted to size of the matrix
				tmp_x := random_int \\ 10 + 2
				tmp_y := random_int \\ 10 + 2

				--Checks if selected cell has already been occupied by another ship
				if board.item (tmp_x, tmp_y) /= Occupied
				then
					--Checks if ship will exceed the boundaries of the matrix
					if ((tmp_y + i) <= 11 AND check_one (i)) OR
						((tmp_x + i) <= 11 AND check_two (i)) OR
						((tmp_y - i) >= 2 AND check_three (i)) OR
						((tmp_x - i) >= 2 AND check_four (i))
					then
						--Set current cell to occupied and proceed to draw ship					
						board.put (Occupied, tmp_x, tmp_y)
						draw_ship (i)
						i := i + 1
					end
				end
				--Note: if selected cell does not pass the two checks above, it will
				--regenerate a new random cell without incrementing the current index
			end
		ensure
			--ensure_random: ensure board has been randomized and all ships are drawn to board
		end

	--This function draws ships based on the size of the ship, as specified by the function parameter
	--Size of ship taken as input
	draw_ship (i: INTEGER)
		require
			min_max_ship_size: i >= 1 and i <= 5	--Requires that size of the ships are between 2 and 6 units
		local
			value: INTEGER	--Local variable for randomized ship orientation
			j: INTEGER	--Local loop counter
			k: BOOLEAN	--Loop condition to check if ship has been successfully drawn
		do
			from
				k := false
			until
				k
			loop
				--Randomly generates an orientation of the ship
				value := random_int \\ 4 + 1

				--If orientation is 1, then ship will extend down
				if value = 1 then

					--Check that ship will be within boundaries of matrix
					--and no other ships in its way
					if (tmp_y + i) <= 11 AND check_one (i) then
						from
							j := 1
						until
							j > i
						loop
							--Draw ship onto board
							board.put (Occupied, tmp_x, tmp_y + j)
							j := j + 1
						end
						k := true
					end
				end

				--If orientation is 2, then ship will extend right
				if value = 2 then

					--Check that ship will be within boundaries of matrix
					--and no other ships in its way
					if (tmp_x + i) <= 11 AND check_two (i) then
						from
							j := 1
						until
							j > i
						loop
							--Draw ship onto board
							board.put (Occupied, tmp_x + j, tmp_y)
							j := j + 1
						end
						k := true
					end
				end

				--If orientation is 3, then ship will extend up
				if value = 3 then

					--Check that ship will be within boundaries of matrix
					--and no other ships in its way
					if (tmp_y - i) >= 2 AND check_three (i) then
						from
							j := 1
						until
							j > i
						loop
							--Draw ship onto board
							board.put (Occupied, tmp_x, tmp_y - j)
							j := j + 1
						end
						k := true
					end
				end

				--If orientation is 4, then ship will extend left
				if value = 4 then

					--Check that ship will be within boundaries of matrix
					--and no other ships in its way
					if (tmp_x - i) >= 2 AND check_four (i) then
						from
							j := 1
						until
							j > i
						loop
							--Draw ship onto board
							board.put (Occupied, tmp_x - j, tmp_y)
							j := j + 1
						end
						k := true
					end
				end
			end
		end

	--Ensures that no ships are in the way of the current ship about to be drawn (downward)
	check_one (i: INTEGER): BOOLEAN
		require
			--Requires that the ship is within the designated ship sizes for the game
			min_max_ship_size: i >= 1 and i <= 5
		local
			j: INTEGER	--Local loop counter
		do
			--Initially set result to true, and there is no other ship in the way
			Result := true
			from
				j := 1
			until
				j > i
			loop
				--If any cells in the drawing path of the current ship is occupied,
				--return false and a new orientation or head location will be randomly
				--generated
				if board.item (tmp_x, tmp_y + j) = Occupied then
					Result := false
				end
				j := j + 1
			end
		ensure
			--Return value must not be void
			result_check: Result /= void
		end

	--Ensures that no ships are in the way of the current ship about to be drawn (rightward)
	check_two (i: INTEGER): BOOLEAN
		require
			--Requires that the ship is within the designated ship sizes for the game
			min_max_ship_size: i >= 1 and i <= 5
		local
			j: INTEGER	--Local loop counter
		do
			--Initially set result to true, and there is no other ship in the way
			Result := true
			from
				j := 1
			until
				j > i
			loop
				--If any cells in the drawing path of the current ship is occupied,
				--return false and a new orientation or head location will be randomly
				--generated
				if board.item (tmp_x + j, tmp_y) = Occupied then
					Result := false
				end
				j := j + 1
			end
		ensure
			--Return value must not be void
			result_check: Result /= void
		end

	--Ensures that no ships are in the way of the current ship about to be drawn (upward)
	check_three (i: INTEGER): BOOLEAN
		require
			--Requires that the ship is within the designated ship sizes for the game
			min_max_ship_size: i >= 1 and i <= 5
		local
			j: INTEGER	--Local loop counter
		do
			--Initially set result to true, and there is no other ship in the way
			Result := true
			from
				j := 1
			until
				j > i
			loop
				--If any cells in the drawing path of the current ship is occupied,
				--return false and a new orientation or head location will be randomly
				--generated
				if board.item (tmp_x, tmp_y - j) = Occupied then
					Result := false
				end
				j := j + 1
			end
		ensure
			--Return value must not be void
			result_check: Result /= void
		end

	--Ensures that no ships are in the way of the current ship about to be drawn (leftward)
	check_four (i: INTEGER): BOOLEAN
		require
			--Requires that the ship is within the designated ship sizes for the game
			min_max_ship_size: i >= 1 and i <= 5
		local
			j: INTEGER	--Local loop counter
		do
			--Initially set result to true, and there is no other ship in the way
			Result := true
			from
				j := 1
			until
				j > i
			loop
				--If any cells in the drawing path of the current ship is occupied,
				--return false and a new orientation or head location will be randomly
				--generated
				if board.item (tmp_x - j, tmp_y) = Occupied then
					Result := false
				end
				j := j + 1
			end
		ensure
			--Return value must not be void
			result_check: Result /= void
		end

	--This function performs the attack command on the corresponding board
	--X and Y 'raw' coordinate values taken as input
	attack (c1: INTEGER; c2: CHARACTER): STRING
		require
			--Parameter checks to ensure they are valid
			check_c1: c1 >= 2 and c1 <= 11
			check_c2: c2.is_alpha
		local
			x, y: INTEGER	--Local variables representing X and Y coordinate values
		do
			--Set X and Y coordinate values based on input parameters
			x := c1
			y := toint (c2)

			--Checks to determine status of selected cell
			--If occupied, replace cell with 'X' and return "Hit!"
			if board.item (x, y) = Occupied then
				board.put (Hit, x, y)
				Result := "Hit!"
			--If empty, replace cell with '*' and return "Miss!"
			elseif board.item (x, y) = Empty then
				board.put (Marked, x, y)
				Result := "Miss!"
			--If previously targeted, return warning to player
			elseif board.item (x, y) = Marked OR board.item (x, y) = Hit then
				Result := "You have already targeted this cell!"
			--Else the selected cell is invalid
			else
				Result := "Invalid cell!"
			end
		ensure
			--Ensure that the return value is not void
			result_check: Result /= void
		end

	--This function converts the X coordinate character to its corresponding matrix position
	toint (c: CHARACTER): INTEGER
		require
			--Require that input parameter is a character
			check_char: c.is_alpha
		do
			--Switch mechanism checks and returns appropriate value
			inspect c
			when 'A', 'a' then
				Result := 2
			when 'B', 'b' then
				Result := 3
			when 'C', 'c' then
				Result := 4
			when 'D', 'd' then
				Result := 5
			when 'E', 'e' then
				Result := 6
			when 'F', 'f' then
				Result := 7
			when 'G', 'g' then
				Result := 8
			when 'H', 'h' then
				Result := 9
			when 'I', 'i' then
				Result := 10
			when 'J', 'j' then
				Result := 11
			else
				Result := -1
			end
		ensure
			--Ensure that result is not void
			result_check: Result /= void
			--Ensure result is in range
			range_check: Result >= 2 and Result <= 11
		end

invariant
	--Ensure that board contents are consistent with the types of characters allowed
	--check_items: For all items on the board,
	--			   item = 'X' OR item = '*' OR item = '#' OR item = ' '
end
