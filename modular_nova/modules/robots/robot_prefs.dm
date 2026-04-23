/datum/preference/choiced/android_chassis_head
	savefile_key = "feature_android_chassis_head"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_FEATURES
	main_feature_name = "Chassis (Head)"
	should_generate_icons = TRUE
	priority = PREFERENCE_PRIORITY_BODYPARTS
	relevant_species = /datum/species/robot_nova

/datum/preference/choiced/android_chassis_head/init_possible_values()
	return assoc_to_keys_features(SSaccessories.android_chassis_list)

/datum/preference/choiced/android_chassis_head/icon_for(value)
	var/static/datum/universal_icon/base_robot_headless

	if (isnull(base_robot_headless))
		base_robot_headless = uni_icon('icons/mob/augmentation/augments.dmi', "robotic_chest")
		base_robot_headless.blend_icon(uni_icon('icons/mob/augmentation/augments.dmi', "robotic_l_arm"), ICON_OVERLAY)
		base_robot_headless.blend_icon(uni_icon('icons/mob/augmentation/augments.dmi', "robotic_r_arm"), ICON_OVERLAY)
		base_robot_headless.blend_icon(uni_icon('icons/mob/augmentation/augments.dmi', "robotic_l_hand"), ICON_OVERLAY)
		base_robot_headless.blend_icon(uni_icon('icons/mob/augmentation/augments.dmi', "robotic_r_hand"), ICON_OVERLAY)
		base_robot_headless.blend_icon(uni_icon('icons/mob/augmentation/augments.dmi', "robotic_l_leg"), ICON_OVERLAY)
		base_robot_headless.blend_icon(uni_icon('icons/mob/augmentation/augments.dmi', "robotic_r_leg"), ICON_OVERLAY)
		base_robot_headless.blend_color(rgb(122,122,122), ICON_MULTIPLY) // darken it so the new aug pops out

	var/datum/sprite_accessory/chassis = SSaccessories.android_chassis_list[value]

	var/datum/universal_icon/icon_with_chassis = base_robot_headless.copy()
	icon_with_chassis.blend_icon(uni_icon(chassis.icon, "[chassis.icon_state]_head"), ICON_OVERLAY)
	icon_with_chassis.blend_icon(uni_icon('icons/mob/human/human_face.dmi', "eyes_l"), ICON_OVERLAY)
	icon_with_chassis.blend_icon(uni_icon('icons/mob/human/human_face.dmi', "eyes_r"), ICON_OVERLAY)
	icon_with_chassis.scale(64, 64)
	icon_with_chassis.crop(15, 33, 46, 64)

	return icon_with_chassis

/datum/preference/choiced/android_chassis_head/apply_to_human(mob/living/carbon/human/target, value)
	var/datum/sprite_accessory/chassis = SSaccessories.android_chassis_list[value]
	for(var/obj/item/bodypart/limb as anything in target.bodyparts)
		if(limb.body_zone == BODY_ZONE_HEAD)
			limb.change_appearance(chassis.icon, chassis.icon_state, FALSE, FALSE)

/datum/preference/choiced/android_chassis_chest
	savefile_key = "feature_android_chassis_chest"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_FEATURES
	main_feature_name = "Chassis (Chest)"
	should_generate_icons = TRUE
	priority = PREFERENCE_PRIORITY_BODYPARTS
	relevant_species = /datum/species/robot_nova

/datum/preference/choiced/android_chassis_chest/init_possible_values()
	return assoc_to_keys_features(SSaccessories.android_chassis_list)

