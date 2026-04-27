#define LICK_LOCATION "lick_location"
#define LICK_INTENT "lick_intent"
#define LICK_CANCEL "dont_lick"
/// Sounds and text for licking have this range
#define LICK_SOUND_TEXT_RANGE 2

SUBSYSTEM_DEF(handitems)
	name = "HandItems"
	flags = SS_NO_FIRE

	/// our loaded hand items, keyed cutely
	/// list(/path/to/hand/item = /instantiated/hand/item)
	var/list/hand_items = list()
	var/list/gropekissers = list()

/datum/controller/subsystem/handitems/Initialize(start_timeofday)
	generate_hand_items()
	generate_grope_kissers()
	. = ..()
	to_chat(world, span_abductor("Initialized [LAZYLEN(hand_items)] hand items and [LAZYLEN(gropekissers)] ways to fondle!"))

/// Generate our hand items, and store them in our list for later use
/datum/controller/subsystem/handitems/proc/generate_hand_items()
	if(LAZYLEN(hand_items))
		QDEL_LIST_ASSOC_VAL(hand_items)
	for(var/gooby in typesof(/obj/item/hand_item))
		var/obj/item/hand_item/hi = new gooby(null, TRUE)
		hand_items[hi.type] = hi

/datum/controller/subsystem/handitems/proc/generate_grope_kissers()
	if(LAZYLEN(gropekissers))
		QDEL_LIST_ASSOC_VAL(gropekissers)
	for(var/booby in typesof(/datum/grope_kiss_MERP))
		var/datum/grope_kiss_MERP/gkm = new booby()
		gropekissers[gkm.type] = gkm

/datum/controller/subsystem/handitems/proc/grope_kiss(obj/item/hand_item/tactile/hitem, mob/living/user, mob/living/target)
	if(!istype(hitem))
		return FALSE
	if(!hitem.horny_mode)
		return FALSE
	if(!LAZYLEN(gropekissers))
		return FALSE
	var/datum/grope_kiss_MERP/grope = LAZYACCESS(gropekissers, hitem.type)
	if(!grope)
		return FALSE
	var/list/used_grope = gunkem.make_visible_message(doer, target, hitem.lastgrope)
	if(used_grope)
		hitem.lastgrope = used_grope
		return TRUE

/datum/controller/subsystem/handitems/proc/give_hand_item(mob/living/user, obj/item/hand_item/hitem)
	if(!istype(user))
		return FALSE
	if(!ispath(hitem))
		to_chat(user, span_phobia("[hitem] is not a valid path to a hand item! Call 1-800-IM-CODER and tell them error code BIG-STRONG-ALPHA-THRUMBO"))
		stack_trace("Invalid hand item path given to give_hand_item: [hitem]")
		return FALSE
	var/obj/item/hand_item/hi_temp = get_hand_item_template(hitem)
	if(!hi_temp)
		to_chat(user, span_phobia("No template found for [hitem]! Call 1-800-IM-CODER and tell them error code WILD-SLEEPY-BOOMRAT"))
		stack_trace("No template found for [hitem] in give_hand_item: [hitem]")
		return FALSE
	if(hi_temp.just_one)
		if(user_already_has_one_of_these(user, hi_temp))
			to_chat(user, span_alert("You already have your [hi_temp.name] ready!"))
			return FALSE
	if(hi_temp.user_trait_can_spawn_associated_item)
		hi_temp = get_associated_item_for_user_trait(user, hi_temp)
	if(!istype(hi_temp))
		to_chat(user, span_phobia("[hitem] is no longer a valid template! Call 1-800-IM-CODER and tell them error code CHUNKY-FERIAN-SWELLGLOW"))
		stack_trace("No valid template found for [hitem] after checking user traits in give_hand_item: [hitem]. Check that the hand item template is set up correctly and that the user's traits are valid.")
		return FALSE




/datum/controller/subsystem/handitems/proc/get_hand_item_template(path)
	if(!ispath(path))
		to_chat(world, span_phobia("[path] is not a valid path to a hand item! Call 1-800-IM-CODER and tell them error code BIG-STRONG-ALPHA-THRUMBO"))
		stack_trace("Invalid hand item path given to get_hand_item_template: [path]")
		return null
	var/obj/item/hand_item/hi_temp = LAZYACCESS(hand_items, path)
	if(!hi_temp)
		to_chat(world, span_phobia("No template found for [path]! Call 1-800-IM-CODER and tell them error code WILD-SLEEPY-BOOMRAT"))
		stack_trace("No template found for [path] in get_hand_item_template: [path]")
		return null
	return hi_temp

/datum/controller/subsystem/handitems/proc/user_already_has_one_of_these(mob/living/user, obj/item/hand_item/hi_temp)
	if(!istype(user) || !istype(hi_temp))
		CRASH("Invalid arguments given to user_already_has_one_of_these: [user], [hi_temp]")
		return FALSE
	var/loose_pathing = ispath(hi_temp.base_path)
	for(var/atom/movable/AM as anything in (get_nested_locs(user) + user))
		if(loose_pathing)
			if(ispath(AM.type, hi_temp.base_path))
				return TRUE
		else
			if(AM.type == hi_temp.type)
				return TRUE

