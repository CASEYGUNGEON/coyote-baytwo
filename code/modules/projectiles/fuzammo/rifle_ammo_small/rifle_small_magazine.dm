/obj/item/ammo_box/magazine/a223
	name = "magazine template (.223)"
	desc = "should not be here, bugreport."
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	ammo_type = /obj/item/ammo_casing/a223
	caliber = list(CALIBER_223)
	multiple_sprites = 2

/// stanag 10 round ///
/obj/item/ammo_box/magazine/a223/stanag/ten
	name = "short box magazine (.223)"
	desc = "A standard 10 round rifle magazine."
	icon_state = "r10"
	max_ammo = 10
	custom_materials = list(/datum/material/iron = MATS_SMALL_PISTOL_MAGAZINE)

/obj/item/ammo_box/magazine/a223/stanag/ten/empty
	start_empty = 1

/datum/design/ammolathe/a223_s10
	name = "short box magazine (.223)"
	id = "a223_s10"
	materials = list(/datum/material/iron = 4000)
	build_path = /obj/item/ammo_box/magazine/a223/stanag/ten/empty
	category = list("initial", "Simple Magazines")

/// stanag 20 round ///
/obj/item/ammo_box/magazine/a223/stanag/twenty
	name = "straight box magazine (.223)"
	desc = "A standard 20 round rifle magazine."
	icon_state = "r20"
	max_ammo = 20
	custom_materials = list(/datum/material/iron = MATS_LIGHT_SMALL_RIFLE_MAGAZINE)

/obj/item/ammo_box/magazine/a223/stanag/twenty/empty
	start_empty = 1

/datum/design/ammolathe/a223_s20
	name = "straight box magazine (.223)"
	id = "a223_s20"
	materials = list(/datum/material/iron = 4000)
	build_path = /obj/item/ammo_box/magazine/a223/stanag/twenty/empty
	category = list("initial", "Simple Magazines")

/// stanag 30 round ///
/obj/item/ammo_box/magazine/a223/stanag/thirty
	name = "box magazine (.223)"
	desc = "A standard 30 round rifle magazine."
	icon_state = "r30"
	max_ammo = 30
	custom_materials = list(/datum/material/iron = MATS_MEDIUM_SMALL_RIFLE_MAGAZINE)

/obj/item/ammo_box/magazine/a223/stanag/thirty/empty
	start_empty = 1

/datum/design/ammolathe/a223_s30
	name = "box magazine (.223)"
	id = "a223_s30"
	materials = list(/datum/material/iron = 4000)
	build_path = /obj/item/ammo_box/magazine/a223/stanag/thirty/empty
	category = list("initial", "Simple Magazines")

/// minimi belt box ///
/obj/item/ammo_box/magazine/a223/hundred
	name = "belt box (.223)"
	desc = "A rigid box containing a 100 round belt."
	icon_state = "minimi"
	max_ammo = 100
	custom_materials = list(/datum/material/iron = MATS_MEDIUM_EXTENDED_RIFLE_MAGAZINE)

/obj/item/ammo_box/magazine/a223/hundred/empty
	start_empty = 1

/datum/design/ammolathe/a223_100
	name = "belt box (.223)"
	id = "a223_100"
	materials = list(/datum/material/iron = 4000)
	build_path = /obj/item/ammo_box/magazine/a223/hundred/empty
	category = list("initial", "Simple Magazines")
