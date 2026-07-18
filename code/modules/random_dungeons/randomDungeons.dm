SUBSYSTEM_DEF(dungeon)
	name = "dungeon"
	flags = SS_NO_INIT|SS_BACKGROUND
	wait = 30 SECONDS
	runlevels = RUNLEVEL_GAME

	var/list/dungeons = list()




/datum/controller/subsystem/dungeon/init_z(var/name = "Unnamed Randomized Dungeon", type = /datum/space_level/random_dungeon)
	dungeons.Add(SSmapping.add_new_zlevel(name, ZTRAITS_DUNGEON, type))

/datum/controller/subsystem/dungeon/populate_level()


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


/datum/dungeon_room
	var/datum/space_level/random_dungeon/dungeon_type = /datum/space_level/random_dungeon
	var/list/obj/machinery/door/doors = list()
	var/list/mob/mobs = list()
	
	// (x0,y0, x1,y1)
	var/list/bounds = list(0,0, 3,3)

/datum/dungeon_room/set_doors(open = TRUE)
	for(var/obj/machinery/door/thisdoor in doors)
		if(open == TRUE)
			thisdoor.open()
		else
			thisdoor.close()
