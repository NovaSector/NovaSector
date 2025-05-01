// .35 Sol mini revolver

/obj/item/gun/ballistic/revolver/sol
	name = "\improper Renard Revolver"
	desc = "A small revolver with a comically short barrel and cylinder space for eight .35 Sol Short rounds."

	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/trappiste_fabriek/guns32x.dmi'
	icon_state = "eland"

	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/cylinder/c35sol

	suppressor_x_offset = 3
	suppressor_y_offset = 2

	w_class = WEIGHT_CLASS_SMALL

	can_suppress = TRUE

	lore_blurb = "The Renard is as simple as it looks, trimming down Trappiste's typical extravagance for the sake of its small size.<br><br>\
		Originally, it was seen as an acceptable backup for SolFed's police forces, \
		able to be stashed in any manner of pouch, pocket, or even just stuck into your waistband, \
		while still coming loaded with eight .35 Sol Short rounds. \
		As SolFed's myriad forces modernized, the Renard began living a second life with executives, bodyguards, and criminals due to its ease of concealment. \
		If bang for your buck was the focus, you can't do much better then the bare minimum in both cost and size. \
		There's not a lot to be said about the actual function of the gun either; thanks to a centerline barrel \
		and being shot from the lowest chamber of the cylinder, the recoil is non-existent, much like the user's safety. \
		The only out-of-place feature for a budget revolver like this is that the chamber is pressed forward during firing, \
		forming a seal between cylinder and barrel in a manner that still allows it to be suppressed."

/obj/item/gun/ballistic/revolver/sol/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_TRAPPISTE)

/obj/item/ammo_box/magazine/internal/cylinder/c35sol
	ammo_type = /obj/item/ammo_casing/c35sol
	caliber = CALIBER_SOL35SHORT
	max_ammo = 8

// .585 super revolver

/obj/item/gun/ballistic/revolver/takbok
	name = "\improper Défonce Revolver"
	desc = "A hefty revolver with an equally large cylinder capable of holding six .585 Trappiste rounds."

	icon = 'modular_nova/modules/modular_weapons/icons/obj/company_and_or_faction_based/trappiste_fabriek/guns32x.dmi'
	icon_state = "takbok"

	fire_sound = 'modular_nova/modules/modular_weapons/sounds/revolver_heavy.ogg'
	suppressed_sound = 'modular_nova/modules/modular_weapons/sounds/suppressed_heavy.ogg'

	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/cylinder/c585trappiste

	suppressor_x_offset = 5

	can_suppress = TRUE

	fire_delay = 0.5 SECONDS
	recoil = 3

	lore_blurb = "The Defoncé was designed to fulfill a request by the Sol Federation Armed Forces for a maintainable high-caliber handgun.<br><br>\
		While the Guêpe served well to deal with human sized targets, it struggled against large fauna. \
		The Defoncé was made to fill that capability gap, enabling second-line SFAF personnel to easily defend themselves \
		against dangerous creatures when serving in the wilderness of alien worlds. \
		The resulting pistol perfectly filled the SFAF's requirements, and, as such, has remained in service ever since its adoption in 2495. \
		The durable, simple, and easy-to-maintain design of the Defoncé, combined with its high power, \
		has also made it popular in some parts of the civilian firearms market; \
		primarily with frontier settlers and hunters who appreciate its maintainability, and the ease with which it can take down large creatures."

/obj/item/gun/ballistic/revolver/takbok/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_TRAPPISTE)

/obj/item/ammo_box/magazine/internal/cylinder/c585trappiste
	ammo_type = /obj/item/ammo_casing/c585trappiste
	caliber = CALIBER_585TRAPPISTE
	max_ammo = 6
