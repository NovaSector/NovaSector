/// How long the akula will stay wet for, AKA how long until they get a mood debuff
#define DRY_UP_TIME 10 MINUTES
/// How many wetstacks an Akula will get upon creation
#define WETSTACK_INITIAL 5
/// How many wetstacks an Akula needs to activate the TRAIT_SLIPPERY trait
#define WETSTACK_THRESHOLD 3

/datum/species/akula
	name = "Akula"
	plural_form = "Akulae"
	id = SPECIES_AKULA
	offset_features = list(
		OFFSET_GLASSES = list(0, 1),
		OFFSET_EARS = list(0, 2),
		OFFSET_FACEMASK = list(0, 2),
		OFFSET_HEAD = list(0, 2),
		OFFSET_HAIR = list(0, 1),
	)
	mutantbrain = /obj/item/organ/brain/carp/akula
	mutantheart = /obj/item/organ/heart/carp/akula
	mutantlungs = /obj/item/organ/lungs/carp/akula
	mutanttongue = /obj/item/organ/tongue/carp/akula
	mutanteyes = /obj/item/organ/eyes/akula
	mutant_organs = list(/obj/item/organ/fangs/carp/akula)
	meat = /obj/item/food/fishmeat/human
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_LITERATE,
		TRAIT_WATER_BREATHING,
		TRAIT_SLICK_SKIN,
		TRAIT_MUTANT_COLORS,
	)
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID
	payday_modifier = 1.0
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/mutant/akula,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/mutant/akula,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/mutant/akula,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/mutant/akula,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/mutant/akula,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/mutant/akula,
	)
	/// This variable stores the timer datum which appears if the mob becomes wet
	var/dry_up_timer = TIMER_ID_NULL

/datum/species/akula/get_default_mutant_bodyparts()
	return list(
		FEATURE_EARS = MUTPART_BLUEPRINT(SPRITE_ACCESSORY_NONE, is_randomizable = FALSE),
		FEATURE_TAIL = MUTPART_BLUEPRINT("Akula", is_randomizable = TRUE),
		FEATURE_LEGS = MUTPART_BLUEPRINT(NORMAL_LEGS, is_randomizable = FALSE, is_feature = TRUE),
	)

/datum/species/akula/get_species_description()
	return "The Azuleans, 'Akula' or 'Akulans' to detractors, are bipedal, tailed aquatic folk easily confused as shark people. Genetically, they resemble Space Carp more than earth sharks. Stemming from the oceanic planet Selantis, these pseudosharks need moisture to thrive, suffering greatly if their skin is not wet."

/datum/species/akula/get_species_lore()
	return list("https://wiki.novasector13.com/wiki/Lore:Azula",

	"The Azuleans, once proudly 'Akulas' or 'Akulans', are a shameful, strong-willed culture. Once a theocratic monarchy worshipping the original shark under the waves of their homeworld, Selantis, the Akulans saw little reason to surface until scholars noticed stars changing. Disbelief, betrayals, an a well-documented series of coups left the Akulans uniquely vulnerable to manipulation, which the Vox took advantage of.",
	"Their marine biology meant that, in a pressurized cockpit, an Akulan could withstand several hundred newtons of g-forces aboard gifted experimental Vox starfighters. With an appeal to glory, the Vox pushed Akulans on a horrible warpath across unclaimed human space, terrorizing all in their path until a horrifying defeat raiding the MECU. Disregarding safety precautions led to the Bluespacial annihilation of most of the Akulan fleet, and the survivors limped home in shame.",
	"Without the forces to hold their new claims, the reputation as vicious killers, and the baggage around looking like sharks, Akulans were on the galaxy's shit list. Fearing justified retaliation, Selantis broke into three factions in the War Of The Three Seas.",
	"Eventually, the Vox manipulation would come to light, and what Akulan forces remained united against their observers. While they killed their immediate tormenters, the greater Diplomacyteam Arkship arrived to Cease hostilities, disproportionately ensuring that the Bureau of Current Affairs controlled Selantis.",
	"The Bureau of Current Affairs decries survival through Self-control, Discipline, Self-policing. In a campaign to cleanse their peoples' reputation (and not get curb-stomped by a united SolFed), the Bureau immediately rebranded the species as \"Azuleans,\" dropping the hard consanant sound for the Bouba-Kiki effect.",
	"The Bureau strictly polices that all Azuleans come across as friendly and cooperative, endearing rather than endangering. To that end, the Azulean Coast Guard is themed in chivalry and knighthood, the Knighthood of Shining Armor striving to reassociate their might as protective and valiant.",
	"Even Azulean crime is sanitized and oriented towards cooperation, drawing inspriation from prohibition-era gangsters and the Godfather to present as a Family and a Community. The Bureau ensures that when the Coast Guard gets one over on the mobsters, if they're upholding Azulean ideals, their sentence in Gartunamoray Bay is a short-lived vacation. Those who would flex their Akulan fierceness, lawfully or otherwise, are dealt with harshly by both sides of the law.",
	"The Bureau of Current Affairs remains the de facto controller of Azulean culture, regardless of whatever monarchy or government nominally holds power."
	)

