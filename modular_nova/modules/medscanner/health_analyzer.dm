GLOBAL_LIST_INIT(analyzerthemes, list(
	"default",
	"hackerman",
	"ntos_rusty",
	"ntos_healthy",
	"black_ntos",
))

#define MAX_HEALTH_ANALYZER_UPDATE_RANGE 3

/obj/item/healthanalyzer
	///Current mob being tracked by the scanner
	var/mob/living/carbon/human/patient
	///Current user of the scanner
	var/mob/living/carbon/human/current_user

/obj/item/healthanalyzer/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_ITEM_DROPPED, PROC_REF(on_drop))

/obj/item/healthanalyzer/Destroy()
	. = ..()
	UnregisterSignal(src, COMSIG_ITEM_DROPPED, PROC_REF(on_drop))

/obj/item/healthanalyzer/process(seconds_per_tick)
	if(get_turf(src) != get_turf(current_user) || get_dist(get_turf(current_user), get_turf(patient)) > MAX_HEALTH_ANALYZER_UPDATE_RANGE || patient == current_user)
		reset_analyzer_interface()
		return
	update_static_data(current_user)

/obj/item/healthanalyzer/proc/reset_analyzer_interface()
	STOP_PROCESSING(SSobj, src)
	patient = null
	current_user = null

/obj/item/healthanalyzer/ui_interact(mob/user, datum/tgui/ui)
	. = ..()
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "MedScanner", "Medical Scanner")
		update_static_data(user, ui)
		ui.open()

