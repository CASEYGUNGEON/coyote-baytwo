//////////////////////
//AUTOMATIC TEMPLATE//
//////////////////////

/obj/item/gun/ballistic/automatic
	name = "automatic gun template"
	desc = "should not be here, bugreport."

	var/auto_eject = 0 //for en blocs
	var/auto_eject_sound = null
	//var/alarmed = 0 //for a funky, annoying sound when ammo runs out. broken code
	equipsound = 'sound/f13weapons/equipsounds/riflequip.ogg'
	init_recoil = SMG_RECOIL(1, 1)

/obj/item/gun/ballistic/automatic/update_icon_state()
	if(SEND_SIGNAL(src, COMSIG_ITEM_UPDATE_RESKIN))
		return // all done!
	var/bolt_closed = bolt_state == GBOLT_CLOSED
	icon_state = "[initial(icon_state)][magazine ? "-[magazine.max_ammo]" : ""][bolt_closed ? "" : "-e"]"

/obj/item/gun/ballistic/automatic/can_shoot()
	return get_ammo()

/obj/item/gun/ballistic/automatic/afterattack(atom/target, mob/living/user)
	..()
	if(auto_eject && magazine && magazine.stored_ammo && !magazine.stored_ammo.len && !chambered)
		magazine.dropped()
		user.visible_message(
			"[magazine] falls out and clatters on the floor!",
			span_notice("[magazine] falls out and clatters on the floor!")
		)
		if(auto_eject_sound)
			playsound(user, auto_eject_sound, 40, 1)
		magazine.forceMove(get_turf(src.loc))
		magazine.update_icon()
		magazine = null
		update_icon()

///////////////////
//PISTOL TEMPLATE//
///////////////////

/obj/item/gun/ballistic/automatic/pistol
	name = "pistol template"
	desc = "should not be here. Bugreport."
	equipsound = 'sound/f13weapons/equipsounds/pistolequip.ogg'
	init_recoil = HANDGUN_RECOIL(1, 1)

/obj/item/gun/ballistic/automatic/pistol/no_mag
	spawnwithmagazine = FALSE

/obj/item/gun/ballistic/automatic/pistol/update_icon_state()
	var/bolt_closed = bolt_state == GBOLT_CLOSED
	icon_state = "[initial(icon_state)][bolt_closed ? "" : "-e"]"

////////////////////
// RIFLE TEMPLATE //
////////////////////

/obj/item/gun/ballistic/rifle
	name = "rifle template"
	desc = "Should not exist"
	init_recoil = RIFLE_RECOIL(1, 1)
	init_firemodes = list(
		/datum/firemode/bolt_using/straight_pull
	)
	manual_bolt_open_sound =        'sound/weapons/biblically_accurate_guns/bolt_rifle_open_short.ogg'
	manual_bolt_close_sound =       'sound/weapons/biblically_accurate_guns/bolt_rifle_close_short.ogg'
	casing_eject_sound =            'sound/weapons/biblically_accurate_guns/bolt_casing_eject.ogg'
	empty_casing_eject_sound =      'sound/weapons/biblically_accurate_guns/bolt_casing_eject_empty.ogg'

	spawnwithmagazine = TRUE
	can_load_magazine_through_bolt = TRUE

/obj/item/gun/ballistic/rifle/blow_up(mob/user)
	. = 0
	if(chambered && chambered.BB)
		process_fire(user, user, FALSE)
		. = 1

//////////////////////
// SHOTGUN TEMPLATE //
//////////////////////

/obj/item/gun/ballistic/shotgun
	name = "shotgun template"
	desc = "Should not exist"
	mag_type = /obj/item/ammo_box/magazine/internal/shot
	manual_bolt_open_sound =        'sound/weapons/biblically_accurate_guns/bolt_shotgun_open.ogg'
	manual_bolt_close_sound =       'sound/weapons/biblically_accurate_guns/bolt_shotgun_close.ogg'
	casing_eject_sound =            'sound/weapons/biblically_accurate_guns/bolt_casing_eject.ogg'
	empty_casing_eject_sound =      'sound/weapons/biblically_accurate_guns/bolt_casing_eject_empty.ogg'

	init_recoil = SHOTGUN_RECOIL(1, 1)
	init_firemodes = list(
		/datum/firemode/bolt_using/pump_action
	)
	spawnwithmagazine = TRUE
	can_load_magazine_through_bolt = TRUE 

/obj/item/gun/ballistic/shotgun/blow_up(mob/user)
	. = 0
	if(chambered && chambered.BB)
		process_fire(user, user, FALSE)
		. = 1

////////////////////////////////
// AUTOMATIC SHOTGUN TEMPLATE //
////////////////////////////////

/obj/item/gun/ballistic/shotgun/automatic/update_icon_state()
	var/bolt_open = bolt_state == GBOLT_OPEN
	if(bolt_open)
		icon_state = "[initial(icon_state)]-e"
	else
		icon_state = "[initial(icon_state)]"
