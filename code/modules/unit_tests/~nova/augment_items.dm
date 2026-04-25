/datum/unit_test/augment_items

/datum/unit_test/augment_items/Run()
	var/list/slot_to_display = list(
		BODY_ZONE_L_ARM          = AUGMENT_SLOT_L_ARM,
		BODY_ZONE_PRECISE_L_HAND = AUGMENT_SLOT_L_HAND,
		BODY_ZONE_L_LEG          = AUGMENT_SLOT_L_LEG,
		BODY_ZONE_R_ARM          = AUGMENT_SLOT_R_ARM,
		BODY_ZONE_PRECISE_R_HAND = AUGMENT_SLOT_R_HAND,
		BODY_ZONE_R_LEG          = AUGMENT_SLOT_R_LEG,
		BODY_ZONE_HEAD           = AUGMENT_SLOT_HEAD,
		BODY_ZONE_CHEST          = AUGMENT_SLOT_CHEST,
	)
	var/list/flag_to_display = alist(
		ARM_LEFT   = AUGMENT_SLOT_L_ARM,
		ARM_RIGHT = AUGMENT_SLOT_R_ARM,
		LEG_LEFT   = AUGMENT_SLOT_L_LEG,
		LEG_RIGHT  = AUGMENT_SLOT_R_LEG,
		HEAD       = AUGMENT_SLOT_HEAD,
		CHEST      = AUGMENT_SLOT_CHEST,
		HAND_LEFT  = AUGMENT_SLOT_L_HAND,
		HAND_RIGHT = AUGMENT_SLOT_R_HAND,
	)

	for(var/datum/augment_item/limb/augment_path, augment_instance in GLOB.augment_items)
		var/datum/augment_item/limb/aug = augment_instance

		var/slot = aug.slot
		if(isnull(aug.slot))
			TEST_FAIL("[aug] does not have a slot set!")
			continue
		var/body_zone = aug.body_zone
		if(isnull(body_zone))
			TEST_FAIL("[aug] does not have a body_zone set!")
			continue
		var/slot_flag = aug.slot_flag
		if(isnull(flag_to_display[slot_flag]))
			TEST_FAIL("[aug] has an invalid slot_flag value of [slot_flag]! valid values include: CHEST, LEG_LEFT, NONE")
			continue

		var/expected_slot = slot_to_display[body_zone]
		TEST_ASSERT_EQUAL(slot, expected_slot, "augment_item [augment_path] has slot '[aug.slot]' but expected '[expected_slot]' from body_zone '[body_zone]'")

		var/expected_flag = flag_to_display[slot_flag]
		TEST_ASSERT_EQUAL(slot_flag, expected_flag, "augment_item [augment_path] has slot_flag '[aug.slot_flag]' but expected '[expected_flag]' for slot '[aug.slot]'")
