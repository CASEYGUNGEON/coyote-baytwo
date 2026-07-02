//harpers ferry flintlock is baseline



/obj/item/gun/flintlock/blackpowder_pistol
	name = "blackpowder pistol template"								// use a simple common name. do NOT go overly esoteric or extravagant
	desc = "should not be here, bugreport."							// use the format "A submachine gun chambered in caliber. Optional flavor text goes here."
// cosmetic vars
	icon_state = "mp5"												// the object's sprite name
	icon = 'modular_coyote/icons/objects/automatic.dmi'				// location of the sprite
	mob_overlay_icon = 'modular_coyote/icons/objects/back.dmi'		// location of the back sprite. Uses icon_state. set this to null if not applicable
	inhand_icon_state = "p38"										// the inhand sprite name
	lefthand_file = 'icons/mob/inhands/weapons/guns_lefthand.dmi'	// location of inhand sprites
	righthand_file = 'icons/mob/inhands/weapons/guns_righthand.dmi'
	fire_sound = null 												// null means the cartridge's sound is used.
// performance vars
	damage_multiplier = GUN_EXTRA_DAMAGE_0							// weapon damage modifier
	my_caliber = CALIBER_FLINTLOCK									// defines the acceptable cartridge
	load_time = FLINTLOCK_PISTOL_RELOAD_TIME						// momentary hang after trigger pull
	prefire_time = FLINTLOCK_PISTOL_PREFIRE_TIME					// randomness to the hang
	prefire_randomness = FLINTLOCK_PISTOL_PREFIRE_STD
	init_firemodes = list(											// fire modes and fire rate
		/datum/firemode/semi_auto
	)
	init_recoil = AUTOCARBINE_RECOIL(1, 1)							// recoil: first number modifies 1h recoil. second number modifies 2h recoil
	gun_accuracy_zone_type = ZONE_WEIGHT_PRECISION					// determines chance of the gun hitting its intended limb
	added_spread = GUN_SPREAD_NONE									// adds extra inaccuracy
	force = GUN_MELEE_FORCE_PISTOL_HEAVY							// melee damage
	force_unwielded = 10											// must be same as force. spaghet code
	force_wielded = 25												// melee damage wielding in two hands
	backstab_multiplier = 1											// bonus for pistolwhipping from behind
	throwforce = 25													// damage when thrown
	throw_speed = 1													// speed of throw
	throw_range = 10												// range of throw
	block_parry_data = /datum/block_parry_data/bokken				// parrying properties
// handling vars
	w_class = WEIGHT_CLASS_NORMAL									// item size
	slot_flags = INV_SLOTBIT_BELT | INV_SLOTBIT_BACK				// INV_SLOTBIT_BELT | INV_SLOTBIT_BACK to fit in belt and/or back
	draw_time = GUN_DRAW_NORMAL										// time between drawing and readying the gun
	slowdown = GUN_SLOWDOWN_PISTOL_HEAVY							// move speed penalty when drawn
	weapon_weight = GUN_ONE_HAND_ONLY								// akimbo, one handed, or two handed
	restrict_safety = FALSE											// setting to true disables safety

// accessory vars
	gun_tags = list(GUN_FA_MODDABLE, GUN_SCOPE)						// special weapon attachment tags

	zoom_factor = 0													// integrated scope zoom. requires can_scope = false
	can_scope = FALSE												// can attach a scope
	scope_state = "scope"											// sprites are located in 'icons/fallout/objects/guns/attachments.dmi'
	scope_x_offset = 0												// varedit in test server to zero in
	scope_y_offset = 0

	silenced = FALSE												// integrated suppressor. requires can_suppress = false
	can_suppress = FALSE											// can attach a suppressor
	suppressor_state = null											// sprites are located in 'icons/fallout/objects/guns/attachments.dmi'
	suppressor_x_offset = 0											// varedit in test server to zero in
	suppressor_y_offset = 0

	can_flashlight = FALSE											// can attach a flashlight
	gunlight_state = "flight"										// sprites are located in 'icons/fallout/objects/guns/attachments.dmi'
	flight_x_offset = 0												// varedit in test server to zero in
	flight_y_offset = 0

	can_bayonet = FALSE												// can attach a bayonet
	bayonet_state = "bayonetstraight"								// sprites are located in 'icons/fallout/objects/guns/attachments.dmi'
	knife_x_offset = 0												// varedit in test server to zero in
	knife_y_offset = 0

/obj/item/gun/flintlock/blackpowder_pistol/horse
	name = "worn Horseman's pistol"
	desc = "A blackpowder pistol chambered in .58 ball."
/obj/item/gun/flintlock/blackpowder_rifle/horse/q2
	name = "Horseman's pistol"
	max_upgrades = 4
/obj/item/gun/flintlock/blackpowder_rifle/horse/q3
	name = "unrusted Horseman's pistol"
	max_upgrades = 5