/datum/preference/choiced/android_chassis_chest/icon_for(value)
	var/static/datum/universal_icon/base_robot_chestless

	if (isnull(base_robot_chestless))
		base_robot_chestless = uni_icon('icons/mob/augmentation/augments.dmi', "robotic_head")
		base_robot_chestless.blend_icon(uni_icon('icons/mob/human/human_face.dmi', "eyes_l"), ICON_OVERLAY)
		base_robot_chestless.blend_icon(uni_icon('icons/mob/human/human_face.dmi', "eyes_r"), ICON_OVERLAY)
		base_robot_chestless.blend_icon(uni_icon('icons/mob/augmentation/augments.dmi', "robotic_l_arm"), ICON_OVERLAY)
		base_robot_chestless.blend_icon(uni_icon('icons/mob/augmentation/augments.dmi', "robotic_r_arm"), ICON_OVERLAY)
		base_robot_chestless.blend_icon(uni_icon('icons/mob/augmentation/augments.dmi', "robotic_l_hand"), ICON_OVERLAY)
		base_robot_chestless.blend_icon(uni_icon('icons/mob/augmentation/augments.dmi', "robotic_r_hand"), ICON_OVERLAY)
		base_robot_chestless.blend_icon(uni_icon('icons/mob/augmentation/augments.dmi', "robotic_l_leg"), ICON_OVERLAY)
		base_robot_chestless.blend_icon(uni_icon('icons/mob/augmentation/augments.dmi', "robotic_r_leg"), ICON_OVERLAY)
		base_robot_chestless.blend_color(rgb(64,64,64), ICON_MULTIPLY) // darken it so the new aug pops out

	var/datum/sprite_accessory/chassis = SSaccessories.android_chassis_list[value]

	var/datum/universal_icon/icon_with_chassis = base_robot_chestless.copy()
	icon_with_chassis.blend_icon(uni_icon(chassis.icon, "[chassis.icon_state]_chest"), ICON_OVERLAY)
	icon_with_chassis.scale(64, 64)
	icon_with_chassis.crop(15, 18, 46, 49)

	return icon_with_chassis

/datum/preference/choiced/android_chassis_chest/apply_to_human(mob/living/carbon/human/target, value)
	var/datum/sprite_accessory/chassis = SSaccessories.android_chassis_list[value]
	for(var/obj/item/bodypart/limb as anything in target.bodyparts)
		if(limb.body_zone == BODY_ZONE_CHEST)
			limb.change_appearance(chassis.icon, chassis.icon_state, FALSE, FALSE)


/datum/preference/choiced/android_chassis_l_arm
	savefile_key = "feature_android_chassis_l_arm"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_FEATURES
	main_feature_name = "Chassis (Left Arm)"
	should_generate_icons = TRUE
	priority = PREFERENCE_PRIORITY_BODYPARTS
	relevant_species = /datum/species/robot_nova

/datum/preference/choiced/android_chassis_l_arm/init_possible_values()
	return assoc_to_keys_features(SSaccessories.android_chassis_list)

/datum/preference/choiced/android_chassis_l_arm/icon_for(value)
	var/static/datum/universal_icon/base_robot_l_armless

	if (isnull(base_robot_l_armless))
		base_robot_l_armless = uni_icon('icons/mob/augmentation/augments.dmi', "robotic_head")
		base_robot_l_armless.blend_icon(uni_icon('icons/mob/human/human_face.dmi', "eyes_l"), ICON_OVERLAY)
		base_robot_l_armless.blend_icon(uni_icon('icons/mob/human/human_face.dmi', "eyes_r"), ICON_OVERLAY)
		base_robot_l_armless = uni_icon('icons/mob/augmentation/augments.dmi', "robotic_chest")
		base_robot_l_armless.blend_icon(uni_icon('icons/mob/augmentation/augments.dmi', "robotic_r_arm"), ICON_OVERLAY)
		base_robot_l_armless.blend_icon(uni_icon('icons/mob/augmentation/augments.dmi', "robotic_r_hand"), ICON_OVERLAY)
		base_robot_l_armless.blend_icon(uni_icon('icons/mob/augmentation/augments.dmi', "robotic_l_leg"), ICON_OVERLAY)
		base_robot_l_armless.blend_icon(uni_icon('icons/mob/augmentation/augments.dmi', "robotic_r_leg"), ICON_OVERLAY)
		base_robot_l_armless.blend_color(rgb(64,64,64), ICON_MULTIPLY) // darken it so the new aug pops out

	var/datum/sprite_accessory/chassis = SSaccessories.android_chassis_list[value]

	var/datum/universal_icon/icon_with_chassis = base_robot_l_armless.copy()
	icon_with_chassis.blend_icon(uni_icon(chassis.icon, "[chassis.icon_state]_l_arm"), ICON_OVERLAY)
	icon_with_chassis.scale(64, 64)
	icon_with_chassis.crop(15, 18, 46, 49)

	return icon_with_chassis

