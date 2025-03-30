/// the actual organ that exists when made by the reagent
// The organ that spawns spiderlings between 30 seconds and 1
/obj/item/organ/body_egg/spideregg_infection
	name = "spider egg"
	desc = "wriggling balls with far too many eyes looking at you"
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "spidereggs"

	/// The minimum time between activations
	var/cooldown_low = 30 SECONDS
	/// The maximum time between activations
	var/cooldown_high = 60 SECONDS
	/// The cooldown for activations
	COOLDOWN_DECLARE(activation_cooldown)
	/// STATE VARS
	var/uses = 10 // -1 For infinite
	var/active = FALSE

/// Reagent that injects it, similar to romerol
/datum/reagent/spidereggs
	name = "Spider Eggs"
	description = "Scary and seemingly a bioengineered reagent that metabolizes into \
	physical eggs inside the host. Causing eggs to hatch within the host, causing \
	spiders to dig their way out and flee to grow elsewhere."
	color = "#3a2506" // dark/burnt orange
	metabolization_rate = INFINITY
	taste_description = "wriggling goop"
	ph = 0.5

/datum/reagent/spidereggs/expose_mob(mob/living/carbon/human/exposed_mob, methods=TOUCH, reac_volume)
	. = ..()
	// Silently add the spideregg organ, similar to the fleshymass from abductor organs
	if(!exposed_mob.get_organ_slot(ORGAN_SLOT_PARASITE_EGG))
		var/obj/item/organ/body_egg/spideregg_infection/SpiderEgg = new()
		SpiderEgg.Insert(exposed_mob)

// Organ actions - mirrored to xeno parasites
/obj/item/organ/body_egg/spideregg_infection/on_find(mob/living/finder)
	to_chat(finder, span_warning("You found a growing bundle of spider eggs in [owner]'s [zone]!"))

/obj/item/organ/body_egg/spideregg_infection/Initialize(mapload)
	. = ..()
	if(iscarbon(loc))
		Insert(loc)

/obj/item/organ/body_egg/spideregg_infection/proc/Start()
	active = TRUE
	COOLDOWN_START(src, activation_cooldown, rand(cooldown_low, cooldown_high))

/obj/item/organ/body_egg/spideregg_infection/on_mob_insert(mob/living/carbon/egg_owner, special = FALSE, movement_flags)
	. = ..()
	ADD_TRAIT(egg_owner, TRAIT_SPIDER_HOST, ORGAN_TRAIT)
	egg_owner.med_hud_set_status()
	Start()
	INVOKE_ASYNC(src, PROC_REF(AddInfectionImages), egg_owner)

/obj/item/organ/body_egg/spideregg_infection/on_mob_remove(mob/living/carbon/egg_owner, special, movement_flags)
	. = ..()
	active = FALSE
	if(initial(uses) == 1)
		uses = 1
	REMOVE_TRAIT(egg_owner, TRAIT_SPIDER_HOST, ORGAN_TRAIT)
	egg_owner.med_hud_set_status()
	INVOKE_ASYNC(src, PROC_REF(RemoveInfectionImages), egg_owner)

/obj/item/organ/body_egg/spideregg_infection/on_death(seconds_per_tick, times_fired)
	. = ..()
	if(!owner)
		return
	egg_process(seconds_per_tick, times_fired)

/obj/item/organ/body_egg/spideregg_infection/on_life(seconds_per_tick, times_fired)
	. = ..()
	egg_process(seconds_per_tick, times_fired)

// let's make a timer proc so it doesn't shit out spiders every game tic
/obj/item/organ/body_egg/spideregg_infection/on_life(seconds_per_tick, times_fired)
	if(!active)
		return
	if(!ishuman(owner))
		active = FALSE
		return
	if(COOLDOWN_FINISHED(src, activation_cooldown))
		activate()
		uses--
		COOLDOWN_START(src, activation_cooldown, rand(cooldown_low, cooldown_high))
	if(!uses)
		active = FALSE
	egg_process(seconds_per_tick, times_fired)

// activate the spoods!
/obj/item/organ/body_egg/spideregg_infection/activate()
	to_chat(owner, span_warning("You feel something burrowing out of your skin!"))
	var/mob/living/basic/spider/growing/spiderling/spider = new(owner.drop_location())
	spider.directive = "Flee from [owner.real_name]'s nest. Kill anything in the way."

/obj/item/organ/body_egg/spideregg_infection/proc/activate()
	return
