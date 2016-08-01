note
	description: "Summary description for {BOARD}."
	author: "David Iliaguiev, Li Yin, Tin Feng Cheung"
	date: "$Date$"
	revision: "$Revision$"

class
	BOARD

create
	make

feature

	tmp_x, tmp_y: INTEGER

	Empty: CHARACTER
		once
			Result := ' '
		end

	Occupied: CHARACTER
		once
			Result := '#'
		end

	Hit: CHARACTER
		once
			Result := 'x'
		end

	Marked: CHARACTER
		once
			Result := '*'
		end

	random_sequence: RANDOM

	board: ARRAY2 [CHARACTER]

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
			create board.make_filled (' ', 11, 11)
		end

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
			random_char
		end

	display
		local
			i, j: INTEGER
		do
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
		end

		display_solution
		local
			i, j: INTEGER
		do
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
					print (board.item (i, j))
					print (Empty)
					j := j + 1
				end
				print ("%N")
				i := i + 1
			end
		end

	new_ship
		do
		end

	random_int: INTEGER
		do
			random_sequence.forth
			Result := random_sequence.item
		end

	random_char
		local
			i: INTEGER
		do
			from
				i := 1
			until
				i > 5
			loop
				tmp_x := random_int \\ 10 + 2
				tmp_y := random_int \\ 10 + 2
				if board.item (tmp_x, tmp_y) /= Occupied then
					if ((tmp_y + i) <= 11 AND check_one (i)) OR ((tmp_x + i) <= 11 AND check_two (i)) OR ((tmp_y - i) >= 2 AND check_three (i)) OR ((tmp_x - i) >= 2 AND check_four (i)) then
						board.put (Occupied, tmp_x, tmp_y)
						draw_ship (i)
						i := i + 1
					end
				end
			end
		end

	draw_ship (i: INTEGER)
		local
			value: INTEGER
			j, k: INTEGER
		do
			from
				k := 0
			until
				k > 0
			loop
				value := random_int \\ 4 + 1
				if value = 1 then
					if (tmp_y + i) <= 11 AND check_one (i) then
						from
							j := 1
						until
							j > i
						loop
							board.put (Occupied, tmp_x, tmp_y + j)
							j := j + 1
						end
						k := 1
					end
				end
				if value = 2 then
					if (tmp_x + i) <= 11 AND check_two (i) then
						from
							j := 1
						until
							j > i
						loop
							board.put (Occupied, tmp_x + j, tmp_y)
							j := j + 1
						end
						k := 1
					end
				end
				if value = 3 then
					if (tmp_y - i) >= 2 AND check_three (i) then
						from
							j := 1
						until
							j > i
						loop
							board.put (Occupied, tmp_x, tmp_y - j)
							j := j + 1
						end
						k := 1
					end
				end
				if value = 4 then
					if (tmp_x - i) >= 2 AND check_four (i) then
						from
							j := 1
						until
							j > i
						loop
							board.put (Occupied, tmp_x - j, tmp_y)
							j := j + 1
						end
						k := 1
					end
				end
			end
		end

	check_one (i: INTEGER): BOOLEAN
		local
			j: INTEGER
		do
			Result := true
			from
				j := 1
			until
				j > i
			loop
				if board.item (tmp_x, tmp_y + j) = Occupied then
					Result := false
				end
				j := j + 1
			end
		end

	check_two (i: INTEGER): BOOLEAN
		local
			j: INTEGER
		do
			Result := true
			from
				j := 1
			until
				j > i
			loop
				if board.item (tmp_x + j, tmp_y) = Occupied then
					Result := false
				end
				j := j + 1
			end
		end

	check_three (i: INTEGER): BOOLEAN
		local
			j: INTEGER
		do
			Result := true
			from
				j := 1
			until
				j > i
			loop
				if board.item (tmp_x, tmp_y - j) = Occupied then
					Result := false
				end
				j := j + 1
			end
		end

	check_four (i: INTEGER): BOOLEAN
		local
			j: INTEGER
		do
			Result := true
			from
				j := 1
			until
				j > i
			loop
				if board.item (tmp_x - j, tmp_y) = Occupied then
					Result := false
				end
				j := j + 1
			end
		end

	attack (c1: INTEGER; c2: CHARACTER): STRING
		local
			x, y: INTEGER
		do
			x := c1
			y := toint (c2)
			if board.item (x, y) = Occupied then
				board.put (Hit, x, y)
				Result := "Hit!"
			elseif board.item (x, y) = Empty then
				board.put (Marked, x, y)
				Result := "Miss!"
			elseif board.item (x, y) = Marked then
				Result := "You have already targeted this cell!"
			else
				Result := "Invalid cell!"
			end
		end

	toint (c: CHARACTER): INTEGER
		do
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
		end

		--	if value = 0 then Result:= 'A' end
		--	if value = 1 then Result:= 'B' end
		--	if value = 2 then Result:= 'C' end
		--	if value = 3 then Result:= 'D' end
		--	if value = 4 then Result:= 'E' end
		--	if value = 5 then Result:= 'F' end
		--	if value = 6 then Result:= 'G' end
		--	if value = 7 then Result:= 'H' end
		--	if value = 8 then Result:= 'I' end
		--	if value = 9 then Result:= 'J' end

end