/datum/controller/subsystem/handitems/proc/get_associated_item_for_user_trait(mob/living/user, obj/item/hand_item/hi_temp)
	. = hi_temp
	if(!istype(user) || !istype(hi_temp))
		stack_trace("Invalid arguments given to get_associated_item_for_user_trait: [user], [hi_temp]")
		return
	if(!ispath(hi_temp.base_path))
		stack_trace("Invalid hand item template given to get_associated_item_for_user_trait: [hi_temp]. Base path must be set and be a valid path! Check the hand item definition for [hi_temp]")
		return
	var/trait = hi_temp.associated_trait
	if(!trait)
		stack_trace("Hand item [hi_temp] is set to spawn an associated item based on a user trait, but has no associated trait set! Check the hand item definition for [hi_temp]")
		return
	/// list of items to check through
	var/list/candidates = list()
	for(var/hi_pat in typesof(hi_temp.base_path))
		candidates |= LAZYACCESS(hand_items, hi_pat)
	if(!LAZYLEN(candidates))
		stack_trace("Hand item [hi_temp] is set to spawn an associated item based on a user trait, but no candidates were found! Check that there are hand items with a base path of [hi_temp.base_path] in the hand item definitions.")
		return
	for(var/obj/item/hand_item/hi_cand in candidates)
		if(HAS_TRAIT(user, hi_cand.associated_trait))
			return hi_cand

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
	/// if set, if you have a certain trait, it'll search the child objects for that trait and spawn that
	var/user_trait_can_spawn_associated_item
	var/associated_trait
	var/inventoryable = FALSE
	var/just_one = FALSE // if you should only have one at a time, so you cant dual wield your own butt
	var/base_path // set this to the parent object you want to check for to be the thing to have just one of
	var/template = FALSE

/obj/item/hand_item/Initialize(mapload, is_template)
	if(is_template)
		item_flags = NONE
		resistance_flags |= INDESTRUCTIBLE
		template = TRUE
	. = ..()
	if(!inventoryable) // cant stuff your butt in your backpack... i guess?
		ADD_TRAIT(src, TRAIT_NO_STORAGE_INSERT, TRAIT_GENERIC)

/// Tactile hand item, for all your tactile needs
/// It can be used for things like licking, groping, kissing, and... healing!
/// middleclick to make it horny
/obj/item/hand_item/tactile
	var/obj/item/stack/medical/healthing
	var/required_organ_slot
	/// are we licking something?
	var/needed_trait_to_heal
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
	RegisterSignal(src, COMSIG_LICK_RETURN,PROC_REF(perform_tactile_action))

/obj/item/hand_item/tactile/proc/spawn_healthing()
	if(healthing)
		healthing = new /obj/item/stack/medical/healthing(src)

/obj/item/hand_item/tactile/MiddleClick(user)
	if(!grope)
		to_chat(user, span_alert("Your [src] can't exactly be used for horny purposes! (at least not *this* way!)"))
		horny_mode = FALSE
		return COMSIG_MOB_CANCEL_CLICKON
	if(horny_mode)
		horny_mode = FALSE
		to_chat(user, span_love("Your [src]'s horny mode deactivated."))
	else
		horny_mode = TRUE
		to_chat(user, span_love("Your [src]'s horny mode activated!"))
		to_chat(user, span_love("Be sure to consider their preferences and consent!"))
	return COMSIG_MOB_CANCEL_CLICKON

/obj/item/hand_item/tactile/AltClick(mob/user)
	. = ..()
	if(!healthing)
		to_chat(user, span_alert("Your [src] can't exactly be used to heal anything! (At least not medically!)"))
		medical_mode = FALSE
		return COMSIG_MOB_CANCEL_CLICKON
	if(!HAS_TRAIT(user, needed_trait_to_heal))
		to_chat(user, span_alert("You lack the ability to heal anything with your [src]!"))
		medical_mode = FALSE
		return FALSE
	if(medical_mode)
		medical_mode = FALSE
		to_chat(user, span_notice("Your [src]'s medical mode deactivated."))
	else
		medical_mode = TRUE
		to_chat(user, span_notice("Your [src]'s medical mode activated!"))
	return COMSIG_MOB_CANCEL_CLICKON

/// / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / ///
/// Forces this thing to do its tactile action instead of bapping ///
/obj/item/hand_item/tactile/attack(mob/living/L, mob/living/carbon/user)
	INVOKE_ASYNC(PROC(handle_hand_item_use), src, user, L)

/obj/item/hand_item/tactile/attack_obj(obj/O, mob/living/user)
	INVOKE_ASYNC(PROC(handle_hand_item_use), src, user, O)

/obj/item/hand_item/tactile/attack_obj_nohit(obj/O, mob/living/user)
	INVOKE_ASYNC(PROC(handle_hand_item_use), src, user, O)

