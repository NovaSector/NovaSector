// open to suggestions on where to put these overrides
// hugely not a fan of this but we do what we gotta

/*
 * gotta redefine EVERY goddamn ammo type irt to new mat costs for the ammobench's sake
 * previously, SMALL_MATERIAL_AMOUNT was 100 units out of 2000 from a sheet (5%)
 * so the old cost of SMALL_MATERIAL_AMOUNT * 5 was 500/2000 from a sheet (25%)
 * experimental material balance PR makes it so that SMALL_MATERIAL_AMOUNT is actually 10 units out of 100 (10%)
 * which made it so that the old assumed value of SMALL_MATERIAL_AMOUNT * 5 is 50/100 (50% of a sheet for a single bullet) (suboptimal)
 * these updated, more consistent defines make it so that a single round's total materials should total 20% of a sheet, or 2 SMALL_MATERIAL_AMOUNT
*/

#define AMMO_MATS_BASIC list( \
	/datum/material/iron = SMALL_MATERIAL_AMOUNT * 2, \
)

#define AMMO_MATS_AP list( \
	/datum/material/iron = SMALL_MATERIAL_AMOUNT * 1.6, \
	/datum/material/titanium = SMALL_MATERIAL_AMOUNT * 0.4, \
)

#define AMMO_MATS_TEMP list( \
	/datum/material/iron = SMALL_MATERIAL_AMOUNT * 1.6, \
	/datum/material/plasma = SMALL_MATERIAL_AMOUNT * 0.4, \
)

#define AMMO_MATS_EMP list( \
	/datum/material/iron = SMALL_MATERIAL_AMOUNT * 1.6, \
	/datum/material/uranium = SMALL_MATERIAL_AMOUNT * 0.4, \
)

#define AMMO_MATS_PHASIC list( \
	/datum/material/iron = SMALL_MATERIAL_AMOUNT * 1.6, \
	/datum/material/bluespace = SMALL_MATERIAL_AMOUNT * 0.4, \
)

#define AMMO_MATS_TRAC list( \
	/datum/material/iron = SMALL_MATERIAL_AMOUNT * 1.6, \
	/datum/material/silver = SMALL_MATERIAL_AMOUNT * 0.2, \
	/datum/material/gold = SMALL_MATERIAL_AMOUNT * 0.2, \
)

#define AMMO_MATS_HOMING list( \
	/datum/material/iron = SMALL_MATERIAL_AMOUNT * 1, \
	/datum/material/silver = SMALL_MATERIAL_AMOUNT * 0.2, \
	/datum/material/gold = SMALL_MATERIAL_AMOUNT * 0.2, \
	/datum/material/plasma = SMALL_MATERIAL_AMOUNT * 0.2, \
	/datum/material/diamond = SMALL_MATERIAL_AMOUNT * 0.2, \
	/datum/material/bluespace = SMALL_MATERIAL_AMOUNT * 0.2, \
)

// for .35 Sol Ripper
#define AMMO_MATS_RIPPER list( \
	/datum/material/iron = SMALL_MATERIAL_AMOUNT * 1.6, \
	/datum/material/glass = SMALL_MATERIAL_AMOUNT * 0.4, \
)

#define AMMO_MATS_HEAVY list( \
	/datum/material/iron = SMALL_MATERIAL_AMOUNT * 6, \
)

#define AMMO_MATS_HEAVY_TEMP list( \
	/datum/material/iron = SMALL_MATERIAL_AMOUNT * 5, \
	/datum/material/plasma = SMALL_MATERIAL_AMOUNT, \
)
#define AMMO_MATS_HEAVY_EMP list( \
	/datum/material/iron = SMALL_MATERIAL_AMOUNT * 5, \
	/datum/material/uranium = SMALL_MATERIAL_AMOUNT, \
)

#define AMMO_MATS_HEAVY_FAST list( \
	/datum/material/iron = SMALL_MATERIAL_AMOUNT * 5, \
	/datum/material/titanium = SMALL_MATERIAL_AMOUNT, \
)

/obj/item/ammo_casing
	custom_materials = AMMO_MATS_BASIC

///GUN SPRITE OVERWRITES
/obj/item/gun/energy/ionrifle
	icon = 'modular_nova/modules/aesthetics/guns/icons/energy.dmi'
	lefthand_file = 'modular_nova/modules/aesthetics/guns/icons/guns_lefthand.dmi'
	righthand_file = 'modular_nova/modules/aesthetics/guns/icons/guns_righthand.dmi'

/obj/item/gun/energy/ionrifle/carbine
	icon = 'icons/obj/weapons/guns/energy.dmi'
	lefthand_file = 'icons/mob/inhands/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/guns_righthand.dmi'

