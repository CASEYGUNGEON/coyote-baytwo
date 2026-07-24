// 12 gauge is the standard


///////////////////////////////
////////// 12 gauge ammo //////////
///////////////////////////////

///////////////casing///////////////

/obj/item/ammo_casing/a12g
	name = "handloaded 12 gauge slug shell"
	desc = "A low-power 12 gauge slug shell."
	icon_state = "gshell"
	caliber = CALIBER_12G
	projectile_type = /obj/item/projectile/bullet/a12g
	material_class = BULLET_IS_SHOTGUN
	custom_materials = list(
		/datum/material/iron = MATS_SHOTGUN_CASING + MATS_SHOTGUN_BULLET,
		/datum/material/blackpowder = MATS_SHOTGUN_POWDER)
	fire_power = CASING_POWER_SHOTGUN * CASING_POWER_MOD_HANDLOAD
	sound_properties = CSP_SHOTGUN

/obj/item/ammo_casing/a12g/buck
	name = "handloaded 12 gauge buckshot shell"
	desc = "A low-power 12 gauge buckshot shell."
	icon_state = "bbshell"
	caliber = CALIBER_12G
	projectile_type = /obj/item/projectile/bullet/a12g/buck
	material_class = BULLET_IS_SHOTGUN
	custom_materials = list(
		/datum/material/iron = MATS_SHOTGUN_CASING + MATS_SHOTGUN_BULLET,
		/datum/material/blackpowder = MATS_SHOTGUN_POWDER)
	fire_power = CASING_POWER_SHOTGUN * CASING_POWER_MOD_HANDLOAD
	sound_properties = CSP_SHOTGUN

/obj/item/ammo_casing/a12g/q2
	name = "12 gauge slug shell"
	desc = "A 12 gauge slug shell."
	projectile_type = /obj/item/projectile/bullet/a12g/q2
	custom_materials = list(
		/datum/material/iron = MATS_SHOTGUN_CASING + MATS_SHOTGUN_BULLET,
		/datum/material/blackpowder = MATS_SHOTGUN_POWDER)
	fire_power = CASING_POWER_SHOTGUN * CASING_POWER_MOD_SURPLUS

/obj/item/ammo_casing/a12g/buck/q2
	name = "12 gauge buckshot shell"
	desc = "A 12 gauge buckshot shell."
	projectile_type = /obj/item/projectile/bullet/a12g/buck/q2
	custom_materials = list(
		/datum/material/iron = MATS_SHOTGUN_CASING + MATS_SHOTGUN_BULLET,
		/datum/material/blackpowder = MATS_SHOTGUN_POWDER)
	fire_power = CASING_POWER_SHOTGUN * CASING_POWER_MOD_SURPLUS

/obj/item/ammo_casing/a12g/q3
	name = "magnum 12 gauge slug shell"
	desc = "A high-grade 12 gauge slug shell."
	projectile_type = /obj/item/projectile/bullet/a12g/q3
	custom_materials = list(
		/datum/material/iron = MATS_SHOTGUN_CASING + MATS_SHOTGUN_BULLET,
		/datum/material/blackpowder = MATS_SHOTGUN_POWDER)
	fire_power = CASING_POWER_SHOTGUN * CASING_POWER_MOD_MATCH

/obj/item/ammo_casing/a12g/buck/q3
	name = "magnum 12 gauge buckshot shell"
	desc = "A high-grade 12 gauge buckshot shell."
	projectile_type = /obj/item/projectile/bullet/a12g/buck/q3
	custom_materials = list(
		/datum/material/iron = MATS_SHOTGUN_CASING + MATS_SHOTGUN_BULLET,
		/datum/material/blackpowder = MATS_SHOTGUN_POWDER)
	fire_power = CASING_POWER_SHOTGUN * CASING_POWER_MOD_MATCH

///////////////bullet///////////////