/datum/species/akula/create_pref_unique_perks()
	var/list/perks = list()
	perks += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = FA_ICON_TOOTH,
		SPECIES_PERK_NAME = "Big Bites",
		SPECIES_PERK_DESC = "Instead of throwing punches, you use your sharp teeth to bite for more damage."
	))
	perks += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = FA_ICON_PERSON_WALKING,
		SPECIES_PERK_NAME = "Space Walking",
		SPECIES_PERK_DESC = "You can move around in zero-gravity environments, just like your ancestors."
	))
	perks += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = FA_ICON_HAND,
		SPECIES_PERK_NAME = "Slippery Skin",
		SPECIES_PERK_DESC = "When sufficiently wet, you have a bonus chance to escape from grabs."
	))
	perks += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEUTRAL_PERK,
		SPECIES_PERK_ICON = FA_ICON_SHIRT,
		SPECIES_PERK_NAME = "Wetsuits",
		SPECIES_PERK_DESC = "You spawn with clothing that will keep you perpetually wet if not removed."
	))
	perks += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
		SPECIES_PERK_ICON = FA_ICON_LUNGS,
		SPECIES_PERK_NAME = "Gills",
		SPECIES_PERK_DESC = "If you are not wet, you will not be able to breathe oxygen!",
	))
	perks += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
		SPECIES_PERK_ICON = FA_ICON_ARROW_DOWN,
		SPECIES_PERK_NAME = "Nomadic DNA",
		SPECIES_PERK_DESC = "You never want to stay in one place."
	))
	perks += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
		SPECIES_PERK_ICON = FA_ICON_PERSON_FALLING,
		SPECIES_PERK_NAME = "Slippery Soles",
		SPECIES_PERK_DESC = "When sufficiently wet, all slips will send you flying, even just a wet floor.",
	))
	return perks

/datum/species/akula/randomize_features()
	var/list/features = ..()
	var/main_color
	var/secondary_color
	var/tertiary_color
	var/random = rand(1, 4)
	switch(random)
		if(1)
			main_color = "#1CD3E5"
			secondary_color = "#6AF1D6"
			tertiary_color = "#CCF6E2"
		if(2)
			main_color = "#CF3565"
			secondary_color = "#d93554"
			tertiary_color = "#fbc2dd"
		if(3)
			main_color = "#FFC44D"
			secondary_color = "#FFE85F"
			tertiary_color = "#FFF9D6"
		if(4)
			main_color = "#DB35DE"
			secondary_color = "#BE3AFE"
			tertiary_color = "#F5E2EE"
	features[FEATURE_MUTANT_COLOR] = main_color
	features[FEATURE_MUTANT_COLOR_TWO] = secondary_color
	features[FEATURE_MUTANT_COLOR_THREE] = tertiary_color
	return features