/datum/preference/choiced/android_chassis_l_arm/apply_to_human(mob/living/carbon/human/target, value)
	var/datum/sprite_accessory/chassis = SSaccessories.android_chassis_list[value]
	for(var/obj/item/bodypart/limb as anything in target.bodyparts)
		if(limb.body_zone == BODY_ZONE_L_ARM)
			limb.change_appearance(chassis.icon, chassis.icon_state, FALSE, FALSE)


/datum/preference/choiced/android_chassis_r_arm
	savefile_key = "feature_android_chassis_r_arm"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_FEATURES
	main_feature_name = "Chassis (Right Arm)"
	should_generate_icons = TRUE
	priority = PREFERENCE_PRIORITY_BODYPARTS
	relevant_species = /datum/species/robot_nova

/datum/preference/choiced/android_chassis_r_arm/init_possible_values()
	return assoc_to_keys_features(SSaccessories.android_chassis_list)

/datum/preference/choiced/android_chassis_r_arm/icon_for(value)
	var/static/datum/universal_icon/base_robot_r_armless

	if (isnull(base_robot_r_armless))
		base_robot_r_armless = uni_icon('icons/mob/augmentation/augments.dmi', "robotic_head")
		base_robot_r_armless.blend_icon(uni_icon('icons/mob/human/human_face.dmi', "eyes_l"), ICON_OVERLAY)
		base_robot_r_armless.blend_icon(uni_icon('icons/mob/human/human_face.dmi', "eyes_r"), ICON_OVERLAY)
		base_robot_r_armless = uni_icon('icons/mob/augmentation/augments.dmi', "robotic_chest")
		base_robot_r_armless.blend_icon(uni_icon('icons/mob/augmentation/augments.dmi', "robotic_l_arm"), ICON_OVERLAY)
		base_robot_r_armless.blend_icon(uni_icon('icons/mob/augmentation/augments.dmi', "robotic_l_hand"), ICON_OVERLAY)
		base_robot_r_armless.blend_icon(uni_icon('icons/mob/augmentation/augments.dmi', "robotic_l_leg"), ICON_OVERLAY)
		base_robot_r_armless.blend_icon(uni_icon('icons/mob/augmentation/augments.dmi', "robotic_r_leg"), ICON_OVERLAY)
		base_robot_r_armless.blend_color(rgb(64,64,64), ICON_MULTIPLY) // darken it so the new aug pops out

	var/datum/sprite_accessory/chassis = SSaccessories.android_chassis_list[value]

	var/datum/universal_icon/icon_with_chassis = base_robot_r_armless.copy()
	icon_with_chassis.blend_icon(uni_icon(chassis.icon, "[chassis.icon_state]_r_arm"), ICON_OVERLAY)
	icon_with_chassis.scale(64, 64)
	icon_with_chassis.crop(15, 18, 46, 49)

	return icon_with_chassis

/datum/preference/choiced/android_chassis_r_arm/apply_to_human(mob/living/carbon/human/target, value)
	var/datum/sprite_accessory/chassis = SSaccessories.android_chassis_list[value]
	for(var/obj/item/bodypart/limb as anything in target.bodyparts)
		if(limb.body_zone == BODY_ZONE_R_ARM)
			limb.change_appearance(chassis.icon, chassis.icon_state, FALSE, FALSE)

/datum/preference/choiced/android_chassis_l_leg
	savefile_key = "feature_android_chassis_l_leg"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_FEATURES
	main_feature_name = "Chassis (Left Leg)"
	should_generate_icons = TRUE
	priority = PREFERENCE_PRIORITY_BODYPARTS
	relevant_species = /datum/species/robot_nova

/datum/preference/choiced/android_chassis_l_leg/init_possible_values()
	return assoc_to_keys_features(SSaccessories.android_chassis_list)

