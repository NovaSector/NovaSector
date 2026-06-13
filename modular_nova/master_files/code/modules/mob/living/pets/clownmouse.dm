/mob/living/basic/mouse/clown
	name = "clown mouse"
	desc = "The Clown Infection has spread to a mouse! How horrible!"
	icon = 'modular_nova/master_files/icons/mob/pets.dmi'
	icon_state = "mouse_clown"
	icon_dead = "mouse_clown_dead"
	icon_living = "mouse_clown"
	held_state = "mouse_white"
	body_color = "clown"

/mob/living/basic/mouse/clown/Initialize(mapload)
	. = ..()
	RemoveElement(/datum/element/animal_variety)
	AddComponent(/datum/component/squeak, list('sound/items/bikehorn.ogg' = 1), 50)
	AddElementTrait(TRAIT_WADDLING, REF(src), /datum/element/waddling)