/datum/species/akula/prepare_human_for_preview(mob/living/carbon/human/akula)
	var/main_color = "#1CD3E5"
	var/secondary_color = "#6AF1D6"
	var/tertiary_color = "#CCF6E2"
	akula.dna.features[FEATURE_MUTANT_COLOR] = main_color
	akula.dna.features[FEATURE_MUTANT_COLOR_TWO] = secondary_color
	akula.dna.features[FEATURE_MUTANT_COLOR_THREE] = tertiary_color
	akula.dna.mutant_bodyparts[FEATURE_TAIL] = build_mutant_part("Akula", list(main_color, secondary_color, tertiary_color))
	akula.dna.features[FEATURE_LEGS] = NORMAL_LEGS
	regenerate_organs(akula, src, visual_only = TRUE)
	akula.update_body(TRUE)

/datum/species/akula/get_random_body_markings(list/passed_features)
	var/datum/body_marking_set/body_marking_set = GLOB.body_marking_sets["Akula"]
	var/list/markings = list()
	if(body_marking_set)
		markings = assemble_body_markings_from_set(body_marking_set, passed_features, src)
	return markings

/datum/species/akula/pre_equip_species_outfit(datum/job/job, mob/living/carbon/human/equipping, visuals_only = FALSE)
	//should not call parent
	if(job?.akula_outfit)
		equipping.equipOutfit(job.akula_outfit, visuals_only)

///Organ overwrites

// set bonus
/datum/status_effect/organ_set_bonus/carp/akula
	id = "organ_set_bonus_carp_akula"
	limb_texture = null // no carpskin

//Eyes
/obj/item/organ/eyes/akula
	// Eyes over hair as bandaid for the low amounts of head matching hair
	eyes_layer = HAIR_LAYER-0.1

//Brain
/obj/item/organ/brain/carp/akula
	name = "azulean brain"

/obj/item/organ/brain/carp/akula/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/bubble_icon_override, "fish", BUBBLE_ICON_PRIORITY_ORGAN)
	RemoveElement(/datum/element/organ_set_bonus, /datum/status_effect/organ_set_bonus/carp)
	AddElement(/datum/element/organ_set_bonus, /datum/status_effect/organ_set_bonus/carp/akula)

//Heart
/obj/item/organ/heart/carp/akula
	name = "azulean heart"
	organ_traits = list()

/obj/item/organ/heart/carp/akula/Initialize(mapload)
	. = ..()
	RemoveElement(/datum/element/organ_set_bonus, /datum/status_effect/organ_set_bonus/carp)
	AddElement(/datum/element/organ_set_bonus, /datum/status_effect/organ_set_bonus/carp/akula)

//Tongue
/obj/item/organ/tongue/carp/akula
	name = "azulean jaws"
	liked_foodtypes = SEAFOOD | RAW
	disliked_foodtypes = CLOTH | DAIRY
	toxic_foodtypes = TOXIC

/obj/item/organ/tongue/carp/akula/Initialize(mapload)
	. = ..()
	RemoveElement(/datum/element/organ_set_bonus, /datum/status_effect/organ_set_bonus/carp)
	AddElement(/datum/element/organ_set_bonus, /datum/status_effect/organ_set_bonus/carp/akula)

//Fangs
// Akula used to get their bite from /obj/item/organ/tongue/carp before TG split fangs out into their own organ,
// so they get their own carp fangs to keep it, and to stay at the 5 organs the carp set bonus now asks for.
/obj/item/organ/fangs/carp/akula
	name = "azulean fangs"
	desc = "A set of sharp, backward-curving teeth. Rather more orderly than a space carp's."

/obj/item/organ/fangs/carp/akula/Initialize(mapload)
	. = ..()
	RemoveElement(/datum/element/organ_set_bonus, /datum/status_effect/organ_set_bonus/carp)
	AddElement(/datum/element/organ_set_bonus, /datum/status_effect/organ_set_bonus/carp/akula)

