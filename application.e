note
	description : "Battleship application root class"
	author: "Li Yin, 211608973, yinl1"
	coauthor: "David Iliaguiev, Li Yin, Ting Fai Cheung"
	date        : "$Date$"
	revision    : "$Revision$"

class
	APPLICATION

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	interface: NEW_INTERFACE

	make
			-- Run application.
		do
			--| Add your code here
			create interface

		end

end
