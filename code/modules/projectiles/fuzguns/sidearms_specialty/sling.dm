// it...it's a piece of string. that's the baseline

/obj/item/gun/energy/kinetic_accelerator/crossbow/sling
	name = "sling"
	desc = "A simple piece of leather, shaped to hold one rock, and hurl it at a target at high speed. Due to the abundance of stray stones and rubble, this weapon has effectively unlimited reloads."
	ammo_type = list(/obj/item/ammo_casing/energy/bolt/sling)
	weapon_weight = GUN_ONE_HAND_ONLY
	w_class = WEIGHT_CLASS_TINY
	force = 5
	force_unwielded = 5
	force_wielded = 10
	throwforce = 5
	silenced = TRUE
	icon = 'modular_coyote/icons/objects/bows.dmi'
	lefthand_file = 'icons/mob/inhands/equipment/belt_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/belt_righthand.dmi'
	icon_state = "sling"
	inhand_icon_state = "utility"
	pin = null
	no_pin_required = TRUE
	fire_sound = 'sound/weapons/punchmiss.ogg'
	fire_sound_silenced = 'sound/weapons/punchmiss.ogg'
	init_recoil = LASER_HANDGUN_RECOIL(1.2, 1)

/obj/item/gun/energy/kinetic_accelerator/crossbow/sling/staff
	name = "sling staff"
	desc = "A simple piece of leather strapped to a staff allowing it greater damage both in melee and at range. Due to the abundance of stray stones and rubble, this weapon has effectively unlimited reloads."
	weapon_weight = GUN_TWO_HAND_ONLY
	w_class = WEIGHT_CLASS_NORMAL
	force = 25
	force_unwielded = 25
	force_wielded = 35
	throwforce = 25
	silenced = TRUE
	icon_state = "slingstaff"
	overheat_time = 40 // 4.0 seconds
	init_recoil = LASER_CARBINE_RECOIL(2, 1)
	damage_multiplier = GUN_EXTRA_DAMAGE_T5
	init_firemodes = list(
		/datum/firemode/semi_auto/slower
	)