/// / / / / / / / / / / / / / / / / / / / / / / / / / / / / ///
/// Common hand item use handler for tactile touchy things  ///
/obj/item/hand_item/tactile/proc/handle_hand_item_use(atom/source, mob/living/user, atom/licked)
	if(!isliving(user))
		return FALSE
	if(required_organ_slot && iscarbon(user))
		var/mob/living/carbon/C = user
		if(!C.getorganslot(required_organ_slot))
			to_chat(user, span_alert("WHOA, you dont have the right body part to use this! How did you even get this??"))
			qdel(src)
			return FALSE
	if(working)
		to_chat(user, span_alert("You're already [action_verb_ing] something!"))
		return FALSE
	if(!licked)
		return FALSE
	if(horny_mode)
		if(perform_horny_action(user, licked))
			if(!medical_mode)
				return TRUE
	if(medical_mode)
		if(perform_medical_action(user, licked))
			return TRUE
	return perform_tactile_action(user, licked)

/obj/item/hand_item/tactile/proc/perform_medical_action(mob/living/user, mob/living/target)
	if(!healthing)
		medical_mode = FALSE
		return FALSE
	if(!isliving(user) || !isliving(target))
		return
	var/mob/living/mlemmed = target
	if(iscarbon(mlemmed) && !mlemmed.get_bodypart(user.zone_selected))
		return FALSE
	if(!istype(healthing))
		healthing = new healthing(src)
		if(!istype(healthing))
			return FALSE
	if(!healthing.try_heal(mlemmed, user))
		return FALSE
	return TRUE

/obj/item/hand_item/tactile/proc/perform_horny_action(mob/living/user, mob/living/target)
	return SShanditems.grope_kiss(src, user, target)

/obj/item/hand_item/tactile/proc/perform_tactile_action(mob/living/user, atom/target)
	do_message(user, target)
	do_sounds(user, target)
	return TRUE

// non-horny, non-medical tactile action message 
/obj/item/hand_item/tactile/proc/do_message(mob/living/user, atom/target)
	visible_message(
		user,
		"[user] [action_verb_s] [target].",
		"You [action_verb] [target].",
		"You hear [action_verb_ing].",
		TEXT_RANGE
	)

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
	var/line_others
	var/line_self
	var/line_heard
	var/subj_third
	var/subj_second
	if(user == licked)
		subj_third = "[user.their()]"
		subj_second = "your"
	else
		subj_third = "[licked]'s"
		subj_second = "[licked]'s"
	line_others = "[user] [lick_words[LICK_INTENT]] [action_verb_s] [subj_third] [lick_words[LICK_LOCATION]]."
	line_self = "You [lick_words[LICK_INTENT]] [action_verb] [subj_second] [lick_words[LICK_LOCATION]]."
	line_heard = "You hear [action_verb_ing]."
	visible_message(
		user,
		line_others,
		line_self,
		line_heard,
		LICK_SOUND_TEXT_RANGE
	)

/obj/item/hand_item/tactile/proc/get_lick_words(mob/living/user)
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

/obj/item/hand_item/tactile/proc/taste_if_possible(mob/living/user, atom/target)
	if(!iscarbon(user))
		return
	var/mob/living/carbon/C = user
	C.taste(null, target)

/// / / / / ///
/// LICKER  ///
/// Course our first hand item would be a tongue
/obj/item/hand_item/tactile/licker
	name = "tongue"
	desc = "Mlem."
	icon = 'icons/obj/surgery.dmi'
	icon_state = "tonguenormal"
	attack_verb = list("licked", "lapped", "mlemmed")
	pokesound = 'sound/effects/lick.ogg'
	siemens_coefficient = 5 // hewwo mistow ewectwic fence mlem mlem
	healthing = /obj/item/stack/medical/bruise_pack/lick
	needed_trait_to_heal = TRAIT_HEAL_TONGUE
	tend_word = "licking"
	action_verb = "lick"
	action_verb_s = "licks"
	action_verb_ing = "licking"
	can_taste = FALSE
	grope = /datum/grope_kiss_MERP/lick

/obj/item/hand_item/tactile/triage //chimken
	name = "triage kit"
	desc = "A small collection of vital medical supplies."
	icon = 'icons/fallout/objects/medicine/drugs.dmi'
	icon_state = "traumapack"
	attack_verb = list("tended", "treated", "healed")
	pokesound = 'sound/items/tendingwounds.ogg'
	healthing = /obj/item/stack/medical/bruise_pack/lick/tend
	needed_trait_to_heal = TRAIT_HEAL_TEND
	tend_word = "tending"
	action_verb = "tend"
	action_verb_s = "tends"
	action_verb_ing = "tending"
	can_taste = FALSE

/obj/item/hand_item/tactile/toucher //being repurposed as a way to 'feel' the world around the player.  Specifically other players though, lets be real.
	name = "touch"
	desc = "A finger, for touching things."
	icon = 'icons/obj/in_hands.dmi'
	icon_state = "feeder"
	attack_verb = list("touched", "poked", "prodded")
	pokesound = 'sound/items/tendingwounds.ogg'
	healthing = /obj/item/stack/medical/bruise_pack/lick/touch
	needed_trait_to_heal = TRAIT_HEAL_TOUCH
	tend_word = "touching"
	action_verb = "touch"
	action_verb_s = "touches"
	action_verb_ing = "touching"
	grope = /datum/grope_kiss_MERP
	can_taste = FALSE

