// M79 launcher is baseline

/obj/item/gun/ballistic/revolver/thumper
	name = "M79 Thumper"
	desc = "A grenade launcher chambered in 40mm. Affectionally known as the Bloop Gun."
	icon = 'modular_coyote/icons/objects/gun.dmi'
	icon_state = "m79" // shinier sprite! but also points left :V
	inhand_icon_state = "gun"
	mag_type = /obj/item/ammo_box/magazine/internal/grenadelauncher
	init_mag_type = /obj/item/ammo_box/magazine/internal/grenadelauncher
	fire_sound = 'sound/weapons/grenadelaunch.ogg'
	weapon_weight = GUN_TWO_HAND_ONLY
