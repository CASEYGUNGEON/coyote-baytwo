//////////////////////
//FLINTLOCK TEMPLATE//
//////////////////////

/obj/item/gun/flintlock
	name = "flintlock template"
	desc = "should not be here, bugreport."
	icon_state = "flintlock"
	inhand_icon_state = "flintlock"
	dryfire_text = "*not loaded*"
	var/cocked = TRUE
	var/my_caliber = CALIBER_FLINTLOCK
	var/load_time = FLINTLOCK_PISTOL_RELOAD_TIME
	var/prefire_time = FLINTLOCK_PISTOL_PREFIRE_TIME
	var/prefire_randomness = FLINTLOCK_PISTOL_PREFIRE_STD
	var/datum/looping_sound/musket_load/load_loop
	var/datum/looping_sound/musket_fuse/fuse_loop
	weapon_special_component = null

/obj/item/gun/flintlock/Initialize()
	. = ..()
	load_loop = new(list(src), FALSE)
	fuse_loop = new(list(src), FALSE)
	chambered = new /obj/item/ammo_casing/caseless/flintlock(src)

/obj/item/gun/flintlock/admin_fill_gun()
	if(chambered)
		return
	chambered = new /obj/item/ammo_casing/caseless/flintlock(src)
	cocked = TRUE
	update_icon()
	return TRUE

/obj/item/gun/flintlock/generate_guntags()
	..()
	gun_tags |= GUN_PROJECTILE

/obj/item/gun/flintlock/UpdateAmmoCountOverlay()
	// if(isturf(loc))//Only show th ammo count if the magazine is, like, in an inventory or something. Mags on the ground don't need a big number on them, that's ugly.
	// 	maptext = ""
	// else
	// 	var/txte = ""
	// 	var/culur = "#FF0000"
	// 	if(chambered)
	// 		if(cocked)
	// 			txte = "1/1 !C!"
	// 			culur = "#00FFFF"
	// 		else
	// 			txte = "1/1"
	// 			culur = "#FFFF00"
	// 	else
	// 		if(cocked)
	// 			txte = "0/1 !C!"
	// 			culur = "#FF0000"
	// 		else
	// 			txte = "0/1"
	// 			culur = "#FF0000"
	// 	maptext = "<font color='[culur]'><b>[txte]</b></font>"


/obj/item/gun/flintlock/ui_data(mob/user)
	var/list/data = ..()
	data["cockable"] = TRUE
	data["cocked"] = cocked || FALSE
	data["flintlock_load_time"] = (load_time * 0.1) || 0
	data["flintlock_prefire_time"] = (prefire_time * 0.1) || 0
	data["flintlock_prefire_1SD"] = (prefire_randomness * 0.1) || 0
	data["has_magazine"] = TRUE
	data["accepted_magazines"] = "powder, and ball"
	data["magazine_name"] = "Metal Tube"
	data["magazine_calibers"] = "powder, and ball"
	data["shots_remaining"] = !!chambered || 0
	data["shots_max"] = 1
	return data

/obj/item/gun/flintlock/attack_self(mob/living/user)
	cock(user)

/obj/item/gun/flintlock/AltClick(mob/user)
	unload(user)

/obj/item/gun/flintlock/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(istype(I, /obj/item/ammo_box))
		load_from_box(user, I)
	if(istype(I, /obj/item/ammo_casing))
		load_casing(user, I)

/obj/item/gun/flintlock/update_icon_state()
	return

/// Scans the box, takes a casing if possible
/obj/item/gun/flintlock/proc/load_from_box(mob/living/user, obj/item/ammo_box/bawx)
	if(!user)
		return
	if(chambered)
		to_chat(user, span_alert("[src] is already loaded!"))
		return
	if(!istype(bawx, /obj/item/ammo_box))
		return
	var/obj/item/ammo_casing/to_load
	for(var/obj/item/ammo_casing/bluuet in bawx.stored_ammo) // magazine procs suck (I should know, i wrote em)
		if(bluuet.caliber != my_caliber)
			continue
		to_load = bluuet
		break
	if(!to_load)
		to_chat(user, span_alert("Couldn't find anything in [bawx] that fits in [src]."))
		return
	if(!load_casing(user, to_load)) //load the ammo casing into the gun
		to_chat(user, span_alert("You can't seem to load [to_load] into [src].")) //tell the user the gun cannot be loaded
		return //return
	bawx.stored_ammo -= to_load //remove the ammo casing from the boxx
	bawx.update_icon() //update the icon of the boxx

/// Forcemoves bluuet into the gun, and sets its chambered to the bluuet
/obj/item/gun/flintlock/proc/load_casing(mob/living/user, obj/item/ammo_casing/bluuet)
	if(!user) //if there is no user
		return //return
	if(chambered) //if the gun is already loaded
		to_chat(user, span_alert("[src] is already loaded!")) //tell the user the gun is already loaded
		return //return
	if(!istype(bluuet, /obj/item/ammo_casing)) //if the thing you are trying to load is not an ammo casing
		return //return
	if(bluuet.caliber != my_caliber) //if the gun and the ammo casing do not share the same caliber
		to_chat(user, span_alert("[bluuet] doesn't fit in [src].")) //tell the user the casing does not fit
		return //return
	load_loop.start()
	to_chat(user, span_notice("You begin loading [bluuet] into [src].")) //tell the user the gun is being loaded
	if(!do_after(user, load_time, TRUE, src, allow_movement = TRUE)) //do after for loading the gun
		load_loop.stop()
		to_chat(user, span_alert("You were interrupted!")) //tell the user they stopped loading the gun
		return //return
	load_loop.stop()
	if(!user.transferItemToLoc(bluuet, src)) //if the user cannot transfer the item to the location of the gun
		to_chat(user, span_alert("You can't seem to load [bluuet] into [src].")) //tell the user the gun cannot be loaded
		return //return
	chambered = bluuet //set the chambered variable to the ammo casing being loaded
	to_chat(user, span_notice("You load [bluuet] into [src].")) //tell the user the gun is loaded
	playsound(get_turf(src), 'sound/weapons/stuff_casing_end.ogg', 80, TRUE)
	update_icon()
	return TRUE