/obj/item/hand_item/tactile/kisser
	name = "kisser"
	desc = "A kisser, for smooching things."
	icon = 'icons/obj/in_hands.dmi'
	icon_state = "kisser"
	attack_verb = list("kissed", "smooched", "snogged")
	pokesound = list(
		'sound/effects/kiss.ogg',
		'modular_splurt/sound/interactions/kiss/kiss1.ogg',
		'modular_splurt/sound/interactions/kiss/kiss2.ogg',
		'modular_splurt/sound/interactions/kiss/kiss3.ogg',
		'modular_splurt/sound/interactions/kiss/kiss4.ogg',
	)
	healthing = /obj/item/stack/medical/bruise_pack/lick/touch
	needed_trait_to_heal = TRAIT_HEAL_TOUCH
	tend_word = "smooching"
	action_verb = "kiss"
	action_verb_s = "kisses"
	action_verb_ing = "kissing"
	can_taste = FALSE
	grope = /datum/grope_kiss_MERP/kiss

/// / / / / / / / / / / / / / / / / / / / / / / / / / / ///
/// hand items used primarily as a way to attack things ///
/// generally for things you whack other things with    ///
/obj/item/hand_item/weapon
	name = "attack thing"
	desc = "Use it to attack things, probably. May or may not be part of your body."
	force = 15
	w_class = WEIGHT_CLASS_TINY
	flags_1 = CONDUCT_1
	slot_flags = INV_SLOTBIT_GLOVES
	backstab_multiplier = 1.8
	throwforce = 0
	wound_bonus = 4
	sharpness = SHARP_POINTY
	attack_speed = CLICK_CD_MELEE
	item_flags = PERSONAL_ITEM | ABSTRACT | HAND_ITEM
	weapon_special_component = /datum/component/weapon_special/single_turf
	block_parry_data = /datum/block_parry_data/bokken
	var/extra_force_as_glove = 0
	var/extra_damage = 0
	var/extra_damage_type = STAMINA
	var/can_knockback = FALSE
	var/spin_attack = FALSE
	var/use_bodypart_image_slot
	var/list/bodypart_images

/obj/item/hand_item/weapon/ComponentInitialize()
	. = ..()
	if(can_knockback)
		AddComponent(/datum/component/knockback, 1, FALSE, TRUE)

/obj/item/hand_item/weapon/afterattack(mob/living/M, mob/living/user)
	. = ..()
	if(spin_attack)
		user.spin(4, 1) // SPEEN

/obj/item/hand_item/weapon/equipped(mob/user, slot)
	. = ..()
	var/mob/living/carbon/human/H = user
	if(ishuman(user) && slot == SLOT_GLOVES)
		ADD_TRAIT(user, TRAIT_UNARMED_WEAPON, "glove")
		if(HAS_TRAIT(user, TRAIT_UNARMED_WEAPON))
			H.dna.species.punchdamagehigh += force + extra_force_as_glove //Work around for turbo bad code here. Makes this correctly stack with your base damage. No longer makes ghouls the kings of melee.
			H.dna.species.punchdamagelow += force + extra_force_as_glove
			H.dna.species.attack_sound = hitsound
			if(sharpness == SHARP_POINTY || sharpness ==  SHARP_EDGED)
				H.dna.species.attack_verb = safepick(attack_verb) || "blapped"
	if(ishuman(user) && slot != SLOT_GLOVES && !H.gloves)
		REMOVE_TRAIT(user, TRAIT_UNARMED_WEAPON, "glove")
		if(!HAS_TRAIT(user, TRAIT_UNARMED_WEAPON)) //removing your funny trait shouldn't make your fists infinitely stack damage.
			H.dna.species.punchdamagehigh = 10
			H.dna.species.punchdamagelow = 1
		if(HAS_TRAIT(user, TRAIT_IRONFIST))
			H.dna.species.punchdamagehigh = 12
			H.dna.species.punchdamagelow = 6
		if(HAS_TRAIT(user, TRAIT_STEELFIST))
			H.dna.species.punchdamagehigh = 16
			H.dna.species.punchdamagelow = 10
		H.dna.species.attack_sound = initial(H.dna.species.attack_sound)
		H.dna.species.attack_verb = initial(H.dna.species.attack_verb)
	transmute_into_bodypart(user)

/obj/item/hand_item/weapon/pickup(mob/living/user)
	. = ..()
	transmute_into_bodypart(user)

/obj/item/hand_item/weapon/proc/transmute_into_bodypart(mob/user)
	if(!use_bodypart_image_slot)
		return
	if(!iscarbon(user))
		return
	var/datum/genital_images/mynt = SSpornhud.get_genital_datum(user)
	bodypart_images.Cut()
	if(mynt)
		switch(use_bodypart_image_slot)
			if(PHUD_TAIL)
				bodypart_images = mynt.tail.Copy()
			if(PHUD_BUTT)
				bodypart_images = mynt.butt.Copy()
	if(!LAZYLEN(bodypart_images))
		return // use default icon
	icon = "icons/effects/effects.dmi"
	icon = "nothing"
	overlays.Cut()
	for(var/whatever in bodypart_images)
		var/image/I = whatever
		I.dir = NORTH
		overlays += I

/obj/item/hand_item/weapon/attack(mob/living/M, mob/living/user)
	. = ..()
	if(!.)
		return
	if(!istype(M))
		return
	if(!extra_damage)
		return
	M.apply_damage(extra_damage, extra_damage_type, "chest", M.run_armor_check("chest", "melee"))

