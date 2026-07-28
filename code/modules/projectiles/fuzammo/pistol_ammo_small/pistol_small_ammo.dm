//9mm is the standard, plus .38 for revolvers


///////////////////////////////
////////// 9mm ammo //////////
///////////////////////////////

///////////////casing///////////////

/obj/item/ammo_casing/a9mm
	name = "handloaded 9mm bullet casing"
	desc = "A low-grade 9mm bullet casing."
	icon = 'icons/obj/ammo.dmi'
	icon_state = "s-casing"
	caliber = CALIBER_9MM
	projectile_type = /obj/item/projectile/bullet/a9mm
	material_class = BULLET_IS_LIGHT_PISTOL
	custom_materials = list(
		/datum/material/iron = MATS_PISTOL_LIGHT_CASING + MATS_PISTOL_LIGHT_BULLET,
		/datum/material/blackpowder = MATS_PISTOL_LIGHT_POWDER)
	fire_power = CASING_POWER_LIGHT_PISTOL * CASING_POWER_MOD_HANDLOAD
	sound_properties = CSP_PISTOL_LIGHT

/obj/item/ammo_casing/a9mm/q2
	name = "9mm bullet casing"
	desc = "A 9mm bullet casing."
	projectile_type = /obj/item/projectile/bullet/a9mm/q2
	custom_materials = list(
		/datum/material/iron = MATS_PISTOL_LIGHT_CASING + MATS_PISTOL_LIGHT_BULLET,
		/datum/material/blackpowder = MATS_PISTOL_LIGHT_POWDER)
	fire_power = CASING_POWER_LIGHT_PISTOL * CASING_POWER_MOD_SURPLUS

/obj/item/ammo_casing/a9mm/q3
	name = "match 9mm bullet casing"
	desc = "A high-grade 9mm bullet casing."
	projectile_type = /obj/item/projectile/bullet/a9mm/q3
	custom_materials = list(
		/datum/material/iron = MATS_PISTOL_LIGHT_CASING + MATS_PISTOL_LIGHT_BULLET,
		/datum/material/blackpowder = MATS_PISTOL_LIGHT_POWDER)
	fire_power = CASING_POWER_LIGHT_PISTOL * CASING_POWER_MOD_MATCH

///////////////bullet///////////////

/obj/item/projectile/bullet/a9mm
	name = "9mm bullet"
	damage = BULLET_DAMAGE_PISTOL_9MM_HANDLOAD //36
	damage_list = list("30" = 30, "36" = 30, "40" = 30, "41" = 2, "42" = 2, "43" = 2, "44" = 2, "45" = 1, "50" = 0.5, "55" = 0.5)
	stamina = BULLET_STAMINA_PISTOL_9MM
	spread = BULLET_SPREAD_HANDLOAD
	recoil = BULLET_RECOIL_PISTOL_9MM

	wound_bonus = BULLET_WOUND_PISTOL_9MM
	bare_wound_bonus = BULLET_WOUND_PISTOL_9MM_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_PISTOL_9MM
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

/obj/item/projectile/bullet/a9mm/q2
	damage = BULLET_DAMAGE_PISTOL_9MM_SURPLUS
	spread = BULLET_SPREAD_SURPLUS

/obj/item/projectile/bullet/a9mm/q3
	damage = BULLET_DAMAGE_PISTOL_9MM_MATCH
	spread = BULLET_SPREAD_MATCH

///////////////ammo box///////////////

/obj/item/ammo_box/a9mm
	name = "9mm ammo box (handload)"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "9mmbox"
	multiple_sprites = 2
	caliber = list(CALIBER_9MM)
	ammo_type = /obj/item/ammo_casing/a9mm
	max_ammo = 100 // don't change this for new calibers
	w_class = WEIGHT_CLASS_SMALL
	custom_materials = list(/datum/material/iron = MATS_RIFLE_SMALL_BOX)
	randomize_ammo_count = FALSE

/obj/item/ammo_box/a9mm/q2
	name = "9mm ammo box (standard)"
	ammo_type = /obj/item/ammo_casing/a9mm/q2

/obj/item/ammo_box/a9mm/q3
	name = "9mm ammo box (match)"
	ammo_type = /obj/item/ammo_casing/a9mm/q3

///////////////ammo crate///////////////

