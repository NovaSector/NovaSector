#define FEATURE_HASH_PART_START 1
#define FEATURE_HASH_PART_END (DNA_BLOCK_SIZE + 1)
#define FEATURE_HASH_COLOR1_START FEATURE_HASH_PART_END
#define FEATURE_HASH_COLOR1_END (FEATURE_HASH_COLOR1_START + DNA_BLOCK_SIZE_COLOR)
#define FEATURE_HASH_COLOR2_START FEATURE_HASH_COLOR1_END
#define FEATURE_HASH_COLOR2_END (FEATURE_HASH_COLOR2_START + DNA_BLOCK_SIZE_COLOR)
#define FEATURE_HASH_COLOR3_START FEATURE_HASH_COLOR2_END
#define FEATURE_HASH_COLOR3_END (FEATURE_HASH_COLOR3_START + DNA_BLOCK_SIZE_COLOR)

/datum/dna_block/feature
	/// Determines whether to check dna.mutant_bodyparts instead of dna.features for an entry
	var/mutant_part = FALSE
	var/abstract_type = /datum/dna_block/feature

/datum/dna_block/feature/mutant_color/two
	feature_key = FEATURE_MUTANT_COLOR_TWO

/datum/dna_block/feature/mutant_color/three
	feature_key = FEATURE_MUTANT_COLOR_THREE

/datum/dna_block/feature/mutant_color/skin_color
	feature_key = FEATURE_SKIN_COLOR

/datum/dna_block/feature/mutant
	block_length = DNA_FEATURE_BLOCKS_TOTAL_SIZE_PER_FEATURE
	mutant_part = TRUE
	abstract_type = /datum/dna_block/feature/mutant

/datum/dna_block/feature/mutant/create_unique_block(mob/living/carbon/human/target)
	if(isnull(target.dna.mutant_bodyparts[feature_key]))
		return random_string(block_length, GLOB.hex_characters)

	var/list/accessories_for_key = SSaccessories.sprite_accessories[feature_key]
	. = construct_block(accessories_for_key.Find(target.dna.mutant_bodyparts[feature_key][MUTANT_INDEX_NAME]), accessories_for_key.len)
	var/colors_left = DNA_FEATURE_COLOR_BLOCKS_PER_FEATURE
	for(var/color in target.dna.mutant_bodyparts[feature_key][MUTANT_INDEX_COLOR_LIST])
		colors_left--
		. += sanitize_hexcolor(color, include_crunch = FALSE)
	if(colors_left)
		. += random_string(DNA_BLOCK_SIZE_COLOR * colors_left, GLOB.hex_characters)

/datum/dna_block/feature/mutant/apply_to_mob(mob/living/carbon/human/target, dna_hash)
	var/our_block = get_block(dna_hash)
	var/feature_portion = copytext(our_block, FEATURE_HASH_PART_START, FEATURE_HASH_PART_END)
	var/accessory_index = deconstruct_block(feature_portion, length(SSaccessories.sprite_accessories[feature_key]))
	var/list/color_portions = list(
		sanitize_hexcolor(copytext(our_block, FEATURE_HASH_COLOR1_START, FEATURE_HASH_COLOR1_END)),
		sanitize_hexcolor(copytext(our_block, FEATURE_HASH_COLOR2_START, FEATURE_HASH_COLOR2_END)),
		sanitize_hexcolor(copytext(our_block, FEATURE_HASH_COLOR3_START, FEATURE_HASH_COLOR3_END)),
	)
	target.dna.mutant_bodyparts[feature_key][MUTANT_INDEX_NAME] = SSaccessories.sprite_accessories[feature_key][accessory_index]
	target.dna.mutant_bodyparts[feature_key][MUTANT_INDEX_COLOR_LIST] = color_portions
