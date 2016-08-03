note
	description: "Summary description for {CONTROLLER}."
	author: "David Iliaguiev, Li Yin, Tin Feng Cheung"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CONTROLLER

feature

	done: BOOLEAN	--Boolean variable to determine status of the game

	score1: INTEGER	--Player score for single player and P1 multiplayer

	score2: INTEGER	--Player score for P2 multiplayer

	--This function checks user location input and returns true if the input is valid
	--and false otherwise.
	--Takes a character and integer as parameters
	check_input(c: CHARACTER; i: INTEGER): BOOLEAN
	do
		Result := false

		--Check if the character and integer are within desired range of values
		--If not, notifiy the player that their input is invalid and ask them to try again
		if
			(c = 'a' OR c = 'A' OR
			c = 'b' OR c = 'B' OR
			c = 'c' OR c = 'C' OR
			c = 'd' OR c = 'D' OR
			c = 'e' OR c = 'E' OR
			c = 'f' OR c = 'F' OR
			c = 'g' OR c = 'G' OR
			c = 'h' OR c = 'H' OR
			c = 'i' OR c = 'I' OR
			c = 'j' OR c = 'J' OR
			c = 's' OR c = 'S')
			AND
			i >= 0 AND i <= 9
		then
			Result := true
		else
			print("Invalid Location! Please try again%N")
		end
	ensure
		--Ensure that result is not void
		result_check: Result /= void
	end

	--Refreshes all controller variables for new game status
	refresh
	do
		score1 := 0
		score2 := 0
		done := false
	end

	--Display player result consisting of their score and number of turns taken
	--Takes player score and turn count as input
	display_result (score: INTEGER; turn: INTEGER)
		require
			--Requires that the input parameters are not void and >= 0
			score_check: score /= void and score >= 0
			turn_check:	turn /= void and turn >= 0
		do
			--Print approriate results
			print ("%NScore: ")
			print (score)
			print ("%NTurn: ")
			print (turn)
			print ("%N")
		ensure
			--Ensure that no changes have been made to score and turn when displaying result
			score_unchanged: score = old score
			turn_unchanged: turn = old turn
			--Requires that the input parameters are not void and >= 0
			score_check: score /= void and score >= 0
			turn_check:	turn /= void and turn >= 0
		end

invariant
	--done_check: done = true -> exit current game AND done = false -> current game in progress
	score_check:	score1 >= 0 and score2 >= 0	--Ensure player scores are greater than or equal to 0
end