/// Ejects chambered into the user's hands, and sets chambered to null, and sets cocked to FALSE, and plays a ka-ta-click noise, and updates the icon, and returns TRUE
/obj/item/gun/flintlock/proc/unload(mob/living/user)
	if(!user)
		return
	if(!chambered)
		to_chat(user, span_alert("[src] is not loaded!"))
		return
	chambered = null
	cocked = FALSE
	playsound(get_turf(src), 'sound/weapons/stuff_casing.ogg', 80, TRUE)
	playsound(get_turf(src), 'sound/weapons/hammer_click2.ogg', 90, 1)
	to_chat(user, span_notice("You unload [src]."))
	update_icon()
	if(!user.put_in_hands(chambered))
		chambered.forceMove(get_turf(src))
		return
	return TRUE

/// Sets cocked to TRUE, and plays a ka-ta-click noise
/obj/item/gun/flintlock/proc/cock(mob/living/user)
	if(!user)
		return FALSE
	if(cocked)
		uncock(user)
		return
	cocked = TRUE
	playsound(get_turf(src), 'sound/weapons/hammer_cock.ogg', 80, TRUE)
	user.visible_message(span_alert("[user] pulls back [src]'s hammer!"))
	update_icon()

/// Sets cocked to FALSE, and plays a ka-ta-click noise
/obj/item/gun/flintlock/proc/uncock(mob/living/user)
	if(!user)
		return FALSE
	if(!cocked)
		cock(user)
		return
	cocked = FALSE
	playsound(get_turf(src), 'sound/weapons/hammer_click2.ogg', 90, 1)
	user.visible_message(span_notice("[user] gently releases [src]'s hammer back down."))
	update_icon()

/// Plays a click-sound, then a half-second later, shoots whatever's under the user's cursor. or the mob's direction if the cursor's params are null
/obj/item/gun/flintlock/pre_fire(mob/user, atom/target, params, zone_override, message = TRUE)
	if(!user?.client)
		return FALSE
	if(!cocked)
		to_chat(user, span_alert("[src] isn't cocked!"))
		playsound(get_turf(src), 'sound/weapons/tap.ogg', 90, 1)
		return TRUE
	playsound(get_turf(src), 'sound/weapons/hammer_click.ogg', 90, 1)
	playsound(get_turf(src), 'sound/weapons/strike_sizzle.ogg', 45, 1)
	firing = TRUE
	var/shoot_delay = round(max(gaussian(prefire_time, prefire_time * prefire_randomness), prefire_time * 0.75), 0.1)
	fuse_loop.start()
	addtimer(CALLBACK(src,PROC_REF(fire_at_cursor), user), shoot_delay)
	update_icon()
	return TRUE

/// shoots whatever's under the user's cursor. or the user's direction if the cursor's params are null
/obj/item/gun/flintlock/proc/fire_at_cursor(mob/user)
	firing = FALSE // the gun's firing btw
	cocked = FALSE
	fuse_loop.stop()
	if(!chambered || !chambered.BB)
		shoot_with_empty_chamber(user)
		return FALSE
	var/atom/tar_get = user?.client?.mouseObject
	if(istype(tar_get, /atom/movable/screen)) // we clicked the ~void~, and now we need to do math
		tar_get = null
		if(user?.client)
			var/angel = mouse_angle_from_client(user.client)
			var/turf/shootat = get_turf_in_angle(angel, get_turf(src), 20) // sure
			if(shootat)
				tar_get = shootat
	/// this is if they disconnect, or tossed the gun before it fired, or ceased to exist, or something
	if(!tar_get || !user || loc != user)
		tar_get = null
		if(prob(50) || (user && HAS_TRAIT(user, TRAIT_NICE_SHOT))) // pick someone or something to shoot
			var/list/luckyboiz = list()
			for(var/mob/living/luckyboi in view(get_turf(src), 20))
				luckyboiz += luckyboi
			if(LAZYLEN(luckyboiz))
				tar_get = pick(luckyboiz)
		else // if there's nothing to shoot, pick a random direction
			tar_get = get_step(user, pick(GLOB.alldirs))
		user = null // to prevent factionization, and let it shoot yourself (in the foot)
	user?.face_atom(tar_get)
	do_fire(tar_get, user, TRUE, user?.client?.mouseParams)
	SSeffects.do_effect(EFFECT_SMOKE_CONE, get_turf(src), get_turf(tar_get))
	chambered = null // the caseless casing thing deletes itself
	update_icon()
	if(!user) // on the ground, so toss it around
		var/shootdir = turn(get_dir(get_turf(src), get_turf(tar_get)), 180)
		var/turf/toss_thisways = get_step(get_turf(src), shootdir)
		if(prob(50)) // throw a bit further
			toss_thisways = get_step(toss_thisways, shootdir)
		throw_at(toss_thisways, 4, 1, null, TRUE, TRUE)
