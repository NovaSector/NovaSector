/// Tests that the Kinetic Crusher fires a projectile on RMB
/datum/unit_test/crusher_projectile

/datum/unit_test/crusher_projectile/Run()
	var/mob/living/carbon/human/consistent/attacker = EASY_ALLOCATE()
	var/obj/item/kinetic_crusher/crusher = EASY_ALLOCATE()
	crusher.allowed_areas_to_fire = list(/area) // NOVA EDIT ADDITION - Our crushers are limited by default in their area to shoot, so this makes the testing crusher able to shoot anywhere.

	attacker.put_in_active_hand(crusher, forced = TRUE)
	crusher.attack_self(attacker) // wields the crusher

	click_wrapper(attacker, run_loc_floor_top_right, list(RIGHT_CLICK = TRUE, BUTTON = RIGHT_CLICK))

	TEST_ASSERT(!crusher.charged, "Attacker failed to fire the kinetic crusher on right clicking a distant target")
