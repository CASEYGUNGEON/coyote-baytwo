//40mm is the standard (among other things)


///////////////////////////////
////////// 40mm ammo //////////
///////////////////////////////

///////////////casing///////////////

/obj/item/ammo_casing/a40mm
	name = "handloaded 40mm slug shell"
	desc = "A low-power 40mm slug shell."
	icon_state = "40mmHE" // it's blue tipped, that means inert practice ammo
	caliber = CALIBER_40MM
	projectile_type = /obj/item/projectile/bullet/a40mm
	material_class = BULLET_IS_SHOTGUN // cheaper than explosives
	custom_materials = list(
		/datum/material/iron = MATS_GRENADE_CASING + MATS_SHOTGUN_BULLET,
		/datum/material/blackpowder = MATS_SHOTGUN_POWDER)
	fire_power = CASING_POWER_GRENADE * CASING_POWER_MOD_HANDLOAD
	sound_properties = CSP_40MM

/obj/item/ammo_casing/a40mm/buck
	name = "handloaded 40mm buckshot shell"
	desc = "A low-power 40mm buckshot shell."
	icon_state = "40mmbuck"
	projectile_type = /obj/item/projectile/bullet/a40mm/buck
	material_class = BULLET_IS_SHOTGUN // cheaper than explosives
	custom_materials = list(
		/datum/material/iron = MATS_GRENADE_CASING + MATS_SHOTGUN_BULLET,
		/datum/material/blackpowder = MATS_SHOTGUN_POWDER)
	pellets = SHOTGUN_PELLET_BASE * 2
	variance = SHOTGUN_SPREAD_BASE

/obj/item/ammo_casing/a40mm/exp
	name = "handmade 40mm grenade shell"
	desc = "A low-yield explosive 40mm grenade shell."
	icon_state = "40mmHEDP"
	projectile_type = /obj/item/projectile/bullet/a40mm/exp
	material_class = BULLET_IS_GRENADE // full cost
	custom_materials = list(
		/datum/material/iron = MATS_GRENADE_CASING + MATS_GRENADE_BULLET,
		/datum/material/blackpowder = MATS_GRENADE_POWDER)

/obj/item/ammo_casing/a40mm/q2
	name = "40mm slug shell"
	desc = "A 40mm slug shell."
	projectile_type = /obj/item/projectile/bullet/a40mm/q2
	custom_materials = list(
		/datum/material/iron = MATS_GRENADE_CASING + MATS_SHOTGUN_BULLET,
		/datum/material/blackpowder = MATS_SHOTGUN_POWDER)
	fire_power = CASING_POWER_GRENADE * CASING_POWER_MOD_SURPLUS

/obj/item/ammo_casing/a40mm/buck/q2
	name = "40mm buckshot shell"
	desc = "A 40mm buckshot shell."
	projectile_type = /obj/item/projectile/bullet/a40mm/buck/q2
	custom_materials = list(
		/datum/material/iron = MATS_GRENADE_CASING + MATS_SHOTGUN_BULLET,
		/datum/material/blackpowder = MATS_SHOTGUN_POWDER)
	fire_power = CASING_POWER_GRENADE * CASING_POWER_MOD_SURPLUS

/obj/item/ammo_casing/a40mm/exp/q2
	name = "40mm grenade shell"
	desc = "An explosive 40mm grenade shell."
	projectile_type = /obj/item/projectile/bullet/a40mm/exp/q2
	custom_materials = list(
		/datum/material/iron = MATS_GRENADE_CASING + MATS_GRENADE_BULLET,
		/datum/material/blackpowder = MATS_GRENADE_POWDER)
	fire_power = CASING_POWER_GRENADE * CASING_POWER_MOD_SURPLUS

/obj/item/ammo_casing/a40mm/q3
	name = "magnum 40mm slug shell"
	desc = "A high-power 40mm slug shell."
	projectile_type = /obj/item/projectile/bullet/a40mm/q3
	custom_materials = list(
		/datum/material/iron = MATS_GRENADE_CASING + MATS_SHOTGUN_BULLET,
		/datum/material/blackpowder = MATS_SHOTGUN_POWDER)
	fire_power = CASING_POWER_GRENADE * CASING_POWER_MOD_MATCH

