/*
* Checks that synthetic humanoids, humans, and synth-human-hybrids process reagents as expected.
* Includes tests for neuroware chip reagents.
*
* Basic Expectations:
* 1. SYNTHETIC-oriented reagents require PROCESS_SYNTHETIC or a synth liver to process.
* 2. SYNTHETIC-oriented neuroware can't process in non-synthetics.
* 3. ORGANIC-oriented reagents require PROCESS_ORGANIC or a non-synth liver to process.
* 4. ORGANIC-oriented drugs can't process in synthetic humanoids.
*
* Expectations for Neuroware Reagents:
* 1. Neuroware requires a brain to metabolize.
* 2. Neuroware always metabolize in ORGAN_ROBOTIC brains.
* 3. Neuroware in ORGAN_ORGANIC brains require a NIF implant to metabolize.
*/

// Default synthetic humanoid
/datum/unit_test/liver/synthetic/Run()
	// Pause natural mob life so it can be handled entirely by the test
	SSmobs.pause()

	// Setup default robot
	var/mob/living/carbon/human/species/synth/test_robot = EASY_ALLOCATE()
	TEST_ASSERT(!isnull(test_robot.get_organ_by_type(/obj/item/organ/liver/synth)), "Synthetic humanoid does not have a synth liver.")

	// Test organic-oriented reagent reactions
	var/datum/reagent/toxin/mutetoxin/mute_toxin = /datum/reagent/toxin/mutetoxin
	test_robot.reagents.add_reagent(mute_toxin, 15)
	test_robot.Life(SSMOBS_DT)
	TEST_ASSERT(!test_robot.has_status_effect(/datum/status_effect/silenced), "Synthetic humanoid affected by organic reagents.")

	// Test synthetic-oriented reagent and nanite slurry healing
	test_robot = EASY_ALLOCATE()
	test_robot.adjust_brute_loss(5)
	var/datum/reagent/medicine/nanite_slurry/slurry = /datum/reagent/medicine/nanite_slurry
	test_robot.reagents.add_reagent(slurry, 15)
	test_robot.Life(SSMOBS_DT)
	TEST_ASSERT(test_robot.get_brute_loss() < 5, "Synthetic humanoid not healed by nanite slurry reagent.")

	// Test libital healing
	test_robot = EASY_ALLOCATE()
	test_robot.adjust_brute_loss(5)
	var/datum/reagent/medicine/c2/libital/libital = /datum/reagent/medicine/c2/libital
	test_robot.reagents.add_reagent(libital, 15)
	test_robot.Life(SSMOBS_DT)
	TEST_ASSERT(test_robot.get_brute_loss() == 5, "Synthetic humanoid healed by libital reagent.")

/datum/unit_test/liver/synthetic/Destroy()
	SSmobs.ignite()
	return ..()

// Default humans
/datum/unit_test/liver/human/Run()
	// Pause natural mob life so it can be handled entirely by the test
	SSmobs.pause()

	// Setup default human
	var/mob/living/carbon/human/consistent/lab_rat = EASY_ALLOCATE()
	var/obj/item/organ/liver/lab_liver = lab_rat.get_organ_by_type(/obj/item/organ/liver)
	TEST_ASSERT(!isnull(lab_liver) || (lab_liver.type != /obj/item/organ/liver), "Human does not have a regular liver.")

	// Test organic-oriented reagent reactions
	lab_rat = EASY_ALLOCATE()
	var/datum/reagent/toxin/mutetoxin/mute_toxin = /datum/reagent/toxin/mutetoxin
	lab_rat.reagents.add_reagent(mute_toxin, 15)
	lab_rat.Life(SSMOBS_DT)
	TEST_ASSERT(lab_rat.has_status_effect(/datum/status_effect/silenced), "Human not affected by organic reagents.")

	// Test synthetic-oriented reagent and nanite slurry healing
	lab_rat = EASY_ALLOCATE()
	lab_rat.adjust_brute_loss(5)
	var/datum/reagent/medicine/nanite_slurry/slurry = /datum/reagent/medicine/nanite_slurry
	lab_rat.reagents.add_reagent(slurry, 15)
	lab_rat.Life(SSMOBS_DT)
	TEST_ASSERT(lab_rat.get_brute_loss() == 5, "Human healed by nanite slurry reagent.")

	// Test libital healing
	lab_rat = EASY_ALLOCATE()
	lab_rat.adjust_brute_loss(5)
	var/datum/reagent/medicine/c2/libital/libital = /datum/reagent/medicine/c2/libital
	lab_rat.reagents.add_reagent(libital, 15)
	lab_rat.Life(SSMOBS_DT)
	TEST_ASSERT(lab_rat.get_brute_loss() < 5, "Human not healed by libital reagent.")

/datum/unit_test/liver/human/Destroy()
	SSmobs.ignite()
	return ..()

