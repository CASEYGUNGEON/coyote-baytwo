/obj/item/ammo_box/magazine/internal/cylinder/a38
	name = ".38 cylinder"
	ammo_type = /obj/item/ammo_casing/a357
	caliber = list(CALIBER_38)
	max_ammo = 6




/obj/item/ammo_box/magazine/a9mm/doublestack
	name = "doublestack pistol magazine (9mm)"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "m9mmds"
	ammo_type = /obj/item/ammo_casing/a9mm
	caliber = list(CALIBER_9MM)
	max_ammo = 15
	multiple_sprites = 2
	custom_materials = list(/datum/material/iron = MATS_MEDIUM_PISTOL_MAGAZINE)

/obj/item/ammo_box/magazine/a9mm/doublestack/empty
	start_empty = 1

/datum/design/ammolathe/a9mmds
	name = "doublestack pistol magazine (9mm)"
	id = "a9mmds"
	materials = list(/datum/material/iron = 4000)
	build_path = /obj/item/ammo_box/magazine/a9mm/doublestack/empty
	category = list("initial", "Simple Magazines")
