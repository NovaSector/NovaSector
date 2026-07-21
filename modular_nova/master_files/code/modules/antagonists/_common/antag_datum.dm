/datum/antagonist
	/// Should this antagonist be allowed to view exploitable information?
	var/view_exploitables = FALSE
	/// the list of recipes that an antag will learn/unlearn on gain/loss
	var/list/antag_recipes = list()

/datum/antagonist/on_gain()
	. = ..()
	for(var/recipe_datum in antag_recipes)
		owner.teach_crafting_recipe(recipe_datum)

/datum/antagonist/on_removal()
	. = ..()
	for(var/recipe_datum in antag_recipes)
		owner.unteach_crafting_recipe(recipe_datum)

/datum/antagonist/ashwalker
	antag_recipes = list(
		/datum/crafting_recipe/bonesword,
		/datum/crafting_recipe/ash_recipe/macahuitl,
		/datum/crafting_recipe/boneaxe,
		/datum/crafting_recipe/bonespear,
		/datum/crafting_recipe/bonedagger,
		/datum/crafting_recipe/ash_recipe/ash_headdress,
		/datum/crafting_recipe/ash_recipe/ash_headdress/winged,
		/datum/crafting_recipe/ash_recipe/ash_robes,
		/datum/crafting_recipe/ash_recipe/ash_plates,
		/datum/crafting_recipe/ash_recipe/ash_plates/decorated,
	)

// Antags no longer get handed a pool objective; they pick their own path instead.
// Types that already inherit can_assign_self_objectives = TRUE from TG are not repeated here.

/datum/antagonist/heretic
	view_exploitables = TRUE
	give_objectives = FALSE

/datum/antagonist/changeling
	view_exploitables = TRUE
	give_objectives = FALSE

/datum/antagonist/obsessed
	view_exploitables = TRUE

/datum/antagonist/ninja
	view_exploitables = TRUE
	give_objectives = FALSE

/datum/antagonist/wizard
	view_exploitables = TRUE
	give_objectives = FALSE

// Apprentices and academy teachers forge a single role-defining objective rather than pulling from the
// generic pool, and can't self-assign, so leaving them objectiveless would leave them with nothing at all.
/datum/antagonist/wizard/apprentice
	give_objectives = TRUE

/datum/antagonist/wizard/academy
	give_objectives = TRUE

/datum/antagonist/brother
	view_exploitables = TRUE
	can_assign_self_objectives = TRUE

/datum/antagonist/malf_ai
	view_exploitables = TRUE
	give_objectives = FALSE

/datum/antagonist/revenant
	view_exploitables = TRUE
	can_assign_self_objectives = TRUE

/datum/antagonist/traitor
	view_exploitables = TRUE
	give_objectives = FALSE

/datum/antagonist/nightmare
	view_exploitables = TRUE
	can_assign_self_objectives = TRUE

/datum/antagonist/pirate
	view_exploitables = TRUE // pirates are flexible antags, not strictly bound by their objective. i could see this working
	can_assign_self_objectives = TRUE

/datum/antagonist/rev/head
	view_exploitables = TRUE // heads only. while all revs having exploitables would be fine, i feel this would complement the "leaders leading the masses" stuff rev naturally makes
	can_assign_self_objectives = TRUE

/*/datum/antagonist/cortical_borer // come back to borer when it's not as new
	view_exploitables = TRUE */

/datum/antagonist/cult // cult is adminbus only... im not sure about this but im doing it anyway
	view_exploitables = TRUE
	can_assign_self_objectives = TRUE

/*/datum/antagonist/abductor // maybe?
	view_exploitables = TRUE */

