/mob/living/basic/chicken/gunther
	name = "\improper gunther"
	desc = "An odd looking gutlunch, this one seems to have feathers and lay eggs, not like you'd complain about that."
	unsuitable_atmos_damage = 0

/mob/living/basic/chicken/gunther/jr
	name = "\improper gunther jr"
	fertile = FALSE

/mob/living/basic/chicken/gunther/egg_laid(obj/item/egg)
	if(GLOB.chicken_count <= MAX_CHICKENS && fertile && prob(5))
		egg.AddComponent(\
			/datum/component/fertile_egg,\
			embryo_type = /mob/living/basic/chick/gunther,\
			minimum_growth_rate = 1,\
			maximum_growth_rate = 2,\
			total_growth_required = 200,\
			current_growth = 0,\
			location_allowlist = typecacheof(list(/turf)),\
			spoilable = TRUE,\
		)

/mob/living/basic/chick/gunther
	name = "\improper gunther chick"
	desc = "An odd looking baby gutlunch, this one seems to have feathers and lay eggs, not like you'd complain about that."
	unsuitable_atmos_damage = 0
	grow_as = /mob/living/basic/chicken/guntherjr
