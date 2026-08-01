/*
 * /datum/firemode - the way guns know how to fire
 * Every gun gets one of these. Every one of them. Even the ones that don't have a firemode. They get a default one.
 * Defines things like:
 * - Fire rate
 * - Burst size
 * - Fire type (semi, burst, auto)
 * - Damage multiplier
 * - etc
 */

// marge, get my gun
#define GET_GUN var/obj/item/gun/gun = GET_WEAKREF(my_gun); if(!gun) {stack_trace("[src]'s gun is null in [name] firemode [type]!! OH NO"); qdel(src); return}

/datum/firemode
	var/name = "default"
	var/desc = "The default firemode"
	var/extra_tip = "Shoots!"
	var/icon_state
	var/list/settings = list()
	/// is the gun semi, burst, or fullauto?
	var/fire_type = GUN_FIREMODE_SEMIAUTO
	var/fire_type_default = GUN_FIREMODE_SEMIAUTO
	/// Time between shots, both semi and full auto
	var/shoot_delay = GUN_FIRE_DELAY_NORMAL
	var/shoot_delay_default = GUN_FIRE_DELAY_NORMAL
	/// Time between shots when fired as a burst. Shoot delay is time between bursts
	var/burst_delay = GUN_BURSTFIRE_DELAY_NORMAL
	var/burst_delay_default = GUN_BURSTFIRE_DELAY_NORMAL
	/// How many shots per burst
	var/burst_count = 1
	var/burst_count_default = 1
	/// Damage multiplier
	var/damage_multiplier = 1
	var/damage_multiplier_default = 1
	/// Shot cost multiplier
	var/shot_cost_multiplier = 1
	var/shot_cost_multiplier_default = 1
	/// If set, will override the gun's chambered casing with this just as its about to fire
	// var/obj/item/ammo_casing/override_shot
	// var/obj/item/ammo_casing/override_shot_default
	/// If we are here because of an upgrade, this is the upgrade that brought us here
	/// If this is ever not in the gun's item_upgrades list, we will be destroyed!
	var/atom/movable/my_dependant
	/// THe gun this is attached to
	var/datum/weakref/my_gun

	// gun action stuff! lets you have like, a shotgun that can be pump action and semiauto!
	/* ACTION STUFF
	 * This module defines gun action styles that control how firearms operate
	 * when fired. Each style determines:
	 *   - Whether the hammer needs to be cocked before firing
	 *   - Whether the gun recocks automatically after firing
	 *   - When cartridges are ejected (after firing or manually)
	 *   - Whether the action requires racking (semi-auto) or cocking (revolver)
	 *
	 * Examples:
	 *   - Autoloaders: Ignore hammer, automatic recock, rack-based
	 *     - vast majority of guns, includes semiauto, auto, burst, etc
	 *   - Single-action revolvers: Require manual cocking, manual ejection only
	 *   - Pump shotguns: Ignore cocking, eject after racking
	 *   - Bolt-action rifles: Ignore cocking, eject after racking
	 */
	/// Should we consult the hammer state when firing? If true, we defer to the hammer state to see if we can try to shoot
	var/hammer_ignore          = TRUE
	/// Should we automatically recock after firing, if the hammer is consulted? False means you have to click again to recock
	var/hammer_recock_on_fire  = TRUE
	/// can you even mess with the hammer manually?
	var/hammer_manually_operatable = FALSE
	/// does the bolt cycle back, then forward on a shot?
	var/bolt_cycles_on_shoot   = TRUE
	/// when you click the gun, does it cycle until its in a position you can shoot it with?
	var/bolt_cycles_to_shootable_state_on_shoot = TRUE
	// so if it doesnt cycle on shoot, and doesnt cycle to a shootable state
	// when u shoot, you gotta use it to *chunk* it back, then use it to *clack* it forward
	var/bolt_ejects_on_open     = TRUE
	var/bolt_chambers_on_close  = TRUE
	var/bolt_opens_on_last_shot = TRUE
	var/bolt_shootable_state = GBOLT_CLOSED
	var/bolt_manually_chamberable_state = GBOLT_OPEN
	/// sets what state you can load ammo into the *magazine*
	/// set to null to load it from any state
	/// one time on deviantart i found a pony who's special talent was peeing while having an erection
	var/bolt_reloadable_state = GBOLT_OPEN
	var/bolt_ignore = FALSE
	var/bolt_cocks_hammer_on_this_state = GBOLT_CLOSED
	var/bolt_opening_delay = 0
	var/bolt_closing_delay = 0
	/// to add a delay to between you pull trigger and the gun shoots
	/// for stuff like open bolties
	var/trigger_to_shoot_delay = 0

