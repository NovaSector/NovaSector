
/obj/item/bitrunning_disk/item/abductors
	name = "compiled bitrunning gear: abductors"
	desc = "A disk containing fragments of virtual abductor data. Its value to research is unclear, but what is clear is that it's got some sick loots in it."
	selectable_items = list(
		/obj/item/gun/energy/alien/astrum/domain,
		/obj/item/clothing/head/helmet/abductor,
		/obj/item/clothing/suit/armor/abductor/astrum,
	)

/obj/item/gun/energy/alien/astrum/domain
	name = "alien energy pistol"
	desc = "A mysterious pink and grey pistol operating on systems you can't begin to surmise. Enervates as well as burns its targets."
	projectile_damage_multiplier = 2.5 // Same damage as an allstar + stamina
	ammo_type = list(/obj/item/ammo_casing/energy/laser/purplebeam)

/obj/item/cardboard_cutout/abductor
	starting_cutout = "Abductor Agent"

/obj/item/gun/energy/laser/chameleon/energy_only
	actions_types = list(/datum/action/item_action/chameleon/change/gun/energy)
	default_look = /obj/item/gun/energy/shrink_ray


/obj/item/gun/energy/laser/chameleon/energy_only/Initialize(mapload)
	. = ..()
	set_chameleon_disguise(default_look)

/datum/action/item_action/chameleon/change/gun/energy
	chameleon_type = /obj/item/gun/energy
	chameleon_name = "Blaster"
