
/// You may be asking why we need copies of /datum/bounty/reagent, its because the main system is looking for SUBTYPES of reagent, and I want to avoid the system accidentally giving NT, Interdyne bounties.

/datum/bounty/interdyne_reagent
	/// How much of a reagent is needed complete the bounty.
	var/required_volume = 10
	/// How much the player has shipped in the bounty.
	var/shipped_volume = 0
	/// Which reagent is required for the bounty's completion.
	var/datum/reagent/wanted_reagent

/datum/bounty/interdyne_reagent/can_claim()
	return ..() && shipped_volume >= required_volume

/datum/bounty/interdyne_reagent/applies_to(obj/shipped)
	if(!is_reagent_container(shipped))
		return FALSE
	if(!shipped.reagents || !shipped.reagents.has_reagent(wanted_reagent.type))
		return FALSE
	if(shipped.flags_1 & HOLOGRAM_1)
		return FALSE
	return shipped_volume < required_volume

/datum/bounty/interdyne_reagent/ship(obj/shipped)
	if(!applies_to(shipped))
		return FALSE
	shipped_volume += shipped.reagents.get_reagent_amount(wanted_reagent.type)
	if(shipped_volume > required_volume)
		shipped_volume = required_volume
	return TRUE

/datum/bounty/interdyne_reagent/simple_drink
	name = "Simple Drink"
	reward = CARGO_CRATE_VALUE * 3

/datum/bounty/interdyne_reagent/simple_drink/New()
	// Don't worry about making this comprehensive. It doesn't matter if some drinks are skipped.
	var/static/list/possible_reagents = list(
		/datum/reagent/consumable/ethanol/antifreeze,
		/datum/reagent/consumable/ethanol/andalusia,
		/datum/reagent/consumable/tea/arnold_palmer,
		/datum/reagent/consumable/ethanol/b52,
		/datum/reagent/consumable/ethanol/bananahonk,
		/datum/reagent/consumable/ethanol/beepsky_smash,
		/datum/reagent/consumable/ethanol/between_the_sheets,
		/datum/reagent/consumable/ethanol/bilk,
		/datum/reagent/consumable/ethanol/black_russian,
		/datum/reagent/consumable/ethanol/bloody_mary,
		/datum/reagent/consumable/ethanol/brave_bull,
		/datum/reagent/consumable/ethanol/martini,
		/datum/reagent/consumable/ethanol/cuba_libre,
		/datum/reagent/consumable/ethanol/eggnog,
		/datum/reagent/consumable/ethanol/erikasurprise,
		/datum/reagent/consumable/ethanol/ginfizz,
		/datum/reagent/consumable/ethanol/gintonic,
		/datum/reagent/consumable/ethanol/grappa,
		/datum/reagent/consumable/ethanol/grog,
		/datum/reagent/consumable/ethanol/hooch,
		/datum/reagent/consumable/ethanol/iced_beer,
		/datum/reagent/consumable/ethanol/irishcarbomb,
		/datum/reagent/consumable/ethanol/manhattan,
		/datum/reagent/consumable/ethanol/margarita,
		/datum/reagent/consumable/ethanol/gargle_blaster,
		/datum/reagent/consumable/ethanol/rum_coke,
		/datum/reagent/consumable/ethanol/screwdrivercocktail,
		/datum/reagent/consumable/ethanol/snowwhite,
		/datum/reagent/consumable/soy_latte,
		/datum/reagent/consumable/cafe_latte,
		/datum/reagent/consumable/ethanol/syndicatebomb,
		/datum/reagent/consumable/ethanol/tequila_sunrise,
		/datum/reagent/consumable/ethanol/manly_dorf,\
		/datum/reagent/consumable/ethanol/thirteenloko,\
		/datum/reagent/consumable/triple_citrus,\
		/datum/reagent/consumable/ethanol/vodkamartini,\
		/datum/reagent/consumable/ethanol/whiskeysoda,
		/datum/reagent/consumable/ethanol/beer/green,
		/datum/reagent/consumable/ethanol/demonsblood,
		/datum/reagent/consumable/ethanol/crevice_spike,
		/datum/reagent/consumable/ethanol/singulo,
		/datum/reagent/consumable/ethanol/whiskey_sour,
	)

	var/reagent_type = pick(possible_reagents)
	wanted_reagent = new reagent_type
	name = wanted_reagent.name
	description = "I'll be real, corporate is thirsty! Send a shipment of [name] to corporate to quench the company's thirst."
	reward += rand(0, 2) * 500