/obj/item/projectile/bullet/a12g
	name = "12 gauge slug"
	damage = BULLET_DAMAGE_SHOTGUN_SLUG_HANDLOAD
	damage_list = list("30" = 30, "36" = 30, "40" = 30, "41" = 2, "42" = 2, "43" = 2, "44" = 2, "45" = 1, "50" = 0.5, "55" = 0.5)
	stamina = BULLET_STAMINA_SHOTGUN_SLUG // needs a proper define later
	spread = BULLET_SPREAD_HANDLOAD
	recoil = BULLET_RECOIL_SHOTGUN_SLUG

	wound_bonus = BULLET_WOUND_SHOTGUN_SLUG
	bare_wound_bonus = BULLET_WOUND_SHOTGUN_SLUG_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_SHOTGUN_SLUG

	pixels_per_second = BULLET_SPEED_SHOTGUN_SLUG
	damage_falloff = BULLET_FALLOFF_DEFAULT_SHOTGUN_SLUG

/obj/item/projectile/bullet/a12g/q2
	damage = BULLET_DAMAGE_SHOTGUN_SLUG_SURPLUS
	spread = BULLET_SPREAD_SURPLUS

/obj/item/projectile/bullet/a12g/q3
	damage = BULLET_DAMAGE_SHOTGUN_SLUG_MATCH
	spread = BULLET_SPREAD_MATCH

/obj/item/projectile/bullet/a12g/buck
	name = "12 gauge buckshot"
	damage = BULLET_DAMAGE_SHOTGUN_PELLET_HANDLOAD
	damage_list = list("30" = 30, "36" = 30, "40" = 30, "41" = 2, "42" = 2, "43" = 2, "44" = 2, "45" = 1, "50" = 0.5, "55" = 0.5)
	stamina = BULLET_STAMINA_SHOTGUN_PELLET // needs a proper define later
	spread = BULLET_SPREAD_HANDLOAD
	recoil = BULLET_RECOIL_SHOTGUN_PELLET

	wound_bonus = BULLET_WOUND_SHOTGUN_PELLET
	bare_wound_bonus = BULLET_WOUND_SHOTGUN_PELLET_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_SHOTGUN_PELLET

	pixels_per_second = BULLET_SPEED_SHOTGUN_PELLET
	damage_falloff = BULLET_FALLOFF_DEFAULT_SHOTGUN_PELLET

/obj/item/projectile/bullet/a12g/buck/q2
	damage = BULLET_DAMAGE_SHOTGUN_PELLET_SURPLUS
	spread = BULLET_SPREAD_SURPLUS

/obj/item/projectile/bullet/a12g/buck/q3
	damage = BULLET_DAMAGE_SHOTGUN_PELLET_MATCH
	spread = BULLET_SPREAD_MATCH

///////////////ammo box///////////////

/obj/item/ammo_box/a12g
	name = "12 gauge slug box (handload)"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "gbox"
	multiple_sprites = 3 // I think this is right?
	caliber = list(CALIBER_12G)
	ammo_type = /obj/item/ammo_casing/a12g
	max_ammo = 20 // don't change this for new calibers
	w_class = WEIGHT_CLASS_SMALL
	custom_materials = list(/datum/material/iron = MATS_RIFLE_SMALL_BOX)
	randomize_ammo_count = FALSE

/obj/item/ammo_box/a12g/q2
	name = "12 gauge slug box (standard)"
	ammo_type = /obj/item/ammo_casing/a12g/q2

/obj/item/ammo_box/a12g/q3
	name = "12 gauge slug box (magnum)"
	ammo_type = /obj/item/ammo_casing/a12g/q3

/obj/item/ammo_box/a12g/buck
	name = "12 gauge buckshot box (handload)"
	icon_state = "lbox"
	ammo_type = /obj/item/ammo_casing/a12g/buck

/obj/item/ammo_box/a12g/buck/q2
	name = "12 gauge buckshot box (standard)"
	ammo_type = /obj/item/ammo_casing/a12g/buck/q2

/obj/item/ammo_box/a12g/buck/q3
	name = "12 gauge buckshot box (magnum)"
	ammo_type = /obj/item/ammo_casing/a12g/buck/q3

///////////////ammo crate///////////////

/obj/item/ammo_box/a12g/crate
	name = "12 gauge slug crate (handload)"
	desc = "A wooden crate of ammo."
	icon = 'modular_coyote/icons/objects/c13ammo.dmi'
	icon_state = "wood_ammobox"
	w_class = WEIGHT_CLASS_HUGE // don't you dare make this any smaller!
	multiple_sprites = 4
	max_ammo = 120 // don't change this for new calibers
	load_behavior = AMMOB_CRATE

