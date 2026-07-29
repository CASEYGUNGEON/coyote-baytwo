// .223 is the standard

///////////////////////////////
////////// .223 ammo //////////
///////////////////////////////

///////////////casing///////////////

/obj/item/ammo_casing/a223
	name = "handloaded .223 bullet casing"
	desc = "A low-grade .223 bullet casing."
	icon = 'modular_coyote/icons/objects/c13ammo.dmi'
	icon_state = "small-casing"
	caliber = CALIBER_223
	projectile_type = /obj/item/projectile/bullet/a223
	material_class = BULLET_IS_LIGHT_RIFLE
	custom_materials = list(
		/datum/material/iron = MATS_RIFLE_LIGHT_CASING + MATS_RIFLE_LIGHT_BULLET,
		/datum/material/blackpowder = MATS_RIFLE_LIGHT_POWDER)
	fire_power = CASING_POWER_LIGHT_RIFLE * CASING_POWER_MOD_HANDLOAD
	sound_properties = CSP_RIFLE_LIGHT

/obj/item/ammo_casing/a223/q2
	name = ".223 bullet casing"
	desc = "A .223 bullet casing."
	projectile_type = /obj/item/projectile/bullet/a223/q2
	custom_materials = list(
		/datum/material/iron = MATS_RIFLE_LIGHT_CASING + MATS_RIFLE_LIGHT_BULLET,
		/datum/material/blackpowder = MATS_RIFLE_LIGHT_POWDER)
	fire_power = CASING_POWER_LIGHT_RIFLE * CASING_POWER_MOD_SURPLUS

/obj/item/ammo_casing/a223/q3
	name = "match .223 bullet casing"
	desc = "A high-grade .223 bullet casing."
	projectile_type = /obj/item/projectile/bullet/a223/q3
	custom_materials = list(
		/datum/material/iron = MATS_RIFLE_LIGHT_CASING + MATS_RIFLE_LIGHT_BULLET,
		/datum/material/blackpowder = MATS_RIFLE_LIGHT_POWDER)
	fire_power = CASING_POWER_LIGHT_RIFLE * CASING_POWER_MOD_MATCH

///////////////bullet///////////////

/obj/item/projectile/bullet/a223
	name = ".223 bullet"
	damage = BULLET_DAMAGE_RIFLE_SMALL_HANDLOAD // 40
	damage_list_is_mult = TRUE
	damage_list = list("1" = 30, "0.9" = 30, "1.1" = 30, "1.5" = 2, "1.45" = 2, "1.3" = 2, "1.4" = 2, "1.55" = 1, "2" = 0.5, "3" = 0.5)
	stamina = BULLET_STAMINA_RIFLE_SMALL
	spread = BULLET_SPREAD_HANDLOAD
	recoil = BULLET_RECOIL_RIFLE_SMALL_HANDLOAD

	wound_bonus = BULLET_WOUND_RIFLE_SMALL_HANDLOAD
	bare_wound_bonus = BULLET_WOUND_RIFLE_SMALL_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_RIFLE_LIGHT

	pixels_per_second = BULLET_SPEED_RIFLE_SMALL_HANDLOAD
	damage_falloff = BULLET_FALLOFF_DEFAULT_RIFLE_LIGHT

/obj/item/projectile/bullet/a223/q2
	damage = BULLET_DAMAGE_RIFLE_SMALL_STANDARD
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_RIFLE_SMALL_STANDARD
	wound_bonus = BULLET_WOUND_RIFLE_SMALL_STANDARD
	pixels_per_second = BULLET_SPEED_RIFLE_SMALL_STANDARD

/obj/item/projectile/bullet/a223/q3
	damage = BULLET_DAMAGE_RIFLE_SMALL_MATCH
	spread = BULLET_SPREAD_MATCH
	recoil = BULLET_RECOIL_RIFLE_SMALL_MATCH
	wound_bonus = BULLET_WOUND_RIFLE_SMALL_MATCH
	pixels_per_second = BULLET_SPEED_RIFLE_SMALL_MATCH

///////////////ammo box///////////////

/obj/item/ammo_box/a223
	name = ".223 ammo box (handload)"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "556box"
	multiple_sprites = 2
	caliber = list(CALIBER_223)
	ammo_type = /obj/item/ammo_casing/a223
	max_ammo = 50 // don't change this for new calibers
	w_class = WEIGHT_CLASS_SMALL
	custom_materials = list(/datum/material/iron = MATS_RIFLE_SMALL_BOX)
	randomize_ammo_count = FALSE

/obj/item/ammo_box/a223/q2
	name = ".223 ammo box (standard)"
	ammo_type = /obj/item/ammo_casing/a223/q2

/obj/item/ammo_box/a223/q3
	name = ".223 ammo box (match)"
	ammo_type = /obj/item/ammo_casing/a223/q3

///////////////ammo crate///////////////

/obj/item/ammo_box/a223/crate
	name = ".223 ammo crate (handload)"
	desc = "A wooden crate of ammo."
	icon = 'modular_coyote/icons/objects/c13ammo.dmi'
	icon_state = "wood_ammobox"
	w_class = WEIGHT_CLASS_HUGE // don't you dare make this any smaller!
	multiple_sprites = 4
	max_ammo = 300 // don't change this for new calibers
	load_behavior = AMMOB_CRATE

/obj/item/ammo_box/a223/crate/q2
	name = ".223 ammo crate (standard)"
	ammo_type = /obj/item/ammo_casing/a223/q2

/obj/item/ammo_box/a223/crate/q3
	name = ".223 ammo crate (match)"
	ammo_type = /obj/item/ammo_casing/a223/q3

///////////////ammo box recipe///////////////

/datum/design/ammolathe/a223
	name = ".223 ammo box (handload)"
	id = "a223"
	build_path = /obj/item/ammo_box/a223
	category = list("initial", "Basic Ammo")

/datum/design/ammolathe/a223_2
	name = ".223 ammo box (standard)"
	id = "a223_2"
	build_path = /obj/item/ammo_box/a223/q2
	category = list("initial", "Basic Ammo")

/datum/design/ammolathe/a223_3
	name = ".223 ammo box (match)"
	id = "a223_3"
	build_path = /obj/item/ammo_box/a223/q3
	category = list("initial", "Basic Ammo")

///////////////ammo crate recipe///////////////

/datum/design/ammolathe/a223crate
	name = ".223 ammo crate (handload)"
	id = "a223crate"
	build_path = /obj/item/ammo_box/a223/crate
	category = list("initial", "Basic ammo")

/datum/design/ammolathe/a223crate2
	name = ".223 ammo crate (standard)"
	id = "a223crate2"
	build_path = /obj/item/ammo_box/a223/crate/q2
	category = list("initial", "Basic ammo")

/datum/design/ammolathe/a223crate3
	name = ".223 ammo crate (match)"
	id = "a223crate3"
	build_path = /obj/item/ammo_box/a223/crate/q3
	category = list("initial", "Basic ammo")
