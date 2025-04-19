#define QUIRK_HUNGRY_MOD 2

/datum/quirk/hungry
	name = "Hungry"
	desc = "You have an insatiable appetite. In other words, your stomach is bottomless. You will need to eat much more than others to stave off hunger."
	value = -2
	icon = FA_ICON_BOWL_FOOD
	gain_text = span_notice("You feel like your stomach is bottomless.")
	lose_text = span_notice("You no longer feel like your stomach is bottomless.")
	medical_record_text = "Patient experiences hunger much more quickly than normal."
	quirk_flags = QUIRK_HUMAN_ONLY
	mail_goodies = list(
		/obj/item/food/chips,
		/obj/item/paper/paperslip/ration_ticket/luxury,
		/obj/item/paper/paperslip/ration_ticket,
		/obj/item/food/chocolatebar,
		/obj/item/storage/box/spaceman_ration/meats,
		/obj/item/reagent_containers/cup/glass/dry_ramen,
	)

/datum/quirk/hungry/is_species_appropriate(datum/species/mob_species)
	if(TRAIT_NOHUNGER in GLOB.species_prototypes[mob_species].inherent_traits)
		return FALSE
	return ..()

/datum/quirk/hungry/add(client/client_source)
	var/mob/living/carbon/human/human_holder = quirk_holder
	if(istype(human_holder))
		human_holder.physiology.hunger_mod *= QUIRK_HUNGRY_MOD

/datum/quirk/hungry/remove()
	var/mob/living/carbon/human/human_holder = quirk_holder
	if(istype(human_holder))
		human_holder.physiology.hunger_mod /= QUIRK_HUNGRY_MOD

#undef QUIRK_HUNGRY_MOD
