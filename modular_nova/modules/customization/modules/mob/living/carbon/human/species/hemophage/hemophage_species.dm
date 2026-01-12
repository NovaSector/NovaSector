/// Some starter text sent to the Hemophage initially, because Hemophages have shit to do to stay alive.
#define HEMOPHAGE_SPAWN_TEXT "You are an [span_danger("Hemophage")]. You will slowly but constantly lose blood if outside of a closet-like object. If inside a closet-like object, or in pure darkness, you will slowly heal, at the cost of blood. You may gain more blood by grabbing a live victim and using your drain ability."

/datum/species/hemophage
	name = "Hemophage"
	id = SPECIES_HEMOPHAGE
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_NOHUNGER,
		TRAIT_NOBREATH,
		TRAIT_OXYIMMUNE,
		TRAIT_VIRUSIMMUNE,
		TRAIT_LITERATE,
		TRAIT_DRINKS_BLOOD,
		TRAIT_USES_SKINTONES,
	)
	inherent_biotypes = MOB_HUMANOID | MOB_ORGANIC
	exotic_bloodtype = BLOOD_TYPE_UNIVERSAL
	mutantheart = /obj/item/organ/heart/hemophage
	mutantliver = /obj/item/organ/liver/hemophage
	mutantstomach = /obj/item/organ/stomach/hemophage
	mutanttongue = /obj/item/organ/tongue/hemophage
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	examine_limb_id = SPECIES_HUMAN
	skinned_type = /obj/item/stack/sheet/animalhide/carbon/human

/datum/species/hemophage/allows_food_preferences()
	return FALSE


/datum/species/hemophage/get_default_mutant_bodyparts()
	return list(
		FEATURE_LEGS = MUTPART_BLUEPRINT(NORMAL_LEGS, is_randomizable = FALSE, is_feature = TRUE),
	)


/datum/species/hemophage/check_roundstart_eligible()
	if(check_holidays(HALLOWEEN))
		return TRUE

	return ..()


/datum/species/hemophage/on_species_gain(mob/living/carbon/human/new_hemophage, datum/species/old_species, pref_load, regenerate_icons)
	. = ..()
	to_chat(new_hemophage, HEMOPHAGE_SPAWN_TEXT)
	new_hemophage.set_blood_volume(BLOOD_VOLUME_ROUNDSTART_HEMOPHAGE)
	new_hemophage.physiology.bleed_mod *= HEMOPHAGE_BLEED_MOD
	new_hemophage.update_body()


/datum/species/hemophage/on_species_loss(mob/living/carbon/human/former_hemophage, datum/species/new_species, pref_load)
	. = ..()
	former_hemophage.set_blood_volume(BLOOD_VOLUME_NORMAL)
	former_hemophage.physiology.bleed_mod /= HEMOPHAGE_BLEED_MOD
	former_hemophage.update_body()


/datum/species/hemophage/get_species_description()
	return "Oftentimes feared or pushed out of society for the predatory nature of their condition, \
		Hemophages are typically mixed around various Frontier populations, keeping their true nature hidden while \
		reaping both the benefits and easy access to prey, enjoying unpursued existences on the Frontier."


