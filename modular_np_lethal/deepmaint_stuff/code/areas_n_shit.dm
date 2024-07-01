/area/gakster_location
	name = "Hideout"
	requires_power = FALSE
	power_environ = TRUE
	power_equip = TRUE
	power_light = TRUE
	has_gravity = TRUE
	ambience_index = AMBIENCE_MAINT

/area/gakster_location/filtre_spawn
	name = "RLOS Relicten"

/area/gakster_location/inborn_spawn
	name = "Hideout (Evil)"

/area/gakster_location/hideout_real
	name = "Hideout (Real)"

/area/gakster_location/ninja_hideout
	name = "Hideout (Stealthy)"

/area/gakster_location/hideout_real/Entered(atom/movable/arrived, area/old_area)
	. = ..()
	var/mob/living/carbon/human/arriving_mob = arrived
	if(istype(arriving_mob))
		ADD_TRAIT(arriving_mob, TRAIT_PACIFISM, TRAIT_GENERIC)

/area/gakster_location/hideout_real/Exited(atom/movable/gone, direction)
	. = ..()
	var/mob/living/carbon/human/leaving_mob = gone
	if(istype(leaving_mob))
		REMOVE_TRAIT(leaving_mob, TRAIT_PACIFISM, TRAIT_GENERIC)

/area/gakster_location/war
	name = "The Location"
	ambience_index = AMBIENCE_RUINS
	ambient_buzz = 'sound/ambience/magma.ogg'

/area/gakster_location/outside
	name = "DOWN"
	ambience_index = AMBIENCE_RUINS
	ambient_buzz = 'sound/ambience/magma.ogg'
