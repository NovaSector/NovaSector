// For their passive healing
#define SPECIES_SLIME_PASSIVE_REGEN_BRUTE 0.6
#define SPECIES_SLIME_PASSIVE_REGEN_BURN 0.5

/datum/species/jelly
	hair_alpha = 160 //a notch brighter so it blends better.
	facial_hair_alpha = 160
	mutantliver = /obj/item/organ/liver/slime
	mutantstomach = /obj/item/organ/stomach/slime
	mutantbrain = /obj/item/organ/brain/slime
	mutantears = /obj/item/organ/ears/jelly
	inherent_traits = list(
		TRAIT_MUTANT_COLORS,
		TRAIT_TOXINLOVER,
		TRAIT_EASYDISMEMBER,
	)
	/// Ability to allow them to shapeshift their body around.
	var/datum/action/innate/alter_form/alter_form
	/// Ability to allow them to clean themselves and their stuff.
	var/datum/action/cooldown/slime_washing/slime_washing
	/// Ability to allow them to resist the effects of water.
	var/datum/action/cooldown/slime_hydrophobia/slime_hydrophobia
	/// Ability to allow them to turn their core's GPS on or off.
	var/datum/action/innate/core_signal/core_signal

/datum/species/jelly/on_species_gain(mob/living/carbon/new_jellyperson, datum/species/old_species, pref_load, regenerate_icons)
	. = ..()
	if(ishuman(new_jellyperson))
		alter_form = new
		alter_form.Grant(new_jellyperson)
		slime_washing = new
		slime_washing.Grant(new_jellyperson)
		slime_hydrophobia = new
		slime_hydrophobia.Grant(new_jellyperson)
		core_signal = new
		core_signal.Grant(new_jellyperson)

/datum/species/jelly/on_species_loss(mob/living/carbon/former_jellyperson, datum/species/new_species, pref_load)
	. = ..()
	QDEL_NULL(alter_form)
	QDEL_NULL(slime_washing)
	QDEL_NULL(slime_hydrophobia)
	QDEL_NULL(core_signal)

/datum/species/jelly/get_default_mutant_bodyparts()
	return list(
		FEATURE_TAIL = MUTPART_BLUEPRINT(SPRITE_ACCESSORY_NONE, is_randomizable = FALSE),
		FEATURE_SNOUT = MUTPART_BLUEPRINT(SPRITE_ACCESSORY_NONE, is_randomizable = FALSE),
		FEATURE_EARS = MUTPART_BLUEPRINT(SPRITE_ACCESSORY_NONE, is_randomizable = FALSE),
		FEATURE_LEGS = MUTPART_BLUEPRINT(NORMAL_LEGS, is_randomizable = FALSE, is_feature = TRUE),
		FEATURE_TAUR = MUTPART_BLUEPRINT(SPRITE_ACCESSORY_NONE, is_randomizable = FALSE),
		FEATURE_WINGS = MUTPART_BLUEPRINT(SPRITE_ACCESSORY_NONE, is_randomizable = FALSE),
		FEATURE_HORNS = MUTPART_BLUEPRINT(SPRITE_ACCESSORY_NONE, is_randomizable = FALSE),
		FEATURE_SPINES = MUTPART_BLUEPRINT(SPRITE_ACCESSORY_NONE, is_randomizable = FALSE),
		FEATURE_FRILLS = MUTPART_BLUEPRINT(SPRITE_ACCESSORY_NONE, is_randomizable = FALSE),
	)