/datum/preference/choiced/android_chassis_l_leg/icon_for(value)
	var/static/datum/universal_icon/base_robot_l_legless

	if (isnull(base_robot_l_legless))
		base_robot_l_legless = uni_icon('icons/mob/augmentation/augments.dmi', "robotic_head")
		base_robot_l_legless.blend_icon(uni_icon('icons/mob/human/human_face.dmi', "eyes_l"), ICON_OVERLAY)
		base_robot_l_legless.blend_icon(uni_icon('icons/mob/human/human_face.dmi', "eyes_r"), ICON_OVERLAY)
		base_robot_l_legless = uni_icon('icons/mob/augmentation/augments.dmi', "robotic_chest")
		base_robot_l_legless.blend_icon(uni_icon('icons/mob/augmentation/augments.dmi', "robotic_l_arm"), ICON_OVERLAY)
		base_robot_l_legless.blend_icon(uni_icon('icons/mob/augmentation/augments.dmi', "robotic_l_hand"), ICON_OVERLAY)
		base_robot_l_legless.blend_icon(uni_icon('icons/mob/augmentation/augments.dmi', "robotic_r_arm"), ICON_OVERLAY)
		base_robot_l_legless.blend_icon(uni_icon('icons/mob/augmentation/augments.dmi', "robotic_r_hand"), ICON_OVERLAY)
		base_robot_l_legless.blend_icon(uni_icon('icons/mob/augmentation/augments.dmi', "robotic_r_leg"), ICON_OVERLAY)
		base_robot_l_legless.blend_color(rgb(64,64,64), ICON_MULTIPLY) // darken it so the new aug pops out

	var/datum/sprite_accessory/chassis = SSaccessories.android_chassis_list[value]

	var/datum/universal_icon/icon_with_chassis = base_robot_l_legless.copy()
	icon_with_chassis.blend_icon(uni_icon(chassis.icon, "[chassis.icon_state]_l_leg"), ICON_OVERLAY)
	icon_with_chassis.scale(64, 64)
	icon_with_chassis.crop(15, 1, 46, 32)

	return icon_with_chassis

/datum/preference/choiced/android_chassis_l_leg/apply_to_human(mob/living/carbon/human/target, value)
	var/datum/sprite_accessory/chassis = SSaccessories.android_chassis_list[value]
	for(var/obj/item/bodypart/limb as anything in target.bodyparts)
		if(limb.body_zone == BODY_ZONE_L_LEG)
			limb.change_appearance(chassis.icon, chassis.icon_state, FALSE, FALSE)

/datum/preference/choiced/android_chassis_r_leg
	savefile_key = "feature_android_chassis_r_leg"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_FEATURES
	main_feature_name = "Chassis (Right Leg)"
	should_generate_icons = TRUE
	priority = PREFERENCE_PRIORITY_BODYPARTS
	relevant_species = /datum/species/robot_nova

/datum/preference/choiced/android_chassis_r_leg/init_possible_values()
	return assoc_to_keys_features(SSaccessories.android_chassis_list)

/datum/preference/choiced/android_chassis_r_leg/icon_for(value)
	var/static/datum/universal_icon/base_robot_r_legless

	if (isnull(base_robot_r_legless))
		base_robot_r_legless = uni_icon('icons/mob/augmentation/augments.dmi', "robotic_head")
		base_robot_r_legless.blend_icon(uni_icon('icons/mob/human/human_face.dmi', "eyes_l"), ICON_OVERLAY)
		base_robot_r_legless.blend_icon(uni_icon('icons/mob/human/human_face.dmi', "eyes_r"), ICON_OVERLAY)
		base_robot_r_legless = uni_icon('icons/mob/augmentation/augments.dmi', "robotic_chest")
		base_robot_r_legless.blend_icon(uni_icon('icons/mob/augmentation/augments.dmi', "robotic_l_arm"), ICON_OVERLAY)
		base_robot_r_legless.blend_icon(uni_icon('icons/mob/augmentation/augments.dmi', "robotic_l_hand"), ICON_OVERLAY)
		base_robot_r_legless.blend_icon(uni_icon('icons/mob/augmentation/augments.dmi', "robotic_r_arm"), ICON_OVERLAY)
		base_robot_r_legless.blend_icon(uni_icon('icons/mob/augmentation/augments.dmi', "robotic_r_hand"), ICON_OVERLAY)
		base_robot_r_legless.blend_icon(uni_icon('icons/mob/augmentation/augments.dmi', "robotic_l_leg"), ICON_OVERLAY)
		base_robot_r_legless.blend_color(rgb(64,64,64), ICON_MULTIPLY) // darken it so the new aug pops out

	var/datum/sprite_accessory/chassis = SSaccessories.android_chassis_list[value]

	var/datum/universal_icon/icon_with_chassis = base_robot_r_legless.copy()
	icon_with_chassis.blend_icon(uni_icon(chassis.icon, "[chassis.icon_state]_r_leg"), ICON_OVERLAY)
	icon_with_chassis.scale(64, 64)
	icon_with_chassis.crop(15, 1, 46, 32)

	return icon_with_chassis

