/obj/item/food/canned/tuna
	name = "can of tuna"
	desc = "You can tune a piano, but you can't tuna fish."
	icon = 'modular_nova/master_files/icons/obj/food/irnbru.dmi'
	icon_state = "tunacan"
	trash_type = /obj/item/trash/can/food/tuna
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 9,
		/datum/reagent/consumable/nutriment/vitamin = 6
	)
	tastes = list("tuna" = 1)
	foodtypes = SEAFOOD

/obj/item/trash/can/food/tuna
	name = "can of tuna"
	icon = 'modular_nova/master_files/icons/obj/food/irnbru.dmi'
	icon_state = "tunacan_empty"

/obj/item/food/fishmeat/moonfish/human
	name = "aquatic fillet"
	desc = "A fillet of a rather large fish..."
	tastes = list("tender fish" = 1)
	foodtypes = SEAFOOD | GORE
	venue_value = FOOD_MEAT_HUMAN

/obj/item/food/meat/slab/chicken/vox
	name = "meat"
	tastes = list("tender meat" = 1)
	foodtypes = MEAT | RAW | GORE
	venue_value = FOOD_MEAT_HUMAN

/obj/item/food/meat/slab/chicken/vox/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/steak/chicken/vox, rand(30 SECONDS, 90 SECONDS), TRUE, TRUE)

/obj/item/food/meat/steak/chicken/vox/on_microwave_cooked(datum/source, atom/source_item, cooking_efficiency = 1)
	. = ..()
	if(!istype(source_item, /obj/item/food/meat))
		return

	var/obj/item/food/meat/origin_meat = source_item
	subjectname = origin_meat.subjectname
	subjectjob = origin_meat.subjectjob
	if(subjectname)
		name = "[origin_meat.subjectname] meatsteak"
	else if(subjectjob)
		name = "[origin_meat.subjectjob] meatsteak"

/obj/item/food/meat/slab/chicken/vox/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE,  /obj/item/food/meat/rawcutlet/chicken/vox, 3, 3 SECONDS, table_required = TRUE, screentip_verb = "Cut")

/obj/item/food/meat/steak/chicken/vox
	tastes = list("tender meat" = 1)
	foodtypes = MEAT | GORE

/obj/item/food/meat/rawcutlet/chicken/vox
	tastes = list("tender meat" = 1)
	foodtypes = MEAT | RAW | GORE

/obj/item/food/meat/cutlet/chicken/vox
	tastes = list("tender meat" = 1)
	foodtypes = MEAT | GORE

/obj/item/food/meat/cutlet/chicken/human/on_microwave_cooked(datum/source, atom/source_item, cooking_efficiency)
	. = ..()
	if(!istype(source_item, /obj/item/food/meat))
		return

	var/obj/item/food/meat/origin_meat = source_item
	if(subjectname)
		name = "[origin_meat.subjectname] [initial(name)]"
	else if(subjectjob)
		name = "[origin_meat.subjectjob] [initial(name)]"

/obj/item/food/raw_meatball/chicken/vox
	name = "strange raw chicken meatball"
	meatball_type = /obj/item/food/meatball/chicken/vox
	patty_type = /obj/item/food/raw_patty/chicken/vox

/obj/item/food/meatball/chicken/vox
	name = "strange chicken meatball"

/obj/item/food/raw_patty/chicken/vox
	name = "strange raw chicken patty"
	patty_type = /obj/item/food/patty/vox/chicken

/obj/item/food/patty/vox/chicken
	name = "strange chicken patty"
	tastes = list("chikun" = 1)
	icon_state = "chicken_patty"

/datum/food_processor_process/meat/chicken
	blacklist = list(/obj/item/food/meat/slab/chicken/vox)

/datum/food_processor_process/meat/chicken/vox
	input = /obj/item/food/meat/slab/chicken/vox
	output = /obj/item/food/raw_meatball/chicken/vox
	blacklist = null

/obj/item/food/fried_vox
	name = "kingulliq fried vox"
	desc = "A juicy hunk of 'chicken' meat, fried to perfection."
	icon = 'modular_nova/master_files/icons/obj/food/irnbru.dmi'
	icon_state = "fried_vox"
	food_reagents = list(/datum/reagent/consumable/nutriment/protein = 6, /datum/reagent/consumable/nutriment/vitamin = 2)
	tastes = list("chicken" = 3, "fried batter" = 1)
	trash_type = /obj/item/clothing/head/hats/fried_tesh
	foodtypes = MEAT | FRIED | GORE
	junkiness = 25
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = SHEET_MATERIAL_AMOUNT * 4, /datum/material/cardboard = SHEET_MATERIAL_AMOUNT)