/// / / / / ///
/// BITERS  ///
/obj/item/hand_item/weapon/biter
	name = "Biter"
	desc = "Talk shit, get bit."
	icon = 'icons/obj/in_hands.dmi'
	icon_state = "biter"
	attack_verb = list("chomped", "gnawed", "bit", "crunched", "nommed")
	hitsound = "sound/weapons/bite.ogg"
	just_one = TRUE
	user_trait_can_spawn_associated_item = TRUE
	base_path = /obj/item/hand_item/weapon/biter

/obj/item/hand_item/weapon/biter/creature
	force = 35
	force_wielded = 45
	force_unwielded = 35

/obj/item/hand_item/weapon/biter/big
	name = "Big Biter"
	desc = "Talk shit, get BIG bit."
	color = "#884444"
	force = 40
	force_wielded = 50
	force_unwielded = 40
	attack_speed = CLICK_CD_MELEE
	associated_trait = TRAIT_BIGBITE

/obj/item/hand_item/weapon/biter/sabre
	name = "Sabre Toothed Biter"
	desc = "Damn bitch, you eat with them teeth?"
	color = "#FF4444"
	force = 45
	force_wielded = 55
	force_unwielded = 45
	attack_speed = CLICK_CD_MELEE * 1.2
	associated_trait = TRAIT_SABREBITE

/obj/item/hand_item/weapon/biter/fast
	name = "Fast Biter"
	desc = "Talk shit, get SPEED bit."
	color = "#448844"
	force = 25
	force_wielded = 30
	force_unwielded = 25
	attack_speed = CLICK_CD_MELEE * 0.5
	associated_trait = TRAIT_FASTBITE

/obj/item/hand_item/weapon/biter/play
	name = "Play Biter"
	desc = "Someone really should just muzzle you."
	color = "#ff44ff"
	force = 0
	force_wielded = 0
	force_unwielded = 0
	attack_speed = 1
	associated_trait = TRAIT_PLAYBITE

/obj/item/hand_item/weapon/biter/spicy
	name = "Spicy Biter"
	desc = "Your sickly little nibbler, good for dropping fools."
	color = "#44FF44"
	force = 35
	force_wielded = 45
	force_unwielded = 35
	extra_damage = 30
	extra_damage_type = STAMINA
	associated_trait = TRAIT_SPICYBITE

/// / / / ///
/// CLAWS ///
/obj/item/hand_item/weapon/clawer
	name = "Clawer"
	desc = "Thems some claws."
	icon = 'icons/obj/in_hands.dmi'
	icon_state = "clawer"
	slot_flags = INV_SLOTBIT_GLOVES
	w_class = WEIGHT_CLASS_TINY
	flags_1 = CONDUCT_1
	sharpness = SHARP_EDGED
	attack_verb = list("slashed", "sliced", "torn", "ripped", "diced", "cut")
	force = 30
	force_wielded = 40
	force_unwielded = 30
	sharpness = SHARP_EDGED
	item_flags = PERSONAL_ITEM | ABSTRACT | HAND_ITEM
	weapon_special_component = /datum/component/weapon_special/single_turf
	block_parry_data = /datum/block_parry_data/bokken
	user_trait_can_spawn_associated_item = TRUE

/obj/item/hand_item/weapon/clawer/creature
	force = 30
	force_wielded = 40
	force_unwielded = 30

/obj/item/hand_item/weapon/clawer/big
	name = "Big Clawer"
	desc = "Thems some BIG ASS claws."
	color = "#884444"
	force = 35
	force_wielded = 45
	force_unwielded = 35
	attack_speed = CLICK_CD_MELEE * 1.5
	associated_trait = TRAIT_BIGCLAW

/obj/item/hand_item/weapon/clawer/razor
	name = "Razor Sharp Clawers"
	desc = "RIP AND TEAR."
	color = "#FF4444"
	force = 40
	force_wielded = 50
	force_unwielded = 40
	attack_speed = CLICK_CD_MELEE * 1.2
	associated_trait = TRAIT_RAZORCLAW

/obj/item/hand_item/weapon/clawer/fast
	name = "Fast Clawer"
	desc = "Thems some FAST ASS claws."
	color = "#448844"
	force = 30
	force_wielded = 40
	force_unwielded = 30
	attack_speed = CLICK_CD_MELEE * 0.5
	associated_trait = TRAIT_FASTCLAW

/obj/item/hand_item/weapon/clawer/play
	name = "Play Clawer"
	desc = "Basically just a bean thwapper."
	color = "#FF88FF"
	force = 0
	force_wielded = 0
	force_unwielded = 0
	attack_speed = 1
	associated_trait = TRAIT_PLAYCLAW // you dont want to know how this claw plays

/obj/item/hand_item/weapon/clawer/spicy
	name = "Spicy Clawer"
	desc = "My gross little litter box rakes, good for puttings idiots on the ground."
	color = "#44FF44"
	force = 30
	force_wielded = 40
	force_unwielded = 30
	extra_damage = 30
	extra_damage_type = STAMINA
	associated_trait = TRAIT_SPICYCLAW

