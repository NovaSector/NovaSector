
// blood is in code/modules/reagents/chemistry/reagents/other_reagents.dm
/datum/reagent/blood/get_taste_description(mob/living/taster)
	if(isnull(taster) || !HAS_TRAIT(taster, TRAIT_DRINKS_BLOOD))
		return ..()
	var/blood_taste_text = "[name]. The blood type is [data["blood_type"]]. The blood did [data["monkey_origins"] ? "":"not "]originate from a monkey. The owner of the blood is [data["mind"] == null ? "not":""] sentient"

	// [ ? "":""]
	var/list/Q = data["quirks"]
	blood_taste_text += "[Q.Find(/datum/quirk/item_quirk/addict/alcoholic) || Q.Find(/datum/quirk/drunkhealing) || Q.Find(/datum/quirk/alcohol_tolerance) ? ". They seem to be an alcoholic":""]"

	blood_taste_text += "[Q.Find(/datum/quirk/blooddeficiency) ? ". They are blood deficient":""]"

	blood_taste_text += "[Q.Find(/datum/quirk/item_quirk/allergic) || Q.Find(/datum/quirk/item_quirk/food_allergic) ? ". They have some sort of an alergy":""]"

	blood_taste_text += "[Q.Find(/datum/quirk/insanity) || Q.Find(/datum/quirk/item_quirk/addict/junkie) ? ". Their mind seems to be altered by something":""]"

	blood_taste_text += "[Q.Find(/datum/quirk/item_quirk/addict/alcoholic) || Q.Find(/datum/quirk/item_quirk/addict/junkie) ? ". They seem to be addicted to something":""]"

	return list("[blood_taste_text]" = 1)


