note
	description: "Summary description for {INTERFACE_ACCESSOR}."
	author: ""
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
