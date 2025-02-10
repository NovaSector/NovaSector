// .35 Sol pistol

/obj/item/gun/ballistic/automatic/pistol/sol
	name = "\improper Guêpe Pistol"
	desc = "The standard issue service pistol of SolFed's various military branches. Uses .35 Sol and comes with an attached light."

	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/trappiste_fabriek/guns32x.dmi'
	icon_state = "wespe"

	fire_sound = 'modular_nova/modules/modular_weapons/sounds/pistol_light.ogg'

	w_class = WEIGHT_CLASS_NORMAL

	accepted_magazine_type = /obj/item/ammo_box/magazine/c35sol_pistol
	special_mags = TRUE

	suppressor_x_offset = 0
	suppressor_y_offset = 0

	fire_delay = 0.3 SECONDS

/obj/item/gun/ballistic/automatic/pistol/sol/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_TRAPPISTE)

/obj/item/gun/ballistic/automatic/pistol/sol/add_seclight_point()
	AddComponent(/datum/component/seclite_attachable, \
		starting_light = new /obj/item/flashlight/seclite(src), \
		is_light_removable = FALSE, \
		)

/obj/item/gun/ballistic/automatic/pistol/sol/examine(mob/user)
	. = ..()
	. += span_notice("You can <b>examine closer</b> to learn a little more about this weapon.")

/obj/item/gun/ballistic/automatic/pistol/sol/examine_more(mob/user)
	. = ..()

	. += "The Guêpe is an evolution of an older pistol which has seen use for over a century, with incremental \
		improvements keeping it up to date. The first models proved incredibly popular with law enforcement throughout SolFed, \
		due to their ease of use, repair, and that the low-caliber bullets lead to a heavily reduced chance of collateral damage. \
 		As the decades passed the proven design was steadily adopted into various militaries as well, most notably by the \
 		Sol Federation Armed Forces who took it on as their first service pistol just after their founding in 2492 with more modern variants \
		 remaining the SFAF's primary service pistol to this day. \
		In the civilian market the Guêpe is particularly popular among spacers who appreciate the hidden simplicity and surplus of spare parts. \
		Less savory individuals also appreciate just how easy it is get in full-auto, simply by traveling to a less-restrictive jurisdiction and either \
		buying a full-auto variant or having it converted."

	return .

/obj/item/gun/ballistic/automatic/pistol/sol/no_mag
	spawnwithmagazine = FALSE

/obj/item/gun/ballistic/automatic/pistol/sol/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/automatic_fire, fire_delay)

// Sol pistol evil gun

/obj/item/gun/ballistic/automatic/pistol/sol/evil
	desc = "The standard issue service pistol of SolFed's various military branches. Comes with attached light. This one is painted tacticool black."

	icon_state = "wespe_evil"

/obj/item/gun/ballistic/automatic/pistol/sol/evil/no_mag
	spawnwithmagazine = FALSE

// Trappiste high caliber pistol in .585

/obj/item/gun/ballistic/automatic/pistol/trappiste
	name = "\improper Défenestreur Pistol"
	desc = "A somewhat rare to see Trappiste pistol firing the high caliber .585 developed by the same company. \
		Sees rare use mainly due to its tendency to cause severe wrist discomfort."

	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/trappiste_fabriek/guns32x.dmi'
	icon_state = "skild"

	fire_sound = 'modular_nova/modules/modular_weapons/sounds/pistol_heavy.ogg'
	suppressed_sound = 'modular_nova/modules/modular_weapons/sounds/suppressed_heavy.ogg'

	w_class = WEIGHT_CLASS_NORMAL

	accepted_magazine_type = /obj/item/ammo_box/magazine/c585trappiste_pistol

	suppressor_x_offset = 8
	suppressor_y_offset = 0

	fire_delay = 0.7 SECONDS

	recoil = 1

/obj/item/gun/ballistic/automatic/pistol/trappiste/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_TRAPPISTE)

/obj/item/gun/ballistic/automatic/pistol/sol/examine(mob/user)
	. = ..()
	. += span_notice("You can <b>examine closer</b> to learn a little more about this weapon.")

/obj/item/gun/ballistic/automatic/pistol/trappiste/examine_more(mob/user)
	. = ..()

	. += "The Défenestreur is the embodiment of a handcannon; a ridiculously oversized and overloaded pistol round crammed into a just-as-obscene gun to match it. \
		Entered production around 2496, not long after the release of the Défonce revolver, to fill a market niche between anti-material rifle and personal defense weapon. \
		Presented as an anti-wildlife weapon, it's more common-use is ensuring that whatever--or whoever--you open fire at, is gone well-before they have time to realize who did it. \
		A long, almost one piece slide leads back into a rotating bolt/slide combination, loaded from the underside with a ten round magazine as the rounds themselves were far to big \
		to ever fit within a reasonably sized grip. Despite its size, the slide and sheer weight of the gun keep the recoil about as low as anyone could realistically expect. \
		What a beauty."

	return .

/obj/item/gun/ballistic/automatic/pistol/trappiste/no_mag
	spawnwithmagazine = FALSE
