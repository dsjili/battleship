note
	description: "Summary description for {NEW_INTERFACE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NEW_INTERFACE

inherit
	INTERFACE_ACCESSOR
	rename interface as the_interface end

feature

	--Creates only one instance of C_INTERFACE
	the_interface: C_INTERFACE
	once
		create Result.make
	end

end
