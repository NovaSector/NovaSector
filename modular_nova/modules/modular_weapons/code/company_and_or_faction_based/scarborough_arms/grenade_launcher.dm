// Currently unfolded.
#define BOARDER_FOLD_EXTEND 0
// Currently folded.
#define BOARDER_FOLD_FOLDED 1
// Cannot fold.
#define BOARDER_FOLD_NOPE -1

/obj/item/gun/ballistic/pump_launcher
	name = "pump-action grenade launcher"
	desc = "A Scarborough Arms \"Boarder-40\" enhanced velocity grenade launcher, with capacity for four 40mm grenades and one in the chamber."
	desc_controls = "Ctrl-click to fold the stock, reducing the size but increasing recoil and preventing cycling the launcher. \
		Folding the stock takes time - unfolding it does not."
	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/scarborough_arms/launchers48x.dmi'
	icon_state = "boarder40"
	worn_icon = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/scarborough_arms/guns_worn.dmi'
	worn_icon_state = "boarder"
	lefthand_file = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/scarborough_arms/guns_lefthand.dmi'
	righthand_file = 'modular_nova/modules/modular_weapons/icons/mob/company_and_or_faction_based/scarborough_arms/guns_righthand.dmi'
	inhand_icon_state = "boarder"
	inhand_x_dimension = 32
	inhand_y_dimension = 32

	slot_flags = ITEM_SLOT_BACK

	SET_BASE_PIXEL(-8, 0)
	fire_sound = 'modular_nova/modules/modular_weapons/sounds/grenade_launcher.ogg'
	fire_sound_volume = 75
	rack_sound = 'sound/items/weapons/gun/shotgun/rack.ogg'
	load_sound = 'sound/items/weapons/gun/shotgun/insert_shell.ogg'
	drop_sound = 'sound/items/handling/gun/ballistics/shotgun/shotgun_drop1.ogg'
	pickup_sound = 'sound/items/handling/gun/ballistics/shotgun/shotgun_pickup1.ogg'
	w_class = WEIGHT_CLASS_BULKY
	force = 10
	obj_flags = CONDUCTS_ELECTRICITY

	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/pump_launcher
	internal_magazine = TRUE
	semi_auto = FALSE
	casing_ejector = FALSE
	bolt_wording = "pump"
	cartridge_wording = "grenade"
	tac_reloads = FALSE
	weapon_weight = WEAPON_HEAVY
	recoil = 0.5
	rack_delay = 0.6 SECONDS

	projectile_speed_multiplier = 1.3
	// base projectile speed is 1.25 * 1.3 = 1.625

	lore_blurb = "The Boarder series of grenade launchers are pump-action grenade launchers designed by Scarborough Arms \
		to be easily portable for use within tight confines like bunkers, bulkheads, and other enclosed spaces where quick \
		and precise grenade placement are very, very valued.<br><br>\
		The idea for the Boarder was a request from the Gorlex Marauders, who desired a dedicated, \
		more aggressive alternative to the underbarrel grenade launchers. \
		Scarborough Arms was happy to develop the Boarder series, \
		with its Enhanced Launch System increasing grenade velocity. \
		Boarder-series grenade launchers all feature a common receiver and \
		an easily reprogrammable smart scope for different varieties or sizes of grenade, \
		allowing grenadiers to effectively place explosive firepower where it's needed the most."

	/// Lore specific to this type of gun.
	var/model_specific_lore = "Boarder-40 units, true to their name, are chambered for use with the venerable 40mm launcher grenade. \
		This allows them to use the same grenades as the M-90gl, which simplifies logistics for Gorlex \
		operatives already using those launchers. However, Boarder-40 units are also \
		typically pre-configured to the gung-ho Gorlex standard of having no safe arming distance, \
		allowing them to deploy their grenades in the tightest confines - for better or for worse."

	/// Is this grenade launcher folded?
	var/folded = FALSE
	/// Is this grenade launcher able to cycle while folded?
	var/can_rack_when_folded = FALSE
	/// How long does it take to fold the stock down?
	var/fold_time = 2 SECONDS

/obj/item/gun/ballistic/pump_launcher/nofold
	folded = BOARDER_FOLD_NOPE
	icon_state = "boarder40-nofold"
	desc = "A Scarborough Arms \"Boarder/S-40\" enhanced velocity grenade launcher, with capacity for four 40mm grenades and one in the chamber."
	desc_controls = null
	recoil = 0
	model_specific_lore = "Boarder/S-40 units feature a solid, monolithic stock, with increased recoil dampening, \
		and are chambered for use with the venerable 40mm launcher grenade. \
		This allows them to use the same grenades as the M-90gl, which simplifies logistics for Gorlex \
		operatives already using those launchers. \
		However, Boarder-40 units are also typically pre-configured to the gung-ho Gorlex standard of having no safe arming distance, \
		allowing them to deploy their grenades in the tightest confines - for better or for worse."