// Synthetic humanoid with some organic bodyparts and cybernetic liver
/datum/unit_test/liver/hybrid_synthetic/Run()
	// Pause natural mob life so it can be handled entirely by the test
	SSmobs.pause()

	// Setup synthetic humanoid with a cybernetic liver
	var/mob/living/carbon/human/species/synth/test_robot = EASY_ALLOCATE()
	var/obj/item/organ/liver/cybernetic/cyber_liver = EASY_ALLOCATE()
	cyber_liver.Insert(test_robot, special = TRUE, movement_flags = DELETE_IF_REPLACED)

	// Test libital healing on an organic arm with a cybernetic liver
	test_robot = EASY_ALLOCATE()
	cyber_liver = EASY_ALLOCATE()
	cyber_liver.Insert(test_robot, special = TRUE, movement_flags = DELETE_IF_REPLACED)
	var/obj/item/bodypart/arm/right/human_arm = EASY_ALLOCATE()
	test_robot.del_and_replace_bodypart(human_arm)
	human_arm.brute_dam = 5
	var/datum/reagent/medicine/c2/libital/libital = /datum/reagent/medicine/c2/libital
	test_robot.reagents.add_reagent(libital, 15)
	test_robot.Life(SSMOBS_DT)
	TEST_ASSERT(human_arm.get_damage() < 5, "Synthetic humanoid with organic arm and cybernetic liver not healed by libital reagent.")

	// Test nanite slurry healing on robotic arm with a cybernetic liver
	test_robot = EASY_ALLOCATE()
	cyber_liver = EASY_ALLOCATE()
	cyber_liver.Insert(test_robot, special = TRUE, movement_flags = DELETE_IF_REPLACED)
	var/obj/item/bodypart/arm/left/robot_arm = test_robot.get_bodypart(BODY_ZONE_L_ARM)
	robot_arm.brute_dam = 5
	var/datum/reagent/medicine/nanite_slurry/slurry = /datum/reagent/medicine/nanite_slurry
	test_robot.reagents.add_reagent(slurry, 15)
	test_robot.Life(SSMOBS_DT)
	TEST_ASSERT(robot_arm.get_damage() < 5, "Synthetic humanoid with cybernetic liver not healed by nanite slurry reagent.")

/datum/unit_test/liver/hybrid_synthetic/Destroy()
	SSmobs.ignite()
	return ..()

// Human with some robotic bodyparts and synthetic humanoid organs
/datum/unit_test/liver/hybrid_human/Run()
	// Pause natural mob life so it can be handled entirely by the test
	SSmobs.pause()

	// Setup the human with a synth liver
	var/mob/living/carbon/human/consistent/lab_rat = EASY_ALLOCATE()
	var/obj/item/organ/liver/synth/synth_liver = EASY_ALLOCATE()
	synth_liver.Insert(lab_rat, special = TRUE, movement_flags = DELETE_IF_REPLACED)

	// Test libital healing on organic arm with a synth liver
	// A synth liver should not affect a human's ability to process organic reagents
	var/obj/item/bodypart/arm/left/human_arm = lab_rat.get_bodypart(BODY_ZONE_L_ARM)
	human_arm.brute_dam = 5
	var/datum/reagent/medicine/c2/libital/libital = /datum/reagent/medicine/c2/libital
	lab_rat.reagents.add_reagent(libital, 15)
	lab_rat.Life(SSMOBS_DT)
	TEST_ASSERT(human_arm.get_damage() < 5, "Human with organic arm and synth liver not healed by libital reagent.")

	// Test nanite slurry healing on robotic arm
	lab_rat = EASY_ALLOCATE()
	var/obj/item/bodypart/arm/right/robot/robot_arm = EASY_ALLOCATE()
	lab_rat.del_and_replace_bodypart(robot_arm)
	robot_arm.brute_dam = 5
	var/datum/reagent/medicine/nanite_slurry/slurry = /datum/reagent/medicine/nanite_slurry
	lab_rat.reagents.add_reagent(slurry, 15)
	lab_rat.Life(SSMOBS_DT)
	TEST_ASSERT(robot_arm.get_damage() < 5, "Human with robotic arm not healed by nanite slurry reagent.")

/datum/unit_test/liver/hybrid_human/Destroy()
	SSmobs.ignite()
	return ..()