/datum/bounty/interdyne_reagent/complex_drink
	name = "Complex Drink"
	reward = CARGO_CRATE_VALUE * 8

/datum/bounty/interdyne_reagent/complex_drink/New()
	// Don't worry about making this comprehensive. It doesn't matter if some drinks are skipped.
	var/static/list/possible_reagents = list(
		/datum/reagent/consumable/ethanol/atomicbomb,
		/datum/reagent/consumable/ethanol/bacchus_blessing,
		/datum/reagent/consumable/ethanol/bastion_bourbon,
		/datum/reagent/consumable/ethanol/booger,
		/datum/reagent/consumable/ethanol/hippies_delight,
		/datum/reagent/consumable/ethanol/drunkenblumpkin,
		/datum/reagent/consumable/ethanol/fetching_fizz,
		/datum/reagent/consumable/ethanol/goldschlager,
		/datum/reagent/consumable/ethanol/manhattan_proj,
		/datum/reagent/consumable/ethanol/narsour,
		/datum/reagent/consumable/ethanol/neurotoxin,
		/datum/reagent/consumable/ethanol/patron,
		/datum/reagent/consumable/ethanol/quadruple_sec,
		/datum/reagent/consumable/bluecherryshake,
		/datum/reagent/consumable/doctor_delight,
		/datum/reagent/consumable/ethanol/silencer,
		/datum/reagent/consumable/ethanol/peppermint_patty,
		/datum/reagent/consumable/ethanol/aloe,
		/datum/reagent/consumable/pumpkin_latte,
	)

	var/reagent_type = pick(possible_reagents)
	wanted_reagent = new reagent_type
	name = wanted_reagent.name
	description = "Upper level staff want some more complex drinks, and this request must be fulfilled. Ship a container of [name] and you will be rewarded."
	reward += rand(0, 4) * 500

/datum/bounty/interdyne_reagent/chemical_simple
	name = "Simple Chemical"
	reward = CARGO_CRATE_VALUE * 8
	required_volume = 30

/datum/bounty/interdyne_reagent/chemical_simple/New()
	// Chemicals that can be mixed by a single skilled Chemist.
	var/static/list/possible_reagents = list(
		/datum/reagent/medicine/leporazine,
		/datum/reagent/medicine/mine_salve,
		/datum/reagent/medicine/c2/convermol,
		/datum/reagent/medicine/ephedrine,
		/datum/reagent/medicine/diphenhydramine,
		/datum/reagent/drug/space_drugs,
		/datum/reagent/drug/blastoff,
		/datum/reagent/gunpowder,
		/datum/reagent/napalm,
		/datum/reagent/firefighting_foam,
		/datum/reagent/consumable/mayonnaise,
		/datum/reagent/toxin/itching_powder,
		/datum/reagent/toxin/cyanide,
		/datum/reagent/toxin/heparin,
		/datum/reagent/medicine/pen_acid,
		/datum/reagent/medicine/atropine,
		/datum/reagent/drug/aranesp,
		/datum/reagent/drug/krokodil,
		/datum/reagent/drug/methamphetamine,
		/datum/reagent/teslium,
		/datum/reagent/toxin/anacea,
		/datum/reagent/pax,
	)

	var/reagent_type = pick(possible_reagents)
	wanted_reagent = new reagent_type
	name = wanted_reagent.name
	description = "A hospital is in desperate need of the chemical [name]. Ship a container of it to be rewarded."
	reward += rand(0, 4) * 500 //4000 to 6000 credits