/datum/species/jelly/gain_oversized_organs(mob/living/carbon/human/human_holder, datum/quirk/oversized/oversized_quirk)
	if(isnull(human_holder.loc))
		return // preview characters don't need funny organs, prevents a runtime

	var/obj/item/organ/brain/slime/oversized/new_slime_brain = new
	var/obj/item/organ/stomach/slime/oversized/new_slime_stomach = new //YOU LOOK HUGE! THAT MUST MEAN YOU HAVE HUGE golgi apparatus! RIP AND TEAR YOUR HUGE golgi apparatus!

	var/obj/item/organ/brain/slime/old_brain = human_holder.get_organ_slot(ORGAN_SLOT_BRAIN)
	var/obj/item/organ/stomach/slime/old_stomach = human_holder.get_organ_slot(ORGAN_SLOT_STOMACH)
	oversized_quirk.old_organs = list(
		old_brain,
		old_stomach,
	)

	// To prevent ghosting. We have to do this manually here because TG has replace_into() hardcoded to qdel the old brain no matter what and there is no way around it.
	old_brain.Remove(human_holder, special = TRUE, movement_flags = NO_ID_TRANSFER)

	new_slime_brain.Insert(human_holder, special = TRUE, movement_flags = NO_ID_TRANSFER)
	to_chat(human_holder, span_warning("Your massive core pulses with bioelectricity!"))
	if(old_brain)
		old_brain.moveToNullspace()
		STOP_PROCESSING(SSobj, old_brain)
	if(old_stomach.is_oversized) // don't override augments that are already oversized
		oversized_quirk.old_organs -= old_stomach
		qdel(new_slime_stomach)
		return
	new_slime_stomach.Insert(human_holder, special = TRUE)
	to_chat(human_holder, span_warning("You feel your massive golgi apparatus squish!"))
	if(old_stomach)
		old_stomach.moveToNullspace()
		STOP_PROCESSING(SSobj, old_stomach)

// HEALING SECTION
// Handles passive healing and water damage for slimes and water-breathing variants.
/datum/species/jelly/spec_life(mob/living/carbon/human/slime, seconds_per_tick)
	. = ..()

	var/healing = TRUE
	var/is_wet = HAS_TRAIT(slime, TRAIT_IS_WET)

	// Skip if hydrophobic, dry if wet
	if(HAS_TRAIT(slime, TRAIT_SLIME_HYDROPHOBIA))
		if(is_wet)
			slime.set_wet_stacks(0, remove_fire_stacks = FALSE)
		return

	// Determine if water-breathing logic should be inverted
	var/inverted = HAS_TRAIT(slime, TRAIT_WATER_BREATHING)

	// Water-breathing slimes: damaged when dry, heal only when wet
	if(inverted)
		if(!is_wet)
			slime.apply_status_effect(/datum/status_effect/dry_slime)
			healing = FALSE

	else
		// Normal slimes: damaged and unable to heal when wet
		if(is_wet)
			slime.apply_status_effect(/datum/status_effect/wet_slime)
			healing = FALSE

	// Skip if unconscious
	if(slime.stat != CONSCIOUS)
		return

	// PASSIVE HEALING
	if(slime.get_blood_volume() >= BLOOD_VOLUME_NORMAL && healing)
		var/need_mob_update
		need_mob_update += slime.heal_overall_damage(brute = SPECIES_SLIME_PASSIVE_REGEN_BRUTE * seconds_per_tick, burn = SPECIES_SLIME_PASSIVE_REGEN_BURN * seconds_per_tick, updating_health = FALSE, required_bodytype = BODYTYPE_ORGANIC)
		need_mob_update += slime.adjust_oxy_loss(-1 * seconds_per_tick, updating_health = FALSE)
		if(need_mob_update)
			slime.updatehealth()
		if(slime.health < slime.maxHealth)
			new /obj/effect/temp_visual/heal(get_turf(slime), slime.dna.features[FEATURE_MUTANT_COLOR])

/datum/species/jelly/get_species_description()
	return "Slime Hybrids are intelligent, gelatinous life forms capable of shape-shifting and eating almost everything, craving plasma above all else."

