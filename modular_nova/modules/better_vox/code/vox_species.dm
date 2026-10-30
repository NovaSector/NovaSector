/datum/species/vox_primalis
	name = "Vox Primalis"
	id = SPECIES_VOX_PRIMALIS
	can_augment = FALSE
	body_size_restricted = TRUE
	digitigrade_customization = DIGITIGRADE_NEVER // We have our own unique sprites!
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_LITERATE,
		TRAIT_MUTANT_COLORS,
	)
	inherent_biotypes = MOB_ORGANIC | MOB_HUMANOID
	mutantlungs = /obj/item/organ/lungs/nitrogen/vox
	mutantbrain = /obj/item/organ/brain/cybernetic/cortical/vox //reparented vox brain
	meat = /obj/item/food/meat/slab/chicken/human

	mutanttongue = /obj/item/organ/tongue/vox
	payday_modifier = 1.0
	outfit_important_for_life = /datum/outfit/vox
	species_language_holder = /datum/language_holder/vox
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT

	// Vox are cold resistant, but also heat sensitive
	bodytemp_heat_damage_limit = (BODYTEMP_HEAT_DAMAGE_LIMIT - 15) // being cold resistant, should make you heat sensitive actual effect ingame isn't much
	bodytemp_cold_damage_limit = (BODYTEMP_COLD_DAMAGE_LIMIT - 30)

	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/mutant/vox_primalis,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/mutant/vox_primalis,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/mutant/vox_primalis,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/mutant/vox_primalis,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/mutant/vox_primalis,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/mutant/vox_primalis,
	)
	custom_worn_icons = list(
		LOADOUT_ITEM_HEAD = VOX_PRIMALIS_HEAD_ICON,
		LOADOUT_ITEM_MASK = VOX_PRIMALIS_MASK_ICON,
		LOADOUT_ITEM_SUIT = VOX_PRIMALIS_SUIT_ICON,
		LOADOUT_ITEM_UNIFORM = VOX_PRIMALIS_UNIFORM_ICON,
		LOADOUT_ITEM_GLOVES =  VOX_PRIMALIS_GLOVES_ICON,
		LOADOUT_ITEM_SHOES = VOX_PRIMALIS_FEET_ICON,
		LOADOUT_ITEM_GLASSES = VOX_PRIMALIS_EYES_ICON,
		LOADOUT_ITEM_BELT = VOX_PRIMALIS_BELT_ICON,
		LOADOUT_ITEM_MISC = VOX_PRIMALIS_BACK_ICON,
		LOADOUT_ITEM_EARS = VOX_PRIMALIS_EARS_ICON,
	)

/datum/species/vox_primalis/get_default_mutant_bodyparts()
	return list(
		FEATURE_TAIL = MUTPART_BLUEPRINT("Vox Primalis Tail", is_randomizable = FALSE),
	)

/datum/species/vox_primalis/pre_equip_species_outfit(datum/job/job, mob/living/carbon/human/equipping, visuals_only)
	. = ..()
	if(job?.vox_outfit)
		equipping.equipOutfit(job.vox_outfit, visuals_only)
	else
		give_important_for_life(equipping)

/datum/species/vox_primalis/get_custom_worn_icon(item_slot, obj/item/item)
	return item.worn_icon_better_vox

/datum/species/vox_primalis/set_custom_worn_icon(item_slot, obj/item/item, icon/icon)
	item.worn_icon_better_vox = icon

/datum/species/vox_primalis/get_species_description()
	return "The Vox seem to be nomadic, bio-engineered alien creatures that operate in and around human space for scientific purposes. \
			The average Vox is a digitigrade, reptilian biped with stiff, semi-rigid keratin quills on their head, a long prehensile tail, and a teethed and bilaterally-split jaw. They breathe Nitrogen, and suffer from oxygen. \
			The massive moon-sized Arkships that serve as their homes travel meandering and convoluted migratory trails through the Milky Way, and the appearance of their looted and repurposed ships is almost always a cause for attention."