/obj/item/healthanalyzer/ui_static_data(mob/user)
	if(!patient)
		return list()

	var/list/data = list(
		"patient" = patient.name,
		"dead" = (patient.stat == DEAD),
		"health" = patient.health,
		"max_health" = patient.maxHealth,
		"crit_threshold" = patient.crit_threshold,
		"dead_threshold" = HEALTH_THRESHOLD_DEAD,
		"total_brute" = ceil(patient.getBruteLoss()),
		"total_burn" = ceil(patient.getFireLoss()),
		"toxin" = ceil(patient.getToxLoss()),
		"oxy" = ceil(patient.getOxyLoss()),
		"ssd" = (!patient.client),
		"blood_type" = patient.dna.blood_type,
		"blood_amount" = patient.blood_volume,
		"majquirks" = patient.get_quirk_string(FALSE, CAT_QUIRK_MAJOR_DISABILITY, from_scan = TRUE),
		"minquirks" = patient.get_quirk_string(FALSE, CAT_QUIRK_MINOR_DISABILITY, TRUE),
		"accessible_theme" = lowertext(user.client?.prefs.read_preference(/datum/preference/choiced/health_analyzer_themes)),
		"species" = patient.dna.species,
		"custom_species" = patient.client?.prefs.read_preference(/datum/preference/text/custom_species),
	)

	/*
	MEDICAL ALERTS
	*/
	// Special Medical Conditions
	var/list/medical_alerts = list()

	// Cardiac arrest
	if(ishuman(patient))
		var/mob/living/carbon/human/humantarget = patient
		if(humantarget.undergoing_cardiac_arrest() && humantarget.stat != DEAD)
			medical_alerts += list(list(
				"type" = "cardiac_arrest",
				"severity" = "critical",
				"message" = "CARDIAC ARREST - Apply defibrillation immediately!",
				"icon" = "heartbeat",
			))

		// Heart attack (different from cardiac arrest)
		if(humantarget.has_status_effect(/datum/status_effect/heart_attack))
			medical_alerts += list(list(
				"type" = "heart_attack",
				"severity" = "critical",
				"message" = "MYOCARDIAL INFARCTION - Defibrillate now!",
				"icon" = "heart-broken",
			))

		// Husk detection
		if(HAS_TRAIT(humantarget, TRAIT_HUSK))
			var/husk_cause = "mysterious causes"
			if(HAS_TRAIT_FROM(humantarget, TRAIT_HUSK, BURN))
				husk_cause = "severe burns - treat burns and apply synthflesh"
			else if(HAS_TRAIT_FROM(humantarget, TRAIT_HUSK, CHANGELING_DRAIN))
				husk_cause = "desiccation - transfuse blood and apply synthflesh"

			medical_alerts += list(list(
				"type" = "husked",
				"severity" = "critical",
				"message" = "Subject has been husked by [husk_cause]",
				"icon" = "skull",
			))

	// Irradiated
	if(HAS_TRAIT(patient, TRAIT_IRRADIATED))
		medical_alerts += list(list(
			"type" = "irradiated",
			"severity" = "warning",
			"message" = "Subject is irradiated - administer antiradiation",
			"icon" = "radiation",
		))

	// Genetic damage
	if(patient.has_status_effect(/datum/status_effect/genetic_damage))
		var/datum/status_effect/genetic_damage/gen_dam = patient.has_status_effect(/datum/status_effect/genetic_damage)
		var/genetic_percent = round(gen_dam.total_damage / 500 * 100, 0.1)
		medical_alerts += list(list(
			"type" = "genetic_damage",
			"severity" = gen_dam.total_damage >= 500 ? "critical" : "warning",
			"message" = "Genetic damage: [genetic_percent]% - will decay over time",
			"icon" = "dna",
		))

	// Hallucination
	if(patient.has_status_effect(/datum/status_effect/hallucination))
		medical_alerts += list(list(
			"type" = "hallucinating",
			"severity" = "warning",
			"message" = "Subject is hallucinating - administer antipsychotics",
			"icon" = "eye",
		))

	// Temporal instability
	if(patient.has_status_effect(/datum/status_effect/eigenstasium))
		medical_alerts += list(list(
			"type" = "temporal_unstable",
			"severity" = "warning",
			"message" = "Temporally unstable - administer stabilizers",
			"icon" = "clock",
		))

	// Mutant infection
	if(patient.GetComponent(/datum/component/mutant_infection))
		medical_alerts += list(list(
			"type" = "mutant_infection",
			"severity" = "critical",
			"message" = "UNKNOWN PROTO-VIRAL INFECTION - ISOLATE IMMEDIATELY",
			"icon" = "biohazard",
		))

	// Blood alcohol content
	var/blood_alcohol_content = patient.get_blood_alcohol_content()
	if(blood_alcohol_content > 0)
		var/severity = blood_alcohol_content >= 0.24 ? "critical" : "info"
		medical_alerts += list(list(
			"type" = "intoxicated",
			"severity" = severity,
			"message" = "Blood alcohol content: [blood_alcohol_content]%",
			"icon" = "wine-bottle",
		))

	data["medical_alerts"] = medical_alerts

	/*
	CHEMICALS
	*/
	var/list/chemicals_list = list()
	for(var/datum/reagent/reagent as anything in patient.reagents.reagent_list)
		chemicals_list += list(list(
			"name" = reagent.name,
			"description" = reagent.description,
			"amount" = round(reagent.volume, 0.1),
			"od" = reagent.overdosed,
			"od_threshold" = reagent.overdose_threshold,
			"dangerous" = reagent.overdosed || istype(reagent, /datum/reagent/toxin),
		))
	data["chemicals_list"] = chemicals_list

	/*
	LIMBS
	*/
	var/list/limb_data_list = list()
	if(!ishuman(patient)) // how did we get here?
		return

	var/mob/living/carbon/carbontarget = patient

	for(var/zone in carbontarget.get_all_limbs())
		var/obj/item/bodypart/limb = carbontarget.get_bodypart(zone)
		var/list/current_list = list()
		if(isnull(limb))
			current_list += list(
				"name" = parse_zone(zone),
				"missing" = TRUE,
			)
			continue
		current_list += list(
			"name" = limb.name,
			"missing" = FALSE,
			"brute" = round(limb.brute_dam),
			"burn" = round(limb.burn_dam),
			"limb_status" = null,
			"limb_type" = null,
			"bandaged" = limb.current_gauze ? TRUE : null,
			"bleeding" = limb.get_wound_type(/datum/wound/slash) ? TRUE : FALSE,
			"infection" = limb.get_wound_type(/datum/wound/burn) ? TRUE : FALSE,
		)
		var/limb_status = ""
		var/limb_type = ""
		if(IS_ROBOTIC_LIMB(limb))
			limb_type = "Robotic"
		else if((limb.get_wound_type(/datum/wound/blunt)) && (!limb.current_gauze))
			limb_status = "Fractured"
		else if((limb.get_wound_type(/datum/wound/blunt)) && limb.current_gauze)
			limb_status = "Splinted"

		current_list["limb_type"] = limb_type
		current_list["limb_status"] = limb_status
		limb_data_list += list(current_list)
	data["limb_data_list"] = limb_data_list

	/*
	ORGANS, handles organ data input into the tgui
	*/
	var/damaged_organs = list()
	var/embryo_data

	for(var/obj/item/organ/organ as anything in patient.organs)
		// Check for alien embryo
		if(istype(organ, /obj/item/organ/body_egg/alien_embryo))
			var/obj/item/organ/body_egg/alien_embryo/embryo = organ
			var/embryo_stage = embryo.stage

			var/stage_desc = ""
			switch(embryo_stage)
				if(1, 2)
					stage_desc = "Early stage - barely detectable"
				if(3, 4)
					stage_desc = "Growing - host may show symptoms"
				if(5)
					stage_desc = "Advanced - near maturity"
				if(6)
					stage_desc = "CRITICAL - Imminent emergence!"

			damaged_organs += list(list(
				"name" = "ALIEN PARASITE",
				"status" = stage_desc,
				"damage" = 0,
				"effects" = "BIOHAZARD: Xenomorph larva detected! Recommend immediate surgical removal or the patient will not survive.",
			))

			embryo_data = list(
				"embryo_stage" = embryo_stage,
				"stage_desc" = stage_desc,
			)
			continue

		if(!organ.damage)
			continue
		var/current_organ = list(
			"name" = organ.name,
			"status" = organ.get_status_text(advanced, add_tooltips = FALSE, colored = FALSE),
			"damage" = organ.damage,
			"effects" = organ.desc || "No description available.",
		)
		damaged_organs += list(current_organ)

	data["damaged_organs"] = damaged_organs
	data["damaged_organs"] += get_missing_organs(patient)
	data["embryo_data"] = embryo_data

	if(HAS_TRAIT(patient, TRAIT_DNR))
		data["revivable_string"] = "Permanently deceased" // the actual information shown next to "revivable:" in tgui. "too much damage" etc.
		data["revivable_boolean"] = FALSE // the actual TRUE/FALSE entry used by tgui. if false, revivable text is red. if true, revivable text is yellow
	else if(isnull(patient.get_organ_slot(ORGAN_SLOT_HEART)))
		data["revivable_string"] = "Not ready to defibrillate - heart is missing"
		data["revivable_boolean"] = FALSE
	else if(!isnull(patient.get_organ_slot(ORGAN_SLOT_HEART)))
		var/obj/item/organ/heart = patient.get_organ_by_type(/obj/item/organ/heart)
		if(heart.organ_flags & ORGAN_FAILING || heart.damage >= 100)
			data["revivable_string"] = "Not ready to defibrillate - heart is too damaged"
			data["revivable_boolean"] = FALSE
	else if((patient.getBruteLoss() <= MAX_REVIVE_BRUTE_DAMAGE) && (patient.getFireLoss() <= MAX_REVIVE_FIRE_DAMAGE) && (!HAS_TRAIT(patient, TRAIT_HUSK)))
		data["revivable_string"] = "Ready to [patient ? "defibrillate" : "reboot"]" // Ternary for defibrillate or reboot for some IC flavor
		data["revivable_boolean"] = TRUE
	else
		data["revivable_string"] = "Not ready to [patient ? "defibrillate" : "reboot"] - damage left to repair [(round((patient.getBruteLoss() - MAX_REVIVE_BRUTE_DAMAGE) || (patient.getFireLoss() - MAX_REVIVE_FIRE_DAMAGE)))]"
		data["revivable_boolean"] = FALSE

	/*
	WOUNDS
	*/
	var/list/render_list = list()
	for(var/limb in patient.get_wounded_bodyparts())
		var/obj/item/bodypart/wounded_part = limb
		for(var/limb_wound in wounded_part.wounds)
			var/datum/wound/current_wound = limb_wound
			render_list += list(list(
				"type" = current_wound.name,
				"where" = wounded_part.name,
				"severity" = current_wound.severity_text(FALSE),
				"description" = current_wound.desc,
				"recomended_treatement" = current_wound.treat_text,
			))
	data["wounds"] = render_list

	/*
	Viruses and brain traumas
	*/
	var/list/virus_list = list()
	for(var/datum/disease/disease as anything in patient.diseases)
		if(isnull(disease))
			continue
		if(!(disease.visibility_flags & HIDDEN_SCANNER))
			virus_list += list(list(
				"form" = disease.form,
				"name" = disease.name,
				"type" = disease.spread_text,
				"stage" = disease.stage,
				"maxstage" = disease.max_stages,
				"cure" = disease.cure_text,
			))
	data["viruses"] = virus_list

	var/list/trauma_string
	if(iscarbon(patient))
		if(LAZYLEN(patient.get_traumas()))
			var/list/trauma_text = list()
			for(var/datum/brain_trauma/trauma in patient.get_traumas())
				var/trauma_desc = ""
				switch(trauma.resilience)
					if(TRAUMA_RESILIENCE_SURGERY)
						trauma_desc += "severe "
					if(TRAUMA_RESILIENCE_LOBOTOMY)
						trauma_desc += "deep-rooted "
					if(TRAUMA_RESILIENCE_WOUND)
						trauma_desc += "fracture-derived "
					if(TRAUMA_RESILIENCE_MAGIC)
						trauma_desc += "soul-bound "
					if(TRAUMA_RESILIENCE_ABSOLUTE)
						trauma_desc += "permanent "
				trauma_desc += trauma.scan_desc
				trauma_text += trauma_desc
			trauma_string = "Cerebral traumas detected: subject appears to be suffering from [english_list(trauma_text)]."
	data["brain_traumas"] = trauma_string

	/*
	ADVICE
	*/
	var/list/advice = list()
	var/list/temp_advice = list()
	if(!HAS_TRAIT(patient, TRAIT_DNR)) // only show advice at all if the patient is coming back
		//random stuff that docs should be aware of. possible todo: make a system so we can put these in a collapsible tgui element if there's more added here.
		if(patient.maxHealth != HUMAN_MAXHEALTH)
			advice += list(list(
				"advice" = "Patient has [patient.maxHealth / HUMAN_MAXHEALTH * 100]% constitution.",
				"tooltip" = patient.maxHealth < HUMAN_MAXHEALTH ? "Patient has less maximum health than most humans." : "Patient has more maximum health than most humans.",
				"icon" = patient.maxHealth < HUMAN_MAXHEALTH ? "heart-broken" : "heartbeat",
				"color" = patient.maxHealth < HUMAN_MAXHEALTH ? "grey" : "pink"
			))
		//species advice. possible todo: make a system so we can put these in a collapsible tgui element
		if(issynthetic(patient)) //specifically checking synth/robot here as these are specific to whichever species
			advice += list(list(
				"advice" = "Synthetic: Patient is not revived by defibrillation.",
				"tooltip" = "Synthetics do not heal when being shocked with a defibrillator, meaning they are only revivable over [(round((patient.getBruteLoss() - MAX_REVIVE_BRUTE_DAMAGE) || (patient.getFireLoss() - MAX_REVIVE_FIRE_DAMAGE)))]% health.",
				"icon" = "robot",
				"color" = "label",
			))
			advice += list(list(
				"advice" = "Synthetic: Patient overheats while lower than [patient.crit_threshold / patient.maxHealth * 100]% health.",
				"tooltip" = "Synthetics overheat rapidly while their health is lower than [patient.crit_threshold / patient.maxHealth * 100]%. When defibrillating, the patient should be repaired above this threshold to avoid unnecessary burning.",
				"icon" = "robot",
				"color" = "label",
			))
			advice += list(list(
				"advice" = "Synthetic: Patient does not suffer from blood loss.",
				"tooltip" = "Synthetics don't lose blood normaly.",
				"icon" = "robot",
				"color" = "label",
			))
		if(patient.stat == DEAD) // death advice
			for(var/obj/item/clothing/C in patient.get_equipped_items())
				if((C.body_parts_covered & CHEST) && (C.clothing_flags & THICKMATERIAL))
					advice += list(list(
						"advice" = "Remove patient's suit or armor.",
						"tooltip" = "To defibrillate the patient, you need to remove anything conductive obscuring their chest.",
						"icon" = "shield-alt",
						"color" = "blue",
					))
			if((patient.getBruteLoss() <= MAX_REVIVE_BRUTE_DAMAGE) || (patient.getFireLoss() <= MAX_REVIVE_FIRE_DAMAGE))
				advice += list(list(
					"advice" = "Administer shock via defibrillator!",
					"tooltip" = "The patient is ready to be revived, defibrillate them as soon as possible!",
					"icon" = "bolt",
					"color" = "yellow",
				))
		if(patient.getBruteLoss() > 5)
			if(!issynthetic(patient))
				advice += list(list(
					"advice" = "Use Brute healing medicine or sutures to repair the bruised areas.",
					"tooltip" = "Brute damage can be cured with sutures, or administer some brute healing medicine.",
					"icon" = "band-aid",
					"color" = "green",
				))
			else
				advice += list(list(
					"advice" = "Use a welding tool to repair the dented areas.",
					"tooltip" = "Only a welding tool can repair dented robotic limbs.",
					"icon" = "tools",
					"color" = "red",
				))
		if(patient.getFireLoss() > 5)
			if(!issynthetic(patient))
				advice += list(list(
					"advice" = "Use Burn healing medicine or sutures to repair the burned areas.",
					"tooltip" = "Regenerative Mesh will heal burn damage, or you can administer burn healing medicine.",
					"icon" = "band-aid",
					"color" = "orange",
				))
			else
				advice += list(list(
					"advice" = "Use cable coils to repair the scorched areas.",
					"tooltip" = "Only cable coils can repair scorched robotic limbs.",
					"icon" = "plug",
					"color" = "orange",
				))

		for(var/obj/item/organ/organs as anything in patient.organs)
			if(organs.name == "brain")
				var/obj/item/organ/brain/brain = patient.get_organ_by_type(/obj/item/organ/brain)
				if(brain && brain.damage > 5)
					temp_advice = list(list(
						"advice" = "Administer a single dose of mannitol.",
						"tooltip" = "Significant brain damage detected. Mannitol heals brain damage. If left untreated, patient may be unable to function well.",
						"icon" = "syringe",
						"color" = "blue",
					))
					if(chemicals_list["Mannitol"])
						if(chemicals_list["Mannitol"]["amount"] < 3)
							advice += temp_advice
					else
						advice += temp_advice
			else
				continue
			if(organs.name == "eyes")
				var/obj/item/organ/eyes/eyes = patient.get_organ_by_type(/obj/item/organ/eyes)
				if(eyes && eyes.damage > 5)
					temp_advice = list(list(
						"advice" = "Administer a single dose of occuline.",
						"tooltip" = "Eye damage detected. Occuline heals eye damage. If left untreated, patient may be unable to see properly.",
						"icon" = "syringe",
						"color" = "yellow",
					))
					if(chemicals_list["Occuline"])
						if(chemicals_list["Occuline"]["amount"] < 3)
							advice += temp_advice
					else
						advice += temp_advice
			else
				continue
		if(patient.getBruteLoss() > 30)
			temp_advice = list(list(
				"advice" = "Administer a single dose of Libital or Salicylic Acid to reduce physical trauma.",
				"tooltip" = "Significant physical trauma detected. Libital and Salicylic Acid both reduce brute damage.",
				"icon" = "syringe",
				"color" = "red",
			))
			if(chemicals_list["Libital"])
				if(chemicals_list["Libital"]["amount"] < 3)
					advice += temp_advice
			else
				advice += temp_advice
		if(patient.getFireLoss() > 30)
			temp_advice = list(list(
				"advice" = "Administer a single dose of Aiuri or Oxandrolone to reduce burns.",
				"tooltip" = "Significant tissue burns detected. Aiuri and Oxandrolone both reduces burn damage.",
				"icon" = "syringe",
				"color" = "yellow",
			))
			if(chemicals_list["Aiuri"])
				if(chemicals_list["Aiuri"]["amount"] < 3)
					advice += temp_advice
			else
				advice += temp_advice
		if(patient.getToxLoss() > 15)
			temp_advice = list(list(
				"advice" = "Administer a single dose of multiver or pentetic acid.",
				"tooltip" = "Significant blood toxins detected. Multiver and Pentetic Acid both will reduce toxin damage, or their liver will filter it out on its own. Damaged livers will take even more damage while clearing blood toxins.",
				"icon" = "syringe",
				"color" = "green",
			))
			if(chemicals_list["Multiver"])
				if(chemicals_list["Multiver"]["amount"] < 5)
					advice += temp_advice
			else
				advice += temp_advice
		if(patient.getOxyLoss() > 30)
			temp_advice = list(list(
				"advice" = "Administer a single dose of salbutamol to re-oxygenate patient's blood.",
				"tooltip" = "If you don't have Salbutamol, CPR or treating their other symptoms and waiting for their bloodstream to re-oxygenate will work.",
				"icon" = "syringe",
				"color" = "blue",
			))
			if(chemicals_list["Salbutamol"])
				if(chemicals_list["Salbutamol"]["amount"] < 3)
					advice += temp_advice
			else
				advice += temp_advice
		if(patient.blood_volume <= 500 && !chemicals_list["Saline-Glucose"])
			advice += list(list(
				"advice" = "Administer a single dose of Saline-Glucose or Iron.",
				"tooltip" = "The patient has lost a significant amount of blood. Saline-Glucose or Iron speeds up blood regeneration significantly.",
				"icon" = "syringe",
				"color" = "cyan",
			))
			advice += temp_advice
		if(patient.stat != DEAD && patient.health < patient.crit_threshold)
			temp_advice = list(list(
				"advice" = "Administer a single dose of epinephrine.",
				"tooltip" = "When used in hard critical condition, Epinephrine prevents suffocation and heals the patient, triggering a 5 minute cooldown.",
				"icon" = "syringe",
				"color" = "purple",
			))
			if(chemicals_list["Epinephrine"])
				if(chemicals_list["Epinephrine"]["amount"] < 5)
					advice += temp_advice
			else
				advice += temp_advice
	else
		advice += list(list(
			"advice" = "Patient is unrevivable.",
			"tooltip" = "The patient is permanently deceased. Can occur through being decapitated, DNR on record, or soullessness.",
			"icon" = "ribbon",
			"color" = "white",
		))

	data["advice"] = advice

	return data

