/datum/round_event/vent_clog/get_mob()
	var/static/list/mob_list = list(
	//	TG additions:
		/mob/living/basic/butterfly,
		/mob/living/basic/cockroach,
	/*	/mob/living/basic/cockroach/bloodroach, promoted */
		/mob/living/basic/spider/maintenance,
		/mob/living/basic/mouse,
		/mob/living/basic/snail,
	//	Nova additions:
		/mob/living/basic/pet/chinchilla,
	)
	return pick(mob_list)

/datum/round_event/vent_clog/major/get_mob()
	var/static/list/mob_list = list(
	//	TG additions:
	/*	/mob/living/basic/bee, removed because not major */
	/*	/mob/living/basic/cockroach/hauberoach, removed because enough with the cockroaches */
		/mob/living/basic/spider/giant,
		/mob/living/basic/mouse/rat,
	//	Nova additions:
		/mob/living/basic/bee/toxin,
		/mob/living/basic/carp,
	)
	return pick(mob_list)

/datum/round_event/vent_clog/critical/get_mob()
	var/static/list/mob_list = list(
	//	TG additions:
	/*	/mob/living/basic/bee/toxin, demoted */
	/*	/mob/living/basic/carp, demoted */
	/*	/mob/living/basic/cockroach/glockroach, removed because enough with the cockroaches, also a gun... rly? */
	//	Nova additions:
		/mob/living/simple_animal/hostile/cazador,
		/mob/living/simple_animal/hostile/scorpion,
		/mob/living/simple_animal/hostile/plantmutant,
		/mob/living/simple_animal/hostile/bigcrab,
	)
	return pick(mob_list)

/datum/round_event/vent_clog/strange/get_mob()
	var/static/list/mob_list = list(
	//	TG additions:
		/mob/living/basic/bear,
	/*	/mob/living/basic/cockroach/glockroach/mobroach, just why */
		/mob/living/basic/goose,
		/mob/living/basic/lightgeist,
		/mob/living/basic/mothroach,
		/mob/living/basic/mushroom,
		/mob/living/basic/viscerator,
		/mob/living/basic/pet/gondola,
	//	Nova additions:
		/mob/living/basic/cockroach/bloodroach,
		/mob/living/basic/zombie/cheesezombie,
		/mob/living/basic/spider/giant/badnana_spider,
	)
	return pick(mob_list)