/obj/item/gun/ballistic/shotgun/automatic/combat
	name = "\improper Peacekeeper combat shotgun"
	desc = "A semi-automatic Nanotrasen Peacekeeper shotgun with tactical furnishing and heavier internals meant for sustained fire. Lacks a threaded barrel."
	icon = 'modular_nova/modules/aesthetics/guns/icons/guns.dmi'
	worn_icon = 'modular_nova/modules/aesthetics/guns/icons/guns_back.dmi'
	lefthand_file = 'modular_nova/modules/aesthetics/guns/icons/guns_lefthand.dmi'
	righthand_file = 'modular_nova/modules/aesthetics/guns/icons/guns_righthand.dmi'
	inhand_icon_state = "shotgun_combat"
	inhand_x_dimension = 32
	inhand_y_dimension = 32

// de-overrides this particular gun, it uses the tg file
/obj/item/gun/ballistic/shotgun/automatic/combat/compact
	icon = 'icons/obj/weapons/guns/ballistic.dmi'
	lefthand_file = 'icons/mob/inhands/weapons/64x_guns_left.dmi'
	righthand_file = 'icons/mob/inhands/weapons/64x_guns_right.dmi'
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	worn_icon = null

/obj/item/gun/grenadelauncher
	icon = 'modular_nova/modules/aesthetics/guns/icons/guns.dmi'
	lefthand_file = 'modular_nova/modules/aesthetics/guns/icons/guns_lefthand.dmi'
	righthand_file = 'modular_nova/modules/aesthetics/guns/icons/guns_righthand.dmi'

/obj/item/gun/ballistic/automatic/pistol/m1911
	icon = 'modular_nova/modules/aesthetics/guns/icons/guns.dmi'
	inhand_icon_state = "colt"
	lefthand_file = 'modular_nova/modules/aesthetics/guns/icons/guns_lefthand.dmi'
	righthand_file = 'modular_nova/modules/aesthetics/guns/icons/guns_righthand.dmi'

/obj/item/gun/ballistic/automatic/c20r
	icon = 'modular_nova/modules/aesthetics/guns/icons/guns.dmi'

/obj/item/gun/ballistic/automatic/m90
	icon = 'modular_nova/modules/aesthetics/guns/icons/guns.dmi'

/obj/item/gun/ballistic/automatic/pistol/aps
	icon = 'modular_nova/modules/aesthetics/guns/icons/guns.dmi'

/obj/item/gun/ballistic/automatic/pistol
	icon = 'modular_nova/modules/aesthetics/guns/icons/guns.dmi'

/obj/item/gun/ballistic/automatic/pistol/doorhickey
	icon = 'icons/obj/weapons/guns/ballistic.dmi'

/obj/item/gun/ballistic/automatic/pistol/deagle
	desc = "A robust .454 Trucidator handgun."

/obj/item/gun/ballistic/automatic/pistol/deagle/regal
	icon = 'icons/obj/weapons/guns/ballistic.dmi'
	desc = "A gold plated Desert Eagle folded over a million times by superior martian gunsmiths. Uses .454 Trucidator ammo."

/obj/item/gun/ballistic/automatic/pistol/clandestine/fisher
	icon = 'icons/obj/weapons/guns/ballistic.dmi'

/obj/item/gun/energy/e_gun/nuclear
	icon = 'modular_nova/modules/aesthetics/guns/icons/nucgun.dmi'
	ammo_x_offset = 2
	lefthand_file = 'modular_nova/modules/aesthetics/guns/icons/guns_lefthand.dmi'
	righthand_file = 'modular_nova/modules/aesthetics/guns/icons/guns_righthand.dmi'
	worn_icon_state = "gun"
	worn_icon = null

/obj/item/gun/energy/e_gun/nuclear/rainbow
	name = "fantastic energy gun"
	desc = "An energy gun with an experimental miniaturized nuclear reactor that automatically charges the internal power cell. This one seems quite fancy!"
	ammo_type = list(/obj/item/ammo_casing/energy/laser/rainbow, /obj/item/ammo_casing/energy/disabler/rainbow)

/obj/item/ammo_casing/energy/laser/rainbow
	icon = 'modular_nova/modules/aesthetics/guns/icons/nucgun.dmi'
	icon_state = "laser"
	select_name = "kill"
	projectile_type = /obj/projectile/beam/laser/rainbow

/obj/projectile/beam/laser/rainbow
	icon = 'modular_nova/modules/aesthetics/guns/icons/nucgun.dmi'
	icon_state = "laser"

