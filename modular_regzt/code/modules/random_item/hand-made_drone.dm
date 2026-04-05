/mob/living/basic/drone/handmade
	name = "maintanse drone shell"
	shy = FALSE
	default_storage = null
	desc = "drone shell"
	icon = 'modular_regzt/icons/mob/drone.dmi'
	icon_state = "drone_handmade"
	health = 40
	maxHealth = 40
	picked = TRUE
	hud_type = /datum/hud/human
	hud_possible = list(DIAG_STAT_HUD, DIAG_HUD)

/mob/living/basic/drone/handmade/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/dextrous, hud_type = hud_type)
	AddComponent(/datum/component/basic_inhands, y_offset = getItemPixelShiftY())
	AddComponent(/datum/component/simple_access, SSid_access.get_region_access_list(list(REGION_ALL_GLOBAL)))
	AddComponent(/datum/component/personal_crafting) // Kind of hard to be a drone and not be able to make tiles
	LoadComponent(/datum/component/bloodysoles/bot)

	if(default_storage)
		var/obj/item/storage = new default_storage(src)
		equip_to_slot_or_del(storage, ITEM_SLOT_DEX_STORAGE)

	for(var/holiday_name in GLOB.holidays)
		var/datum/holiday/holiday_today = GLOB.holidays[holiday_name]
		var/obj/item/potential_hat = holiday_today.holiday_hat
		if(!isnull(potential_hat) && isnull(default_headwear)) //If our drone type doesn't start with a hat, we take the holiday one.
			default_headwear = potential_hat

	if(default_headwear)
		var/obj/item/new_hat = new default_headwear(src)
		equip_to_slot_or_del(new_hat, ITEM_SLOT_HEAD)

	shy_update()
	alert_drones(DRONE_NET_CONNECT)

	var/datum/atom_hud/data/diagnostic/diag_hud = GLOB.huds[DATA_HUD_DIAGNOSTIC]
	diag_hud.add_atom_to_hud(src)

	add_traits(list(
		TRAIT_VENTCRAWLER_ALWAYS,
		TRAIT_LITERATE,
		TRAIT_KNOW_ENGI_WIRES,
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_REAGENT_SCANNER,
		TRAIT_UNOBSERVANT,
		TRAIT_SILICON_EMOTES_ALLOWED,
	), INNATE_TRAIT)

	listener = new(list(ALARM_ATMOS, ALARM_FIRE, ALARM_POWER), list(z))
	RegisterSignal(listener, COMSIG_ALARM_LISTENER_TRIGGERED, PROC_REF(alarm_triggered))
	RegisterSignal(listener, COMSIG_ALARM_LISTENER_CLEARED, PROC_REF(alarm_cleared))
	listener.RegisterSignal(src, COMSIG_LIVING_DEATH, TYPE_PROC_REF(/datum/alarm_listener, prevent_alarm_changes))
	listener.RegisterSignal(src, COMSIG_LIVING_REVIVE, TYPE_PROC_REF(/datum/alarm_listener, allow_alarm_changes))
