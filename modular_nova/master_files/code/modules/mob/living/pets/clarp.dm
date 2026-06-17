/mob/living/basic/carp/clarp
	name = "clarp"
	desc = "A Space Dragon ate a Clown Station, it tasted funny. This was the result."
	faction = list(FACTION_NEUTRAL)
	icon = 'modular_nova/master_files/icons/mob/pets.dmi'
	icon_dead = "clarp_dead"
	icon_gib = "clarp_gib"
	icon_living = "clarp"
	icon_state = "clarp"
	greyscale_config = NONE

/mob/living/basic/carp/clarp/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/squeak, list('sound/items/bikehorn.ogg' = 1), 50)
	AddElementTrait(TRAIT_WADDLING, REF(src), /datum/element/waddling)
