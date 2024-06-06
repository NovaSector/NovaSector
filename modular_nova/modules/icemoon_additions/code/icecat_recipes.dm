/obj/item/anointing_oil
	name = "anointing bloodresin"
	desc = "And so Helgar Knife-Arm spoke to the Hearth, and decreed that all of the Kin who gave name to beasts would do so with conquest and blood."
	icon = 'icons/obj/medical/chemical.dmi'
	icon_state = "potred"
	throwforce = 0
	w_class = WEIGHT_CLASS_TINY

	var/being_used = FALSE

/obj/item/anointing_oil/attack(mob/living/target_mob, mob/living/user, params)
	if (!is_species(user, /datum/species/human/felinid/primitive))
		to_chat(user, span_warning("You have no idea what this disgusting concoction is used for."))
		return
	if(being_used || !ismob(target_mob)) //originally this was going to check if the mob was friendly, but if an icecat wants to name some terror mob while it's tearing chunks out of them, why not?
		return
	if(target_mob.ckey)
		to_chat(user, span_warning("You would never shame a creature so intelligent by not allowing it to choose its own name."))
		return

	if(try_anoint(target_mob, user))
		qdel(src)
	else
		being_used = FALSE

/obj/item/anointing_oil/proc/try_anoint(mob/living/target_mob, mob/living/user)
	being_used = TRUE

	var/new_name = sanitize_name(tgui_input_text(user, "Speak forth this beast's new name for all the Kin to hear.", "Input a name", target_mob.name, MAX_NAME_LEN))

	if(!new_name || QDELETED(src) || QDELETED(target_mob) || new_name == target_mob.name || !target_mob.Adjacent(user))
		being_used = FALSE
		return FALSE

	target_mob.visible_message(span_notice("[user] leans down and smears twinned streaks of glistening bloodresin upon [target_mob], then straightens up with ritual purpose..."))
	user.say("Let the ice know you forevermore as +[new_name]+.")

	user.log_message("used [src] on [target_mob], renaming it to [new_name].", LOG_GAME)

	target_mob.name = new_name

	//give the stupid dog zoomies from getting named
	if(istype(target_mob, /mob/living/basic/mining/wolf))
		target_mob.emote("awoo")
		target_mob.emote("spin")

	return TRUE

/obj/item/anointing_oil/examine(mob/user)
	. = ..()
	if(is_species(user, /datum/species/human/felinid/primitive))
		. += span_info("Using this on the local wildlife will allow you to give them a name.")

/datum/crafting_recipe/anointing_oil
	name = "Anointing Bloodresin"
	category = CAT_MISC
	//recipe given to icecats as part of their spawner/team setting
	crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_MUST_BE_LEARNED

	reqs = list(
		/datum/reagent/consumable/liquidgibs = 80,
		/datum/reagent/blood = 20,
	)

	result = /obj/item/anointing_oil

/obj/item/clothing/suit/armor/handcrafted_hearthkin_armor
	name = "handcrafted hearthkin armor"
	desc = "An armor obviously crafted by the expertise of a hearthkin. It has leather shoulder pads and a chain mail underneath."
	icon_state = "chained_leather_armor"
	icon = 'modular_nova/modules/primitive_catgirls/icons/clothing_greyscale.dmi'
	worn_icon = 'modular_nova/modules/primitive_catgirls/icons/clothing_greyscale.dmi'
	resistance_flags = FIRE_PROOF
	body_parts_covered = GROIN|CHEST
	obj_flags_nova = ANVIL_REPAIR
	armor_type = /datum/armor/armor_forging_plate_armor

/datum/crafting_recipe/handcrafted_hearthkin_armor
	name = "Handcrafted Hearthkin Armor"
	category = CAT_CLOTHING

	//recipe given to icecats as part of their spawner/team setting
	crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_MUST_BE_LEARNED

	reqs = list(
		/obj/item/forging/complete/chain = 4,
		/obj/item/stack/sheet/leather = 2,
	)

	result = /obj/item/clothing/suit/armor/handcrafted_hearthkin_armor

// Hearthkin Exclusive Beds
/obj/structure/bed/double/pelt
	name = "white pelts bed"
	desc = "A luxurious double bed, made with white wolf pelts."
	icon_state = "pelt_bed_white"
	icon = 'modular_nova/modules/tribal_extended/icons/tribal_beds.dmi'
	anchored = TRUE
	can_buckle = TRUE
	buckle_lying = 90
	resistance_flags = FLAMMABLE
	max_integrity = 100
	integrity_failure = 0.35
	max_buckled_mobs = 2
	/// What material this bed is made of
	build_stack_type = /obj/item/stack/sheet/sinew/wolf
	/// How many mats to drop when deconstructed
	build_stack_amount = 4

/obj/structure/bed/double/pelt/atom_deconstruct(disassembled = TRUE)
	. = ..()
	new /obj/item/stack/sheet/mineral/wood(loc, build_stack_amount)

/datum/crafting_recipe/white_pelt_bed
	name = "White Pelts Bed"
	category = CAT_FURNITURE
	//recipe given to icecats as part of their spawner/team setting
	crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_MUST_BE_LEARNED | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND

	reqs = list(
		/obj/item/stack/sheet/sinew/wolf = 4,
		/obj/item/stack/sheet/mineral/wood = 4,
	)

	result = /obj/structure/bed/double/pelt

/obj/structure/bed/double/pelt/black
	name = "black pelts bed"
	desc = "A luxurious double bed, made with black wolf pelts."
	icon_state = "pelt_bed_black"
	icon = 'modular_nova/modules/tribal_extended/icons/tribal_beds.dmi'

/datum/crafting_recipe/black_pelt_bed
	name = "Black Pelts Bed"
	category = CAT_FURNITURE
	//recipe given to icecats as part of their spawner/team setting
	crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_MUST_BE_LEARNED | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND

	reqs = list(
		/obj/item/stack/sheet/sinew/wolf = 4,
		/obj/item/stack/sheet/mineral/wood = 4,
	)

	result = /obj/structure/bed/double/pelt/black