/// / / / / / / ///
/// ARM BLADES  ///
/obj/item/hand_item/weapon/arm_blade
	name = "arm blade"
	desc = "A grotesque blade made out of bone and flesh that cleaves through people as a hot knife through butter."
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "arm_blade"
	inhand_icon_state = "arm_blade"
	lefthand_file = 'icons/mob/inhands/antag/changeling_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/antag/changeling_righthand.dmi'
	w_class = WEIGHT_CLASS_HUGE
	force = 40
	force_wielded = 50
	force_unwielded = 40
	backstab_multiplier = 1.5
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")
	sharpness = SHARP_EDGED
	user_trait_can_spawn_associated_item = TRUE

/obj/item/hand_item/weapon/arm_blade/cyber
	name = "Cyber blade"
	desc = "A advanced cybernetic blade made out of numerous materials that cleaves through people as a hot knife through butter."
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "cyber_blade"
	inhand_icon_state = "cyber_blade"
	lefthand_file = 'icons/mob/inhands/antag/changeling_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/antag/changeling_righthand.dmi'
	associated_trait = TRAIT_CYBERKNIFE

/// / / / / ///
/// SHOVERS ///
/obj/item/hand_item/shover // i shove around the blind people
	name = "shover"
	desc = "Stay back!"
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "latexballon"
	inhand_icon_state = "nothing"
	attack_verb = list("shoved", "pushed")
	hitsound = "sound/weapons/thudswoosh.ogg"
	force = 0
	force_wielded = 0
	throwforce = 0
	wound_bonus = 0
	causes_knockback = TRUE

/// / / / ///
/// TAILS ///
/obj/item/hand_item/weapon/tail
	name = "tailwhack"
	desc = "A tail. Good for whacking."
	icon = 'icons/obj/surgery.dmi'
	icon_state = "severedtail"
	w_class = WEIGHT_CLASS_TINY
	force = 15
	backstab_multiplier = 1.8
	weapon_special_component = /datum/component/weapon_special/single_turf
	block_parry_data = /datum/block_parry_data/bokken
	can_knockback = TRUE
	spin_attack = TRUE
	use_bodypart_image_slot = PHUD_TAIL
	just_one = TRUE
	base_path = /obj/item/hand_item/weapon/tail
	user_trait_can_spawn_associated_item = TRUE

/obj/item/hand_item/weapon/tail/playful
	name = "playful tail"
	desc = "A playful tail, good for teasing."
	force = 0
	force_wielded = 0
	attack_speed = 3
	weapon_special_component = /datum/component/weapon_special/single_turf
	associated_trait = TRAIT_TAILPLAY // yeah im into tailplay, what of it?

/obj/item/hand_item/weapon/tail/fast
	name = "fast tail"
	desc = "A speedy tail that's very good at whackin' fast."
	color = "#448844"
	force = 18
	attack_speed = CLICK_CD_MELEE * 0.6
	associated_trait = TRAIT_TAILWHIP

/obj/item/hand_item/weapon/tail/big
	name = "big tail"
	desc = "A big tail that whacks hard."
	color = "#884444"
	force = 25
	associated_trait = TRAIT_TAILSMASH

/obj/item/hand_item/weapon/tail/spicy
	name = "spicy tail"
	desc = "A tail with something that can inject venom on it."
	color = "#44FF44"
	force = 15
	extra_damage = 30
	extra_damage_type = STAMINA
	associated_trait = TRAIT_TAILSPICY

/obj/item/hand_item/weapon/tail/thago
	name = "dangerous tail"
	desc = "A god damn mighty tail that would kill an allosaurus.  Maybe."
	color = "#FF4444"
	force = 40
	attack_speed = CLICK_CD_MELEE * 1.2
	associated_trait = TRAIT_TAILTHAGO

/// / / / ///
/// BEANS ///
/obj/item/hand_item/weapon/beans
	name = "beans"
	desc = "Them's ya' beans. Touch em' to things."
	icon = 'icons/obj/in_hands.dmi'
	icon_state = "bean"
	color = "#ff88bb"
	attack_verb = list()
	hitsound = "sound/effects/attackblob.ogg"
	force = 0
	force_wielded = 0
	throwforce = 0
	attack_speed = 0
	extra_damage = 1 // its mildly annoying!
	extra_damage_type = STAMINA

/obj/item/hand_item/weapon/beans/war
	name = "war beans"
	desc = "Them's ya' war beans. Touch em' to things you want dead."
	color = "#ff4444"
	force = 6
	force_wielded = 10
	backstab_multiplier = 3 //OBLITERATE THEM, BOYKISSER. ~TK

/// / / / ///
/// BUTT  ///
/obj/item/hand_item/weapon/butt
	name = "your butt"
	desc = "Very smoochable."
	icon = 'icons/ass/assfemale.png' // rofl
	attack_verb = list("smecked", "bwapped", "bumped", "clapped", "quapped", "vooped", "whomped")
	w_class = WEIGHT_CLASS_GIGANTIC // your butt is HUGE!!!!
	force = 15
	weapon_special_component = /datum/component/weapon_special/single_turf
	block_parry_data = /datum/block_parry_data/bokken
	use_bodypart_image_slot = PHUD_BUTT
	spin_attack = TRUE
	just_one = TRUE
	base_path = /obj/item/hand_item/weapon/butt

/obj/item/hand_item/weapon/butt/equipped(mob/user, slot)
	. = ..()
	buttify(user)

