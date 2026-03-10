/obj/structure/flora/ocean
	icon = 'modular_nova/modules/liquids/icons/obj/flora/ocean_flora.dmi'
	var/random_variants = 0

/obj/structure/flora/ocean/Initialize(mapload)
	. = ..()
	if(random_variants)
		icon_state = "[icon_state][rand(1,random_variants)]"

/obj/structure/flora/ocean/glowweed
	name = "glow weed"
	icon_state = "glowweed"
	desc = "A plant with glowing bulbs at the end of it."
	random_variants = 3
	light_color = LIGHT_COLOR_CYAN
	light_range = 1.5

/obj/structure/flora/ocean/seaweed
	name = "sea weed"
	icon_state = "seaweed"
	desc = "Just your regular seaweed."
	random_variants = 5

/obj/structure/flora/ocean/longseaweed
	name ="sea weed"
	icon_state = "longseaweed"
	desc = "Less so regular seaweed. This one is very long."
	random_variants = 4

/obj/structure/flora/ocean/coral
	name = "coral"
	icon_state = "coral"
	desc = "Beautiful coral."
	random_variants = 3
	density = TRUE

/obj/effect/spawner/liquids_spawner
	name = "Liquids Spawner (Water, Waist-Deep)"
	icon = 'modular_nova/modules/liquids/icons/obj/effects/liquid.dmi'
	icon_state = "spawner"
	color = "#AAAAAA77"
	var/reagent_list = list(/datum/reagent/water = ONE_LIQUIDS_HEIGHT*LIQUID_WAIST_LEVEL_HEIGHT)
	var/temp = T20C

/obj/effect/spawner/liquids_spawner/Initialize(mapload)
	. = ..()

	if(!isturf(loc))
		return
	var/turf/T = loc
	T.add_liquid_list(reagent_list, FALSE, temp)

/obj/effect/spawner/liquids_spawner/puddle
	name = "Liquids Spawner (Water, Puddle)"
	reagent_list = list(/datum/reagent/water = ONE_LIQUIDS_HEIGHT)

/obj/effect/spawner/liquids_spawner/ankles
	name = "Liquids Spawner (Water, Ankle-Deep)"
	reagent_list = list(/datum/reagent/water = ONE_LIQUIDS_HEIGHT*LIQUID_ANKLES_LEVEL_HEIGHT)

/obj/effect/spawner/liquids_spawner/shoulders
	name = "Liquids Spawner (Water, Shoulder-Deep)"
	reagent_list = list(/datum/reagent/water = ONE_LIQUIDS_HEIGHT*LIQUID_SHOULDERS_LEVEL_HEIGHT)

/obj/effect/spawner/liquids_spawner/fulltile
	name = "Liquids Spawner (Water, Fulltile)"
	reagent_list = list(/datum/reagent/water = ONE_LIQUIDS_HEIGHT*LIQUID_FULLTILE_LEVEL_HEIGHT)
