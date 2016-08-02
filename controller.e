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

	--Display player result consisting of their score and number of turns taken
	--Takes player score and turn count as input
	display_result (score: INTEGER; turn: INTEGER)
		require
			--Requires that the input parameters are not void
			score_check: score /= void
			turn_check:	turn /= void
		do
			--Print approriate results
			print ("%NScore: ")
			print (score)
			print ("%NTurn: ")
			print (turn)
			print ("%N")
		end

invariant
	--done_check: done = true -> exit current game AND done = false -> current game in progress
	score_check:	score1 >= 0 and score2 >= 0	--Ensure player scores are greater than or equal to 0
end
