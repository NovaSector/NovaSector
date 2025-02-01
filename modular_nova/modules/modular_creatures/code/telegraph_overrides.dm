#define SLOW_SWING (0.7 SECONDS)
#define AVERAGE_SWING (0.5 SECONDS)
#define FAST_SWING (0.3 SECONDS)

// HUMANOIDS

/mob/living/basic/trooper/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/basic_mob_attack_telegraph, telegraph_duration = FAST_SWING)

/mob/living/basic/zombie/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/basic_mob_attack_telegraph, telegraph_duration = SLOW_SWING)

/mob/living/basic/revolutionary/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/basic_mob_attack_telegraph, telegraph_duration = FAST_SWING)

/mob/living/basic/skeleton/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/basic_mob_attack_telegraph, telegraph_duration = FAST_SWING)

/mob/living/basic/stickman/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/basic_mob_attack_telegraph, telegraph_duration = FAST_SWING)

/mob/living/basic/cat_butcherer/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/basic_mob_attack_telegraph, telegraph_duration = FAST_SWING)

// BEASTS

/mob/living/basic/bee/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/basic_mob_attack_telegraph, telegraph_duration = FAST_SWING)

/*
/mob/living/basic/spider/giant/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/basic_mob_attack_telegraph, telegraph_duration = FAST_SWING)

*/
/mob/living/basic/carp/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/basic_mob_attack_telegraph, telegraph_duration = AVERAGE_SWING)

// CREATURES

/mob/living/basic/mushroom/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/basic_mob_attack_telegraph, telegraph_duration = AVERAGE_SWING)

/mob/living/basic/killer_tomato/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/basic_mob_attack_telegraph, telegraph_duration = AVERAGE_SWING)

/mob/living/basic/mimic/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/basic_mob_attack_telegraph, telegraph_duration = AVERAGE_SWING)

/mob/living/basic/blob_minion/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/basic_mob_attack_telegraph, telegraph_duration = FAST_SWING)

/mob/living/basic/venus_human_trap/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/basic_mob_attack_telegraph, telegraph_duration = AVERAGE_SWING)

/mob/living/basic/alien/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/basic_mob_attack_telegraph, telegraph_duration = FAST_SWING)

/mob/living/basic/hivebot/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/basic_mob_attack_telegraph, telegraph_duration = AVERAGE_SWING)

/mob/living/basic/creature/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/basic_mob_attack_telegraph, telegraph_duration = AVERAGE_SWING)

/mob/living/basic/blankbody/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/basic_mob_attack_telegraph, telegraph_duration = AVERAGE_SWING)

/mob/living/basic/migo/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/basic_mob_attack_telegraph, telegraph_duration = AVERAGE_SWING)

/mob/living/basic/mold/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/basic_mob_attack_telegraph, telegraph_duration = FAST_SWING)

#undef SLOW_SWING
#undef AVERAGE_SWING
#undef FAST_SWING