/datum/species/vox_primalis/get_species_lore()
	return list(
		"https://wiki.novasector13.com/wiki/Lore:Vox",
		"The species 'Vox' and 'Vox Primalis' are the same species; spriting and code issues demand separate species.",

		"In simple words: Vox are strange. They have skin and bone but also metal? They ask a lot of questions and do a lot of learning. We don't know why! They can be found almost anywhere and their home is a moving group of big ships. \
			They are as tall as people, have quills, two legs, three or four eyes, and while their body is different, a doctor can give them the same help that they give to a human. They also have body writing that we don't understand. \
			Watch out! They breathe Nitrogen and not normal air.",
		"Further simply explained: Vox work in thinking teams to ask questions and get answers. Some of these teams are big enough to need an entire space ship, called an Arkship. \
			Vox like to write stories about what they have done, and what they can make. Stories about how to make things are \"Advancements,\" and stories about what not to do are \"Parables.\" Vox like to help each other write these. ",

		"The average Vox is a digitigrade, reptilian biped with stiff, semi-rigid keratin quills on their head, a long prehensile tail, and a teethed and bilaterally-split jaw. They have a flexible and lightweight skeleton and a two-channel redundant nervous system. They generally stand anywhere from 1.3 to 2 meters tall, averaging at 1.5 for most Vox, with a primarily green and brown coloration, but can have different colored quills and body markings. Their bodies are scaled with rigid, nonconducting plates in overlapping rows, which can be bristled or flattened at will to optimize cooling or form interior seals as to retain heat. Their aforementioned quills act as a supplementary cooling system, with tiny capillaries allowing bloodflow into the hollow recesses inside of the quills, which they may often violently shake to produce a cooling effect with the air; this also functions as a threat display, as many Vox will attempt to cool themselves down before engaging in a fight as to regulate their body-temperature though exertion. They do not respirate as humans do, but they do require a nitrogen-rich atmosphere to 'breathe', and suffer badly in the presence of oxygen. Their musculature is geared towards sudden bursts of rapid movement, with a vulnerability to lactic acid buildup as a result. ",

		"The Vox body markings culturally exist to identify a Vox's topic of research, their present skillsets, their past accomplishments, and active experiments. Of particular note are the Voxform's position in the Tree, and any possible Publications they have notably Contributed to. Alas, there is no standardized format or verification of these markings, as the Individuality Team found greater detriment to mass standardization than the Qualiolinguistics Transferrence Team found benefit. ",
		"The Cortical Stack is a closely-kept Vox secret: each Vox is the mind, memories, and skills encapsulated in a comparatively small biomechanical organ, the Cortical Stack. The Cortical Stack is transplanted between different Voxforms as death or need of differing Voxforms occur. The Cortical Stack holds the Resonance of the Vox, as well as critical memories crucial to that Vox's sense of self and ability to contribute. The Voxform's brain holds the specific motor skills unique to that Voxform, as well as basic cultural knowledge and task analysis. As a result, modern Vox may literally have more progressive views than Vox remaining in older Voxforms. The Cortical Stack was intentionally designed to internally cannibalize a Voxform upon the body's death, sustaining the core Vox self through intensely dire situations and over extended durations, similar to how a human's gut biome will digest itself posthumously. ",


		"All Vox culture is derived from a single tenet, the Grand Vision. From this axiom comes the rest of their civilization. Loosely translated into Sol Common:",

		"Vox will achieve the End of Science.",

		"Vox are strictly organized into research teams, each tracing a line of sub-teams and committees up the 'Tree' to the core question at the heart of each Arkship.",
		"Vox have twelve words for these research groups, discerning size, intent, likelihood of being on the critical path to the end of Science, and notoriety, but the Universal Linguistics Information Redundancy Team strongly suggests that each research group be referred to in other languages strictly as a Team. More prominent teams include the Diplomacy Team, Violence Team, Productivity Team (mockingly known as the Team Team), Materials Team (notably split along the Organics, Inorganics, and Applied Materials Teams), and Immaterials Team. Almost every lesser Team can trace their way up the Tree to one of these teams, almost as much a historical record as an organizational chart. An individual Vox belongs to only one team at any given moment in their life, though are often commissioned by other teams to conduct parallel research as they pursue their main vision. ",
		"Vox are organized into Arkships, massive interstellar vessels dedicated to a research topic, with the largest supposedly dwarfing most planets. A mixture of inorganic and organic technologies, these ships grow with effort and necessity, absorbing flesh and metal in equal measures into their superstructures. Each Arkship's research topic, or Vision, tends to be as broad as the ship is large, with obvious exceptions for research into size-related matters. The Diplomacy Team serves aboard the largest known Arkship, whose name is incomprehensibly long, oft shortened to \"The Tongue\". When one Vox refers to the Arkships, they typically mean the most prominent ones, though any vessel which hosts Vox and a focused mission qualifies. Arkships are known to host specific inquiries and research fields as subsets of the primary Vision. This Arkship organization is a result of early Productivity Team inquests with the Immaterials' Data Transfer and Storage research, finding an optimum between research mobility, data locality, and cross-research applications. Modern Productivity Team findings, especially in a post-Bluespace era, would not reach the same conclusions, but the Cultural Monolith Team and Repurposement Initiative separately concluded that disassembling the Arkships for decentralized research stations would be both cruel, inefficient, and culturally suppressive. ",

		"If your attention has somehow been kept through this entire summary, kindly investigate the main Vox writeup at https://wiki.novasector13.com/wiki/Lore:Vox",
	)

/datum/species/vox_primalis/on_species_gain(mob/living/carbon/human/transformer, datum/species/old_species, pref_load, regenerate_icons)
	. = ..()
	var/vox_color = transformer.dna.features["vox_bodycolor"]
	if(!vox_color || vox_color == "default")
		return
	for(var/obj/item/bodypart/limb as anything in transformer.bodyparts)
		limb.limb_id = "[SPECIES_VOX_PRIMALIS]_[vox_color]"
	transformer.update_body()