/datum/firemode/New(obj/item/gun/_gun, atom/movable/_dependant)
	..()
	fire_type = fire_type_default
	shoot_delay = shoot_delay_default
	burst_delay = burst_delay_default
	burst_count = burst_count_default
	damage_multiplier_default = _gun.damage_multiplier
	damage_multiplier = damage_multiplier_default
	shot_cost_multiplier = shot_cost_multiplier_default
	my_gun = WEAKREF(_gun)
	if(_dependant)
		my_dependant = WEAKREF(_dependant)
	if(prob(1))
		desc += " Bitch."

/datum/firemode/Destroy()
	var/obj/item/gun/gun = GET_WEAKREF(my_gun)
	if(gun)
		gun.firemodes -= src
		gun.set_firemode(1)
	my_gun = null
	return ..()

/datum/firemode/proc/apply_firemode()
	GET_GUN
	update_mods()
	gun.automatic = (fire_type == GUN_FIREMODE_AUTO)
	gun.burst_size = burst_count
	gun.fire_delay = shoot_delay
	gun.burst_shot_delay = burst_delay
	gun.damage_multiplier = damage_multiplier

/datum/firemode/proc/update_mods()
	GET_GUN
	if(my_dependant)
		var/atom/movable/papa_mod = GET_WEAKREF(my_dependant)
		if(!papa_mod || !(papa_mod in gun.item_upgrades))
			qdel(src)
			return
	fire_type = fire_type_default
	shoot_delay = shoot_delay_default
	burst_delay = burst_delay_default
	burst_count = burst_count_default
	damage_multiplier = damage_multiplier_default
	shot_cost_multiplier = shot_cost_multiplier_default
	for(var/obj/item/attch in gun.item_upgrades)
		var/list/my_upgrades = list()
		SEND_SIGNAL(attch, COMSIG_GET_UPGRADES, my_upgrades)
		if(!LAZYLEN(my_upgrades))
			continue
		for(var/cat in my_upgrades)
			switch(cat)
				if(GUN_UPGRADE_DAMAGE_MULT)
					damage_multiplier = LAZYACCESS(my_upgrades, cat)
				if(GUN_UPGRADE_FIRE_DELAY_MULT)
					shoot_delay *= LAZYACCESS(my_upgrades, cat)
					burst_delay *= LAZYACCESS(my_upgrades, cat)
				if(GUN_UPGRADE_CHARGECOST)
					shot_cost_multiplier *= LAZYACCESS(my_upgrades, cat)

/datum/firemode/proc/get_fire_delay(rpm_plz)
	var/deciseconds_per_shot = shoot_delay
	if(rpm_plz)
		deciseconds_per_shot = round((10 / max(deciseconds_per_shot, 0.1)) * 60, 5)
	return deciseconds_per_shot

//Called whenever the firemode is switched to, or the gun is picked up while its active
/datum/firemode/proc/update()
	return

/////////////////////////////////////////////////////
//// PARENT FIRE RATES, DON'T USE THESE PROBABLY ////
/////////////////////////////////////////////////////

/datum/firemode/bolt_using
	name = "Parent Bolt Using"
	desc = "hi"
	extra_tip = "Fires when you release the mouse button. Note that on any intent other than Harm, \
		if you move your mouse before releasing the button, or your mouse is over a different 'thing' \
		when let go, you will probably not fire. To more reliably fire, use the Harm intent when shooting!\n\n\
		Also, remember that you have to bolt the gun manually after every shot!"
	shoot_delay_default                     = GUN_FIRE_DELAY_SLOW
	bolt_ignore                             = FALSE
	bolt_cycles_to_shootable_state_on_shoot = FALSE
	bolt_cycles_on_shoot                    = FALSE
	bolt_ejects_on_open                     = TRUE
	bolt_opens_on_last_shot                 = FALSE
	bolt_shootable_state                    = GBOLT_CLOSED
	bolt_manually_chamberable_state         = GBOLT_OPEN
	bolt_cocks_hammer_on_this_state         = GBOLT_CLOSED
	bolt_opening_delay                      = 0
	bolt_closing_delay                      = 0
	bolt_reloadable_state                   = GBOLT_OPEN

