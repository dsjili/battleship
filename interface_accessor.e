note
	description: "Singleton accessor class for INTERFACE"
	author: "Li Yin, 211608973, yinl1"
	coauthors: "David Iliaguiev, Ting Feng Cheung"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	INTERFACE_ACCESSOR

feature{NONE}

	--Provides access to unique instance
	interface: C_INTERFACE
	deferred
	end

	--Check singleton status
	is_real_interface: BOOLEAN
	do
		Result:= interface = interface
	end

invariant
	--Ensure that there is only one instance of interface
	real_interface: is_real_interface

end
