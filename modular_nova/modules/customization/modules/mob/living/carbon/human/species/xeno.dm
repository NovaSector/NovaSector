/datum/species/xeno
	// A cloning mistake, crossing human and xenomorph DNA
	name = "Xenomorph Hybrid"
	id = SPECIES_XENO
	family_heirlooms = list(/obj/item/toy/plush/rouny, /obj/item/clothing/mask/facehugger/toy)
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_LITERATE,
		TRAIT_MUTANT_COLORS,
	)
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID
	mutantbrain = /obj/item/organ/brain/xeno_hybrid
	mutanttongue = /obj/item/organ/tongue/xeno_hybrid
	mutantliver = /obj/item/organ/liver/xeno_hybrid
	mutantstomach = /obj/item/organ/stomach/xeno_hybrid
	mutant_organs = list(
		/obj/item/organ/alien/plasmavessel/roundstart,
		/obj/item/organ/alien/resinspinner/roundstart,
		/obj/item/organ/alien/hivenode,
		)
	exotic_blood = /datum/reagent/toxin/acid
	exotic_bloodtype = "X*"
	heatmod = 2.5
	mutant_bodyparts = list()
	payday_modifier = 1.0
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/mutant/xenohybrid,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/mutant/xenohybrid,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/mutant/xenohybrid,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/mutant/xenohybrid,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/digitigrade/xenohybrid,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/digitigrade/xenohybrid,
	)

	meat = /obj/item/food/meat/slab/xeno
	skinned_type = /obj/item/stack/sheet/animalhide/xeno
	death_sound = 'sound/mobs/non-humanoids/hiss/hiss6.ogg'
	gib_anim = "gibbed-a"

/datum/species/xeno/get_default_mutant_bodyparts()
	return list(
		"tail" = list("Xenomorph Tail", FALSE),
		"xenodorsal" = list("Standard", TRUE),
		"xenohead" = list("Standard", TRUE),
		"legs" = list(DIGITIGRADE_LEGS,FALSE),
		"taur" = list("None", FALSE),
	)

/datum/species/xeno/get_species_description()
	return placeholder_description

/datum/species/xeno/get_species_lore()
	return list(placeholder_lore)

/datum/species/xeno/create_pref_unique_perks()
	var/list/to_add = list()

	to_add += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = "biohazard",
		SPECIES_PERK_NAME = "Xenomorphic Biology",
		SPECIES_PERK_DESC = "Xeno-hybrids inherit organs from their primal ascendants."
	))

	to_add += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
		SPECIES_PERK_ICON = "fire",
		SPECIES_PERK_NAME = "High Temperature Weakness",
		SPECIES_PERK_DESC = "A partial silicone structure and acid blood make the xeno-hybrid species extremely weak to heat."
	))

	return to_add

/datum/species/xeno/prepare_human_for_preview(mob/living/carbon/human/xeno)
	var/xeno_color = "#525288"
	xeno.dna.features["mcolor"] = xeno_color
	xeno.eye_color_left = "#30304F"
	xeno.eye_color_right = "#30304F"
	xeno.dna.mutant_bodyparts["tail"] = list(MUTANT_INDEX_NAME = "Xenomorph Tail", MUTANT_INDEX_COLOR_LIST = list(xeno_color, xeno_color, xeno_color))
	xeno.dna.mutant_bodyparts["xenodorsal"] = list(MUTANT_INDEX_NAME = "Standard", MUTANT_INDEX_COLOR_LIST = list(xeno_color))
	xeno.dna.mutant_bodyparts["xenohead"] = list(MUTANT_INDEX_NAME = "Standard", MUTANT_INDEX_COLOR_LIST = list(xeno_color, xeno_color, xeno_color))
	regenerate_organs(xeno, src, visual_only = TRUE)
	xeno.update_body(TRUE)

/datum/species/xeno/on_species_gain(mob/living/carbon/human/human_who_gained_species, datum/species/old_species, pref_load)
	. = ..()
	human_who_gained_species.gib_type = /obj/effect/decal/cleanable/xenoblood/xgibs

/datum/species/xeno/on_species_loss(mob/living/carbon/human/human_who_lost_species, datum/species/new_species, pref_load)
	. = ..()
	human_who_lost_species.gib_type = initial(human_who_lost_species.gib_type)

//Xenohybrid blood trails
/mob/living/carbon/human/getTrail()
	if(get_blood_id() != /datum/reagent/toxin/acid)
		return ..()
	if(getBruteLoss() < 300)
		return pick (list("xltrails_1", "xltrails2"))
	else
		return pick (list("xttrails_1", "xttrails2"))