/obj/item/ammo_casing/energy/disabler/rainbow
	icon = 'modular_nova/modules/aesthetics/guns/icons/nucgun.dmi'
	icon_state = "laser"
	select_name = "disable"
	projectile_type = /obj/projectile/beam/disabler/rainbow

/obj/projectile/beam/disabler/rainbow
	icon = 'modular_nova/modules/aesthetics/guns/icons/nucgun.dmi'
	icon_state = "laser"

/obj/item/gun/energy/e_gun/nuclear/emag_act(mob/user, obj/item/card/emag/E)
	. = ..()
	if(obj_flags & EMAGGED)
		return FALSE
	if(pin)
		to_chat(user, span_warning("You probably want to do this on a new gun!"))
		return FALSE
	to_chat(user, "<font color='#ff2700'>T</font><font color='#ff4e00'>h</font><font color='#ff7500'>e</font> <font color='#ffc400'>g</font><font color='#ffeb00'>u</font><font color='#ebff00'>n</font> <font color='#9cff00'>s</font><font color='#75ff00'>u</font><font color='#4eff00'>d</font><font color='#27ff00'>d</font><font color='#00ff00'>e</font><font color='#00ff27'>n</font><font color='#00ff4e'>l</font><font color='#00ff75'>y</font> <font color='#00ffc4'>f</font><font color='#00ffeb'>e</font><font color='#00ebff'>e</font><font color='#00c4ff'>l</font><font color='#009cff'>s</font> <font color='#004eff'>q</font><font color='#0027ff'>u</font><font color='#0000ff'>i</font><font color='#2700ff'>t</font><font color='#4e00ff'>e</font> <font color='#9c00ff'>f</font><font color='#c400ff'>a</font><font color='#eb00ff'>n</font><font color='#ff00eb'>t</font><font color='#ff00c4'>a</font><font color='#ff009c'>s</font><font color='#ff0075'>t</font><font color='#ff004e'>i</font><font color='#ff0027'>c</font><font color='#ff0000'>!</font>")
	new /obj/item/gun/energy/e_gun/nuclear/rainbow(get_turf(user))
	obj_flags |= EMAGGED
	qdel(src)
	return TRUE

/obj/item/gun/energy/e_gun/nuclear/rainbow/update_overlays()
	. = ..()
	. += "[icon_state]_emagged"

/obj/item/gun/energy/e_gun/nuclear/rainbow/emag_act(mob/user, obj/item/card/emag/E)
	return FALSE

//BEAM SOUNDS
/obj/item/ammo_casing/energy
	fire_sound = 'modular_nova/modules/aesthetics/guns/sound/laser.ogg'

/obj/item/ammo_casing/energy/laser/pulse
	fire_sound = 'modular_nova/modules/aesthetics/guns/sound/pulse.ogg'

/obj/item/gun/energy/xray
	fire_sound_volume = 100

/obj/item/ammo_casing/energy/xray
	fire_sound = 'modular_nova/modules/aesthetics/guns/sound/xray_laser.ogg'

/obj/item/ammo_casing/energy/laser/accelerator
	fire_sound = 'modular_nova/modules/aesthetics/guns/sound/laser_cannon_fire.ogg'

/obj/item/gun/ballistic/automatic/sniper_rifle
	name = "sniper rifle"
	desc = "A long ranged weapon that does significant damage. No, you can't quickscope."
	icon = 'modular_nova/modules/aesthetics/guns/icons/guns_gubman2.dmi'
	icon_state = "sniper"
	w_class = WEIGHT_CLASS_BULKY
	inhand_icon_state = "sniper"
	worn_icon_state = null
	fire_sound = 'sound/items/weapons/gun/sniper/shot.ogg'
	fire_sound_volume = 90
	load_sound = 'sound/items/weapons/gun/sniper/mag_insert.ogg'
	rack_sound = 'sound/items/weapons/gun/sniper/rack.ogg'
	suppressed_sound = 'sound/items/weapons/gun/general/heavy_shot_suppressed.ogg'
	recoil = 2
	weapon_weight = WEAPON_HEAVY
	accepted_magazine_type = /obj/item/ammo_box/magazine/sniper_rounds
	fire_delay = 6 SECONDS
	burst_size = 1
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = ITEM_SLOT_BACK
	actions_types = list()
	mag_display = TRUE
	suppressor_x_offset = 3
	suppressor_y_offset = 3

/obj/item/gun/ballistic/automatic/sniper_rifle/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/scope, range_modifier = 2)