/datum/species/hemophage/get_species_lore()
	return list(
				"Though not technically a species all their own, Hemophages are a general catch-all term for individuals afflicted by a symbiotic infection. This infection - usually, but not always - is transmitted via bite from one infectee to another wherein a small organism is implanted through the bloodstream which eventually grows into the full symbiont. Beyond this, commonalities between each individual hemophage will vary, as the specific mutations and genetic traits of each organism can be radically different from others, each distinct type known as 'clades.'",

				"Despite the clade a symbiont will originate from: all share at least a few commonalities: the symbiont will attach to and rapidly integrate with major organ systems in the host's body. Initially this will start with the host's cardiovascular system but shortly thereafter, translucent tendrils from the tiny pitch-colored form of the symbiont will worm their way into the spinal column and eventually: the brain of the host. When it does, the host begins to not only psychologically, but also physically crave the consumption of blood in order to survive. Depending on the clade, these changes can take effect as early as hours after initial infection, though occurrance after a factor of days is not unheard of.",

				"Further changes occur in the host: the symbiont is heavily reliant on extremely rapid cell regeneration to sustain itself, which is disrupted by the presence of UV light. As a result, the host can start to experience heightened irritation in the presence of light and especially sunlight.",

				"Once fully integrated into the host, the now-Hemophagic individual finds themselves a changed entity; their thoughts, base instincts, and reactions altered - albeit usually subtly - to more accommodate the symbiont through its need for blood.",

				"These alterations are not without their benefits however:",

				"The extremely rapid regeneration of the symbiont, while similar to cancerous cells in many ways, offer a marked increase in healing in the host; as the symbiont attempts to repair itself by releasing hypercoagulant agents and healing factors into the bloodstream, resulting in small wounds healing extremely rapidly. All but the most virulent diseases find no purchase in the symbiont and its host, while carbon dioxide is recycled in the infected's altered lungs back into oxygen. Blood taken in by the host is rapidly converted into a usable antigen-agnostic blood type by the symbiont's bodily processes.",

				"All of this renders the infected individual into a new, conjoined being with its symbiont not long after infection. Separation of the two becomes next to impossible due to how rapidly and thoroughly the symbiont's tendrils spread into the host's systems. Some claim mastery of hidden, expensive, or painful procedures to 'cure' one of the symbiosis but the results these range from actively damaging to the host, to utterly useless.",

				"The exact benefits, transference methods, features, and side-effects of symbiosis have been documented to be exceptionally variable, depending on which specific clade a host's progenitor originates from. Some feature blackened blood and are wracked with constant pain, others find themselves largely unaffected outside of the craving for blood, others still hear the whisperings of others constantly in the back of their mind.",
	)


/datum/species/hemophage/prepare_human_for_preview(mob/living/carbon/human/human)
	human.skin_tone = "albino"
	human.hair_color = "#1d1d1d"
	human.hairstyle = "Pompadour (Big)"
	regenerate_organs(human, src, visual_only = TRUE)
	human.update_body(TRUE)


/datum/species/hemophage/create_pref_unique_perks()
	var/list/to_add = list()

	to_add += list(
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "moon",
			SPECIES_PERK_NAME = "Darkness Affinity",
			SPECIES_PERK_DESC = "A Hemophage is most at home in the darkness, as light artificial or \
								otherwise irritates their bodies and the cancer keeping them alive. \
								Modern \
								Hemophages have been known to use lockers as a convenient \
								source of darkness, while the extra protection they provide \
								against background radiations allows their tumor to avoid \
								having to expend any blood to maintain minimal bodily functions \
								so long as their host remains stationary in said locker.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "biohazard",
			SPECIES_PERK_NAME = "Viral Symbiosis",
			SPECIES_PERK_DESC = "Hemophages, due to their condition, cannot get infected by \
								other viruses and don't actually require an external source of oxygen \
								to stay alive.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = "tint",
			SPECIES_PERK_NAME = "The Thirst",
			SPECIES_PERK_DESC = "In place of eating, Hemophages suffer from the Thirst, caused by their tumor. \
								Thirst of what? Blood! Their tongue allows them to grab people and drink \
								their blood, and they will suffer severe consequences if they run out. As a note, \
								it doesn't matter whose blood you drink, it will all be converted into your blood \
								type when consumed. That being said, the blood of other sentient humanoids seems \
								to quench their Thirst for longer than otherwise-acquired blood would.",
		),
	)

	return to_add


/datum/species/hemophage/create_pref_blood_perks()
	var/list/to_add = list()

	to_add += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEUTRAL_PERK,
		SPECIES_PERK_ICON = "tint",
		SPECIES_PERK_NAME = "Universal Blood",
		SPECIES_PERK_DESC = "[plural_form] have blood that appears to be an amalgamation of all other \
							blood types, made possible thanks to some special antigens produced by \
							their tumor, making them able to receive blood of any other type, so \
							long as it is still human-like blood.",
		),
	)

	return to_add

/datum/species/hemophage/get_cry_sound(mob/living/carbon/human/hemophage)
	var/datum/species/human/human_species = GLOB.species_prototypes[/datum/species/human]
	return human_species.get_cry_sound(hemophage)

// We don't need to mention that they're undead, as the perks that come from it are otherwise already explicited, and they might no longer be actually undead from a gameplay perspective, eventually.
/datum/species/hemophage/create_pref_biotypes_perks()
	return


#undef HEMOPHAGE_SPAWN_TEXT
