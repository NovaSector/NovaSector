/obj/item/reagent_containers/hypospray/medipen/deforest/occuisate/examine()
	. = ..()
	. += span_notice("Heals <b>eyes</b> and <b>ears</b>.")
	return .

/obj/item/reagent_containers/hypospray/medipen/deforest/adrenaline
	list_reagents = list(
		/datum/reagent/medicine/synaptizine = 5,
		/datum/reagent/medicine/inaprovaline = 5,
		/datum/reagent/determination = 10,
		/datum/reagent/toxin/lipolicide = 5,
	)

/obj/item/reagent_containers/hypospray/medipen/deforest/adrenaline/examine()
	. = ..()
	. += span_notice("Heals <b>stamina damage</b>, <b>critical conditions</b>, and makes you <b>lock in</b>.")
	return .

/obj/item/reagent_containers/hypospray/medipen/deforest/morpital
	list_reagents = list(
		/datum/reagent/medicine/mine_salve = 5,
		/datum/reagent/medicine/omnizine = 15,
		/datum/reagent/toxin/lipolicide = 5,
	)

/obj/item/reagent_containers/hypospray/medipen/deforest/morpital/examine()
	. = ..()
	. += span_notice("Heals <b>all damage types</b>.")
	return .

/obj/item/reagent_containers/hypospray/medipen/deforest/lipital
	list_reagents = list(
		/datum/reagent/medicine/lidocaine = 5,
		/datum/reagent/medicine/omnizine = 5,
		/datum/reagent/medicine/c2/libital = 10,
	)

/obj/item/reagent_containers/hypospray/medipen/deforest/lipital/examine()
	. = ..()
	. += span_notice("Heals <b>brute damage</b>.")
	return .

/obj/item/reagent_containers/hypospray/medipen/deforest/meridine
	list_reagents = list(
		/datum/reagent/medicine/c2/multiver = 10,
		/datum/reagent/medicine/potass_iodide = 10,
		/datum/reagent/toxin/lipolicide = 5,
	)

/obj/item/reagent_containers/hypospray/medipen/deforest/meridine/examine()
	. = ..()
	. += span_notice("Heals <b>toxin damage</b>.")
	return .

/obj/item/reagent_containers/hypospray/medipen/deforest/synephrine/examine()
	. = ..()
	. += span_notice("Heals <b>critical conditions</b> and <b>stamina damage</b>.")
	return .

/obj/item/reagent_containers/hypospray/medipen/deforest/calopine
	list_reagents = list(
		/datum/reagent/medicine/atropine = 10,
		/datum/reagent/medicine/coagulant/fabricated = 5,
		/datum/reagent/medicine/salbutamol = 5,
		/datum/reagent/toxin/lipolicide = 5,
	)

/obj/item/reagent_containers/hypospray/medipen/deforest/calopine/examine()
	. = ..()
	. += span_notice("Heals <b>critical conditions</b> and <b>bleeding</b>.")
	return .

/obj/item/reagent_containers/hypospray/medipen/deforest/coagulants/examine()
	. = ..()
	. += span_notice("Heals <b>bleeding</b>.")
	return .

/obj/item/reagent_containers/hypospray/medipen/deforest/krotozine/examine()
	. = ..()
	. += span_notice("Heals <b>all damage types</b> and <b>lowers action delay</b>.")
	return .

/obj/item/reagent_containers/hypospray/medipen/deforest/lepoturi
	list_reagents = list(
		/datum/reagent/medicine/mine_salve = 5,
		/datum/reagent/medicine/leporazine = 5,
		/datum/reagent/medicine/c2/lenturi = 10,
		/datum/reagent/toxin/lipolicide = 5,
	)

/obj/item/reagent_containers/hypospray/medipen/deforest/lepoturi/examine()
	. = ..()
	. += span_notice("Heals <b>burn damage</b> and <b>stabilizes temperature</b>.")
	return .

/obj/item/reagent_containers/hypospray/medipen/deforest/psifinil/examine()
	. = ..()
	. += span_notice("Heals <b>drowsiness</b>, <b>insanity</b>, and <b>dizziness</b>.")
	return .

/obj/item/reagent_containers/hypospray/medipen/deforest/halobinin/examine()
	. = ..()
	. += span_notice("Heals <b>overdoses</b> and <b>poisoning</b>.")
	return .

/obj/item/reagent_containers/hypospray/medipen/deforest/aranepaine/examine()
	. = ..()
	. += span_notice("Heals <b>stamina damage</b> and <b>lowers action delay</b>.")
	return .

/obj/item/reagent_containers/hypospray/medipen/deforest/pentibinin
	volume = 30
	list_reagents = list(
		/datum/reagent/medicine/c2/penthrite = 5,
		/datum/reagent/medicine/polypyr = 10,
		/datum/reagent/medicine/silibinin = 5,
		/datum/reagent/medicine/omnizine = 10,
	)

/obj/item/reagent_containers/hypospray/medipen/deforest/pentibinin/examine()
	. = ..()
	. += span_notice("Heals <b>everything</b>.")
	return .

/obj/item/reagent_containers/hypospray/medipen/deforest/synalvipitol/examine()
	. = ..()
	. += span_notice("Heals <b>stamina damage</b> and makes you <b>immune to stuns</b>.")
	return .

// Super emergency drug cocktail two-use injector

/obj/item/reagent_containers/hypospray/medipen/deforest/captagon
	name = "'Sector 9 Special' emergency autoinjector"
	desc = "A two-use autoinjector filled with an outright insane cocktail of chemicals to allow any Gakster on the planet to go, 'Nah, I'd win'."
	icon = 'modular_np_lethal/medical_stuff/icons/medpens.dmi'
	icon_state = "captagon"
	base_icon_state = "captagon"
	volume = 140
	amount_per_transfer_from_this = 70
	list_reagents = list(
		/datum/reagent/drug/demoneye = 20,
		/datum/reagent/drug/kronkaine = 20,
		/datum/reagent/drug/pumpup = 20,
		/datum/reagent/medicine/c2/penthrite = 20,
		/datum/reagent/medicine/mine_salve = 20,
		/datum/reagent/medicine/muscle_stimulant = 20,
		/datum/reagent/impurity = 20,
	)

/obj/item/reagent_containers/hypospray/medipen/deforest/captagon/update_icon_state()
	. = ..()
	if(reagents.total_volume >= volume)
		icon_state = base_icon_state
		return
	icon_state = "[base_icon_state][(reagents.total_volume > 0) ? 1 : 0]"