///Xenohybrid additional blood color decals
/obj/effect/decal/cleanable/blood/hitsplatter/xenoblood
	icon = 'modular_nova/master_files/icons/effects/x_blood.dmi'
	icon_state = "xhitsplatter1"
	random_icon_states = list("xhitsplatter1", "xhitsplatter2", "xhitsplatter3")
	blood_state = BLOOD_STATE_XENO
	blood_dna_info = list("UNKNOWN DNA" = "X*")

/obj/effect/decal/cleanable/xenoblood/xsplatter/over_window // special layer/plane set to appear on windows
	layer = ABOVE_WINDOW_LAYER
	plane = GAME_PLANE
	vis_flags = VIS_INHERIT_PLANE
	alpha = 180

/obj/effect/decal/cleanable/blood/drip/xenoblood
	name = "drips of blood"
	desc = "It's green."
	icon = 'modular_nova/master_files/icons/effects/x_blood.dmi'
	icon_state = "xdrip5"
	random_icon_states = list("xdrip1","xdrip2","xdrip3","xdrip4","xdrip5")
	should_dry = FALSE //human only thing
	blood_state = BLOOD_STATE_XENO
	beauty = -150

/obj/effect/decal/cleanable/blood/drip/xenoblood/Initialize(mapload)
	. = ..()
	add_blood_DNA(list("UNKNOWN DNA" = "X*"))

///Xenomorph organs modified to suit roundstart styling
#define BUILD_DURATION 0.5 SECONDS

//Plasma vessel
/obj/item/organ/alien/plasmavessel/roundstart
	stored_plasma = 55
	max_plasma = 55
	plasma_rate = 2
	heal_rate = 1.5
	actions_types = list(
		/datum/action/cooldown/alien/make_structure/plant_weeds/roundstart,
		/datum/action/cooldown/alien/transfer,
	)

/datum/action/cooldown/alien/make_structure/plant_weeds
	var/build_duration = 0 SECONDS //regular aliens can build instantly

/datum/action/cooldown/alien/make_structure/plant_weeds/roundstart
	build_duration = BUILD_DURATION //hybrids are a bit slower

/datum/action/cooldown/alien/make_structure/plant_weeds/Activate(atom/target)
	if(build_duration && !do_after(owner, build_duration))
		owner.balloon_alert(owner, "interrupted!")
		return
	return ..()

//Resin spinner
/obj/item/organ/alien/resinspinner/roundstart
	actions_types = list(/datum/action/cooldown/alien/make_structure/resin/roundstart)

/datum/action/cooldown/alien/make_structure/resin
	var/build_duration = 0 SECONDS

/datum/action/cooldown/alien/make_structure/resin/roundstart
	build_duration = BUILD_DURATION
	//Non-modularly checked in `code\modules\mob\living\carbon\alien\adult\alien_powers.dm`

//Organ resprites
/obj/item/organ/brain/xeno_hybrid
	icon_state = "brain-x" //rebranding

/obj/item/organ/stomach/xeno_hybrid
	icon_state = "stomach-x"

/obj/item/organ/liver/xeno_hybrid
	icon_state = "liver-x"

//Liver modification (xenohybrids can process plasma!)
/obj/item/organ/liver/xeno_hybrid/handle_chemical(mob/living/carbon/owner, datum/reagent/toxin/chem, seconds_per_tick, times_fired)
	. = ..()
	if(. & COMSIG_MOB_STOP_REAGENT_CHECK)
		return
	if(chem.type == /datum/reagent/toxin/plasma)
		chem.toxpwr = 0

#undef BUILD_DURATION

///Xenohybrid gib and dust tweaks
/mob/living/carbon/human/spawn_gibs(drop_bitflags=NONE)
	if(!isxenohybrid(src))
		return ..()
	if(drop_bitflags & DROP_BODYPARTS)
		new /obj/effect/gibspawner/xeno(drop_location(), src, get_static_viruses())
	else
		new /obj/effect/gibspawner/xeno/bodypartless(drop_location(), src, get_static_viruses())

/mob/living/carbon/human/spawn_dust(just_ash = FALSE)
	if(!isxenohybrid(src))
		return ..()
	if(just_ash)
		new /obj/effect/decal/cleanable/ash(loc)
	else
		new /obj/effect/decal/remains/xeno(loc)
