/obj/item/bitrunning_disk
	w_class = WEIGHT_CLASS_SMALL

/obj/item/bitrunning_disk/ability/tier0
	name = "bitrunning program: cantrip"
	selectable_actions = list(
		/datum/action/cooldown/spell/shapeshift/minor_illusion,
		/datum/action/cooldown/spell/conjure_item/fire,
		/datum/action/cooldown/spell/conjure_item/water,
		/datum/action/cooldown/spell/conjure/cheese,
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
		/obj/item/storage/medkit/robotic_repair/preemo/stocked,
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
	purchase_path = /obj/item/bitrunning_disk/ability/tier0
	desc = "This disk contains a program that lets you cast Minor Illusion, Summon Cheese, Produce Flame, or Produce Water."

/datum/orderable_item/bitrunning_tech/item_tier0
	cost_per_order = 350
	purchase_path = /obj/item/bitrunning_disk/item/tier0
	desc = "This disk contains a program that lets you equip a pair of binoculars, thirty marker beacons, a snack rig, a D20, a stabilizer pouch, a robotic repair kit, or an empty colonial first-aid pouch."

/obj/item/bitrunning_disk/item/tierlewd
	name = "bitrunning gear: relaxation"
	selectable_items = list(
		/obj/item/summon_beacon/lustwish,
		/obj/item/storage/box/nif_ghost_box,
		/obj/item/storage/box/syndie_kit/chameleon/ghostcafe,
		/obj/item/survivalcapsule/luxury,
	)

/obj/item/summon_beacon/lustwish
	name = "relaxation machine beacon"
	icon_state = "sb_delivery"
	desc = "Once a vending machine is selected, delivers it to the target location."

	allowed_areas = list(
		/area/virtual_domain,
		/area/space/virtual_domain,
		/area/ruin/space/virtual_domain,
		/area/icemoon/underground/explored/virtual_domain,
		/area/lavaland/surface/outdoors/virtual_domain,
	)

	selectable_atoms = list(
		/obj/machinery/vending/dorms/bitrunning,
	)

	area_string = "virtual domains"
	supply_pod_stay = FALSE

/obj/machinery/vending/dorms/bitrunning/Initialize(mapload)
	. = ..()
	all_products_free = TRUE
	onstation = FALSE

/datum/orderable_item/bitrunning_tech/item_tierlewd
	cost_per_order = 250
	purchase_path = /obj/item/bitrunning_disk/item/tierlewd
	desc = "This disk contains a program that lets you equip a LustWish vending machine delivery beacon, a quick-booting NIF package, a luxury survival capsule, or a set of chameleon clothing."

/obj/item/bitrunning_disk/item/tier1/Initialize(mapload)
	. = ..()
	selectable_items += list(
		/obj/item/storage/belt/military,
		/obj/item/book_of_babel,
		/obj/item/storage/toolbox/syndicate,
		/obj/item/knife/combat,
	)

/obj/item/bitrunning_disk/item/tier2/Initialize(mapload)
	. = ..()
	selectable_items -= list(
		/obj/item/gun/ballistic/automatic/pistol,
	)
	selectable_items += list(
		/obj/item/storage/toolbox/guncase/clandestine,
		/obj/item/storage/toolbox/guncase/wt550,
		/obj/item/autosurgeon/syndicate/hackerman/bitrunning,
		/obj/item/clothing/head/helmet,
		/obj/item/melee/energy/sword/saber/blue,
		/obj/item/storage/medkit/expeditionary/surplus,
		/obj/item/katana,
		/obj/item/shield/riot/tele,
		/obj/item/gun/energy/modular_laser_rifle/carbine,
		/obj/item/syndicate_contacts,
	)

/obj/item/autosurgeon/syndicate/hackerman/bitrunning
	name = "hacking arm implanter"

/obj/item/bitrunning_disk/item/tier3/Initialize(mapload)
	. = ..()
	selectable_items -= list(
		/obj/item/gun/energy/e_gun/nuclear,
	)
	selectable_items += list(
		/obj/item/domain_anchor,
		/obj/item/autosurgeon/syndicate/nodrop/bitrunning,
		/obj/item/gun/energy/modular_laser_rifle,
		/obj/item/storage/belt/holster/energy/nanite,
		/obj/item/minigunpack,
	)

/obj/item/autosurgeon/syndicate/nodrop/bitrunning
	name = "anti-drop implanter"

/obj/item/bitrunning_disk/ability/tier1/Initialize(mapload)
	. = ..()
	selectable_actions += list(
		/datum/action/cooldown/spell/touch/lay_on_hands,
		/datum/action/cooldown/spell/conjure/flare,
	)
	selectable_actions -= list(
		/datum/action/cooldown/spell/conjure/cheese,
	)

/obj/item/bitrunning_disk/ability/tier2/Initialize(mapload)
	. = ..()
	selectable_actions += list(
		/datum/action/cooldown/adrenaline,
		/datum/action/cooldown/spell/charge,
		/datum/action/cooldown/mob_cooldown/dash,
		/datum/action/cooldown/spell/teleport/radius_turf/blink/bitrunning,
		/datum/action/cooldown/spell/sanguine_strike,
		/datum/action/cooldown/spell/tap/bitrunning,
		/datum/action/cooldown/spell/summonitem,
	)

/datum/action/cooldown/spell/tap/bitrunning
	name = "Data Tap"
	desc = "Resets all spell cooldowns but weakens your connection, lowering your avatar's max health when used."
	spell_requirements = SPELL_REQUIRES_NO_ANTIMAGIC

/datum/action/cooldown/spell/teleport/radius_turf/blink/bitrunning
	name = "Corrupt Position"
	spell_requirements = SPELL_REQUIRES_NO_ANTIMAGIC
	invocation = "CEE'OCEE TEH-HALL!" // coc testinghall
	desc = "Randomly teleports you a short distance. May prove unreliable in cramped areas or near domain limits."

/datum/action/cooldown/spell/chuuni_invocations/bitrunning
	name = "Slice of Life Data Torrent"
	spell_requirements = SPELL_REQUIRES_NO_ANTIMAGIC

/obj/item/bitrunning_disk/ability/tier3/Initialize(mapload)
	. = ..()
	selectable_actions += list(
		/datum/action/cooldown/spell/shapeshift/juggernaut,
		/datum/action/cooldown/spell/shapeshift/wraith,
		/datum/action/cooldown/spell/death_loop,
		/datum/action/cooldown/spell/chuuni_invocations/bitrunning,
	)

/obj/item/storage/belt/holster/energy/nanite
	name = "nanite pistol shoulder holsters"
	desc = "A rather plain pair of shoulder holsters with a bit of padding inside. Meant to hold a twinned pair of nanite pistols, but can fit several kinds of energy handguns as well."

/obj/item/storage/belt/holster/energy/nanite/PopulateContents()
	generate_items_inside(list(
		/obj/item/gun/energy/laser/thermal = 2,
	),src)

/datum/orderable_item/bitrunning_tech/item_tier1
	desc = "This disk contains a program that lets you equip a medical beamgun, a C4 explosive, a box of infinite pizza, a tactical toolbox, a combat knife, or a military webbing."

/datum/orderable_item/bitrunning_tech/item_tier2
	desc = "This disk contains a program that lets you equip a luxury medipen, a pistol case, a rifle case, an armour vest, a helmet, an energy sword, a katana, a modular laser carbine, an expeditionary medkit, a ballistic shield, flashproof contacts, or a hacker implant."

/datum/orderable_item/bitrunning_tech/item_tier3
	desc = "This disk contains a program that lets you equip a domain connection anchor, Hyeseong laser rifle, a laser minigun pack, a nanite pistol holster, a dual bladed energy sword, a minibomb, or an anti-drop implanter."

/datum/orderable_item/bitrunning_tech/ability_tier1
	desc = "This disk contains a program that lets you cast Summon Light Source, Lesser Heal, or Mending Touch."

/datum/orderable_item/bitrunning_tech/ability_tier2
	desc = "This disk contains a program that lets you cast Fireball, Lightning Bolt, Sanguine Strike, Forcewall, Adrenaline Rush, Dash, Blink, Data Tap, Instant Summons, or Charge Item."

/datum/orderable_item/bitrunning_tech/ability_tier3
	desc = "This disk contains a program that lets you shapeshift into a lesser ashdrake, a polar bear, a holy juggernaut, or a holy wraith; or learn Death Loop or Chuuni Invocations."

/datum/orderable_item/bitrunning_tech/pref_item
	cost_per_order = 500
	purchase_path = /obj/item/bitrunning_disk/prefs
	desc = "This disk contains a program that lets you load in custom characters."
