// Gum
/obj/item/food/chempouch
	name = "chem pouch"
	desc = "A soft cellulose pouch for transmucosal absorbtion. This one looks empty."
	icon_state = "bubblegum"
	inhand_icon_state = null
	color = "#E48AB5" // craftable custom gums someday?
	food_reagents = list(/datum/reagent/consumable/sugar = 5)
	tastes = list("candy" = 1)
	food_flags = FOOD_FINGER_FOOD
	slot_flags = ITEM_SLOT_MASK
	w_class = WEIGHT_CLASS_TINY

/obj/item/food/nicpouch/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/chewable)

/obj/item/food/bubblegum/nicotine
	name = "nicotine gum"
	food_reagents = list(
		/datum/reagent/drug/nicotine = 10,
		/datum/reagent/consumable/menthol = 5,
	)
	tastes = list("mint" = 1)
	color = "#60A584"

/obj/item/food/bubblegum/happiness
	name = "\improper HP+ gum"
	desc = "A rubbery strip of gum. It smells funny."
	food_reagents = list(/datum/reagent/drug/happiness = 15)
	tastes = list("paint thinner" = 1)
	color = "#EE35FF"

//misc food
/obj/item/food/bubblegum/wake_up
	name = "wake-up gum"
	desc = "A rubbery strip of gum. It's stamped with the emblem of the Mothic Nomad Fleet."
	food_reagents = list(
		/datum/reagent/consumable/sugar = 13,
		/datum/reagent/drug/methamphetamine = 2,
	)
	tastes = list("herbs" = 1)
	color = "#567D46"