/datum/firemode/semi_auto
	name = "Semi Automatic"
	desc = "Shoot one shot per trigger pull."
	extra_tip = "Fires when you release the mouse button. Note that on any intent other than Harm, \
		if you move your mouse before releasing the button, or your mouse is over a different 'thing' \
		when let go, you will probably not fire. To more reliably fire, use the Harm intent when shooting!"
	icon_state = "semi"
	fire_type_default = GUN_FIREMODE_SEMIAUTO
	shoot_delay_default = GUN_FIRE_DELAY_FAST
	burst_count_default = 1

/datum/firemode/automatic
	name = "Fully Automatic"
	desc = "Spray and pray."
	icon_state = "auto"
	extra_tip = "Fires as long as you hold the mouse click down. Careful when clicking things, \
		it will rapidly click them."
	fire_type_default = GUN_FIREMODE_AUTO
	shoot_delay_default = GUN_FIRE_RATE_1200

/datum/firemode/burst
	name = "Burstfire"
	desc = "Shoot multiple shots per triggerpull."
	extra_tip = "Fires a several-round burst. Recoil is calculated after the end of the burst, so every shot \
		in the burst will have more or less the same amount of spread."
	icon_state = "burst"
	fire_type_default = GUN_FIREMODE_BURST
	burst_delay_default = GUN_BURSTFIRE_DELAY_NORMAL
	shoot_delay_default = GUN_FIRE_DELAY_SLOW
	burst_count_default = 3

/datum/firemode/open_bolt
	name = "Open Bolt"
	desc = "Shoot one shot per trigger pull."
	extra_tip = "Fires when you release the mouse button. Note that on any intent other than Harm, \
		if you move your mouse before releasing the button, or your mouse is over a different 'thing' \
		when let go, you will probably not fire. To more reliably fire, use the Harm intent when shooting!"
	icon_state = "semi"
	fire_type_default = GUN_FIREMODE_SEMIAUTO
	shoot_delay_default = GUN_FIRE_DELAY_NORMAL
	burst_count_default = 1
	bolt_ignore                             = FALSE
	bolt_cycles_to_shootable_state_on_shoot = TRUE
	bolt_ejects_on_open                     = TRUE
	bolt_opens_on_last_shot                 = FALSE
	bolt_shootable_state                    = GBOLT_OPEN
	bolt_manually_chamberable_state         = GBOLT_OPEN
	bolt_cocks_hammer_on_this_state         = GBOLT_OPEN
	// trigger_to_shoot_delay = 0.1 SECONDS

/datum/firemode/open_bolt/automatic
	name = "Open Bolt Automatic"
	desc = "Spray and pray, but with an open bolt design."
	icon_state = "auto"
	extra_tip = "Fires as long as you hold the mouse click down. Careful when clicking things, \
		it will rapidly click them."
	fire_type_default = GUN_FIREMODE_AUTO
	shoot_delay_default = GUN_FIRE_RATE_1200

////////////////////////////////////////
///////// SPECIALTY FIRE RATES /////////
//// WEIRD BURST FIRE RATES GO HERE ////
////////////////////////////////////////

/datum/firemode/semi_auto/shotgun_fixed
	name = "Single-Barrel Shot"
	desc = "Blast 'em with one of those barrels!"
	bolt_ejects_on_open = GEJECTOR_MANUAL_ONLY

/datum/firemode/burst/two/shotgun_fixed
	name = "Both barrels"
	desc = "Fire both barrels at once!"
	burst_delay_default = GUN_BURSTFIRE_DELAY_FASTEST
	burst_count_default = 2
	bolt_ejects_on_open = GEJECTOR_MANUAL_ONLY

/*
 * SINGLE ACTION FIREMODES
 * For revolvers of various types, and break action guns
 * HAMMER is important, BOLT is not
 * For burstfire single-actions (DB shotguns or whatever), make the hammer recock on fire
 * and ideally, have a burst count equal to the magazine capacity, to maintain the illusion
 */
/datum/firemode/single_action
	name = "Single Action"
	desc = "Shoot one shot, pull back the hammer, repeat."
	extra_tip = "Fires when you release the mouse button. Note that on any intent other than Harm, \
		if you move your mouse before releasing the button, or your mouse is over a different 'thing' \
		when let go, you will probably not fire. To more reliably fire, use the Harm intent when shooting!\n\n\
		Also, remember that you have to pull back the hammer manually after every shot!"
	icon_state = "semi"
	fire_type_default = GUN_FIREMODE_SEMIAUTO
	shoot_delay_default = GUN_FIRE_DELAY_FAST
	burst_count_default = 1
	hammer_recock_on_fire = FALSE
	hammer_ignore = FALSE
	bolt_ignore = TRUE
	bolt_ejects_on_open = GEJECTOR_MANUAL_ONLY
	bolt_cycles_on_shoot = FALSE
	bolt_cycles_to_shootable_state_on_shoot = FALSE