/obj/item/ammo_box/a9mm/crate
	name = "9mm ammo crate (handload)"
	desc = "A wooden crate of ammo."
	icon = 'modular_coyote/icons/objects/c13ammo.dmi'
	icon_state = "wood_ammobox"
	w_class = WEIGHT_CLASS_HUGE // don't you dare make this any smaller!
	multiple_sprites = 4
	max_ammo = 600 // don't change this for new calibers
	load_behavior = AMMOB_CRATE

/obj/item/ammo_box/a9mm/crate/q2
	name = "9mm ammo crate (standard)"
	ammo_type = /obj/item/ammo_casing/a9mm/q2

/obj/item/ammo_box/a9mm/crate/q3
	name = "9mm ammo crate (match)"
	ammo_type = /obj/item/ammo_casing/a9mm/q3

///////////////ammo box recipe///////////////

/datum/design/ammolathe/a9mm
	name = "9mm ammo box (handload)"
	id = "a9mm"
	build_path = /obj/item/ammo_box/a9mm
	category = list("initial", "Basic Ammo")

/datum/design/ammolathe/a9mm_2
	name = "9mm ammo box (standard)"
	id = "a9mm_2"
	build_path = /obj/item/ammo_box/a9mm/q2
	category = list("initial", "Basic Ammo")

/datum/design/ammolathe/a9mm_3
	name = "9mm ammo box (match)"
	id = "a9mm_3"
	build_path = /obj/item/ammo_box/a9mm/q3
	category = list("initial", "Basic Ammo")

///////////////ammo crate recipe///////////////

/datum/design/ammolathe/a9mmcrate
	name = "9mm ammo crate (surplus)"
	id = "a9mmcrate"
	build_path = /obj/item/ammo_box/a9mm/crate
	category = list("initial", "Basic ammo")

/datum/design/ammolathe/a9mmcrate2
	name = "9mm ammo crate (standard)"
	id = "a9mmcrate2"
	build_path = /obj/item/ammo_box/a9mm/crate/q2
	category = list("initial", "Basic ammo")

/datum/design/ammolathe/a9mmcrate3
	name = "9mm ammo crate (match)"
	id = "a9mmcrate3"
	build_path = /obj/item/ammo_box/a9mm/crate/q3
	category = list("initial", "Basic ammo")



//////////////////////////////
////////// .38 ammo //////////
//////////////////////////////

///////////////casing///////////////

/obj/item/ammo_casing/a38
	name = "handloaded .38 bullet casing"
	desc = "A low-grade .38 bullet casing."
	icon = 'icons/obj/ammo.dmi'
	icon_state = "s-casing"
	caliber = CALIBER_38
	projectile_type = /obj/item/projectile/bullet/a38
	material_class = BULLET_IS_LIGHT_PISTOL
	custom_materials = list(
		/datum/material/iron = MATS_PISTOL_LIGHT_CASING + MATS_PISTOL_LIGHT_BULLET,
		/datum/material/blackpowder = MATS_PISTOL_LIGHT_POWDER)
	fire_power = CASING_POWER_LIGHT_PISTOL * CASING_POWER_MOD_HANDLOAD
	sound_properties = CSP_PISTOL_LIGHT

/obj/item/ammo_casing/a38/q2
	name = ".38 bullet casing"
	desc = "A .38 bullet casing."
	projectile_type = /obj/item/projectile/bullet/a38/q2
	custom_materials = list(
		/datum/material/iron = MATS_PISTOL_LIGHT_CASING + MATS_PISTOL_LIGHT_BULLET,
		/datum/material/blackpowder = MATS_PISTOL_LIGHT_POWDER)
	fire_power = CASING_POWER_LIGHT_PISTOL * CASING_POWER_MOD_SURPLUS

/obj/item/ammo_casing/a38/q3
	name = "match .38 bullet casing"
	desc = "A high-grade .38 bullet casing."
	projectile_type = /obj/item/projectile/bullet/a38/q3
	custom_materials = list(
		/datum/material/iron = MATS_PISTOL_LIGHT_CASING + MATS_PISTOL_LIGHT_BULLET,
		/datum/material/blackpowder = MATS_PISTOL_LIGHT_POWDER)
	fire_power = CASING_POWER_LIGHT_PISTOL * CASING_POWER_MOD_MATCH

