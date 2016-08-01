note
	description: "Summary description for {CONTROLLER}."
	author: "David Iliaguiev, Li Yin, Tin Feng Cheung"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CONTROLLER

feature

	done: BOOLEAN

	score1: INTEGER

	score2: INTEGER

	display_result (score: INTEGER; turn: INTEGER)
		require
			score_check: score /= VOID
			turn_check:	turn /= VOID
		do
			print ("%NScore: ")
			print (score)
			print ("%NTurn: ")
			print (turn)
			print ("%N")
		end

invariant
	--done_check: done = true implies exit current game
	score_check:	score1 >= 0 and score2 >= 0
end