/datum/firemode/single_action/double_action
	name = "Double Action"
	desc = "Shoot one shot, repeat."
	extra_tip = "Fires when you release the mouse button. Note that on any intent other than Harm, \
		if you move your mouse before releasing the button, or your mouse is over a different 'thing' \
		when let go, you will probably not fire. To more reliably fire, use the Harm intent when shooting!"
	hammer_recock_on_fire = TRUE

/* 
 * BOLT ACTION FIREMODES
 * For guns that require manual cycling of the bolt, like bolt action rifles and pump shotguns
 * BOLT is important, HAMMER is (generally) not
 * For burstfire bolt-actions... just use one of the automatic firemodes
 */
/datum/firemode/bolt_using/straight_pull
	name = "Straight-Pull Bolt Action"
	desc = "Shoot one shot, pull the bolt straight back and forward, repeat."
	extra_tip = "Uses a straight-pull bolt action, which means you just pull the bolt back, \
		then push it forward, with no delay on either action."

/datum/firemode/bolt_using/straight_pull/fast
	shoot_delay_default = GUN_FIRE_DELAY_FAST


/datum/firemode/bolt_using/delay_on_open
	name = "Cock-On-Open Bolt Action"
	desc = "Shoot one shot, pull the bolt back, slap it forward, repeat."
	extra_tip = "Uses a cock-on-open bolt action, which means that pulling the bolt open \
		will have a short delay, but closing it will be instant."
	bolt_opening_delay = 0.2 SECONDS

/datum/firemode/bolt_using/delay_on_open/fast
	shoot_delay_default = GUN_FIRE_DELAY_FAST


/datum/firemode/bolt_using/delay_on_close
	name = "Cock-On-Close Bolt Action"
	desc = "Shoot one shot, pull the bolt back, slap it forward, repeat."
	extra_tip = "Uses a cock-on-close bolt action, which means that jorking the bolt closed \
		will have a short delay, but opening it will be instant."
	bolt_closing_delay = 0.2 SECONDS

/datum/firemode/bolt_using/delay_on_close/fast
	shoot_delay_default = GUN_FIRE_DELAY_FAST


/datum/firemode/bolt_using/pump_action
	name = "Pump Action"
	desc = "Shoot one shot, pull the pump back, push it forward, repeat."
	extra_tip = "Uses a pump action, which means that you just pull the pump back, \
		then push it forward, with no delay on either action."
	bolt_reloadable_state = null


/datum/firemode/bolt_using/lever_action
	name = "Lever Action"
	desc = "Shoot one shot, jork the lever, repeat."
	extra_tip = "Uses a lever action, which means that you just jork the lever, \
		with no delay on either action."
	bolt_reloadable_state = null

/datum/firemode/bolt_using/lever_action/fast
	shoot_delay_default = GUN_FIRE_DELAY_FAST

/////////////////////////////////////////////////////////////////////////////////////////////////////////
//// MAIN FIRERATES: NEW ADDITIONS SHOULD BE FULL FORMATED BLOCKS, PLACED IN ORDER OF DESCENDING RPM ////
/////////////////////////////////////////////////////////////////////////////////////////////////////////

// 1200 RPM FIRE RATES //////////////////////////////////////////////////////////////////////////////////
/datum/firemode/semi_auto/rpm1200
	desc = "Semi-automatic - 1200 RPM."
	shoot_delay_default = GUN_FIRE_RATE_1200
/datum/firemode/automatic/rpm1200
	desc = "Automatic - 1200 RPM."
	shoot_delay_default = GUN_FIRE_RATE_1200
/datum/firemode/burst/rpm1200
	desc = "Burst fire - 1200 RPM."
	burst_delay_default = GUN_FIRE_RATE_1200
	shoot_delay_default = GUN_FIRE_RATE_1200
/datum/firemode/open_bolt/rpm1200
	desc = "Open bolt semi-auto - 1200 RPM."
	shoot_delay_default = GUN_FIRE_RATE_1200
/datum/firemode/open_bolt/automatic/rpm1200
	desc = "Open bolt automatic - 1200 RPM."
	shoot_delay_default = GUN_FIRE_RATE_1200

// 1000 RPM FIRE RATES //////////////////////////////////////////////////////////////////////////////////
/datum/firemode/semi_auto/rpm1000
	desc = "Semi-automatic - 1000 RPM."
	shoot_delay_default = GUN_FIRE_RATE_1000
