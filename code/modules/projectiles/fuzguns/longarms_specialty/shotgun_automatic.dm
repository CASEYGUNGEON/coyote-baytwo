// model 7188 is baseline
/obj/item/gun/ballistic/automatic/auto_shotgun
	name = "automatic shotgun template"								// use a simple common name. do NOT go overly esoteric or extravagant
	desc = "should not be here, bugreport."							// use the format "A submachine gun chambered in caliber. Optional flavor text goes here."
// cosmetic vars
	icon_state = "shotgun"											// the object's sprite name
	icon = 'icons/fallout/objects/guns/ww2guns.dmi'					// location of the sprite
	mob_overlay_icon = null											// location of the back sprite. Uses icon_state. set this to null if not applicable
	inhand_icon_state = "shotgunauto5"								// the inhand sprite name
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'	// location of inhand sprites
	righthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	fire_sound = 'sound/f13weapons/repeater_fire.ogg' 				// null means the cartridge's sound is used.
	ejector_side = GUN_EJECTOR_RIGHT								// direction casings are ejected
// performance vars
	damage_multiplier = GUN_EXTRA_DAMAGE_0							// weapon damage modifier
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/a12g/eight			// family of magazines it can fit
	init_mag_type = /obj/item/ammo_box/magazine/internal/cylinder/a12g/eight	// specific mag it starts with 
	extra_mag_types = list()										// extra familes of magazines it can fit
	disallowed_mags = list()										// members of magazine family it cannot fit
	init_firemodes = list(											// fire modes and fire rate
		/datum/firemode/automatic/rpm450,
		/datum/firemode/semi_auto/rpm450
	)
	init_recoil = AUTOSHOTGUN_RECOIL(1, 1)							// recoil: first number modifies 1h recoil. second number modifies 2h recoil
	gun_accuracy_zone_type = ZONE_WEIGHT_SHOTGUN					// determines chance of the gun hitting its intended limb
	added_spread = GUN_SPREAD_NONE									// adds extra inaccuracy
// melee vars
	force = GUN_MELEE_FORCE_PISTOL_HEAVY							// melee damage
	force_unwielded = GUN_MELEE_FORCE_PISTOL_HEAVY					// must be same as force. spaghet code
	force_wielded = GUN_MELEE_FORCE_RIFLE_LIGHT						// melee damage wielding in two hands
	attack_speed = CLICK_CD_MELEE * 1.1								// delay between attacks
	backstab_multiplier = 3											// bonus for pistolwhipping from behind
	throwforce = GUN_MELEE_FORCE_PISTOL_HEAVY						// damage when thrown
	throw_speed = 1													// speed of throw
	throw_range = 5													// range of throw
	block_parry_data = /datum/block_parry_data/bokken				// parrying properties
// handling vars
	w_class = WEIGHT_CLASS_BULKY									// item size
	slot_flags = INV_SLOTBIT_BACK									// INV_SLOTBIT_BELT | INV_SLOTBIT_BACK to fit in belt and/or back
	draw_time = GUN_DRAW_NORMAL										// time between drawing and readying the gun
	slowdown = GUN_SLOWDOWN_SHOTGUN_AUTO							// move speed penalty when drawn
	weapon_weight = GUN_ONE_HAND_ONLY								// akimbo, one handed, or two handed
	restrict_safety = FALSE											// setting to true disables safety
	auto_eject = 0													// auto-ejects empty magazine
	auto_eject_sound = null
	insert_magazine_delay = 0.5 SECONDS								// time to insert new mag
	remove_magazine_delay = 0.5 SECONDS								// time to remove mag
	can_load_magazine_through_bolt = TRUE
// accessory vars
	gun_tags = list(GUN_FA_MODDABLE)								// special weapon attachment tags

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

/obj/item/gun/ballistic/automatic/auto_shotgun/m7188
	name = "worn Model 7188"
	desc = "An automatic shotgun chambered in 12 gauge. A favored shotgun of the Navy SEALs."
/obj/item/gun/ballistic/automatic/auto_shotgun/m7188/q2
	name = "Model 7188"
	max_upgrades = 4
/obj/item/gun/ballistic/automatic/auto_shotgun/m7188/q3
	name = "unrusted Model 7188"
	max_upgrades = 5
