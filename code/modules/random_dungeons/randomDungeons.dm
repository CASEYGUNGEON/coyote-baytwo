SUBSYSTEM_DEF(dungeon)
	name = "dungeon"
	flags = SS_NO_INIT|SS_BACKGROUND
	wait = 30 SECONDS
	runlevels = RUNLEVEL_GAME

	var/list/dungeons = list()




/datum/controller/subsystem/dungeon/init_z(var/name = "Unnamed Randomized Dungeon", type = /datum/space_level/random_dungeon)
	var/newlevel = SSmapping.add_new_zlevel(name, ZTRAITS_DUNGEON, type)
	dungeons.Add(newlevel)

/datum/controller/subsystem/dungeon/populate_level(/datum/space_level/random_dungeon/zlevel)
	zlevel.populate()


/datum/space_level/random_dungeon
	name = "Randomized Dungeon"

	// types to choose from for map generation
	var/list/turf/closed/walls = list(/turf/closed/indestructible = 1)
	var/list/turf/open/floors = list(/turf/open/floor = 1)
	var/list/obj/machinery/door/doors = list(/obj/machinery/door = 1)

	// premapped room templates
	var/list/datum/map_template/prefabs = list()

	// key: room num, value: list of doors in room
	var/list/doors_by_room = alist()

/datum/space_level/random_dungeon/pick_wall()
	return pickweight(walls, 1)

/datum/space_level/random_dungeon/pick_ground()
	return pickweight(floors, 1)

/datum/space_level/random_dungeon/pick_door()
	return pickweight(doors, 1)

/datum/space_level/random_dungeon/make_room()
	var/datum/dungeon_room/room = new /datum/dungeon_room()
	room.dungeon_type = type

/datum/space_level/random_dungeon/populate()
	//TODO: find room placements and init first room.
	break


/datum/dungeon_room
	var/datum/space_level/random_dungeon/dungeon_type = /datum/space_level/random_dungeon
	var/list/mob/mobs = list()
	var/list/turf/closed/wall_types = null
	var/list/turf/closed/floor_types = null
	
	// (x0,y0, x1,y1)
	var/list/bounds = list(0,0, 5,5)

/datum/dungeon_room/place(x1 = 0, y1 = 0, z = 0)
	var/x2 = x1+bounds[2]
	var/y2 = y1+bounds[3]
	for (x in range(x1, x2))
		for (y in range(y1, y2))
			var/turf/turfloc = locate(x,y,z)

			//set turf
			if (x==x1 || y==y1)
				turfloc = new(pickweight(wall_types))
			else
				turfloc = new(pickweight(floor_types))
			
			//TODO: populate mobs and objects
			//TODO: place doors

/datum/dungeon_room/finish()
	//TODO: Clean up, set up to load next rooms
	break

/datum/dungeon_room/set_doors(open = TRUE)
	for(var/obj/machinery/door/thisdoor in doors)
		if(open == TRUE)
			thisdoor.open()
		else
			thisdoor.close()
