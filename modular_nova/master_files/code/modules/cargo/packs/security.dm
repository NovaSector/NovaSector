/datum/supply_pack/security/ammo
	express_lock = TRUE

/datum/supply_pack/security/armor
	express_lock = TRUE

/datum/supply_pack/security/disabler
	cost = CARGO_CRATE_VALUE * 5

/datum/supply_pack/security/helmets
	express_lock = TRUE

/datum/supply_pack/security/securityclothes
	express_lock = TRUE

/datum/supply_pack/security/armory/ballistic
	desc = "For when the enemy absolutely needs to be replaced with lead. \
		Contains three Nanotrasen Peacekeeper combat shotguns, and three bandoliers."
	cost = CARGO_CRATE_VALUE * 12.5 // 2500cr at time of writing
	crate_name = "combat shotguns crate"

/datum/supply_pack/security/armory/thermal
	express_lock = TRUE

/datum/supply_pack/security/armory/rnd_locked/xray
	desc = "Contains a Type 6/RP X-ray Laser Gun, an atypical energy gun that fires radioactive-infused laser beams, \
		which are capable of penetrating most forms of armor, but not walls."
	contains = list(/obj/item/gun/energy/laser/xray/no_wallbang = 1)

/datum/supply_pack/security/armory/rnd_locked/xray/three_pack
	contains = list(/obj/item/gun/energy/laser/xray/no_wallbang = 3)
