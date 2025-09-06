///Checks that synthetic humanoids, humans, and synth-human-hybrids process reagents as expected.
///Includes tests for neuroware chip reagents.
///Basic Expectations:
/// 1. SYNTHETIC-oriented reagents require PROCESS_SYNTHETIC or a synth liver to process.
/// 2. SYNTHETIC-oriented neuroware can't process in non-synthetics.
/// 3. ORGANIC-oriented reagents require PROCESS_ORGANIC or a non-synth liver to process.
/// 4. ORGANIC-oriented drugs can't process in synthetic humanoids.

// Default synthetic humanoid
/datum/unit_test/liver/synthetic/Run()
	// Pause natural mob life so it can be handled entirely by the test
	SSmobs.pause()

	var/mob/living/carbon/human/species/synth/test_robot = EASY_ALLOCATE()

	TEST_ASSERT(!isnull(test_robot.get_organ_by_type(/obj/item/organ/liver/synth)), "Synthetic humanoid does not have a synth liver.")

	// Test neuroware reactions
	// Synthetic humanoid should always be affected by neuroware reagents
	var/datum/reagent/toxin/mutetoxin/synth/neuroware_mute_toxin = /datum/reagent/toxin/mutetoxin/synth
	test_robot.reagents.add_reagent(neuroware_mute_toxin, 15)
	test_robot.Life(SSMOBS_DT)
	TEST_ASSERT(test_robot.has_status_effect(/datum/status_effect/silenced), "Synthetic humanoid not affected by neuroware reagents.")

	// Test organic-oriented reagent reactions
	test_robot = EASY_ALLOCATE()
	var/datum/reagent/toxin/mutetoxin/mute_toxin = /datum/reagent/toxin/mutetoxin
	test_robot.reagents.add_reagent(mute_toxin, 15)
	test_robot.Life(SSMOBS_DT)
	TEST_ASSERT(!test_robot.has_status_effect(/datum/status_effect/silenced), "Synthetic humanoid affected by organic reagents.")

	// Test synthetic-oriented reagent and nanite slurry healing
	test_robot = EASY_ALLOCATE()
	test_robot.adjustBruteLoss(5)
	var/datum/reagent/medicine/nanite_slurry/slurry = /datum/reagent/medicine/nanite_slurry
	test_robot.reagents.add_reagent(slurry, 15)
	test_robot.Life(SSMOBS_DT)
	TEST_ASSERT(test_robot.getBruteLoss() < 5, "Synthetic humanoid not healed by nanite slurry reagent.")

	// Test libital healing
	test_robot = EASY_ALLOCATE()
	test_robot.adjustBruteLoss(5)
	var/datum/reagent/medicine/c2/libital/libital = /datum/reagent/medicine/c2/libital
	test_robot.reagents.add_reagent(libital, 15)
	test_robot.Life(SSMOBS_DT)
	TEST_ASSERT(test_robot.getBruteLoss() == 5, "Synthetic humanoid healed by libital reagent.")

/datum/unit_test/liver/synthetic/Destroy()
	SSmobs.ignite()
	return ..()

// Default humans
/datum/unit_test/liver/human/Run()
	// Pause natural mob life so it can be handled entirely by the test
	SSmobs.pause()

	var/mob/living/carbon/human/consistent/lab_rat = EASY_ALLOCATE()
	var/obj/item/organ/liver/lab_liver = lab_rat.get_organ_by_type(/obj/item/organ/liver)
	TEST_ASSERT(!isnull(lab_liver) || (lab_liver.type != /obj/item/organ/liver), "Human does not have a regular liver.")

	// Test neuroware reactions
	// Human species should never be affected by neuroware reagents
	var/datum/reagent/toxin/mutetoxin/synth/neuroware_mute_toxin = /datum/reagent/toxin/mutetoxin/synth
	lab_rat.reagents.add_reagent(neuroware_mute_toxin, 15)
	lab_rat.Life(SSMOBS_DT)
	TEST_ASSERT(!lab_rat.has_status_effect(/datum/status_effect/silenced), "Human affected by neuroware reagents.")

	// Test organic-oriented reagent reactions
	lab_rat = EASY_ALLOCATE()
	var/datum/reagent/toxin/mutetoxin/mute_toxin = /datum/reagent/toxin/mutetoxin
	lab_rat.reagents.add_reagent(mute_toxin, 15)
	lab_rat.Life(SSMOBS_DT)
	TEST_ASSERT(lab_rat.has_status_effect(/datum/status_effect/silenced), "Human not affected by organic reagents.")

	// Test synthetic-oriented reagent and nanite slurry healing
	lab_rat = EASY_ALLOCATE()
	lab_rat.adjustBruteLoss(5)
	var/datum/reagent/medicine/nanite_slurry/slurry = /datum/reagent/medicine/nanite_slurry
	lab_rat.reagents.add_reagent(slurry, 15)
	lab_rat.Life(SSMOBS_DT)
	TEST_ASSERT(lab_rat.getBruteLoss() == 5, "Human healed by nanite slurry reagent.")

	// Test libital healing
	lab_rat = EASY_ALLOCATE()
	lab_rat.adjustBruteLoss(5)
	var/datum/reagent/medicine/c2/libital/libital = /datum/reagent/medicine/c2/libital
	lab_rat.reagents.add_reagent(libital, 15)
	lab_rat.Life(SSMOBS_DT)
	TEST_ASSERT(lab_rat.getBruteLoss() < 5, "Human not healed by libital reagent.")