/datum/preference/choiced/android_chassis_r_leg/apply_to_human(mob/living/carbon/human/target, value)
	var/datum/sprite_accessory/chassis = SSaccessories.android_chassis_list[value]
	for(var/obj/item/bodypart/limb as anything in target.bodyparts)
		if(limb.body_zone == BODY_ZONE_R_LEG)
			limb.change_appearance(chassis.icon, chassis.icon_state, FALSE, FALSE)

/datum/preference/choiced/android_stomach
	savefile_key = "feature_android_stomach"
	main_feature_name = "Engine Choice"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	priority = PREFERENCE_PRIORITY_BODYPARTS // we need to run after species application so we can jam the right organs in
	relevant_species = /datum/species/robot_nova

/datum/preference/choiced/android_stomach/init_possible_values()
	return list(
		"Liquid Fuel Engine (Alcohol/Flammable Liquids)",
		"Biofuel Engine (Solid Food)",
		"Weak Combo Engine (Food/Liquids)",
		"Soda Brand Engine (Random Soda)",
		"Illegal APC Power Cable (CONTRABAND)",
	)

/datum/preference/choiced/android_stomach/apply_to_human(mob/living/carbon/human/target, value)
	switch(value)
		if("Liquid Fuel Engine (Alcohol/Flammable Liquids)")
			var/obj/item/organ/stomach/fuel_generator/engine = new(target)
			engine.Insert(target, special = TRUE, movement_flags = DELETE_IF_REPLACED)
		if("Biofuel Engine (Solid Food)")
			var/obj/item/organ/stomach/fuel_generator/biofuel/engine = new(target)
			engine.Insert(target, special = TRUE, movement_flags = DELETE_IF_REPLACED)
		if("Weak Combo Engine (Food/Liquids)")
			var/obj/item/organ/stomach/fuel_generator/combo/engine = new(target)
			engine.Insert(target, special = TRUE, movement_flags = DELETE_IF_REPLACED)
		if("Soda Brand Engine (Random Soda)")
			var/obj/item/organ/stomach/fuel_generator/brand/engine = new(target)
			engine.Insert(target, special = TRUE, movement_flags = DELETE_IF_REPLACED)
		if("Illegal APC Power Cable (CONTRABAND)")
			var/obj/item/organ/stomach/fuel_generator/power_cable/engine = new(target)
			engine.Insert(target, special = TRUE, movement_flags = DELETE_IF_REPLACED)

/datum/preference/choiced/android_stomach/create_default_value()
	return "Liquid Fuel Engine (Alcohol/Flammable Liquids)"

/datum/preference/choiced/android_appendix
	savefile_key = "feature_android_appendix"
	main_feature_name = "Extra Part Choice"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	priority = PREFERENCE_PRIORITY_BODYPARTS // we need to run after species application so we can jam the right organs in
	relevant_species = /datum/species/robot_nova

/datum/preference/choiced/android_appendix/init_possible_values()
	return list(
		"Graphics Processing Unit (Power Generation)",
		"Emotion Processing Unit (Enables Mood)",
	)

/datum/preference/choiced/android_appendix/apply_to_human(mob/living/carbon/human/target, value)
	switch(value)
		if("Graphics Processing Unit (Power Generation)")
			var/obj/item/organ/appendix/random_number_database/gpu = new(target)
			gpu.Insert(target, special = TRUE, movement_flags = DELETE_IF_REPLACED)
		if("Emotion Processing Unit (Enables Mood)")
			var/obj/item/organ/appendix/emotion_chip/epu = new(target)
			epu.Insert(target, special = TRUE, movement_flags = DELETE_IF_REPLACED)

/datum/preference/choiced/android_appendix/create_default_value()
	return "Graphics Processing Unit (Power Generation)"
