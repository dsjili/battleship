note
	description: "Instance accessor class for INTERFACE"
	author: "Li Yin, 211608973, yinl1"
	coauthors: "David Iliaguiev, Ting Feng Cheung"
	date: "$Date$"
	revision: "$Revision$"

class
	NEW_INTERFACE

inherit
	INTERFACE_ACCESSOR
	rename interface as the_interface end

feature

	--Creates only one instance of C_INTERFACE
	the_interface: INTERFACE_SINGLETON
	once
		create Result.make
	end

end