/obj/item/ammo_box/a12g/crate/q2
	name = "12 gauge slug crate (standard)"
	ammo_type = /obj/item/ammo_casing/a12g/q2

/obj/item/ammo_box/a12g/crate/q3
	name = "12 gauge slug crate (magnum)"
	ammo_type = /obj/item/ammo_casing/a12g/q3

/obj/item/ammo_box/a12g/buck/crate
	name = "12 gauge buckshot crate (handload)"
	desc = "A wooden crate of ammo."
	icon = 'modular_coyote/icons/objects/c13ammo.dmi'
	icon_state = "wood_ammobox"
	w_class = WEIGHT_CLASS_HUGE // don't you dare make this any smaller!
	multiple_sprites = 4
	max_ammo = 120 // don't change this for new calibers
	load_behavior = AMMOB_CRATE

/obj/item/ammo_box/a12g/buck/crate/q2
	name = "12 gauge buckshot crate (standard)"
	ammo_type = /obj/item/ammo_casing/a12g/buck/q2

/obj/item/ammo_box/a12g/buck/crate/q3
	name = "12 gauge buckshot crate (magnum)"
	ammo_type = /obj/item/ammo_casing/a12g/buck/q3

///////////////ammo box recipe///////////////

/datum/design/ammolathe/a12g
	name = "12 gauge slug box (handload)"
	id = "a12g"
	build_path = /obj/item/ammo_box/a12g
	category = list("initial", "Basic Ammo")

/datum/design/ammolathe/a12g2
	name = "12 gauge slug box (standard)"
	id = "a12g2"
	build_path = /obj/item/ammo_box/a12g/q2
	category = list("initial", "Basic Ammo")

/datum/design/ammolathe/a12g3
	name = "12 gauge slug box (magnum)"
	id = "a12g3"
	build_path = /obj/item/ammo_box/a12g/q3
	category = list("initial", "Basic Ammo")

/datum/design/ammolathe/a12gb
	name = "12 gauge buckshot box (handload)"
	id = "a12gb"
	build_path = /obj/item/ammo_box/a12g/buck
	category = list("initial", "Basic Ammo")

/datum/design/ammolathe/a12gb2
	name = "12 gauge buckshot box (standard)"
	id = "a12gb2"
	build_path = /obj/item/ammo_box/a12g/buck/q2
	category = list("initial", "Basic Ammo")

/datum/design/ammolathe/a12gb3
	name = "12 gauge buckshot box (magnum)"
	id = "a12gb3"
	build_path = /obj/item/ammo_box/a12g/buck/q3
	category = list("initial", "Basic Ammo")

///////////////ammo crate recipe///////////////

/datum/design/ammolathe/a12gcrate
	name = "12 gauge slug crate (handload)"
	id = "a12gcrate"
	build_path = /obj/item/ammo_box/a12g/crate
	category = list("initial", "Basic ammo")

/datum/design/ammolathe/a12gcrate2
	name = "12 gauge slug crate (standard)"
	id = "a12gcrate2"
	build_path = /obj/item/ammo_box/a12g/crate/q2
	category = list("initial", "Basic ammo")

/datum/design/ammolathe/a12gcrate3
	name = "12 gauge slug crate (magnum)"
	id = "a12gcrate3"
	build_path = /obj/item/ammo_box/a12g/crate/q3
	category = list("initial", "Basic ammo")

/datum/design/ammolathe/a12gbcrate
	name = "12 gauge buckshot crate (handload)"
	id = "a12gbcrate"
	build_path = /obj/item/ammo_box/a12g/buck/crate
	category = list("initial", "Basic ammo")

/datum/design/ammolathe/a12gbcrate2
	name = "12 gauge buckshot crate (standard)"
	id = "a12gbcrate2"
	build_path = /obj/item/ammo_box/a12g/buck/crate/q2
	category = list("initial", "Basic ammo")

/datum/design/ammolathe/a12gbcrate3
	name = "12 gauge buckshot crate (magnum)"
	id = "a12gbcrate3"
	build_path = /obj/item/ammo_box/a12g/buck/crate/q3
	category = list("initial", "Basic ammo")