/datum/firemode/automatic/rpm1000
	desc = "Automatic - 1000 RPM."
	shoot_delay_default = GUN_FIRE_RATE_1000
/datum/firemode/burst/rpm1000
	desc = "Burst fire - 1000 RPM."
	burst_delay_default = GUN_FIRE_RATE_1000
	shoot_delay_default = GUN_FIRE_RATE_1000
/datum/firemode/open_bolt/rpm1000
	desc = "Open bolt semi-auto - 1000 RPM."
	shoot_delay_default = GUN_FIRE_RATE_1000
/datum/firemode/open_bolt/automatic/rpm1000after_shooting
	desc = "Open bolt automatic - 1000 RPM."
	shoot_delay_default = GUN_FIRE_RATE_1000

// 800 RPM FIRE RATES //////////////////////////////////////////////////////////////////////////////////
/datum/firemode/semi_auto/rpm800
	desc = "Semi-automatic - 800 RPM."
	shoot_delay_default = GUN_FIRE_RATE_800
/datum/firemode/automatic/rpm800
	desc = "Automatic - 800 RPM."
	shoot_delay_default = GUN_FIRE_RATE_800
/datum/firemode/burst/rpm800
	desc = "Burst fire - 800 RPM."
	burst_delay_default = GUN_FIRE_RATE_800
	shoot_delay_default = GUN_FIRE_RATE_800
/datum/firemode/open_bolt/rpm800
	desc = "Open bolt semi-auto - 800 RPM."
	shoot_delay_default = GUN_FIRE_RATE_800
/datum/firemode/open_bolt/automatic/rpm800
	desc = "Open bolt automatic - 800 RPM."
	shoot_delay_default = GUN_FIRE_RATE_800

// 600 RPM FIRE RATES //////////////////////////////////////////////////////////////////////////////////
/datum/firemode/semi_auto/rpm600
	desc = "Semi-automatic - 600 RPM."
	shoot_delay_default = GUN_FIRE_RATE_600
/datum/firemode/automatic/rpm600
	desc = "Automatic - 600 RPM."
	shoot_delay_default = GUN_FIRE_RATE_600
/datum/firemode/burst/rpm600
	desc = "Burst fire - 600 RPM."
	burst_delay_default = GUN_FIRE_RATE_600
	shoot_delay_default = GUN_FIRE_RATE_600
/datum/firemode/open_bolt/rpm600
	desc = "Open bolt semi-auto - 600 RPM."
	shoot_delay_default = GUN_FIRE_RATE_600
/datum/firemode/open_bolt/automatic/rpm600
	desc = "Open bolt automatic - 600 RPM."
	shoot_delay_default = GUN_FIRE_RATE_600

// 450 RPM FIRE RATES //////////////////////////////////////////////////////////////////////////////////
/datum/firemode/semi_auto/rpm450
	desc = "Semi-automatic - 450 RPM."
	shoot_delay_default = GUN_FIRE_RATE_450
/datum/firemode/automatic/rpm450
	desc = "Automatic - 450 RPM."
	shoot_delay_default = GUN_FIRE_RATE_450
/datum/firemode/burst/rpm450
	desc = "Burst fire - 450 RPM."
	burst_delay_default = GUN_FIRE_RATE_450
	shoot_delay_default = GUN_FIRE_RATE_450
/datum/firemode/open_bolt/rpm450
	desc = "Open bolt semi-auto - 450 RPM."
	shoot_delay_default = GUN_FIRE_RATE_450
/datum/firemode/open_bolt/automatic/rpm450
	desc = "Open bolt automatic - 450 RPM."
	shoot_delay_default = GUN_FIRE_RATE_450

// 400 RPM FIRE RATES //////////////////////////////////////////////////////////////////////////////////
/datum/firemode/semi_auto/rpm400
	desc = "Semi-automatic - 400 RPM."
	shoot_delay_default = GUN_FIRE_RATE_400
/datum/firemode/automatic/rpm400
	desc = "Automatic - 400 RPM."
	shoot_delay_default = GUN_FIRE_RATE_400
/datum/firemode/burst/rpm400
	desc = "Burst fire - 400 RPM."
	burst_delay_default = GUN_FIRE_RATE_400
	shoot_delay_default = GUN_FIRE_RATE_400
/datum/firemode/open_bolt/rpm400
	desc = "Open bolt semi-auto - 400 RPM."
	shoot_delay_default = GUN_FIRE_RATE_400
/datum/firemode/open_bolt/automatic/rpm400
	desc = "Open bolt automatic - 400 RPM."
	shoot_delay_default = GUN_FIRE_RATE_400
