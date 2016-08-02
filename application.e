note
	description : "Battleship application root class"
	author: "David Iliaguiev, Li Yin, Tin Feng Cheung"
	date        : "$Date$"
	revision    : "$Revision$"

class
	APPLICATION

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	interface: INTERFACE

	make
			-- Run application.
		do
			--| Add your code here
			create interface.make

		end

end