/datum/unit_test/liver/human/Destroy()
	SSmobs.ignite()
	return ..()

// Synthetic humanoid with some organic bodyparts and cybernetic liver
/datum/unit_test/liver/hybrid_synthetic/Run()
	// Pause natural mob life so it can be handled entirely by the test
	SSmobs.pause()

	// Setup the synth with an cybernetic liver
	var/mob/living/carbon/human/species/synth/test_robot = EASY_ALLOCATE()
	var/obj/item/organ/liver/cybernetic/cyber_liver = EASY_ALLOCATE()
	cyber_liver.Insert(test_robot, special = TRUE, movement_flags = DELETE_IF_REPLACED)

	// Test neuroware reactions with cybernetic liver
	// Synthetic humanoid should always be affected by neuroware reagents
	var/datum/reagent/toxin/mutetoxin/synth/neuroware_mute_toxin = /datum/reagent/toxin/mutetoxin/synth
	test_robot.reagents.add_reagent(neuroware_mute_toxin, 15)
	test_robot.Life(SSMOBS_DT)
	TEST_ASSERT(test_robot.has_status_effect(/datum/status_effect/silenced), "Synthetic humanoid with cybernetic liver not affected by neuroware reagents.")

	// Test libital healing on an organic arm with cybernetic liver
	test_robot = EASY_ALLOCATE()
	cyber_liver = EASY_ALLOCATE()
	cyber_liver.Insert(test_robot, special = TRUE, movement_flags = DELETE_IF_REPLACED)
	var/obj/item/bodypart/arm/right/human_arm = EASY_ALLOCATE()
	test_robot.del_and_replace_bodypart(human_arm)
	human_arm.brute_dam = 5
	var/datum/reagent/medicine/c2/libital/libital = /datum/reagent/medicine/c2/libital
	test_robot.reagents.add_reagent(libital, 15)
	test_robot.Life(SSMOBS_DT)
	TEST_ASSERT(human_arm.get_damage() < 5, "Synthetic humanoid with organic arm and liver not healed by libital reagent.")

	// Test nanite slurry healing on robotic arm with cybernetic liver
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

	// Test neuroware reactions
	// Human species should never be affected by neuroware reagents
	var/datum/reagent/toxin/mutetoxin/synth/neuroware_mute_toxin = /datum/reagent/toxin/mutetoxin/synth
	lab_rat.reagents.add_reagent(neuroware_mute_toxin, 15)
	lab_rat.Life(SSMOBS_DT)
	TEST_ASSERT(!lab_rat.has_status_effect(/datum/status_effect/silenced), "Human with synth liver affected by neuroware reagents.")

	// Test libital healing on organic arm
	lab_rat = EASY_ALLOCATE()
	var/obj/item/bodypart/arm/left/human_arm = lab_rat.get_bodypart(BODY_ZONE_L_ARM)

	human_arm.brute_dam = 5
	var/datum/reagent/medicine/c2/libital/libital = /datum/reagent/medicine/c2/libital
	lab_rat.reagents.add_reagent(libital, 15)
	lab_rat.Life(SSMOBS_DT)
	TEST_ASSERT(human_arm.get_damage() < 5, "Human with robotic arm and liver not healed by libital reagent.")

	// Test nanite slurry healing on robotic arm
	lab_rat = EASY_ALLOCATE()
	var/obj/item/bodypart/arm/right/robot/robot_arm = EASY_ALLOCATE()
	lab_rat.del_and_replace_bodypart(robot_arm)
	robot_arm.brute_dam = 5
	var/datum/reagent/medicine/nanite_slurry/slurry = /datum/reagent/medicine/nanite_slurry
	lab_rat.reagents.add_reagent(slurry, 15)
	lab_rat.Life(SSMOBS_DT)
	TEST_ASSERT(robot_arm.get_damage() < 5, "Human with robotic liver not healed by nanite slurry reagent.")

/datum/unit_test/liver/hybrid_human/Destroy()
	SSmobs.ignite()
	return ..()