/obj/item/hand_item/weapon/butt/pickup(mob/living/user)
	. = ..()
	buttify(user)

/// modifies your butt's damage and attack speed based off its size
/// why yes this is in fact gameplay mechanics defined by ERP stuff
/obj/item/hand_item/weapon/butt/proc/buttify(mob/user)
	if(!iscarbon(user))
		return
	var/mob/living/carbon/human/H = user
	if(!H.has_butt())
		return
	var/obj/item/organ/genital/butt/B = H.getorganslot(ORGAN_SLOT_BUTT)
	force = 6 * B.size
	attack_speed = (CLICK_CD_MELEE / 3) * B.size
	switch(B.size)
		if(1 to 2)
			w_class = WEIGHT_CLASS_TINY
		if(3)
			w_class = WEIGHT_CLASS_SMALL
		if(4)
			w_class = WEIGHT_CLASS_NORMAL
		if(5)
			w_class = WEIGHT_CLASS_BULKY
		if(6 to 7)
			w_class = WEIGHT_CLASS_HUGE
		if(8 to INFINITY)
			w_class = WEIGHT_CLASS_GIGANTIC

////// old code in case the above doesnt work
// /obj/item/hand_item/butt/proc/buttify(mob/user)
// 	if(!iscarbon(user))
// 		return
// 	var/mob/living/carbon/human/H = user
// 	if(!H.has_butt())
// 		return
// 	icon = "icons/effects/effects.dmi"
// 	icon = "nothing"
// 	var/obj/item/organ/genital/butt/B = H.getorganslot(ORGAN_SLOT_BUTT)
// 	var/datum/sprite_accessory/sprite_acc = B.get_sprite_accessory()
// 	icon = 'icons/obj/genitals/butt_onmob.dmi'
// 	icon_state = B.get_icon_state(user, sprite_acc, FALSE, "FRONT")
// 	dir = NORTH
// 	var/datum/preferences/P = extract_prefs(user)
// 	color = "#[P.features["butt_color"]]"
// 	force = 6 * B.size
// 	attack_speed = (CLICK_CD_MELEE / 3) * B.size
// 	switch(B.size)
// 		if(1 to 2)
// 			w_class = WEIGHT_CLASS_TINY
// 		if(3)
// 			w_class = WEIGHT_CLASS_SMALL
// 		if(4)
// 			w_class = WEIGHT_CLASS_NORMAL
// 		if(5)
// 			w_class = WEIGHT_CLASS_BULKY
// 		if(6 to 7)
// 			w_class = WEIGHT_CLASS_HUGE
// 		if(8 to INFINITY)
// 			w_class = WEIGHT_CLASS_GIGANTIC

/// / / / / / / / / / / / / / / / / / / / / / / / / / ///
/// And a bunch of stuff we probably dont use anymore ///


/obj/item/hand_item/cantrip
	name = "Cantrip"
	desc = "it's magic yo."
	icon = 'icons/obj/in_hands.dmi'
	icon_state = "clawer"
	w_class = WEIGHT_CLASS_TINY
	attack_verb = list("slashed", "sliced", "torn", "ripped", "diced", "cut")
	force = 15
	backstab_multiplier = 1.8
	throwforce = 0
	wound_bonus = 4
	attack_speed = CLICK_CD_MELEE * 0.7
	item_flags = DROPDEL | HAND_ITEM
	weapon_special_component = /datum/component/weapon_special/single_turf


/obj/item/hand_item/cantrip/godhand
	icon_state = "disintegrate"
	inhand_icon_state = "disintegrate"
	icon = 'icons/obj/items_and_weapons.dmi'
	lefthand_file = 'icons/mob/inhands/items_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items_righthand.dmi'
	name = "Shocking Grasp"
	desc = "A basic cantrip that allows the caster to inflict nasty shocks on touch"
	item_flags = ABSTRACT | DROPDEL
	force = 30
	backstab_multiplier = 1.6
	hitsound = 'sound/weapons/sear.ogg'
	damtype = BURN
	attack_verb = list("seared", "zapped", "fried", "shocked")


/obj/item/hand_item/merp_doer
	name = "MERP doer"
	desc = "Click someone with this thing to open the MERP interactions menu! From there, you can do all sorts of lewd or not-so-lewd things with them (or yourself!!)!"
	icon = 'icons/obj/in_hands.dmi'
	icon_state = "blushfox"

/obj/item/hand_item/merp_doer/attack(mob/living/M, mob/living/user)
	SEND_SIGNAL(user, COMSIG_CLICK_CTRL_SHIFT, M)
	qdel(src)

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/obj/item/hand_item/subtle_catapult
	name = "discrete action delivery system"
	desc = "Do lewd things in public, without anyone (but whoever you're doing it to) knowing!"
	icon = 'icons/obj/in_hands.dmi'
	icon_state = "blushfox"
	item_flags = ABSTRACT | HAND_ITEM | NO_TURN
	max_reach = 70
	var/message
	var/aoe_range = 1