/obj/item/organ/fangs/carp/akula/on_mob_insert(mob/living/carbon/fangs_owner, special, movement_flags)
	. = ..()
	if(!ishuman(fangs_owner))
		return
	var/mob/living/carbon/human/human_receiver = fangs_owner
	if(!human_receiver.can_mutate())
		return
	var/datum/species/rec_species = human_receiver.dna.species
	rec_species.update_no_equip_flags(fangs_owner, initial(rec_species.no_equip_flags))

//Lungs
/obj/item/organ/lungs/carp/akula
	name = "azulean lungs"
	safe_oxygen_min = /obj/item/organ/lungs::safe_oxygen_min
	safe_oxygen_max = /obj/item/organ/lungs::safe_oxygen_max

/obj/item/organ/lungs/carp/akula/Initialize(mapload)
	organ_traits -= TRAIT_NO_BREATHLESS_DAMAGE
	. = ..()
	RemoveElement(/datum/element/organ_set_bonus, /datum/status_effect/organ_set_bonus/carp)
	AddElement(/datum/element/organ_set_bonus, /datum/status_effect/organ_set_bonus/carp/akula)


// Wet_stacks handling
// more about grab_resists in `code\modules\mob\living\living.dm` at li 1119
// more about slide_distance in `code\game\turfs\open\_open.dm` at li 233
/// Lets register the signal which calls when we are above 10 wet_stacks
/datum/species/akula/on_species_gain(mob/living/carbon/akula, datum/species/old_species, pref_load, regenerate_icons)
	. = ..()
	RegisterSignal(akula, COMSIG_MOB_TRIGGER_WET_SKIN, PROC_REF(wetted), akula)
	// lets give 15 wet_stacks on initial
	akula.set_wet_stacks(WETSTACK_INITIAL, remove_fire_stacks = FALSE)

/// Remove the signal on species loss
/datum/species/akula/on_species_loss(mob/living/carbon/akula, datum/species/new_species, pref_load)
	. = ..()
	UnregisterSignal(akula, COMSIG_MOB_TRIGGER_WET_SKIN)

/// This proc is called when a mob with TRAIT_SLICK_SKIN gains over 10 wet_stacks
/datum/species/akula/proc/wetted(mob/living/carbon/akula)
	SIGNAL_HANDLER
	// Apply the slippery trait if it's not there yet
	if(!HAS_TRAIT(akula, TRAIT_SLIPPERY))
		ADD_TRAIT(akula, TRAIT_SLIPPERY, SPECIES_TRAIT)

	// Relieve the negative moodlet
	akula.clear_mood_event("dry_skin")
	// The timer which will initiate above 10 wet_stacks, and call dried() once the timer runs out
	dry_up_timer = addtimer(CALLBACK(src, PROC_REF(dried), akula), DRY_UP_TIME, TIMER_UNIQUE | TIMER_STOPPABLE | TIMER_DELETE_ME)

/// This proc is called after a mob with the TRAIT_SLIPPERY has its related timer run out
/datum/species/akula/proc/dried(mob/living/carbon/akula)
	// A moodlet which will not go away until the user gets wet
	akula?.add_mood_event("dry_skin", /datum/mood_event/dry_skin)

/// A simple overwrite which calls parent to listen to wet_stacks
/datum/status_effect/fire_handler/wet_stacks/tick(delta_time)
	. = ..()
	if(!owner)
		return
	if(HAS_TRAIT(owner, TRAIT_SLICK_SKIN) && stacks >= WETSTACK_THRESHOLD)
		SEND_SIGNAL(owner, COMSIG_MOB_TRIGGER_WET_SKIN)

	if(HAS_TRAIT(owner, TRAIT_SLIPPERY) && stacks <= 0.5) // Removed just before we hit 0 and delete the /status_effect/
		REMOVE_TRAIT(owner, TRAIT_SLIPPERY, SPECIES_TRAIT)

#undef DRY_UP_TIME
#undef WETSTACK_INITIAL
#undef WETSTACK_THRESHOLD
