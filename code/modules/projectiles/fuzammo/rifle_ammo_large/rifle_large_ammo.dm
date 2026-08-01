// .308 is the standard

///////////////////////////////
////////// .308 ammo //////////
///////////////////////////////

///////////////casing///////////////

/obj/item/ammo_casing/a308
	name = "handloaded .308 bullet casing"
	desc = "A low-grade .308 bullet casing."
	caliber = CALIBER_308
	projectile_type = /obj/item/projectile/bullet/a308
	material_class = BULLET_IS_HEAVY_RIFLE
	custom_materials = list(
		/datum/material/iron = MATS_RIFLE_HEAVY_CASING + MATS_RIFLE_HEAVY_BULLET,
		/datum/material/blackpowder = MATS_RIFLE_HEAVY_POWDER)
	fire_power = CASING_POWER_HEAVY_RIFLE * CASING_POWER_MOD_HANDLOAD
	sound_properties = CSP_RIFLE_HEAVY

/obj/item/ammo_casing/a308/q2
	name = ".308 bullet casing"
	desc = "A .308 bullet casing."
	projectile_type = /obj/item/projectile/bullet/a308/q2
	custom_materials = list(
		/datum/material/iron = MATS_RIFLE_HEAVY_CASING + MATS_RIFLE_HEAVY_BULLET,
		/datum/material/blackpowder = MATS_RIFLE_HEAVY_POWDER)
	fire_power = CASING_POWER_HEAVY_RIFLE * CASING_POWER_MOD_SURPLUS

/obj/item/ammo_casing/a308/q3
	name = "match .308 bullet casing"
	desc = "A high-grade .308 bullet casing."
	projectile_type = /obj/item/projectile/bullet/a308/q3
	custom_materials = list(
		/datum/material/iron = MATS_RIFLE_HEAVY_CASING + MATS_RIFLE_HEAVY_BULLET,
		/datum/material/blackpowder = MATS_RIFLE_HEAVY_POWDER)
	fire_power = CASING_POWER_HEAVY_RIFLE * CASING_POWER_MOD_MATCH

///////////////bullet///////////////

/obj/item/projectile/bullet/a308
	name = ".308 bullet"
	damage = BULLET_DAMAGE_RIFLE_LARGE_HANDLOAD // 80
	damage_list_is_mult = TRUE
	damage_list = list("1" = 30, "0.9" = 30, "1.1" = 30, "1.5" = 2, "1.45" = 2, "1.3" = 2, "1.4" = 2, "1.55" = 1, "2" = 0.5, "3" = 0.5)
	stamina = BULLET_STAMINA_RIFLE_LARGE
	spread = BULLET_SPREAD_HANDLOAD
	recoil = BULLET_RECOIL_RIFLE_LARGE_HANDLOAD

	wound_bonus = BULLET_WOUND_RIFLE_LARGE_HANDLOAD
	bare_wound_bonus = BULLET_WOUND_RIFLE_LARGE_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_RIFLE_HEAVY

	pixels_per_second = BULLET_SPEED_RIFLE_LARGE_HANDLOAD
	damage_falloff = BULLET_FALLOFF_DEFAULT_RIFLE_HEAVY

/obj/item/projectile/bullet/a308/q2
	damage = BULLET_DAMAGE_RIFLE_LARGE_STANDARD
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_RIFLE_LARGE_STANDARD
	wound_bonus = BULLET_WOUND_RIFLE_LARGE_STANDARD
	pixels_per_second = BULLET_SPEED_RIFLE_LARGE_STANDARD

/obj/item/projectile/bullet/a308/q3
	damage = BULLET_DAMAGE_RIFLE_LARGE_MATCH
	spread = BULLET_SPREAD_MATCH
	recoil = BULLET_RECOIL_RIFLE_LARGE_MATCH
	wound_bonus = BULLET_WOUND_RIFLE_LARGE_MATCH
	pixels_per_second = BULLET_SPEED_RIFLE_LARGE_MATCH

///////////////ammo box///////////////

/obj/item/ammo_box/a308
	name = ".308 ammo box (handload)"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "308box"
	multiple_sprites = 2
	caliber = list(CALIBER_308)
	ammo_type = /obj/item/ammo_casing/a308
	max_ammo = 20 // don't change this for new calibers
	w_class = WEIGHT_CLASS_SMALL
	custom_materials = list(/datum/material/iron = MATS_RIFLE_SMALL_BOX)
	randomize_ammo_count = FALSE

/obj/item/ammo_box/a308/q2
	name = ".308 ammo box (standard)"
	ammo_type = /obj/item/ammo_casing/a308/q2

/obj/item/ammo_box/a308/q3
	name = ".308 ammo box (match)"
	ammo_type = /obj/item/ammo_casing/a308/q3

///////////////ammo crate///////////////

/obj/item/ammo_box/a308/crate
	name = ".308 ammo crate (handload)"
	desc = "A wooden crate of ammo."
	icon = 'modular_coyote/icons/objects/c13ammo.dmi'
	icon_state = "wood_ammobox"
	w_class = WEIGHT_CLASS_HUGE // don't you dare make this any smaller!
	multiple_sprites = 4
	max_ammo = 120 // don't change this for new calibers
	load_behavior = AMMOB_CRATE

/obj/item/ammo_box/a308/crate/q2
	name = ".308 ammo crate (standard)"
	ammo_type = /obj/item/ammo_casing/a308/q2

/obj/item/ammo_box/a308/crate/q3
	name = ".308 ammo crate (match)"
	ammo_type = /obj/item/ammo_casing/a308/q3

///////////////ammo box recipe///////////////

/datum/design/ammolathe/a308
	name = ".308 ammo box (handload)"
	id = "a308"
	build_path = /obj/item/ammo_box/a308
	category = list("initial", "Basic Ammo")

/datum/design/ammolathe/a308_2
	name = ".308 ammo box (standard)"
	id = "a308_2"
	build_path = /obj/item/ammo_box/a308/q2
	category = list("initial", "Basic Ammo")

/datum/design/ammolathe/a308_3
	name = ".308 ammo box (match)"
	id = "a308_3"
	build_path = /obj/item/ammo_box/a308/q3
	category = list("initial", "Basic Ammo")

///////////////ammo crate recipe///////////////

/datum/design/ammolathe/a308crate
	name = ".308 ammo crate (handload)"
	id = "a308crate"
	build_path = /obj/item/ammo_box/a308/crate
	category = list("initial", "Basic ammo")

/datum/design/ammolathe/a308crate2
	name = ".308 ammo crate (standard)"
	id = "a308crate2"
	build_path = /obj/item/ammo_box/a308/crate/q2
	category = list("initial", "Basic ammo")

/datum/design/ammolathe/a308crate3
	name = ".308 ammo crate (match)"
	id = "a308crate3"
	build_path = /obj/item/ammo_box/a308/crate/q3
	category = list("initial", "Basic ammo")
