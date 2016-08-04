note
	description: "Prompts user for input and translates input into X and Y matrix coordinates."
	author: "Li Yin, 211608973, yinl1"
	coauthors: "David Iliaguiev, Ting Feng Cheung"
	date: "$Date$"
	revision: "$Revision$"

class
	ATTACK_VIEW

feature

	--Prompts user for location input for single player modes
	display_attack
		do
			print ("Please select a cell to attack!%N")
			print ("Please enter a letter from A-J followed by a number from 0-9 and the ENTER key:%N")
			print ("(Type S followed by the ENTER key to forfeit current game)%N")
		end

	--Prompts player 1 for location input for multiplayer mode
	display_attackp1
		do
			print ("P1: Please select a cell to attack!%N")
			print ("P1: Please enter a letter from A-J followed by a number from 0-9 and the ENTER key:%N")
			print ("(Type S followed by the ENTER key to forfeit current game)%N")
		end

	--Prompts player 2 for location input for multiplayer mode
	display_attackp2
		do
			print ("P2: Please select a cell to attack!%N")
			print ("P2: Please enter a letter from A-J followed by a number from 0-9 and the ENTER key:%N")
			print ("(Type S followed by the ENTER key to forfeit current game)%N")
		end

	--Gets x coordinate value from user input
	get_char:CHARACTER
		local
			s: STRING
		do
			io.read_line
			s:= io.last_string
			Result := s.item (1)
		ensure
			result_not_void:	Result /= VOID
			--	result_is_alpha:	Result.is_alpha
			--	This ^ is ensured by the controller on return
		end

	--Gets y coordinate value from user input
	get_int:INTEGER
		local
			s: STRING
		do
			s := io.last_string

			if s.count = 2 then
				Result:= convert_int(s.item (2))
			elseif s.item (1) = 's' OR s.item (1) = 'S' then
				Result := 0
			else
				Result:= -1
			end

		ensure
			result_not_void:	Result /= VOID
			--	result_range:	Result >= 0 and Result <= 9
			--	This ^ is checked by controller on return
		end

	--Converts character to corresponding integer value
	convert_int(c:CHARACTER):INTEGER
	do
		inspect c
			when '0' then
				Result := 0
			when '1' then
				Result := 1
			when '2' then
				Result := 2
			when '3' then
				Result := 3
			when '4' then
				Result := 4
			when '5' then
				Result := 5
			when '6' then
				Result := 6
			when '7' then
				Result := 7
			when '8' then
				Result := 8
			when '9' then
				Result := 9
			else
				Result := -1
			end
		ensure
			--Ensures that returned value is not void and is a valid value
			result_not_void:	Result /= VOID
			--	result_range:	Result >= -1 and Result <= 9
	end
end
