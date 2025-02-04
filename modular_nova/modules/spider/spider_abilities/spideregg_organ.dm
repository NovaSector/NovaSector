#define TRAIT_SPIDER_HOST "spider_host"
#define TRAIT_SPIDER_IMMUNE "spider_immune"

/// the actual organ that exists when made by the reagent
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

// HUD update
/mob/living/carbon/med_hud_set_status()
	if(HAS_TRAIT(src, TRAIT_SPIDER_HOST))
		set_hud_image_state(STATUS_HUD, "hudxeno")
		return FALSE

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
	..()
	to_chat(finder, span_warning("You found a growing bundle of spider eggs in [owner]'s [zone]!"))

/obj/item/organ/body_egg/spideregg_infection/Initialize(mapload)
	. = ..()
	if(iscarbon(loc))
		Insert(loc)

/obj/item/organ/body_egg/spideregg_infection/proc/ownerCheck()
	if(ishuman(owner))
		return TRUE
	return FALSE

/obj/item/organ/body_egg/spideregg_infection/proc/Start()
	active = 1
	COOLDOWN_START(src, activation_cooldown, rand(cooldown_low, cooldown_high))

/obj/item/organ/body_egg/spideregg_infection/on_mob_insert(mob/living/carbon/egg_owner, special = FALSE, movement_flags)
	. = ..()
	egg_owner.add_traits(list(TRAIT_SPIDER_HOST, TRAIT_SPIDER_IMMUNE), ORGAN_TRAIT)
	egg_owner.med_hud_set_status()
	Start()
	INVOKE_ASYNC(src, PROC_REF(AddInfectionImages), egg_owner)

/obj/item/organ/body_egg/spideregg_infection/on_mob_remove(mob/living/carbon/egg_owner, special, movement_flags)
	. = ..()
	active = FALSE
	if(initial(uses) == 1)
		uses = initial(uses)
	egg_owner.remove_traits(list(TRAIT_SPIDER_HOST, TRAIT_SPIDER_IMMUNE), ORGAN_TRAIT)
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
	if(!ownerCheck())
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
	spider.directive = "Flee from [owner.real_name]'s nest, kill anything in the way."

/obj/item/organ/body_egg/spideregg_infection/proc/activate()
	return

#undef TRAIT_SPIDER_HOST
#undef TRAIT_SPIDER_IMMUNE