/obj/item/ammo_casing/a40mm/buck/q3
	name = "magnum 40mm buckshot shell"
	desc = "A high-power 40mm buckshot shell."
	projectile_type = /obj/item/projectile/bullet/a40mm/buck/q3
	custom_materials = list(
		/datum/material/iron = MATS_GRENADE_CASING + MATS_SHOTGUN_BULLET,
		/datum/material/blackpowder = MATS_SHOTGUN_POWDER)
	fire_power = CASING_POWER_GRENADE * CASING_POWER_MOD_MATCH

/obj/item/ammo_casing/a40mm/exp/q3
	name = "HE 40mm grenade shell"
	desc = "A high-explosive 40mm grenade shell."
	projectile_type = /obj/item/projectile/bullet/a40mm/exp/q3
	custom_materials = list(
		/datum/material/iron = MATS_GRENADE_CASING + MATS_GRENADE_BULLET,
		/datum/material/blackpowder = MATS_GRENADE_POWDER)
	fire_power = CASING_POWER_GRENADE * CASING_POWER_MOD_MATCH

///////////////bullet///////////////

/obj/item/projectile/bullet/a40mm
	name = "40mm slug"
	icon_state= "bolter"
	damage = BULLET_DAMAGE_GRENADE_SLUG_HANDLOAD // 120
	damage_list_is_mult = TRUE
	damage_list = list("1" = 30, "0.9" = 30, "1.1" = 30, "1.5" = 2, "1.45" = 2, "1.3" = 2, "1.4" = 2, "1.55" = 1, "2" = 0.5, "3" = 0.5)
	stamina = BULLET_STAMINA_GRENADE_SLUG
	spread = BULLET_SPREAD_HANDLOAD
	recoil = BULLET_RECOIL_GRENADE_SLUG_HANDLOAD

	wound_bonus = BULLET_WOUND_GRENADE_SLUG_HANDLOAD
	bare_wound_bonus = BULLET_WOUND_GRENADE_SLUG_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_SHOTGUN_SLUG

	pixels_per_second = BULLET_SPEED_GRENADE_SLUG_HANDLOAD
	damage_falloff = BULLET_FALLOFF_DEFAULT_SHOTGUN_SLUG

/obj/item/projectile/bullet/a40mm/q2
	damage = BULLET_DAMAGE_GRENADE_SLUG_STANDARD
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_GRENADE_SLUG_STANDARD
	wound_bonus = BULLET_WOUND_GRENADE_SLUG_STANDARD
	pixels_per_second = BULLET_SPEED_GRENADE_SLUG_STANDARD

/obj/item/projectile/bullet/a40mm/q3
	damage = BULLET_DAMAGE_GRENADE_SLUG_MATCH
	spread = BULLET_SPREAD_MATCH
	recoil = BULLET_RECOIL_GRENADE_SLUG_MATCH
	wound_bonus = BULLET_WOUND_GRENADE_SLUG_MATCH
	pixels_per_second = BULLET_SPEED_GRENADE_SLUG_MATCH

/obj/item/projectile/bullet/a40mm/buck
	name = "buckshot pellet"
	icon_state= "bullet"
	damage = BULLET_DAMAGE_GRENADE_BUCK_HANDLOAD // 7 * 18 = 126
	damage_list_is_mult = TRUE
	damage_list = list("1" = 30, "0.9" = 30, "1.1" = 30, "1.5" = 2, "1.45" = 2, "1.3" = 2, "1.4" = 2, "1.55" = 1, "2" = 0.5, "3" = 0.5)
	stamina = BULLET_STAMINA_GRENADE_BUCK
	spread = BULLET_SPREAD_HANDLOAD
	recoil = BULLET_RECOIL_GRENADE_BUCK_HANDLOAD

	wound_bonus = BULLET_WOUND_GRENADE_BUCK_HANDLOAD
	bare_wound_bonus = BULLET_WOUND_GRENADE_BUCK_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_SHOTGUN_PELLET

	pixels_per_second = BULLET_SPEED_GRENADE_BUCK_HANDLOAD
	damage_falloff = BULLET_FALLOFF_DEFAULT_SHOTGUN_PELLET

