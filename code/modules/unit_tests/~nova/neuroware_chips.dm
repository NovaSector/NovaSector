/**
* Checks that Neuroware chips function as expected on compatible and incompatible targets.
* Only the chips are tested. For the reagents see [code/modules/unit_tests/~nova/liver.dm]
*
* Basic Expectations:
* 1. Neuroware chips are always compatible with synthetic humanoids.
* 2. Neuroware chips are incompatible with default humans.
* 3. Neuroware chips are compatible with humans using a NIF implant.
* 4. Neuroware chips are incompatible with humans using a broken/non-functional NIF implant.
*/
/datum/unit_test/neuroware_chips/Run()
	// Pause natural mob life so reagents don't metabolize before assertions
	SSmobs.pause()

	// Fetch all neuroware chip subtypes
	var/list/neuroware_chip_types = subtypesof(/obj/item/disk/neuroware)
	for(var/chip_type in neuroware_chip_types)
		// Allocate the test neuroware chip
		var/obj/item/disk/neuroware/test_chip = allocate(chip_type)

		// Skip neuroware chips which don't install reagents
		if(isnull(test_chip.list_reagents))
			continue

		// Skip lewd neuroware chips
		if(test_chip.is_lewd)
			continue

		// Setup default synthetic humanoid
		var/mob/living/carbon/human/species/synth/test_robot = EASY_ALLOCATE()
		// Installation should succeed on a compatible synthetic humanoid
		var/install_status = test_chip.try_install(test_robot, test_robot)
		TEST_ASSERT_EQUAL(install_status, TRUE, "\"[test_chip.type]/proc/try_install()\" should return TRUE when used on synthetic humanoid.")

		// Ensure the reagents were added successfully
		for(var/reagent_type in test_chip.list_reagents)
			TEST_ASSERT(test_robot.has_reagent(reagent_type), "\"[reagent_type]\" is missing when its presence is expected after using \"[test_chip.type]\" on synthetic humanoid.")

		// Setup default human
		var/mob/living/carbon/human/consistent/lab_rat = EASY_ALLOCATE()

		// Installation should fail on an incompatible default human
		test_chip = allocate(chip_type)
		install_status = test_chip.try_install(lab_rat, lab_rat)
		TEST_ASSERT_EQUAL(install_status, null, "\"[test_chip.type]/proc/try_install()\" should return null when used on default human.")

		// Ensure the reagents weren't added
		for(var/reagent_type in test_chip.list_reagents)
			TEST_ASSERT(!lab_rat.has_reagent(reagent_type), "\"[reagent_type]\" is present when it's expected to be missing after using \"[test_chip.type]\" on default human.")

		// Setup human with NIF implant
		lab_rat = EASY_ALLOCATE()
		var/obj/item/organ/cyberimp/brain/nif/standard/nif_implant = EASY_ALLOCATE()
		nif_implant.Insert(lab_rat, special = TRUE)

		// Installation should succeed on a compatible human with a NIF implant
		test_chip = allocate(chip_type)
		install_status = test_chip.try_install(lab_rat, lab_rat)
		TEST_ASSERT_EQUAL(install_status, TRUE, "\"[test_chip.type]/proc/try_install()\" should return TRUE when used on human with NIF implant.")

		// Ensure the reagents were added
		for(var/reagent_type in test_chip.list_reagents)
			TEST_ASSERT(lab_rat.has_reagent(reagent_type), "\"[reagent_type]\" is missing when its presence is expected after using \"[test_chip.type]\" on human with NIF implant.")

		// Setup human with a broken NIF implant
		lab_rat = EASY_ALLOCATE()
		nif_implant = EASY_ALLOCATE()
		nif_implant.Insert(lab_rat, special = TRUE)
		nif_implant.durability = 0
		nif_implant.broken = TRUE

		// Installation should fail on a human with a broken NIF implant
		test_chip = allocate(chip_type)
		install_status = test_chip.try_install(lab_rat, lab_rat)
		TEST_ASSERT_EQUAL(install_status, null, "\"[test_chip.type]/proc/try_install()\" should return null when used on human with a broken NIF implant.")

		// Ensure the reagents weren't added
		for(var/reagent_type in test_chip.list_reagents)
			TEST_ASSERT(!lab_rat.has_reagent(reagent_type), "\"[reagent_type]\" is present when it's expected to be missing after using \"[test_chip.type]\" on human with broken NIF implant.")

/datum/unit_test/neuroware_chips/Destroy()
	SSmobs.ignite()
	return ..()
