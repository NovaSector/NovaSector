// ORE BOX REINFORCEMENT KIT
/obj/item/ore_box_reinforcement
	name = "ore box reinforcement kit"
	desc = "A case containing reinforced thermally-resistant plastic parts for standard wooden ore boxes used across the universe. \
		Contains all the parts and proprietary tools required to make an ore box significantly less prone to combustion-based disassembly."
	// I'm lazy so we're just reusing the crusher kit sprites.
	icon = 'modular_nova/modules/mining_crushers/icons/crusher_conversion_kit.dmi'
	icon_state = "crusher_kit"
	lefthand_file = 'modular_nova/modules/mining_crushers/icons/kit_lefthand.dmi'
	righthand_file = 'modular_nova/modules/mining_crushers/icons/kit_righthand.dmi'
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2, /datum/material/plastic = SHEET_MATERIAL_AMOUNT * 4)
	w_class = WEIGHT_CLASS_BULKY

/obj/item/ore_box_reinforcement/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!istype(interacting_with, /obj/structure/ore_box))
		return NONE

	var/obj/structure/ore_box/our_box = interacting_with
	if(length(our_box.contents))
		balloon_alert(user, "empty ore box first!")
		return NONE

	playsound(src, 'sound/items/tools/drill_use.ogg', 80, TRUE, -1)
	var/obj/structure/ore_box/reinforced/new_box = new(get_turf(our_box))
	var/mob/being_pulled_by = our_box.pulledby
	being_pulled_by?.start_pulling(new_box)
	qdel(our_box)
	. = ITEM_INTERACT_SUCCESS
	qdel(src)

// REINFORCED ORE BOX
/obj/structure/ore_box/reinforced
	icon = 'modular_nova/modules/ore_box_reinforcement/icons/ore_box.dmi'
	icon_state = "orebox_plastic"
	name = "reinforced ore box"
	desc = "A heavy box, reinforced with high-performance thermoplastics, which can be filled with a lot of ores or boulders. \
		Unfortunately, the reinforcement is prone to shattering upon disassembly."
	max_integrity = 350 // +50 integrity
	resistance_flags = LAVA_PROOF | FIRE_PROOF
	custom_materials = list(/datum/material/wood = SHEET_MATERIAL_AMOUNT * 4, /datum/material/plastic = SHEET_MATERIAL_AMOUNT * 4)
