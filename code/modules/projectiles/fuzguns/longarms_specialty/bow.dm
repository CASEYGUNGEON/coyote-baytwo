// recurve bow is baseline
//this category also includes crossbows

//holy placeholder batman

/obj/item/gun/ballistic/bow/modern
	name = "Modern Recurve Bow"
	desc = "A recurve bow manufactured with modern tools and materials."
	icon = 'modular_coyote/icons/objects/guns/bows.dmi'
	icon_state = "modern"
	inhand_icon_state = "bow"
	damage_multiplier = GUN_EXTRA_DAMAGE_T3 //Now actually worth taking over the longbow.
	init_firemodes = list(
		/datum/firemode/semi_auto/rpm800 // Fires faster, more accurate.
	)