/obj/item/healthanalyzer/ui_state(mob/user)
	return GLOB.hands_state

/// Handles UI closing when item is dropped
/obj/item/healthanalyzer/proc/on_drop(mob/user)
	SIGNAL_HANDLER
	reset_analyzer_interface()

/obj/item/healthanalyzer/ui_close(mob/user)
	reset_analyzer_interface()

/obj/item/healthanalyzer/proc/get_missing_organs(mob/living/carbon/target)
	if(ishuman(target))
		var/mob/living/carbon/human/humantarget = target
		var/missing_organs = list()
		if(!humantarget.get_organ_slot(ORGAN_SLOT_BRAIN))
			missing_organs += list(list(
				"name" = "Brain",
				"status" = "Missing",
				"damage" = "",
				"effects" = "Handles all cognitive functions. Stores the patient's mind and memories.",
			))
		if(!HAS_TRAIT_FROM(humantarget, TRAIT_NOBLOOD, SPECIES_TRAIT) && !humantarget.get_organ_slot(ORGAN_SLOT_HEART))
			missing_organs += list(list(
				"name" = "Heart",
				"status" = "Missing",
				"damage" = "",
				"effects" = "Pumps blood throughout the body. Required to prevent suffocation.",
			))
		if(!HAS_TRAIT_FROM(humantarget, TRAIT_NOBREATH, SPECIES_TRAIT) && !humantarget.get_organ_slot(ORGAN_SLOT_LUNGS))
			missing_organs += list(list(
				"name" = "Lungs",
				"status" = "Missing",
				"damage" = "",
				"effects" = "Oxygenates blood. Required for breathing.",
			))
		if(!HAS_TRAIT_FROM(humantarget, TRAIT_LIVERLESS_METABOLISM, SPECIES_TRAIT) && !humantarget.get_organ_slot(ORGAN_SLOT_LIVER))
			missing_organs += list(list(
				"name" = "Liver",
				"status" = "Missing",
				"damage" = "",
				"effects" = "Filters toxins from the bloodstream.",
			))
		if(!HAS_TRAIT_FROM(humantarget, TRAIT_NOHUNGER, SPECIES_TRAIT) && !humantarget.get_organ_slot(ORGAN_SLOT_STOMACH))
			missing_organs += list(list(
				"name" = "Stomach",
				"status" = "Missing",
				"damage" = "",
				"effects" = "Processes and digests food.",
			))
		if(!humantarget.get_organ_slot(ORGAN_SLOT_TONGUE))
			missing_organs += list(list(
				"name" = "Tongue",
				"status" = "Missing",
				"damage" = "",
				"effects" = "Required for speech and tasting.",
			))
		if(!humantarget.get_organ_slot(ORGAN_SLOT_EARS))
			missing_organs += list(list(
				"name" = "Ears",
				"status" = "Missing",
				"damage" = "",
				"effects" = "Required for hearing.",
			))
		if(!humantarget.get_organ_slot(ORGAN_SLOT_EYES))
			missing_organs += list(list(
				"name" = "Eyes",
				"status" = "Missing",
				"damage" = "",
				"effects" = "Required for vision.",
			))
		return missing_organs

#undef MAX_HEALTH_ANALYZER_UPDATE_RANGE

