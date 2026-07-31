//9mm magazine parent
/obj/item/ammo_box/magazine/a45
	name = "magazine template (.45ACP)"
	desc = "should not be here, bugreport."
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	ammo_type = /obj/item/ammo_casing/a45
	caliber = list(CALIBER_45ACP)
	multiple_sprites = 2

// 8rnd single stack pistol magazine
/obj/item/ammo_box/magazine/a45/eight
	name = "pistol magazine (.45ACP)"
	desc = "An 8 round single-stack pistol magazine."
	icon_state = "45"
	max_ammo = 8
	multiple_sprites = 1
	custom_materials = list(/datum/material/iron = MATS_MEDIUM_PISTOL_MAGAZINE)

/obj/item/ammo_box/magazine/a45/eight/empty
	start_empty = 1

/datum/design/ammolathe/a45_8
	name = "pistol magazine (.45ACP)"
	id = "a45_8"
	materials = list(/datum/material/iron = 4000)
	build_path = /obj/item/ammo_box/magazine/a45/eight/empty
	category = list("initial", "Simple Magazines")

// standard 30rnd smg straight magazine
/obj/item/ammo_box/magazine/a45/thirty
	name = "smg magazine (.45ACP)"
	desc = "A standard 30 round smg magazine."
	icon_state = "grease"
	max_ammo = 30
	custom_materials = list(/datum/material/iron = MATS_SMG)

/obj/item/ammo_box/magazine/a45/thirty/empty
	start_empty = 1

/datum/design/ammolathe/a45_30
	name = "smg magazine (.45ACP)"
	id = "a45_30"
	materials = list(/datum/material/iron = 4000)
	build_path = /obj/item/ammo_box/magazine/a45/thirty/empty
	category = list("initial", "Simple Magazines")
