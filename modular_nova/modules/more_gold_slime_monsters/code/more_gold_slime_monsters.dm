// this folder is entirely just adding tags to let things spawn, or not spawn, in gold slimes. enjoy

/mob/living/basic/pet/gondola
	gold_core_spawnable = HOSTILE_SPAWN // make them less consistent

/mob/living/basic/deer
	gold_core_spawnable = FRIENDLY_SPAWN

/mob/living/basic/pet/dog/corgi/exoticcorgi
	gold_core_spawnable = FRIENDLY_SPAWN

/mob/living/basic/pet/fox/docile
	gold_core_spawnable = FRIENDLY_SPAWN

/mob/living/basic/mad_piano
	gold_core_spawnable = HOSTILE_SPAWN

/mob/living/basic/flesh_spider
	gold_core_spawnable = HOSTILE_SPAWN // Not like rat kings - does not ping ghosts for control if spawned directly, so this is fine.

/mob/living/basic/spaceman
	gold_core_spawnable = HOSTILE_SPAWN

/mob/living/basic/bat
	gold_core_spawnable = HOSTILE_SPAWN

/mob/living/simple_animal/hostile/ooze/gelatinous
	gold_core_spawnable = HOSTILE_SPAWN

/mob/living/simple_animal/hostile/ooze/grapes/xenobio
	ghost_controllable = FALSE // i lied, we also define this one mob to not be ghost controllable.
	gold_core_spawnable = HOSTILE_SPAWN