/datum/bounty/interdyne_reagent/chemical_complex
	name = "Rare Chemical"
	reward = CARGO_CRATE_VALUE * 12
	required_volume = 20

/datum/bounty/interdyne_reagent/chemical_complex/New()
	// Reagents that require interaction with multiple departments or are a pain to mix. Lower required_volume since acquiring 30u of some is unrealistic
	var/static/list/possible_reagents = list(
		/datum/reagent/medicine/pyroxadone,
		/datum/reagent/medicine/rezadone,
		/datum/reagent/medicine/regen_jelly,
		/datum/reagent/drug/bath_salts,
		/datum/reagent/hair_dye,
		/datum/reagent/consumable/honey,
		/datum/reagent/consumable/frostoil,
		/datum/reagent/toxin/slimejelly,
		/datum/reagent/teslium/energized_jelly,
		/datum/reagent/toxin/mimesbane,
		/datum/reagent/medicine/strange_reagent,
		/datum/reagent/nitroglycerin,
		/datum/reagent/medicine/rezadone,
		/datum/reagent/toxin/zombiepowder,
		/datum/reagent/toxin/ghoulpowder,
		/datum/reagent/mulligan,
	)

	var/reagent_type = pick(possible_reagents)
	wanted_reagent = new reagent_type
	name = wanted_reagent.name
	description = "A hospital is in need of a rare chemical, [name]. Ship a container of it to be rewarded."
	reward += (rand(0, 5) * (PAYCHECK_COMMAND * 7.5)) //6000 to 9750 credits

/datum/bounty/interdyne_pill
	/// quantity of the pills needed, this value acts as minimum, gets randomized on new()
	var/required_amount = 80
	/// counter for pills sent
	var/shipped_amount = 0
	/// reagent requested
	var/datum/reagent/wanted_reagent
	/// minimum volume of chemical needed, gets randomized on new()
	var/wanted_vol = 30

/datum/bounty/interdyne_pill/can_claim()
	return ..() && shipped_amount >= required_amount

/datum/bounty/interdyne_pill/applies_to(obj/shipped)
	if(!istype(shipped, /obj/item/reagent_containers/applicator/pill))
		return FALSE
	if(shipped?.reagents.get_reagent_amount(wanted_reagent.type) >= wanted_vol)
		return TRUE
	return FALSE

/datum/bounty/interdyne_pill/ship(obj/shipped)
	if(!applies_to(shipped))
		return FALSE
	shipped_amount += 1
	if(shipped_amount > required_amount)
		shipped_amount = required_amount
	return TRUE

/datum/bounty/interdyne_pill/simple_pill
	name = "Simple Pill"
	reward = CARGO_CRATE_VALUE * 20

/datum/bounty/interdyne_pill/simple_pill/New()
	//reagent that are possible to be chem factory'd
	var/static/list/possible_reagents = list(\
		/datum/reagent/medicine/spaceacillin,\
		/datum/reagent/medicine/c2/synthflesh,\
		/datum/reagent/medicine/pen_acid,\
		/datum/reagent/medicine/atropine,\
		/datum/reagent/medicine/cryoxadone,\
		/datum/reagent/medicine/salbutamol,\
		/datum/reagent/medicine/c2/hercuri,\
		/datum/reagent/medicine/c2/probital,\
		/datum/reagent/drug/methamphetamine,\
		/datum/reagent/nitrous_oxide,\
		/datum/reagent/barbers_aid,\
		/datum/reagent/pax,\
		/datum/reagent/flash_powder,\
		/datum/reagent/phlogiston,\
		/datum/reagent/firefighting_foam)

	var/datum/reagent/reagent_type = pick(possible_reagents)
	wanted_reagent = new reagent_type
	name = "[wanted_reagent.name] pills"
	required_amount += rand(1,60)
	wanted_vol += rand(1,20)
	description = "Special Request from someone out of your paygrade, they need [required_amount] of [name] containing at least [wanted_vol] each. Ship a container of it to be rewarded."
	reward += rand(1, 5) * (CARGO_CRATE_VALUE * 6)
