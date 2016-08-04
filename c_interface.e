note
	description: "Main controller class for Battleship game and responsible for game creation (SINGLETON)"
	author: "Li Yin, 211608973, yinl1"
	coauthor: "David Iliaguiev, Li Yin, Ting Fai Cheung"
	date: "$Date$"
	revision: "$Revision$"

class
	C_INTERFACE

feature{NONE}

	--Unique instance of C_INTERFACE class
	frozen the_interface: C_INTERFACE
	once
		Result:= current
	end

invariant
	--Ensure singleton status is preserved
	only_one_instance: Current = the_interface

end