/obj/item/projectile/bullet/a40mm/buck/q2
	damage = BULLET_DAMAGE_GRENADE_BUCK_STANDARD
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_GRENADE_BUCK_STANDARD
	wound_bonus = BULLET_WOUND_GRENADE_BUCK_STANDARD
	pixels_per_second = BULLET_SPEED_GRENADE_BUCK_STANDARD

/obj/item/projectile/bullet/a40mm/buck/q3
	damage = BULLET_DAMAGE_GRENADE_BUCK_MATCH
	spread = BULLET_SPREAD_MATCH
	recoil = BULLET_RECOIL_GRENADE_BUCK_MATCH
	wound_bonus = BULLET_WOUND_GRENADE_BUCK_MATCH
	pixels_per_second = BULLET_SPEED_GRENADE_BUCK_MATCH

/obj/item/projectile/bullet/a40mm/exp
	name = "40mm grenade"
	icon_state= "bolter"
	damage = 60 // bonus damage because handmade are only light explosion
	damage_list_is_mult = TRUE
	damage_list = list("1" = 30, "0.9" = 30, "1.1" = 30, "1.5" = 2, "1.45" = 2, "1.3" = 2, "1.4" = 2, "1.55" = 1, "2" = 0.5, "3" = 0.5)
	stamina = BULLET_STAMINA_GRENADE_SLUG
	spread = BULLET_SPREAD_HANDLOAD
	recoil = BULLET_RECOIL_GRENADE_SLUG_HANDLOAD

	wound_bonus = BULLET_WOUND_GRENADE_SLUG_HANDLOAD
	bare_wound_bonus = BULLET_WOUND_GRENADE_SLUG_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_SHOTGUN_SLUG

	pixels_per_second = TILES_TO_PIXELS(6) //slower than bullets
	damage_falloff = BULLET_FALLOFF_DEFAULT_SHOTGUN_SLUG

/obj/item/projectile/bullet/a40mm/he/on_hit(atom/target, blocked = FALSE)
	..()
	explosion(target, -1, -1, -1, 3, 0)
	new /obj/effect/temp_visual/explosion(get_turf(target))
	return BULLET_ACT_HIT

/obj/item/projectile/bullet/a40mm/exp/q2
	damage = 10 // a little direct damage plus a heavy blast at ground zero
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_GRENADE_BUCK_STANDARD
	wound_bonus = BULLET_WOUND_GRENADE_BUCK_STANDARD
	pixels_per_second = TILES_TO_PIXELS(9)

/obj/item/projectile/bullet/a40mm/exp/q2/on_hit(atom/target, blocked = FALSE)
	..()
	explosion(target, -1, -1, 1, 3, 0)
	new /obj/effect/temp_visual/explosion(get_turf(target))
	return BULLET_ACT_HIT

/obj/item/projectile/bullet/a40mm/exp/q3
	damage = 10
	spread = BULLET_SPREAD_MATCH
	recoil = BULLET_RECOIL_GRENADE_BUCK_MATCH
	wound_bonus = BULLET_WOUND_GRENADE_BUCK_MATCH
	pixels_per_second = TILES_TO_PIXELS(12)

/obj/item/projectile/bullet/a40mm/exp/q3/on_hit(atom/target, blocked = FALSE)
	..()
	explosion(target, -1, -1, 2, 3, 0)
	new /obj/effect/temp_visual/explosion(get_turf(target))
	return BULLET_ACT_HIT


///////////////ammo box///////////////

/obj/item/ammo_box/a40mm
	name = "40mm slug box (handload)"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "40mm"
	multiple_sprites = 3 // I think this is right?
	caliber = list(CALIBER_40MM)
	ammo_type = /obj/item/ammo_casing/a40mm
	max_ammo = 4 // don't change this for new calibers
	w_class = WEIGHT_CLASS_SMALL
	custom_materials = list(/datum/material/iron = MATS_RIFLE_SMALL_BOX)
	randomize_ammo_count = FALSE

/obj/item/ammo_box/a40mm/q2
	name = "40mm slug box (standard)"
	ammo_type = /obj/item/ammo_casing/a40mm/q2