/obj/item/gun/ballistic/pump_launcher/c980
	name = "pump-action airburst grenade launcher"
	icon_state = "boarder980"
	desc = "A Scarborough Arms \"Boarder-980\" enhanced velocity grenade launcher, with capacity for five .980 Tydhouer grenades and one in the chamber. \
		The smartscope doubles as a ballistic computer, which automatically configures airburst settings based on the distance between user and aimed target."

	projectile_speed_multiplier = 1.625
	// base projectile speed is 1 * 1.625 = 1.625

	model_specific_lore = "Boarder-980 launchers, true to their name, are chambered for use with the modern .980 Tydhouer smart launcher grenade. \
		While less popular with full-force Gorlex units due to the reduction of damage potential, \
		other customers report more satisfaction with, quote, \
		\"a greatly reduced risk of accidentally turning charging men into chunky salsa\". \
		Boarder-980 scopes serve double duty as the ballistic co-processor, \
		allowing smart, on-the-fly airburst calculations for each launched grenade - \
		in return for not allowing manual airburst configuration. \
		As is typical of Boarder launchers, these also default to a distinct lack of safe arming distance."

	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/pump_launcher/c980


/obj/item/gun/ballistic/pump_launcher/c980/prefold
	folded = BOARDER_FOLD_FOLDED
	recoil = 1.5
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/gun/ballistic/pump_launcher/c980/prefold/Initialize(mapload)
	. = ..()
	update_icon()

// proc defines

/obj/item/gun/ballistic/pump_launcher/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/scope, range_modifier = 1)

/obj/item/gun/ballistic/pump_launcher/get_lore_blurb()
	return lore_blurb + "<br><br>" + model_specific_lore

/obj/item/gun/ballistic/pump_launcher/rack(mob/user)
	if((folded == BOARDER_FOLD_FOLDED) && !can_rack_when_folded)
		to_chat(user, span_warning("[src] can't cycle while folded!"))
		balloon_alert(user, "can't rack when folded!")
		return FALSE
	. = ..()

/obj/item/gun/ballistic/pump_launcher/item_ctrl_click(mob/user)
	if(!user.is_holding(src))
		return // how do you expect to fiddle with the stock without holding it, genius
	if(folded != BOARDER_FOLD_NOPE)
		toggle_stock(user)

/obj/item/gun/ballistic/pump_launcher/proc/toggle_stock(mob/user)
	// Drop of a hat, these guys will rock and roll.
	if(folded)
		// Spring-loaded stocks snap into place. Things are about to get out of hand.
		w_class = WEIGHT_CLASS_BULKY
		recoil = 0.5
	else
		if(!do_after(user, fold_time, timed_action_flags = IGNORE_USER_LOC_CHANGE))
			balloon_alert(user, "interrupted!")
			return
		w_class = WEIGHT_CLASS_NORMAL
		recoil = 1.5 // ow ouch ouchie oof
	folded = !folded
	if(user)
		balloon_alert(user, "stock [folded ? "collapsed" : "extended"]")
		playsound(src.loc, 'sound/items/weapons/batonextend.ogg', 30, 1)
	update_icon()

/obj/item/gun/ballistic/pump_launcher/update_icon_state()
	. = ..()
	if(folded == BOARDER_FOLD_FOLDED)
		icon_state += "-folded"

// magazines
/obj/item/ammo_box/magazine/internal/pump_launcher
	name = "pump-action grenade launcher magazine tube"
	desc = "Oh. That's a 40mm grenade. That's a 40mm grenade being launched towards my face."
	ammo_type = /obj/item/ammo_casing/a40mm
	caliber = CALIBER_40MM
	max_ammo = 4
	ammo_box_multiload = AMMO_BOX_MULTILOAD_NONE

/obj/item/ammo_box/magazine/internal/pump_launcher/c980
	desc = "Oh. That's a .980 grenade. That's a .980 grenade being launched towards my face."
	ammo_type = /obj/item/ammo_casing/c980grenade/shrapnel
	max_ammo = 5
	caliber = CALIBER_980TYDHOUER

// cases
/obj/item/storage/toolbox/guncase/traitor/boarder
	name = "boarder grenade launcher case"
	weapon_to_spawn = /obj/item/gun/ballistic/pump_launcher/c980/prefold
	extra_to_spawn = /obj/item/ammo_box/c980grenade/shrapnel
	ammo_box_to_spawn = /obj/item/ammo_box/c980grenade/shrapnel/phosphor

/obj/item/storage/toolbox/guncase/nova/boarder
	weapon_to_spawn = /obj/item/gun/ballistic/pump_launcher
	extra_to_spawn = /obj/item/ammo_box/a40mm
