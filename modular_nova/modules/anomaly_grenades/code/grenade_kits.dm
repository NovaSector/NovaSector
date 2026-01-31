/obj/item/crafting_conversion_kit/anomaly_grenades
	name = "case of uncharged anomaly grenades"
	desc = "A large metal case of anomaly grenade casings, designed to siphon the energy of contained anomaly cores \
		and feed them into more direct, practical applications. Like grenades, evidently. \
		It's sealed pretty shut - looks like it only opens when done charging."
	icon = 'icons/obj/storage/case.dmi'
	icon_state = "lockbox+b"
	w_class = WEIGHT_CLASS_BULKY

/obj/item/crafting_conversion_kit/anomaly_grenades/Initialize(mapload)
	. = ..()
	var/static/list/slapcraft_recipe_list = list(/datum/crafting_recipe/anchor_grenade_case)
	AddElement(
		/datum/element/slapcrafting,\
		slapcraft_recipes = slapcraft_recipe_list,\
	)

/datum/crafting_recipe/anchor_grenade_case
	name = "Case of Fastball Bluespace Grounders"
	desc = "Feed a dimensional anomaly core into the specialized anomaly-siphoning charging hardcase, receive lockbox of teleport-blocking grenades."
	result = /obj/item/storage/lockbox/anomaly_grenades/anchor
	reqs = list(
		/obj/item/crafting_conversion_kit/anomaly_grenades = 1,
		/obj/item/assembly/signaler/anomaly/dimensional = 1
	)
	time = 5 SECONDS
	category = CAT_WEAPON_RANGED

/// Grenade
/datum/storage/lockbox/grenades
	max_total_storage = WEIGHT_CLASS_SMALL * 7
	max_slots = 7

/obj/item/storage/lockbox/anomaly_grenades
	name = "lockbox of anomaly grenades"
	desc = "A large metal case of anomaly grenades. Improper charging has turned these into nonfunctional grenades, somehow."
	req_access = list(ACCESS_SECURITY)
	storage_type = /datum/storage/lockbox/grenades
	var/obj/item/grenade/starting_nade = /obj/item/grenade

/obj/item/storage/lockbox/anomaly_grenades/PopulateContents()
	for(var/i in 1 to 5)
		new starting_nade(src)

/obj/item/storage/lockbox/anomaly_grenades/anchor
	name = "lockbox of bluespace grounding grenades"
	desc = "A large metal case of anomaly grenades. A small display indicates that this case was used to make teleport-blocking grenades."
	starting_nade = /obj/item/grenade/anchor

/datum/supply_pack/security/armory/anomaly_grenades
	name = "Anomaly Grenade Case"
	desc = "Contains one locked case of uncharged anomaly grenades. Requires charging via anomaly core. \
		Currently only useful for bluespace grounding grenades, but that could change."
	cost = CARGO_CRATE_VALUE * 3
	contains = list(/obj/item/crafting_conversion_kit/anomaly_grenades)
	crate_name = "uncharged anomaly grenades case crate"