/datum/species/jelly/get_species_lore()
	return list(
		"Slimes, referred to with a variety of languages word simply for 'slime', are amorphous fauna entirely native to bluespace. \
		Liquid, like everything else in this celestial space, slimes are an opportunistic group of omnivores utilizing practically anything as a food source: Plastic, metal, meat, but they are known to prioritize the incredibly high energy of solid, liquid, or gaseous plasma first and foremost. \
		Slimes will normally seat themselves in the barrier between realspace and bluespace or its permanent pores, filter feeding off the resulting ore that forms. Other times, they will gather in groups of anywhere from a lake to a sea, all the way up to oceanic masses of slimes, intentionally wearing away at the Veil's stability and introducing dimensional friction on their own.",

		"Normally located on the other end of the barrier, numerous slimes will often end up leaking through to realspace in search of their prized meals, typically keying themselves to an associated anomaly's properties. Single dog-sized masses have normally been reported, but tidal waves of poorly differentiated ooze are not uncommon. \
		The Ordoht have historically been known to intentionally pull slime out from the other side, exploiting a common feature: mimicry. Slimes are capable of incredible feats of learning and overall mental agility, necessary to navigate the currents and eddies of their home dimension. \
		Within even a few months of existing in realspace, a slime can be brought to resemble almost any organism it typically interacts with, and able to react to speech in under an hour. Further work can give one a roughly humanoid shape, upon which the Ordoht would recognize them as capable of complex learning-- the foundations of becoming a person.",

		"Despite their amorphous and shape-shifting nature as liquids, slimes that reach the point of personhood can become rapidly affixed to a single identity. Thought of by the Ordoht as 'mimicking themselves' and looping in on their own habits, a slime's disposition can become extraordinarily individualistic and defined in most cultures it's exposed to. \
		Even before and after the point of peak memetic saturation, slimes will ruthlessly chase any new cultural or philosophical information to either adopt or discard.",

		"The first slimes captured by Nanotrasen in the modern day are known to have come from anomalies in deep space, seemingly searching for the plasma ore stored aboard stations and ships. Failing to recognize their desire for the purple substance, humans started with normal everyday food-- later stepping it up to whole livestock. \
		Some simply performed basic mitosis, but others diverged into a multitude of colors as their bodies adapted to different properties. In search of exploiting the memetic properties of slimes with faster results than 'domestication', many scientists have attempted to apply them to a carbon-based lifeform's anatomy, resulting in slime physiology patterned off humanoid psychology."
	)

/datum/species/jelly/roundstartslime
	name = "Xenobiological Slime Hybrid"
	id = SPECIES_SLIMESTART
	examine_limb_id = SPECIES_SLIMEPERSON
	coldmod = 3
	heatmod = 1
	specific_alpha = 155
	markings_alpha = 130 //This is set lower than the other so that the alpha values don't stack on top of each other so much
	mutanteyes = /obj/item/organ/eyes/roundstartslime
	mutanttongue = /obj/item/organ/tongue/jelly

	bodypart_overrides = list( //Overriding jelly bodyparts
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/jelly/slime/roundstart,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/jelly/slime/roundstart,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/jelly/slime/roundstart,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/jelly/slime/roundstart,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/jelly/slime/roundstart,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/jelly/slime/roundstart,
	)

/datum/species/jelly/roundstartslime/create_pref_unique_perks()
	var/list/to_add = list()

	to_add += list(
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "circle",
			SPECIES_PERK_NAME = "Single-Celled Organism",
			SPECIES_PERK_DESC = "Slimes only have one discrete organ, their core. It comes pre-installed with a togglable microchip for ease in location; their other organelles are unremovable.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "notes-medical",
			SPECIES_PERK_NAME = "Regenerator",
			SPECIES_PERK_DESC = "Slimes, if they have a proper amount of jelly inside, are capable of regenerating damage and limbs. If they're exposed to plasma at a high jelly volume, they can regenerate wounds.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = "droplet-slash",
			SPECIES_PERK_NAME = "Dissolution",
			SPECIES_PERK_DESC = "If slimes have their limbs chopped off, they disintegrate and cannot be recovered. If their body dies as a whole, it dissolves away from their core and requires 100u of liquid plasma to fix.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "hand-holding-droplet",
			SPECIES_PERK_NAME = "Washes Right Out",
			SPECIES_PERK_DESC = "Slimes are capable of cleaning themselves and their clothing, siphoning the dirt off it and into themselves; even off the floor, if they're barefoot. This gives them a mild amount of nutrition.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = "person-swimming",
			SPECIES_PERK_NAME = "Major Hydrophobia",
			SPECIES_PERK_DESC = "Slimes dissolve when exposed to water under normal circumstances, water diluting their slime volume and preventing their ability to regenerate. Water-breathing slimes do exist, although they won't fare well without water.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "person-booth",
			SPECIES_PERK_NAME = "Shapeshifter",
			SPECIES_PERK_DESC = "Slimes can alter their size and general shape.",
		),
	)

	return to_add

/datum/species/jelly/roundstartslime/apply_supplementary_body_changes(mob/living/carbon/human/target, datum/preferences/preferences, visuals_only = FALSE)
	if(preferences.read_preference(/datum/preference/toggle/allow_mismatched_hair_color))
		target.dna.species.hair_color_mode = null

#undef SPECIES_SLIME_PASSIVE_REGEN_BRUTE
#undef SPECIES_SLIME_PASSIVE_REGEN_BURN