/obj/item/ammo_box/a40mm/q3
	name = "40mm slug box (magnum)"
	ammo_type = /obj/item/ammo_casing/a40mm/q3

/obj/item/ammo_box/a40mm/buck
	name = "40mm buckshot box (handload)"
	icon_state = "40mmbuckshot"
	ammo_type = /obj/item/ammo_casing/a40mm/buck

/obj/item/ammo_box/a40mm/buck/q2
	name = "40mm buckshot box (standard)"
	ammo_type = /obj/item/ammo_casing/a40mm/buck/q2

/obj/item/ammo_box/a40mm/buck/q3
	name = "40mm buckshot box (magnum)"
	ammo_type = /obj/item/ammo_casing/a40mm/buck/q3

/obj/item/ammo_box/a40mm/exp
	name = "40mm grenade box (handmade)"
	icon_state = "40mmbuckshot"
	ammo_type = /obj/item/ammo_casing/a40mm/exp

/obj/item/ammo_box/a40mm/exp/q2
	name = "40mm grenade box (standard)"
	ammo_type = /obj/item/ammo_casing/a40mm/exp/q2

/obj/item/ammo_box/a40mm/exp/q3
	name = "40mm grenade box (high explosive)"
	ammo_type = /obj/item/ammo_casing/a40mm/exp/q3

///////////////ammo crate///////////////

/obj/item/ammo_box/a40mm/crate
	name = "40mm slug crate (handload)"
	desc = "A wooden crate of ammo."
	icon = 'modular_coyote/icons/objects/c13ammo.dmi'
	icon_state = "wood_ammobox"
	w_class = WEIGHT_CLASS_HUGE // don't you dare make this any smaller!
	multiple_sprites = 4
	max_ammo = 24 // don't change this for new calibers
	load_behavior = AMMOB_CRATE

/obj/item/ammo_box/a40mm/crate/q2
	name = "40mm slug crate (standard)"
	ammo_type = /obj/item/ammo_casing/a40mm/q2

/obj/item/ammo_box/a40mm/crate/q3
	name = "40mm slug crate (magnum)"
	ammo_type = /obj/item/ammo_casing/a40mm/q3

/obj/item/ammo_box/a40mm/buck/crate
	name = "40mm buckshot crate (handload)"
	desc = "A wooden crate of ammo."
	icon = 'modular_coyote/icons/objects/c13ammo.dmi'
	icon_state = "wood_ammobox"
	w_class = WEIGHT_CLASS_HUGE // don't you dare make this any smaller!
	multiple_sprites = 4
	max_ammo = 24 // don't change this for new calibers
	load_behavior = AMMOB_CRATE

/obj/item/ammo_box/a40mm/buck/crate/q2
	name = "40mm buckshot crate (standard)"
	ammo_type = /obj/item/ammo_casing/a40mm/buck/q2

/obj/item/ammo_box/a40mm/buck/crate/q3
	name = "40mm buckshot crate (magnum)"
	ammo_type = /obj/item/ammo_casing/a40mm/buck/q3

/obj/item/ammo_box/a40mm/exp/crate
	name = "40mm grenade box (handmade)"
	desc = "A wooden crate of ammo."
	icon = 'modular_coyote/icons/objects/c13ammo.dmi'
	icon_state = "wood_ammobox"
	w_class = WEIGHT_CLASS_HUGE // don't you dare make this any smaller!
	multiple_sprites = 4
	max_ammo = 24 // don't change this for new calibers
	load_behavior = AMMOB_CRATE

/obj/item/ammo_box/a40mm/exp/crate/q2
	name = "40mm grenade box (standard)"
	ammo_type = /obj/item/ammo_casing/a40mm/exp/q2

/obj/item/ammo_box/a40mm/exp/crate/q3
	name = "40mm grenade box (high explosive)"
	ammo_type = /obj/item/ammo_casing/a40mm/exp/q3

///////////////ammo box recipe///////////////

/datum/design/ammolathe/a40mm
	name = "40mm slug box (handload)"
	id = "a40mm"
	build_path = /obj/item/ammo_box/a40mm
	category = list("initial", "Basic Ammo")