/obj/item/hand_item/subtle_catapult/examine(mob/user)
	. = ..()
	// . += span_green("AOE range: Your tile, plus [aoe_range] tiles in every direction.")
	. += span_green("Current message:")
	. += span_notice(message ? message : "None.")
	. += span_green("--")
	. += span_green("HOW 2 USE:")
	. += span_notice("1. Click it in hand to start writing a message.")
	. += span_notice("2. Click this on someone to send that message to them.")
	. += span_notice("3. Or CtrlShift click it to pick anyone in view")
	. += span_notice("You can also alt-click it to view your previous messages, and even select them to send!")
	. += span_notice("It will ask you to confirm before sending, so don't worry about accidentally sending something you didn't mean to!")
	. += span_notice("Also dont worry about dropping it or anything, it should still take whatever you wrote with it!")
	. += span_green("--")

/obj/item/hand_item/subtle_catapult/pre_attack(atom/A, mob/living/user, params, attackchain_flags, damage_multiplier)
	. = TRUE
	if(!extract_client(A))
		return
	if(message)
		StartSendMessage(user, A)
	else
		EditMessage(user, A)

/obj/item/hand_item/subtle_catapult/attack_self(mob/user)
	. = ..()
	EditMessage(user)

/obj/item/hand_item/subtle_catapult/AltClick(mob/user)
	. = ..()
	var/list/messages = SSchat.GetHornyHistory(user)
	if(!LAZYLEN(messages))
		to_chat(user, span_alert("You haven't made any messages yet!"))
		return
	var/selected = input(
		user, 
		"Here's a list of the messages you've made with this! Pick one to load it into this tool!", 
		"Select a message to send!", 
		message,
	) as null|anything in messages
	if(selected)
		message = selected
		to_chat(user, span_green("Message loaded!"))
	else
		to_chat(user, span_alert("Message selection cancelled!"))

/obj/item/hand_item/subtle_catapult/CtrlShiftClick(mob/user)
	. = ..()
	var/list/ppl = hearers(10, user)
	for(var/mob/M in ppl)
		if(!extract_client(M))
			ppl -= M
		if(!isliving(M))
			ppl -= M
		if(M == user)
			ppl -= M
	var/mob/whomst = input(
		user,
		"Who would you like to send a message to?",
		"Select a target!",
		null
	) as null|anything in ppl
	if(whomst)
		if(message)
			StartSendMessage(user, whomst)
		else
			EditMessage(user, whomst)
	else
		to_chat(user, span_alert("Message selection cancelled!"))

/obj/item/hand_item/subtle_catapult/dropped(mob/user)
	. = ..()
	SSchat.StashHornyThing(user)

/obj/item/hand_item/subtle_catapult/proc/EditMessage(mob/user, mob/living/M, and_send)
	var/head = M ? "Prepare a message for [M]!" : "Prepare a message!"
	var/msg = stripped_multiline_input_or_reflect(user, EMOTE_HEADER_TEXT, head, message, 99999)
	if(msg)
		to_chat(user, span_green("Message prepared:"))
		to_chat(user, span_notice(msg))
		to_chat(user, span_green("Click [M] to send it!"))
		message = msg
		SSchat.StoreHornyMessage(user, msg)
		if(M)
			StartSendMessage(user, M)
	else
		to_chat(user, span_alert("Message cancelled! Nothing's changed!!"))

/obj/item/hand_item/subtle_catapult/proc/StartSendMessage(mob/user, mob/living/M)
	if(!message)
		return
	if(!M || !user)
		return
	// if(M == user || !M.client)
	// 	return
	var/shomsg = message
	if(LAZYLEN(shomsg) > 700)
		shomsg = copytext(shomsg, 0, 700) + "..."
	// first we ask em, you sure you wanna do this?
	var/confirm = alert(user, "You are about to send this message to [M]:\n\n[message]\n\nAre you sure you want to do this?", "Send message?", "Yes", "No")
	if(confirm != "Yes")
		to_chat(user, span_alert("Okay nevermind!!"))
		return
	DeliverMessage(user, M)

/obj/item/hand_item/subtle_catapult/proc/DeliverMessage(mob/user, mob/living/M)
	var/original_message = message
	var/to_send = message

	user.log_message(to_send, LOG_SUBTLE)
	var/msg_check = user.say_narrate_replace(to_send, user)
	if(msg_check)
		to_send = span_subtle("<i>[msg_check]</i>")
	else
		to_send = span_subtle("<b>[user]</b> " + "<i>[user.say_emphasis(to_send)]</i>")

	var/datum/emote/E
	E = E.emote_list["subtle"]

	var/datum/rental_mommy/chat/mommy = E.BuildMommy(user, to_send)
	mommy.original_message = original_message
	mommy.exclusive_targets = list(M, user)

	// Visible to_send, as in only visible to you and them
	user.visible_message(
		message = to_send,
		data = list("mom" = mommy))

	//broadcast to ghosts, if they have a client, are dead, arent in the lobby, allow ghostsight, and, if subtler, are admemes
	user.emote_for_ghost_sight(mommy.message, TRUE, 0)
	mommy.checkin()
	user.playsound_local(get_turf(user), 'sound/f13effects/sunsetsounds/blush.ogg', 80, FALSE)
	M.playsound_local(get_turf(M), 'sound/f13effects/sunsetsounds/blush.ogg', 80, FALSE)




#undef LICK_LOCATION
#undef LICK_INTENT
#undef LICK_CANCEL