///////////////bullet///////////////

/obj/item/projectile/bullet/a38
	name = ".38 bullet"
	damage = BULLET_DAMAGE_PISTOL_9MM_HANDLOAD // same as the 9mm right now as they are heavy pistol baseline
	damage_list = list("30" = 30, "36" = 30, "40" = 30, "41" = 2, "42" = 2, "43" = 2, "44" = 2, "45" = 1, "50" = 0.5, "55" = 0.5)
	stamina = BULLET_STAMINA_PISTOL_9MM
	spread = BULLET_SPREAD_HANDLOAD
	recoil = BULLET_RECOIL_PISTOL_9MM

	wound_bonus = BULLET_WOUND_PISTOL_9MM
	bare_wound_bonus = BULLET_WOUND_PISTOL_9MM_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_PISTOL_9MM
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

/obj/item/projectile/bullet/a38/q2
	damage = BULLET_DAMAGE_PISTOL_9MM_SURPLUS
	spread = BULLET_SPREAD_SURPLUS

/obj/item/projectile/bullet/a38/q3
	damage = BULLET_DAMAGE_PISTOL_9MM_MATCH
	spread = BULLET_SPREAD_MATCH

///////////////ammo box///////////////

/obj/item/ammo_box/a38
	name = ".38 ammo box (handload)"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "38box"
	multiple_sprites = 2
	caliber = list(CALIBER_38)
	ammo_type = /obj/item/ammo_casing/a38
	max_ammo = 100 // don't change this for new calibers
	w_class = WEIGHT_CLASS_SMALL
	custom_materials = list(/datum/material/iron = MATS_RIFLE_SMALL_BOX)
	randomize_ammo_count = FALSE

/obj/item/ammo_box/a38/q2
	name = ".38 ammo box (standard)"
	ammo_type = /obj/item/ammo_casing/a38/q2

/obj/item/ammo_box/a38/q3
	name = ".38 ammo box (match)"
	ammo_type = /obj/item/ammo_casing/a38/q3

///////////////ammo crate///////////////

/obj/item/ammo_box/a38/crate
	name = ".38 ammo crate (handload)"
	desc = "A wooden crate of ammo."
	icon = 'modular_coyote/icons/objects/c13ammo.dmi'
	icon_state = "wood_ammobox"
	w_class = WEIGHT_CLASS_HUGE // don't you dare make this any smaller!
	multiple_sprites = 4
	max_ammo = 600 // don't change this for new calibers
	load_behavior = AMMOB_CRATE

/obj/item/ammo_box/a38/crate/q2
	name = ".38 ammo crate (standard)"
	ammo_type = /obj/item/ammo_casing/a38/q2

/obj/item/ammo_box/a38/crate/q3
	name = ".38 ammo crate (match)"
	ammo_type = /obj/item/ammo_casing/a38/q3

///////////////ammo box recipe///////////////

/datum/design/ammolathe/a38
	name = ".38 ammo box (handload)"
	id = "a38"
	build_path = /obj/item/ammo_box/a38
	category = list("initial", "Basic Ammo")

/datum/design/ammolathe/a38_2
	name = ".38 ammo box (standard)"
	id = "a38_2"
	build_path = /obj/item/ammo_box/a38/q2
	category = list("initial", "Basic Ammo")

/datum/design/ammolathe/a38_3
	name = ".38 ammo box (match)"
	id = "a38_3"
	build_path = /obj/item/ammo_box/a38/q3
	category = list("initial", "Basic Ammo")

///////////////ammo crate recipe///////////////

/datum/design/ammolathe/a38crate
	name = ".38 ammo crate (handload)"
	id = "a38crate"
	build_path = /obj/item/ammo_box/a38/crate
	category = list("initial", "Basic ammo")

/datum/design/ammolathe/a38mcrate2
	name = ".38 ammo crate (standard)"
	id = "a38crate2"
	build_path = /obj/item/ammo_box/a38/crate/q2
	category = list("initial", "Basic ammo")

/datum/design/ammolathe/a38crate3
	name = ".38 ammo crate (match)"
	id = "a38crate3"
	build_path = /obj/item/ammo_box/a38/crate/q3
	category = list("initial", "Basic ammo")
