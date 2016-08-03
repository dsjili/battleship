note
	description: "Summary description for {ATTACK_VIEW}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ATTACK_VIEW

feature

	display_attack
		do
			print ("Please select a cell to attack!%N")
			print ("Please enter a letter from A-J followed by a number from 0-9 and the ENTER key:%N")
			print ("(Type S followed by any number and the ENTER key to forfeit current game)%N")
		end

	display_attackp1
		do
			print ("P1: Please select a cell to attack!%N")
			print ("P1: Please enter a letter from A-J followed by a number from 0-9 and the ENTER key:%N")
			print ("(Type S followed by any number and the ENTER key to forfeit current game)%N")
		end

	display_attackp2
		do
			print ("P2: Please select a cell to attack!%N")
			print ("P2: Please enter a letter from A-J followed by a number from 0-9 and the ENTER key:%N")
			print ("(Type S followed by any number and the ENTER key to forfeit current game)%N")
		end

	get_char:CHARACTER
		do
			io.read_character
			Result := io.last_character
		ensure
			result_not_void:	Result /= VOID
			--	result_is_alpha:	Result.is_alpha
			--	This ^ is ensured by the controller on return
		end

	get_int:INTEGER
		do
			io.read_integer
			Result := io.last_integer
		ensure
			result_not_void:	Result /= VOID
			--	result_range:	Result >= 0 and Result <= 9
			--	This ^ is checked by controller on return
		end
end
