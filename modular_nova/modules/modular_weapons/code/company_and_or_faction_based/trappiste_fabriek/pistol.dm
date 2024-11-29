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

	. += "The Guêpe is an evolution of an older pistol which has seen use for over a century with incremental \
		improvements keeping it up to date. The first models proved incredibly popular with law enforcement throughout SolFed, \
		due to their ease of use, repair, and that the low-caliber bullets lead to a heavily reduced chance of collateral damage. \
 		As the decades passed the proven design was steadily adopted into various militaries as well, most notably by the \
 		Sol Federation Armed Forces who took it on as their first service pistol just after their founding in 2492 with more modern variants \
		 remaining the SFAF’s primary service pistol to this day. \
		In the civilian market the Guêpe is particularly popular among spacers who appreciate the hidden simplicity, and surplus of spare parts. \
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

	. += "The Skild only exists due to a widely known event that SolFed's military \
		would prefer wasn't anywhere near as popular. A general, name unknown as of now, \
		was recorded complaining about the lack of capability the Wespe provided to the \
		military, alongside several statements comparing the Wespe's lack of masculinity \
		to the, quote, 'unique lack of testosterone those NRI mongrels field'. While the \
		identities of both the general and people responsible for the leaking of the recording \
		are still classified, many high ranking SolFed military staff suspiciously have stopped \
		appearing in public, unlike the Skild. A lot of several thousand pistols, the first \
		of the weapons to ever exist, were not so silently shipped to SolFed's Plutonian \
		shipping hub from TRAPPIST. SolFed military command refuses to answer any \
		further questions about the incident to this day."

	return .

/obj/item/gun/ballistic/automatic/pistol/trappiste/no_mag
	spawnwithmagazine = FALSE