/datum/design/ammolathe/a40mm2
	name = "40mm slug box (standard)"
	id = "a40mm2"
	build_path = /obj/item/ammo_box/a40mm/q2
	category = list("initial", "Basic Ammo")

/datum/design/ammolathe/a40mm3
	name = "40mm slug box (magnum)"
	id = "a40mm3"
	build_path = /obj/item/ammo_box/a40mm/q3
	category = list("initial", "Basic Ammo")

/datum/design/ammolathe/a40mmb
	name = "40mm buckshot box (handload)"
	id = "a40mmb"
	build_path = /obj/item/ammo_box/a40mm/buck
	category = list("initial", "Basic Ammo")

/datum/design/ammolathe/a40mmb2
	name = "40mm buckshot box (standard)"
	id = "a40mmb2"
	build_path = /obj/item/ammo_box/a40mm/buck/q2
	category = list("initial", "Basic Ammo")

/datum/design/ammolathe/a40mmb3
	name = "40mm buckshot box (magnum)"
	id = "a40mmb3"
	build_path = /obj/item/ammo_box/a40mm/buck/q3
	category = list("initial", "Basic Ammo")

/datum/design/ammolathe/a40mme
	name = "40mm grenade box (handmade)"
	id = "a40mme"
	build_path = /obj/item/ammo_box/a40mm/exp
	category = list("initial", "Basic Ammo")

/datum/design/ammolathe/a40mme2
	name = "40mm grenade box (standard)"
	id = "a40mme2"
	build_path = /obj/item/ammo_box/a40mm/exp/q2
	category = list("initial", "Basic Ammo")

/datum/design/ammolathe/a40mme3
	name = "40mm grenade box (high explosive)"
	id = "a40mme3"
	build_path = /obj/item/ammo_box/a40mm/exp/q3
	category = list("initial", "Basic Ammo")

///////////////ammo crate recipe///////////////

/datum/design/ammolathe/a40mmcrate
	name = "40mm slug crate (handload)"
	id = "a40mmcrate"
	build_path = /obj/item/ammo_box/a40mm/crate
	category = list("initial", "Basic ammo")

/datum/design/ammolathe/a40mmcrate2
	name = "40mm slug crate (standard)"
	id = "a40mmcrate2"
	build_path = /obj/item/ammo_box/a40mm/crate/q2
	category = list("initial", "Basic ammo")

/datum/design/ammolathe/a40mmcrate3
	name = "40mm slug crate (magnum)"
	id = "a40mmcrate3"
	build_path = /obj/item/ammo_box/a40mm/crate/q3
	category = list("initial", "Basic ammo")

/datum/design/ammolathe/a40mmbcrate
	name = "40mm buckshot crate (handload)"
	id = "a40mmbcrate"
	build_path = /obj/item/ammo_box/a40mm/buck/crate
	category = list("initial", "Basic ammo")

/datum/design/ammolathe/a40mmbcrate2
	name = "40mm buckshot crate (standard)"
	id = "a40mmbcrate2"
	build_path = /obj/item/ammo_box/a40mm/buck/crate/q2
	category = list("initial", "Basic ammo")

/datum/design/ammolathe/a40mmbcrate3
	name = "40mm buckshot crate (magnum)"
	id = "a40mmbcrate3"
	build_path = /obj/item/ammo_box/a40mm/buck/crate/q3
	category = list("initial", "Basic ammo")

/datum/design/ammolathe/a40mmecrate
	name = "40mm grenade crate (handmade)"
	id = "a40mmecrate"
	build_path = /obj/item/ammo_box/a40mm/exp/crate
	category = list("initial", "Basic ammo")

/datum/design/ammolathe/a40mmecrate2
	name = "40mm grenade crate (standard)"
	id = "a40mmecrate2"
	build_path = /obj/item/ammo_box/a40mm/exp/crate/q2
	category = list("initial", "Basic ammo")

/datum/design/ammolathe/a40mmecrate3
	name = "40mm grenade crate (high explosive)"
	id = "a40mmecrate3"
	build_path = /obj/item/ammo_box/a40mm/exp/crate/q3
	category = list("initial", "Basic ammo")
