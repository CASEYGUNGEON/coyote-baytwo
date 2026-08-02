/obj/structure/destructible //a base for destructible structures
	max_integrity = 100
	var/break_message = span_warning("$SRC$ breaks!") //The message shown when a structure breaks
	var/break_sound = 'sound/misc/crack.ogg' //The sound played when a structure breaks
	var/list/debris = null //Parts left behind when a structure breaks, takes the form of list(path = amount_to_spawn)

/obj/structure/destructible/deconstruct(disassembled = TRUE)
	if(!disassembled)
		if(!(flags_1 & NODECONSTRUCT_1))
			if(islist(debris))
				for(var/I in debris)
					for(var/i in 1 to debris[I])
						new I (get_turf(src))
		if(break_message)
			var/brkmsg = replacetext(break_message, "$SRC$", "\the [src]")
			visible_message(brkmsg)
		if(break_sound)
			playsound(src, break_sound, 50, 1)
	qdel(src)
	return 1
