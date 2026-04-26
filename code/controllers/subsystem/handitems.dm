SUBSYSTEM_DEF(handitems)
	name = "HandItems"
	flags = SS_BACKGROUND|SS_NO_INIT
	wait = 1 SECONDS

	/// our loaded hand items, keyed cutely
	/// list("key" = /instantiated/hand/item)
	var/list/hand_items = list()
	var/list/gropekissers = list()

/datum/controller/subsystem/handitems/Initialize(start_timeofday)
	generate_hand_items()
	generate_grope_kissers()
	. = ..()
	to_chat(world, span_abductor("Initialized [LAZYLEN(hand_items)] hand items!"))

/// Generate our hand items, and store them in our list for later use
/datum/controller/subsystem/handitems/proc/generate_hand_items()
	if(LAZYLEN(hand_items))
		QDEL_LIST_ASSOC_VAL(hand_items)

/datum/controller/subsystem/handitems/proc/generate_grope_kissers()
	if(!LAZYLEN(gropekissers))
		for(var/booby in typesof(/datum/grope_kiss_MERP))
			var/datum/grope_kiss_MERP/gkm = new booby()
			gropekissers[gkm.type] = gkm







/// / / / / / / ///
/// HAND ITEMS! ///
/// For all of the items that are really just the user's hand used in different ways, mostly (all, really) from emotes
/obj/item/hand_item
	name = "your hand"
	desc = "Gimme five (or however many fingers you have, if you have any)!"
	force = 0
	throwforce = 0
	item_flags = DROPDEL | HAND_ITEM
	resistance_flags = FIRE_PROOF | ACID_PROOF
	rad_flags = RAD_NO_CONTAMINATE
	slot_flags = INV_SLOTBIT_DENYPOCKET
	block_parry_data = /datum/block_parry_data/bokken //release the butt parries
	var/inventoryable = FALSE

/obj/item/hand_item/Initialize(mapload)
	. = ..()
	if(!inventoryable) // cant stuff your butt in your backpack... i guess?
		ADD_TRAIT(src, TRAIT_NO_STORAGE_INSERT, TRAIT_GENERIC)

/// Tactile hand item, for all your tactile needs
/// It can be used for things like licking, groping, kissing, and... healing!
/// middleclick to make it horny
/obj/item/hand_item/tactile
	var/obj/item/stack/medical/healthing
	/// are we licking something?
	var/needed_trait_to_heal = TRAIT_HEAL_TONGUE
	var/tend_word = "licking"
	var/action_verb = "lick"
	var/action_verb_s = "licks"
	var/action_verb_ing = "licking"
	var/datum/grope_kiss_MERP/grope
	var/list/lastgrope
	var/horny_mode = FALSE
	var/medical_mode = FALSE

/obj/item/hand_item/tactile/Initialize(mapload)
	. = ..()
	spawn_healthing()
	if(is_licker)
		RegisterSignal(src, COMSIG_LICK_RETURN,PROC_REF(perform_tactile_action))

/obj/item/hand_item/tactile/proc/spawn_healthing()
	if(healthing)
		healthing = new /obj/item/stack/medical/healthing(src)

/obj/item/hand_item/tactile/MiddleClick(user)
	if(horny_mode)
		horny_mode = FALSE
		to_chat(user, span_love("Horny gropekiss mode deactivated."))
	else
		horny_mode = TRUE
		to_chat(user, span_love("Horny gropekiss mode activated!"))
	return COMSIG_MOB_CANCEL_CLICKON

/obj/item/hand_item/tactile/AltClick(mob/user)
	. = ..()
	if(!HAS_TRAIT(user, needed_trait_to_heal))
		medical_mode = FALSE
		to_chat(user, span_alert("You lack the ability to use this thing!"))
		return FALSE
	if(medical_mode)
		medical_mode = FALSE
		to_chat(user, span_notice("Medical mode deactivated."))
	else
		medical_mode = TRUE
		to_chat(user, span_notice("Medical mode activated!"))
	return COMSIG_MOB_CANCEL_CLICKON

/// / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / ///
/// Forces this thing to do its tactile action instead of bapping ///
/obj/item/hand_item/tactile/attack(mob/living/L, mob/living/carbon/user)
	return handle_hand_item_use(src, user, L)

/obj/item/hand_item/tactile/attack_obj(obj/O, mob/living/user)
	return handle_hand_item_use(src, user, O)

/obj/item/hand_item/tactile/attack_obj_nohit(obj/O, mob/living/user)
	return handle_hand_item_use(src, user, O)

/obj/item/hand_item/tactile/proc/handle_hand_item_use(atom/source, mob/living/user, atom/licked)
	if(!isliving(user))
		return FALSE
	if(working)
		to_chat(user, span_alert("You're already [tend_word] something!"))
		return FALSE
	if(!licked)
		return FALSE
	if(horny_mode)
		if(medical_mode)
			perform_medical_action(user, licked)
		if(perform_horny_action(user, licked))
			return TRUE
	if(medical_mode)
		if(perform_medical_action(user, licked))
			return TRUE
	return perform_tactile_action(user, licked)

/obj/item/hand_item/tactile/proc/perform_medical_action(mob/living/user, mob/living/target)
	if(!isliving(user) || !isliving(target))
		return
	var/mob/living/mlemmed = target
	if(iscarbon(mlemmed) && !mlemmed.get_bodypart(user.zone_selected))
		return FALSE
	if(!istype(healthing))
		healthing = new healthing(src)
	if(!istype(healthing))
		return FALSE
	if(!healthing.try_heal(mlemmed, user, TRUE))
		return FALSE
	healthing.attack(mlemmed, user)
	return TRUE