// Test neuroware reagents with synthetic humanoid species
/datum/unit_test/liver/neuroware_synth/Run()
	// Pause natural mob life so it can be handled entirely by the test
	SSmobs.pause()

	// Mute toxin neuroware which adds a status effect
	var/datum/reagent/toxin/mutetoxin/synth/neuroware_mute_toxin = /datum/reagent/toxin/mutetoxin/synth

	// Setup default synthetic humanoid
	var/mob/living/carbon/human/species/synth/test_robot = EASY_ALLOCATE()

	// Synthetic humanoid should always be affected by neuroware reagents
	test_robot.reagents.add_reagent(neuroware_mute_toxin, 15)
	test_robot.Life(SSMOBS_DT)
	// Neuroware status effect should be present after neuroware starts metabolizing
	TEST_ASSERT(test_robot.has_status_effect(/datum/status_effect/neuroware), "Neuroware status effect is missing in synthetic humanoid.")
	TEST_ASSERT(test_robot.has_status_effect(/datum/status_effect/silenced), "Synthetic humanoid not affected by neuroware reagents.")

	// Setup synthetic humanoid with cybernetic liver
	test_robot = EASY_ALLOCATE()
	var/obj/item/organ/liver/cybernetic/cyber_liver = EASY_ALLOCATE()
	cyber_liver.Insert(test_robot, special = TRUE, movement_flags = DELETE_IF_REPLACED)

	// Cyber liver should not block synthetic humanoids from processing neuroware reagents
	test_robot.reagents.add_reagent(neuroware_mute_toxin, 15)
	test_robot.Life(SSMOBS_DT)
	TEST_ASSERT(test_robot.has_status_effect(/datum/status_effect/neuroware), "Neuroware status effect is missing in synthetic humanoid with cybernetic liver.")
	TEST_ASSERT(test_robot.has_status_effect(/datum/status_effect/silenced), "Synthetic humanoid with cybernetic liver not affected by neuroware reagents.")

	// Setup synthetic humanoid without a liver
	test_robot = EASY_ALLOCATE()
	var/obj/item/organ/liver/synth/synth_liver = test_robot.get_organ_slot(ORGAN_SLOT_LIVER)
	synth_liver.Remove(test_robot, special = TRUE)
	// Lacking a liver should not block neuroware reagents from metabolizing
	test_robot.reagents.add_reagent(neuroware_mute_toxin, 15)
	test_robot.Life(SSMOBS_DT)
	TEST_ASSERT(test_robot.has_status_effect(/datum/status_effect/neuroware), "Neuroware status effect is missing in synthetic humanoid without a liver.")
	TEST_ASSERT(test_robot.has_status_effect(/datum/status_effect/silenced), "Synthetic humanoid without a liver not affected by neuroware reagents.")

/datum/unit_test/liver/neuroware_synth/Destroy()
	SSmobs.ignite()
	return ..()

// Test neuroware reagents with human species
/datum/unit_test/liver/neuroware_human/Run()
	// Pause natural mob life so it can be handled entirely by the test
	SSmobs.pause()

	// Mute toxin neuroware which adds a status effect
	var/datum/reagent/toxin/mutetoxin/synth/neuroware_mute_toxin = /datum/reagent/toxin/mutetoxin/synth

	// Setup default human
	var/mob/living/carbon/human/consistent/lab_rat = EASY_ALLOCATE()

	// Human species without NIF implant should not be affected by neuroware reagents
	lab_rat.reagents.add_reagent(neuroware_mute_toxin, 15)
	lab_rat.Life(SSMOBS_DT)
	TEST_ASSERT(!lab_rat.has_status_effect(/datum/status_effect/neuroware), "Neuroware status effect is present in default human.")
	TEST_ASSERT(!lab_rat.has_status_effect(/datum/status_effect/silenced), "Default human affected by neuroware reagents.")

	// Setup the human with a NIF implant
	lab_rat = EASY_ALLOCATE()
	var/obj/item/organ/cyberimp/brain/nif/standard/nif_implant = EASY_ALLOCATE()
	nif_implant.Insert(lab_rat, special = TRUE)

	// Human with NIF should always be affected by neuroware reagents
	lab_rat.reagents.add_reagent(neuroware_mute_toxin, 15)
	lab_rat.Life(SSMOBS_DT)
	TEST_ASSERT(lab_rat.has_status_effect(/datum/status_effect/neuroware), "Neuroware status effect is missing in human with NIF implant.")
	TEST_ASSERT(lab_rat.has_status_effect(/datum/status_effect/silenced), "Human with NIF implant not affected by neuroware reagents.")

	// Setup the human with a synth liver
	lab_rat = EASY_ALLOCATE()
	var/obj/item/organ/liver/synth/synth_liver = EASY_ALLOCATE()
	synth_liver.Insert(lab_rat, special = TRUE, movement_flags = DELETE_IF_REPLACED)

	// Synth liver should not allow human species to process neuroware reagents
	lab_rat.reagents.add_reagent(neuroware_mute_toxin, 15)
	lab_rat.Life(SSMOBS_DT)
	TEST_ASSERT(!lab_rat.has_status_effect(/datum/status_effect/neuroware), "Neuroware status effect is present in human with synth liver.")
	TEST_ASSERT(!lab_rat.has_status_effect(/datum/status_effect/silenced), "Human with synth liver affected by neuroware reagents.")

/datum/unit_test/liver/neuroware_human/Destroy()
	SSmobs.ignite()
	return ..()
