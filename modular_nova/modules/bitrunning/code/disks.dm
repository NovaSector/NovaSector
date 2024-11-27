/obj/item/bitrunning_disk/ability/tier0
	name = "bitrunning program: cantrip"
	selectable_actions = list(
		/datum/action/cooldown/spell/shapeshift/minor_illusion,
		/datum/action/cooldown/spell/conjure_item/fire,
		/datum/action/cooldown/spell/conjure_item/water,
	)

/obj/item/bitrunning_disk/item/tier0
	name = "bitrunning gear: trinket"
	selectable_items = list(
		/obj/item/binoculars,
		/obj/item/stack/marker_beacon/thirty,
		/obj/item/storage/belt/military/snack/full,
		/obj/item/dice/d20,
		/obj/item/storage/pouch/medical/firstaid/stabilizer,
		/obj/item/storage/pouch/cin_medkit,
	)

/obj/item/bitrunning_disk/prefs
	name = "\improper DeForest biological simulation disk"
	desc = "A disk containing the biological simulation data necessary to load custom characters into bitrunning domains."
	icon = 'icons/obj/devices/circuitry_n_data.dmi'
	base_icon_state = "datadisk"
	icon_state = "datadisk0"

	w_class = WEIGHT_CLASS_SMALL

	var/datum/preferences/loaded_preference

	var/include_loadout = FALSE

/obj/item/bitrunning_disk/prefs/examine(mob/user)
	. = ..()
	if(!isnull(loaded_preference))
		var/name = loaded_preference.read_preference(/datum/preference/name/real_name)
		. += "It currently has the character [name] loaded, with loadouts [(include_loadout ? "enabled" : "disabled")]"
		. += span_notice("Alt-Click to change loadout loading")

/obj/item/bitrunning_disk/prefs/click_alt(mob/user)
	if(isnull(loaded_preference))
		return CLICK_ACTION_BLOCKING
	include_loadout = !include_loadout // We just switch this around. Elegant!
	balloon_alert(user, include_loadout ? "Loadout enabled" : "Loadout disabled")
	return CLICK_ACTION_SUCCESS

/obj/item/bitrunning_disk/prefs/attack_self(mob/user, modifiers)
	. = ..()

	var/list/prefdata_names = user.client.prefs?.create_character_profiles()
	if(isnull(prefdata_names))
		return

	var/response = tgui_alert(user, message = "Change selected prefs?", title = "Prefchange", buttons = list("Yes", "No"))
	if(isnull(response) || response == "No")
		return
	var/choice = tgui_input_list(user, message = "Select a character",  title = "Character selection", items = prefdata_names)
	if(isnull(choice) || !user.is_holding(src))
		return

	loaded_preference = new(user.client)
	loaded_preference.load_character(prefdata_names.Find(choice))

	balloon_alert(user, "character set!")
	to_chat(user, span_notice("Character set to [choice] sucessfully!"))

/datum/orderable_item/bitrunning_tech/ability_tier0
	cost_per_order = 350
	item_path = /obj/item/bitrunning_disk/ability/tier0
	desc = "This disk contains a program that lets you cast Minor Illusion, Conjure Presents!, Produce Flame, or Produce Water."

/datum/orderable_item/bitrunning_tech/item_tier0
	cost_per_order = 350
	item_path = /obj/item/bitrunning_disk/item/tier0
	desc = "This disk contains a program that lets you equip a pair of binoculars, thirty marker beacons, a snack rig, a D20, a stabilizer pouch, or an empty colonial first-aid pouch."

/obj/item/bitrunning_disk/item/tier1/Initialize(mapload)
	. = ..()
	selectable_items += list(
		/obj/item/storage/belt/military,
	)

/obj/item/bitrunning_disk/item/tier2/Initialize(mapload)
	. = ..()
	selectable_items -= list(
		/obj/item/gun/ballistic/automatic/pistol,
	)
	selectable_items += list(
		/obj/item/storage/toolbox/guncase/clandestine,
		/obj/item/autosurgeon/syndicate/hackerman,
		/obj/item/clothing/head/helmet,
		/obj/item/melee/energy/sword/saber/blue,
		/obj/item/storage/medkit/expeditionary/surplus,
	)

/obj/item/bitrunning_disk/item/tier3/Initialize(mapload)
	. = ..()
	selectable_items -= list(
		/obj/item/gun/energy/e_gun/nuclear,
	)
	selectable_items += list(
		/obj/item/autosurgeon/syndicate/nodrop,
		/obj/item/gun/energy/modular_laser_rifle,
		/obj/item/gun/energy/laser/thermal,
		/obj/item/minigunpack,
	)

/obj/item/bitrunning_disk/ability/tier1/Initialize(mapload)
	. = ..()
	selectable_actions += list(
		/datum/action/cooldown/spell/touch/lay_on_hands,
		/datum/action/cooldown/spell/conjure/flare,
	)

/obj/item/bitrunning_disk/ability/tier2/Initialize(mapload)
	. = ..()
	selectable_actions += list(
		/datum/action/cooldown/adrenaline,
		/datum/action/cooldown/spell/charge,
		/datum/action/cooldown/mob_cooldown/dash,
		/datum/action/cooldown/spell/touch/scream_for_me,
	)

/obj/item/bitrunning_disk/ability/tier3/Initialize(mapload)
	. = ..()
	selectable_actions += list(
		/datum/action/cooldown/spell/shapeshift/juggernaut,
		/datum/action/cooldown/spell/shapeshift/wraith,
		/datum/action/cooldown/spell/death_loop,
	)

/datum/orderable_item/bitrunning_tech/item_tier1
	desc = "This disk contains a program that lets you equip a medical beamgun, a C4 explosive, a box of infinite pizza, or a military webbing."

/datum/orderable_item/bitrunning_tech/item_tier2
	desc = "This disk contains a program that lets you equip a luxury medipen, a pistol case, an armour vest, a helmet, an energy sword, an expeditionary medkit, or a hacker implant."

/datum/orderable_item/bitrunning_tech/item_tier3
	desc = "This disk contains a program that lets you equip a Hyeseong laser rifle, a laser minigun pack, a nanite pistol, a dual bladed energy sword, a minibomb, or an anti-drop implanter."

/datum/orderable_item/bitrunning_tech/ability_tier1
	desc = "This disk contains a program that lets you cast Summon Cheese, Summon Light Source, Lesser Heal, or Mending Touch."

/datum/orderable_item/bitrunning_tech/ability_tier2
	desc = "This disk contains a program that lets you cast Fireball, Lightning Bolt, Scream For Me, Forcewall, Adrenaline Rush, Dash, or Charge Item."

/datum/orderable_item/bitrunning_tech/ability_tier3
	desc = "This disk contains a program that lets you shapeshift into a lesser ashdrake, a polar bear, a holy juggernaut, or a holy wraith; or cast Death Loop."

/datum/orderable_item/bitrunning_tech/pref_item
	cost_per_order = 500
	item_path = /obj/item/bitrunning_disk/prefs
	desc = "This disk contains a program that lets you load in custom characters."