/obj/item/hand_item/tactile/proc/perform_horny_action(mob/living/user, mob/living/target)

/obj/item/hand_item/tactile/proc/perform_tactile_action(mob/living/user, atom/target)
	do_message(user, target)
	do_sounds(user, target)
	return TRUE

/obj/item/hand_item/tactile/proc/do_message(mob/living/user, atom/target)

/obj/item/hand_item/tactile/proc/do_sounds(mob/living/user, atom/target)
	var/list/sounds2play = list()
	// sounds2play += hitsound
	sounds2play += pokesound
	playsound(target, safepick(sounds2play), 85, TRUE)


/obj/item/hand_item/tactile/licker/perform_tactile_action(mob/living/user, atom/target)
	/// give other things a chance to handle being licked, and if they did, stop here cus they do it
	var/lick_ret = SEND_SIGNAL(licked, COMSIG_LICK_RETURN, user, target)
	if(lick_ret)
		return lick_ret
	. = ..()
	taste_if_possible(user, target)

/obj/item/hand_item/tactile/licker/do_message(mob/living/user, atom/licked)
	var/list/lick_words = get_lick_words(user)
	var/l_intent = lick_words[LICK_INTENT]
	var/l_location = lick_words[LICK_LOCATION]
	var/a_verb = action_verb
	var/a_verb_s = action_verb_s
	var/a_verb_ing = action_verb_ing
	var/subj_third
	var/subj_second
	var/subj_self
	if(isliving(licked))
		if(user == licked)
			subj_third = "[user.their()]"
			subj_second = "your"
			subj_self = "yourself"
		else
			subj_third = "[licked]'s"
			subj_second = "[licked]'s"
			subj_self = "[licked]"
		visible_message(
			user,
			span_notice("[user] [lick_words[LICK_INTENT]] [action_verb_s] [user == licked ? "[user.p_their()]" : "[lick"] [lick_words[LICK_LOCATION]]."),
			span_notice("You [lick_words[LICK_INTENT]] [action_verb] [user == licked ? "your" : "[licked]'s"] [lick_[LICK_LOCATION]]."),
			span_notice("You hear [action_verb_ing]."),
			LICK_SOUND_TEXT_RANGE
		)
	else
		if(user == licked)
			subj_third = "[user.they()]self"
			subj_second = "yourself"
			subj_self = "yourself"
		else
			subj_third = "[licked]"
			subj_second = "[licked]"
			subj_self = "[licked]"
	if(isliving(licked))
user,
			span_notice("[user] [lick_words[LICK_INTENT]] [action_verb_s] [user == licked ? "[user.p_them()]self" : "[licked]"]."),
			span_notice("You [lick_words[LICK_INTENT]] [action_verb] [user == licked ? "yourself" : "[licked]"]."),
			span_notice("You hear [action_verb_ing]."),
			LICK_SOUND_TEXT_RANGE
		)
ng(licked))
	elseactile/proc/get_lick_words(mob/living/user)
	if(!user)
		return

	. = list(LICK_LOCATION = "spot", LICK_INTENT = "like a dork") //👀 Dan I swear to god.
	switch(user.zone_selected)
		if(BODY_ZONE_CHEST)
			.[LICK_LOCATION] = "chest"
		if(BODY_ZONE_HEAD)
			.[LICK_LOCATION] = "face"
		if(BODY_ZONE_L_ARM)
			.[LICK_LOCATION] = "left arm"
		if(BODY_ZONE_R_ARM)
			.[LICK_LOCATION] = "right arm"
		if(BODY_ZONE_L_LEG)
			.[LICK_LOCATION] = "left leg"
		if(BODY_ZONE_R_LEG)
			.[LICK_LOCATION] = "right leg"
		if(BODY_ZONE_PRECISE_EYES)
			.[LICK_LOCATION] = "eyes"
		if(BODY_ZONE_PRECISE_MOUTH)
			.[LICK_LOCATION] = "lips"
		if(BODY_ZONE_PRECISE_GROIN)
			.[LICK_LOCATION] = "butt"
		if(BODY_ZONE_PRECISE_L_HAND)
			.[LICK_LOCATION] = "left hand"
		if(BODY_ZONE_PRECISE_R_HAND)
			.[LICK_LOCATION] = "right hand"
		if(BODY_ZONE_PRECISE_L_FOOT)
			.[LICK_LOCATION] = "left foot"
		if(BODY_ZONE_PRECISE_R_FOOT)
			.[LICK_LOCATION] = "right foot"
	switch(user.a_intent)
		if(INTENT_HELP)
			.[LICK_INTENT] = "gently"
		if(INTENT_DISARM)
			.[LICK_INTENT] = "briskly"
		if(INTENT_GRAB)
			.[LICK_INTENT] = "aggressively"
		if(INTENT_HARM)
			.[LICK_INTENT] = "very aggressively"


/obj/item/hand_item/tactile/proc/taste_if_possible(mob/living/user, atom/licked)
	if(!iscarbon(user))
		return
	lick_flavor(atom_licked = licked, licker = user)

/obj/item/hand_item/tactile/proc/lick_flavor(atom/source, atom/atom_licked, mob/living/licker)
	if(!atom_licked)
		return
	if(!licker)
		var/mob/living/maybe_licker = loc
		if(!isliving(maybe_licker))
			return
		licker = maybe_licker
	if(iscarbon(licker))
		var/mob/living/carbon/C = licker
		C.taste(null, atom_licked)
	playsound(get_turf(src), pokesound, 25, 1, SOUND_DISTANCE(LICK_SOUND_TEXT_RANGE))




