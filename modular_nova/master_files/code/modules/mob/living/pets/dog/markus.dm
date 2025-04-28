/mob/living/basic/pet/dog/markus
	name = "\proper Markus"
	desc = "The supply department's overfed yet still beloved dog."
	icon = 'modular_nova/master_files/icons/mob/pets.dmi'
	icon_state = "markus"
	icon_dead = "markus_dead"
	icon_living = "markus"
	butcher_results = list(
		/obj/item/food/burger/cheese = 1,
		/obj/item/food/meat/slab = 2,
		/obj/item/trash/syndi_cakes = 1,
		)
	ai_controller = /datum/ai_controller/basic_controller/dog/corgi
	gender = MALE
	can_be_held = FALSE
	gold_core_spawnable = FRIENDLY_SPAWN
	///can this mob breed?
	var/can_breed = TRUE

	/// List of possible dialogue options. This is both used by the AI and as an override when a sentient Markus speaks.
	var/static/list/markus_speak = list("Borf!", "Boof!", "Bork!", "Bowwow!", "Burg?")

/mob/living/basic/pet/dog/markus/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_TRASHMAN, TRAIT_GENERIC) //The burgers in his belly protect him
	if(can_breed)
		add_breeding_component()

/mob/living/basic/pet/dog/markus/treat_message(message)
	if(client)
		message = pick(markus_speak) // markus only talks business
	return ..()

/mob/living/basic/pet/dog/markus/update_dog_speech(datum/ai_planning_subtree/random_speech/speech)
	. = ..()
	speech.speak = markus_speak

/mob/living/basic/pet/dog/markus/proc/add_breeding_component()
	var/static/list/partner_paths = typecacheof(list(/mob/living/basic/pet/dog/corgi))
	var/static/list/baby_paths = list(
		/mob/living/basic/pet/dog/corgi/puppy = 1,
	)
	AddComponent(\
		/datum/component/breed,\
		can_breed_with = partner_paths,\
		baby_paths = baby_paths,\
	)

/datum/chemical_reaction/mark_reaction
	results = list(/datum/reagent/consumable/liquidgibs = 15)
	required_reagents = list(
		/datum/reagent/blood = 20,
		/datum/reagent/medicine/omnizine = 20,
		/datum/reagent/medicine/c2/synthflesh = 20,
		/datum/reagent/consumable/nutriment/protein = 10,
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/ketchup = 5,
		/datum/reagent/consumable/mayonnaise = 5,
		/datum/reagent/colorful_reagent/powder/yellow/crayon = 5,
	)

	required_catalysts = list(/datum/reagent/consumable/enzyme = 5)
	required_temp = 480

/datum/chemical_reaction/mark_reaction/on_reaction(datum/reagents/holder, datum/equilibrium/reaction, created_volume)
	. = ..()
	var/location = get_turf(holder.my_atom)
	new /mob/living/basic/pet/dog/markus(location)
	playsound(location, 'modular_nova/master_files/sound/effects/dorime.ogg', vol = 100, vary = FALSE, extrarange = 7)