/obj/item/gun/ballistic/automatic/sniper_rifle/reset_fire_cd()
	. = ..()
	if(suppressed)
		playsound(src, 'sound/machines/eject.ogg', 25, TRUE, ignore_walls = FALSE, extrarange = SILENCED_SOUND_EXTRARANGE, falloff_distance = 0)
	else
		playsound(src, 'sound/machines/eject.ogg', 50, TRUE)

/obj/item/gun/ballistic/automatic/sniper_rifle/syndicate
	name = "syndicate sniper rifle"
	desc = "An illegally modified .50 sniper rifle with suppressor compatibility. Quickscoping still doesn't work."
	icon = 'modular_nova/modules/aesthetics/guns/icons/guns_gubman2.dmi'
	icon_state = "sniper2"
	worn_icon_state = "sniper"
	fire_delay = 5.5 SECONDS
	can_suppress = TRUE
	can_unsuppress = TRUE
	pin = /obj/item/firing_pin/implant/pindicate

/obj/item/gun/ballistic/automatic/sniper_rifle/modular
	name = "AUS-107 anti-materiel rifle"
	desc = "A devastating Aussec Armory heavy sniper rifle, fitted with a modern scope."
	icon = 'modular_nova/modules/aesthetics/guns/icons/guns_gubman2.dmi'
	icon_state = "sniper"
	worn_icon_state = "sniper"
	fire_sound = 'modular_nova/modules/aesthetics/guns/sound/sniperrifle.ogg'
	suppressed_sound = 'modular_nova/modules/aesthetics/guns/sound/sniperrifle_s.ogg'
	w_class = WEIGHT_CLASS_BULKY
	can_suppress = FALSE

/obj/item/gun/ballistic/automatic/sniper_rifle/modular/syndicate
	name = "'Caracal' anti-materiel rifle"  //we flop out
	desc = "A sleek, light bullpup .50 sniper rifle with a reciprocating barrel, nicknamed 'Caracal' by Scarborough Arms. Its compact folding parts make it able to fit into a backpack, and its modular barrel can have a suppressor installed within it rather than as a muzzle extension. Its advanced scope accounts for all ballistic inaccuracies of a reciprocating barrel."
	icon_state = "sysniper"
	fire_sound = 'modular_nova/modules/aesthetics/guns/sound/sniperrifle.ogg'
	suppressed_sound = 'modular_nova/modules/aesthetics/guns/sound/sniperrifle_s.ogg'
	fire_delay = 4 SECONDS //Delay reduced thanks to recoil absorption
	burst_size = 0.5
	recoil = 1
	can_suppress = TRUE
	can_unsuppress = TRUE
	weapon_weight = WEAPON_LIGHT

/obj/item/gun/ballistic/automatic/sniper_rifle/modular/syndicate/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_SCARBOROUGH)

/obj/item/gun/ballistic/automatic/sniper_rifle/modular/blackmarket  //Normal sniper but epic
	name = "SA-107 anti-materiel rifle"
	desc = "An illegal Scarborough Arms rendition of an Aussec Armory sniper rifle. This one has been fitted with a heavy duty scope, a sturdier stock, and has a removable muzzle brake that allows easy attachment of suppressors."
	icon_state = "sniper2"
	fire_sound = 'modular_nova/modules/aesthetics/guns/sound/sniperrifle.ogg'
	suppressed_sound = 'modular_nova/modules/aesthetics/guns/sound/sniperrifle_s.ogg'
	fire_sound_volume = 90
	vary_fire_sound = FALSE
	load_sound = 'sound/items/weapons/gun/sniper/mag_insert.ogg'
	rack_sound = 'sound/items/weapons/gun/sniper/rack.ogg'
	w_class = WEIGHT_CLASS_NORMAL
	can_suppress = TRUE
	can_unsuppress = TRUE
	recoil = 1.8
	weapon_weight = WEAPON_HEAVY
	accepted_magazine_type = /obj/item/ammo_box/magazine/sniper_rounds
	fire_delay = 55 //Slightly smaller than standard sniper
	burst_size = 1
	slot_flags = ITEM_SLOT_BACK
	mag_display = TRUE

/obj/item/gun/ballistic/automatic/ar/modular
	name = "\improper NT ARG-63"
	desc = "Nanotrasen's prime ballistic option based on the Stoner design, fitted with a light polymer frame and other tactical furniture, chambered in .223 - nicknamed 'Boarder' by Special Operations teams."
	icon = 'modular_nova/modules/aesthetics/guns/icons/guns_gubman2.dmi'
	icon_state = "arg"
	inhand_icon_state = "arg"
	can_suppress = FALSE

// GUBMAN3 - FULL BULLET RENAME
// no more. we are free
