/obj/item/machete
	name = "surplus machete"
	icon = 'modular_nova/modules/mauling_melees/icons/objects.dmi'
	icon_state = "machete"
	lefthand_file = 'modular_nova/modules/mauling_melees/icons/lefthands.dmi'
	righthand_file = 'modular_nova/modules/mauling_melees/icons/righthands.dmi'
	inhand_icon_state = "machete"
	desc = "An nondescript machete with a rubberized, non-conductive handle. Could be from some old military surplus, or from a recent stockpile, or anywhere in between. \
	Good for hacking away at things, like plants, people, or plantpeople."
	obj_flags = NONE
	force = 20
	w_class = WEIGHT_CLASS_BULKY
	throwforce = 10
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	throw_speed = 1
	throw_range = 5
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 6)
	attack_verb_continuous = list("slashes", "slices", "tears", "lacerates", "rips", "dices", "cuts")
	attack_verb_simple = list("slash", "slice", "tear", "lacerate", "rip", "dice", "cut")
	sharpness = SHARP_EDGED
	armor_type = /datum/armor/item_knife
	wound_bonus = 10
	bare_wound_bonus = 20
	tool_behaviour = TOOL_KNIFE
	/*
	20 force, 10 wb, 20 bwb = 30, 50 against bare skin
	compare/contrast force/wound bonuses with the captain's sabre, i guess
	which at time of writing is 20 force 5 wb 20 bwb = 25, 45 against bare skin, BUT has 75 AP/50 melee-only blockchance
	the shamshir also has the same damage/wound stats but "only" 25 AP/20 blockchance
	*/

/obj/item/machete/Initialize(mapload)
	. = ..()
	// not great for butchering. kind of unwieldy for doing so
	AddComponent(/datum/component/butchering, \
	speed = 6 SECONDS, \
	effectiveness = 80, \
	bonus_modifier = force - 10, \
	)
	// but it's good for murdering plantpeople
	AddElement(/datum/element/bane, mob_biotypes = MOB_PLANT, damage_multiplier = 0.5, requires_combat_mode = FALSE)
	// Kill.
	AddElement(/datum/element/mauling)

/obj/item/machete/afterattack(atom/target, mob/user, click_parameters)
	. = ..()
	if(target.resistance_flags & INDESTRUCTIBLE)
		return
	if(istype(target, /obj/structure/flora))
		var/obj/structure/flora/flora_target = target
		if(!(flora_target.flora_flags & FLORA_HERBAL) && !(flora_target.flora_flags & FLORA_WOODEN))
			return
		target.take_damage(force) // simulate taking double damage

#define MACHETE_BACK 0
#define MACHETE_WAIST 1
#define MACHETE_LEG 2
/obj/item/storage/belt/machete
	name = "surplus machete scabbard"
	desc = "A large synthetic-leather scabbard used to carry some kind of machete. A compact set of buckles suggests the ability to be strapped to the back, waist, or some kinds of armor."
	icon = 'modular_nova/modules/mauling_melees/icons/objects.dmi'
	worn_icon = 'modular_nova/modules/mauling_melees/icons/back.dmi'
	lefthand_file = 'modular_nova/modules/mauling_melees/icons/lefthands.dmi'
	righthand_file = 'modular_nova/modules/mauling_melees/icons/righthands.dmi'
	icon_state = "msheath"
	inhand_icon_state = "msheath"
	worn_icon_state = "msheath"
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_BACK | ITEM_SLOT_SUITSTORE
	storage_type = /datum/storage/machete_belt
	/// Used for deciding the worn icon_state variant, using defines for MACHETE_BACK, MACHETE_WAIST, MACHETE_LEG.
	var/worn_variant = MACHETE_BACK

/datum/storage/machete_belt
	max_slots = 1
	// not a rifle but this is the sound tgmc uses
	rustle_sound = 'modular_nova/modules/mauling_melees/sounds/rifle_draw.ogg'
	max_specific_storage = WEIGHT_CLASS_BULKY
	click_alt_open = FALSE

/datum/storage/machete_belt/New(atom/parent, max_slots, max_specific_storage, max_total_storage)
	. = ..()
	set_holdable(/obj/item/machete)

/obj/item/storage/belt/machete/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)

/obj/item/storage/belt/machete/examine(mob/user)
	. = ..()
	if(length(contents))
		. += span_notice("Alt-click it to quickly draw the blade.")

/obj/item/storage/belt/machete/click_alt(mob/user)
	for(var/obj/item/machete/machete in contents)
		user.visible_message(span_notice("[user] takes [machete] out of [src]."), span_notice("You take [machete] out of [src]."))
		machete.remove_item_from_storage(user)
		user.put_in_hands(machete)
		update_appearance()
		return CLICK_ACTION_SUCCESS
	balloon_alert(user, "it's empty!")

/obj/item/storage/belt/machete/update_icon_state()
	icon_state = initial(icon_state)
	inhand_icon_state = initial(inhand_icon_state)
	worn_icon_state = initial(worn_icon_state)
	worn_icon_state += "[worn_variant]"
	if(contents.len)
		icon_state += "-full"
		inhand_icon_state += "-full"
		worn_icon_state += "-full"
	return ..()

/obj/item/storage/belt/machete/full/PopulateContents()
	new /obj/item/machete(src)
	update_appearance()

/// alt rmb to change wear style
/obj/item/storage/belt/machete/click_alt_secondary(mob/user)
	switch(worn_variant)
		if (MACHETE_BACK)
			worn_variant = MACHETE_WAIST
			to_chat(user, "You adjust [src] to hang sideways behind your back.")
		if (MACHETE_WAIST)
			worn_variant = MACHETE_LEG
			to_chat(user, "You adjust [src] to hang down your leg.")
		if (MACHETE_LEG)
			worn_variant = MACHETE_BACK
			to_chat(user, "You adjust [src] to hang across your back.")
	update_appearance()

#undef MACHETE_BACK
#undef MACHETE_WAIST
#undef MACHETE_LEG

/obj/item/trench_tool/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/mauling)
