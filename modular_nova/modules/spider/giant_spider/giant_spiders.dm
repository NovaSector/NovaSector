/**
 * ### Webslinger Spider
 * A subtype of the giant spider which is slower, can throw webs to ensnare those pesky bipeds.
 */
/mob/living/basic/spider/giant/webslinger
	name = "webslinger spider"
	desc = "Furry and white, it makes you shudder to look at it. Sharp green eyes are all that can be seen..."
	icon = 'modular_nova/modules/spider/icons/spider.dmi'
	icon_state = "webslinger"
	icon_living = "webslinger"
	icon_dead = "webslinger_dead"
	gender = FEMALE
	maxHealth = 175
	health = 175
	obj_damage = 45
	melee_damage_lower = 25
	melee_damage_upper = 30
	poison_per_bite = 1.5
	poison_type = /datum/reagent/toxin/hunterspider
	speed = 3
	gold_core_spawnable = NO_SPAWN
	sight = SEE_TURFS
	menu_description = "somewhat slow, throw webs to ensnare."
	ai_controller = /datum/ai_controller/basic_controller/webslinger
	alpha = 30
	innate_actions = list(
		/datum/action/cooldown/mob_cooldown/command_spiders/communication_spiders,
		/datum/action/cooldown/mob_cooldown/sneak/webslinger,
		/datum/action/cooldown/mob_cooldown/wrap,
		/datum/action/cooldown/mob_cooldown/lay_web/web_passage,
		/datum/action/cooldown/spell/pointed/projectile/web_restraints = BB_ARACHNID_RESTRAIN,
		/datum/action/cooldown/mob_cooldown/web_effigy,
	)

/mob/living/basic/spider/giant/webslinger/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_STRONG_GRABBER, INNATE_TRAIT)
	AddElement(/datum/element/web_walker, /datum/movespeed_modifier/below_average_web)

	AddComponent(/datum/component/seethrough_mob)
	AddComponent(/datum/component/appearance_on_aggro, alpha_on_aggro = 255, alpha_on_deaggro = alpha)
	AddComponent(/datum/component/tree_climber, climbing_distance = 15)

/mob/living/basic/spider/giant/webslinger/Login()
	. = ..()
	if(!. || !client)
		return FALSE

	animate(src, alpha = 255, time = 2 SECONDS)

	AddComponent(/datum/component/healing_touch,\
		heal_brute = 10,\
		heal_burn = 10,\
		heal_time = 2.5 SECONDS,\
		interaction_key = DOAFTER_SOURCE_SPIDER,\
		valid_targets_typecache = typecacheof(list(/mob/living/basic/spider/giant)),\
		action_text = "%SOURCE% begins wrapping the wounds of %TARGET% with medicated webs.",\
		complete_text = "%SOURCE% wraps the wounds of %TARGET%.",\
	)

/**
 * ### Voltaic Spider
 * A subtype of the giant spider which similar to the viper, but instead of toxin it injects teslium.
 * Far more squishier than all other types, it is an ambush predator meant to bite and run while the Teslium works its way into them.
 */
/mob/living/basic/spider/giant/voltaic
	name = "voltaic spider"
	desc = "Chitinous and yellow with electrical arcs running across its carapace, it makes you shudder to look at it. This one has effervescent yellow eyes."
	icon = 'modular_nova/modules/spider/icons/spider.dmi'
	icon_state = "voltaic"
	icon_living = "voltaic"
	icon_dead = "voltaic_dead"
	gender = FEMALE
	maxHealth = 175
	health = 175
	melee_damage_lower = 8
	melee_damage_upper = 8
	poison_per_bite = 2
	poison_type = /datum/reagent/teslium
	speed = 3
	gold_core_spawnable = NO_SPAWN
	sight = SEE_TURFS
	menu_description = "fast but not sturdy, your bites inject teslium"
	ai_controller = /datum/ai_controller/basic_controller/voltaic
	innate_actions = list(
		/datum/action/cooldown/mob_cooldown/command_spiders/communication_spiders,
		/datum/action/cooldown/mob_cooldown/lay_web/solid_web,
		/datum/action/cooldown/mob_cooldown/secrete_acid,
		/datum/action/cooldown/mob_cooldown/web_effigy,
	)

/mob/living/basic/spider/giant/voltaic/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_STRONG_GRABBER, INNATE_TRAIT)
	AddElement(/datum/element/web_walker, /datum/movespeed_modifier/below_average_web)

/**
 * ### Pit Spider
 * A behemoth of a spider, doing both high damage but mid-level health. Front line commander.
 */
/mob/living/basic/spider/giant/pit
	name = "pit spider"
	desc = "Furry and brown with an orange top, its massive jaws strike fear in you and also sometimes into walls. This one has bright orange eyes."
	icon = 'modular_nova/modules/spider/icons/spider.dmi'
	icon_state = "pit"
	icon_living = "pit"
	icon_dead = "pit_dead"
	gender = MALE
	maxHealth = 250
	health = 250
	armour_penetration = 25
	melee_damage_lower = 5
	melee_damage_upper = 15
	unsuitable_atmos_damage = 0
	minimum_survivable_temperature = 25
	maximum_survivable_temperature = 1100
	unsuitable_cold_damage = 0
	wound_bonus = 25
	bare_wound_bonus = 50
	sharpness = SHARP_EDGED
	obj_damage = 60
	web_speed = 0.25
	limb_destroyer = 50
	speed = 3
	player_speed_modifier = -4
	gold_core_spawnable = NO_SPAWN
	sight = SEE_TURFS
	menu_description = "Has the ability to destroy walls and limbs, and to send warnings to the nest."
	ai_controller = /datum/ai_controller/basic_controller/pit
	innate_actions = list(
		/datum/action/cooldown/mob_cooldown/wrap,
		/datum/action/cooldown/mob_cooldown/command_spiders,
		/datum/action/cooldown/mob_cooldown/charge/basic_charge,
	)
/mob/living/basic/spider/giant/pit/Initialize(mapload)
	. = ..()
	var/datum/action/cooldown/mob_cooldown/lay_web/solid_web/web_solid = new(src)
	web_solid.Grant(src)

	AddElement(/datum/element/wall_tearer)
	AddElement(/datum/element/web_walker, /datum/movespeed_modifier/below_average_web)

/**
 * ### Ogre Spider
 * A fat armored cute spider, completely utility focused and to soak damage for the weaker variants.
 */
/mob/living/basic/spider/giant/ogre
	name = "ogre spider"
	desc = "Furry, brown, and fat. While kind of cute its size horrifies you. This one has dark purple eyes and seems heavily armored."
	icon = 'modular_nova/modules/spider/icons/spider.dmi'
	icon_state = "ogre"
	icon_living = "ogre"
	icon_dead = "ogre_dead"
	gender = FEMALE
	maxHealth = 600 // hah fat
	health = 600
	damage_coeff = list(BRUTE = 1, BURN = 1, TOX = 1, STAMINA = 1, OXY = 1)
	poison_per_bite = 1.5
	poison_type = /datum/reagent/toxin/viperspider
	melee_damage_lower = 5
	melee_damage_upper = 5
	obj_damage = 15
	speed = 3
	gold_core_spawnable = NO_SPAWN
	sight = SEE_TURFS
	menu_description = "Extremely tanky with very poor offense. Able to self-heal and lay reflective silk screens, passages, and traps."
	ai_controller = /datum/ai_controller/basic_controller/ogre
	innate_actions = list(
		/datum/action/cooldown/mob_cooldown/command_spiders/communication_spiders,
		/datum/action/cooldown/mob_cooldown/lay_web/solid_web,
		/datum/action/cooldown/mob_cooldown/lay_web/sticky_web,
		/datum/action/cooldown/mob_cooldown/lay_web/web_passage,
		/datum/action/cooldown/mob_cooldown/lay_web/web_spikes,
		/datum/action/cooldown/mob_cooldown/lay_web/sealer,
		/datum/action/cooldown/mob_cooldown/lay_web/web_reflector,

	)
/mob/living/basic/spider/giant/ogre/Initialize(mapload)
	. = ..()

	AddElement(/datum/element/web_walker, /datum/movespeed_modifier/below_average_web)

	AddComponent(/datum/component/healing_touch,\
		heal_brute = 50,\
		heal_burn = 50,\
		heal_time = 5 SECONDS,\
		self_targeting = HEALING_TOUCH_SELF_ONLY,\
		interaction_key = DOAFTER_SOURCE_SPIDER,\
		valid_targets_typecache = typecacheof(list(/mob/living/basic/spider/giant/ogre)),\
		extra_checks = CALLBACK(src, PROC_REF(can_mend)),\
		action_text = "%SOURCE% begins mending themselves...",\
		complete_text = "%SOURCE%'s wounds mend together.",\
	)

/// Prevents you from healing other spiders spiders, or from healing when on fire
/mob/living/basic/spider/giant/ogre/proc/can_mend(mob/living/source, mob/living/target)
	if (on_fire)
		balloon_alert(src, "can't heal while on fire!")
		return FALSE
	if(target != source)
		balloon_alert(src, "you can only heal yourself!")
		return FALSE
	return TRUE

/**
 * ### Carrier Spider
 * A lithe infectious spider that injects spider egg reagents into their victims.
 */

/mob/living/basic/spider/giant/carrier
	name = "carrier spider"
	desc = "Chitinous with a sickly green and red carapace, it makes you shudder to look at it. This one has sharp neon eyes."
	icon = 'modular_nova/modules/spider/icons/spider.dmi'
	icon_state = "carrier"
	icon_living = "carrier"
	icon_dead = "carrier_dead"
	gender = FEMALE
	maxHealth = 225
	health = 225
	melee_damage_lower = 10
	melee_damage_upper = 15
	poison_per_bite = 2
	poison_type = /datum/reagent/spidereggs
	speed = 3
	gold_core_spawnable = NO_SPAWN
	sight = SEE_TURFS
	menu_description = "The life of the nest, injects spidereggs that will grow inside the host and burrow out."
	ai_controller = /datum/ai_controller/basic_controller/carrier
	innate_actions = list(
		/datum/action/cooldown/mob_cooldown/command_spiders/communication_spiders,
		/datum/action/cooldown/spell/pointed/projectile/web_restraints = BB_ARACHNID_RESTRAIN,
		/datum/action/cooldown/mob_cooldown/lay_web/solid_web,
		/datum/action/cooldown/mob_cooldown/lay_web/sticky_web,
		/datum/action/cooldown/mob_cooldown/lay_web/web_passage,
		/datum/action/cooldown/mob_cooldown/web_effigy,
		/datum/action/cooldown/mob_cooldown/lay_web/sealer,
	)

/mob/living/basic/spider/giant/carrier/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_STRONG_GRABBER, INNATE_TRAIT)
	AddElement(/datum/element/web_walker, /datum/movespeed_modifier/below_average_web)


/**
 * ### Baron Spider
 * The big bad spider, rarely to be used but designed to inflect major casuality/damage.
 */

/mob/living/basic/spider/giant/baron
	name = "baron spider"
	desc = "This girthy spider seems to exist in a rage-filled state, if it moves its many eyes follow."
	icon = 'modular_nova/modules/spider/icons/64x64_spider.dmi'
	icon_state = "baron"
	icon_living = "baron"
	icon_dead = "baron_dead"
	gender = MALE
	maxHealth = 2000
	health = 2000
	obj_damage = 200
	armour_penetration = 50
	melee_damage_lower = 10
	melee_damage_upper = 30
	wound_bonus = 30
	bare_wound_bonus = 60
	poison_per_bite = 5
	poison_type = /datum/reagent/toxin/viperspider
	speed = 3
	unsuitable_atmos_damage = 0
	minimum_survivable_temperature = 0
	maximum_survivable_temperature = INFINITY
	unsuitable_cold_damage = 0
	pixel_x = -16
	base_pixel_x = -16
	maptext_height = 64
	maptext_width = 64
	gold_core_spawnable = NO_SPAWN
	sight = SEE_TURFS
	attack_vis_effect = ATTACK_EFFECT_SLASH
	status_flags = NONE // nuh uh
	mob_size = MOB_SIZE_HUGE
	ai_controller = /datum/ai_controller/basic_controller/baron
	move_resist = MOVE_FORCE_EXTREMELY_STRONG
	pull_force = MOVE_FORCE_EXTREMELY_STRONG

	innate_actions = list(
		/datum/action/cooldown/mob_cooldown/command_spiders,
		/datum/action/cooldown/mob_cooldown/spider_leap,
		/datum/action/cooldown/mob_cooldown/charge/triple_charge,
		/datum/action/cooldown/mob_cooldown/watcher_gaze,
		/datum/action/cooldown/spell/pointed/projectile/web_restraints = BB_ARACHNID_RESTRAIN,
		/datum/action/cooldown/mob_cooldown/lay_web/solid_web,
		/datum/action/cooldown/mob_cooldown/lay_web/sticky_web,
		/datum/action/cooldown/mob_cooldown/lay_web/web_passage,
		/datum/action/cooldown/mob_cooldown/lay_web/web_spikes,
		/datum/action/cooldown/mob_cooldown/lay_web/sealer,
		/datum/action/cooldown/mob_cooldown/lay_web/web_reflector,
	)
/mob/living/basic/spider/giant/baron/Initialize(mapload)
	. = ..()
	var/datum/action/cooldown/mob_cooldown/lay_web/solid_web/web_solid = new(src)
	web_solid.Grant(src)

	AddElement(/datum/element/wall_tearer)
	AddElement(/datum/element/web_walker, /datum/movespeed_modifier/below_average_web)
	AddComponent(/datum/component/seethrough_mob)

	AddComponent(/datum/component/healing_touch,\
		heal_brute = 50,\
		heal_burn = 50,\
		heal_time = 3 SECONDS,\
		self_targeting = HEALING_TOUCH_SELF_ONLY,\
		interaction_key = DOAFTER_SOURCE_SPIDER,\
		valid_targets_typecache = typecacheof(list(/mob/living/basic/spider/giant)),\
		extra_checks = CALLBACK(src, PROC_REF(can_mend)),\
		action_text = "%SOURCE% begins wrapping the wounds of %TARGET% with medicated webs.",\
		complete_text = "%SOURCE% wraps the wounds of %TARGET%.",\
	)

/mob/living/basic/spider/giant/baron/proc/can_mend(mob/living/source, mob/living/target)
	if (on_fire)
		balloon_alert(src, "can't heal while on fire!")
		return FALSE
	return TRUE

/**
 * ### Badnana Spider
 * Laugh yourself to death!
 */

/mob/living/basic/spider/giant/badnana_spider
	name = "badnana spider"
	desc = "WHY WOULD GOD ALLOW THIS?!"
	icon = 'modular_nova/master_files/icons/mob/newmobs.dmi'
	icon_state = "badnanaspider" // created by Coldstorm on the Skyrat Discord
	icon_living = "badnanaspider"
	icon_dead = "badnanaspider_d"
	maxHealth = 40
	health = 40
	melee_damage_lower = 5
	melee_damage_upper = 5
	poison_per_bite = 5
	poison_type = /datum/reagent/toxin/laughjuice
	speed = 3
	faction = list(FACTION_SPIDER)
	ai_controller = /datum/ai_controller/basic_controller/badnana
	innate_actions = list(
		/datum/action/cooldown/mob_cooldown/command_spiders/communication_spiders,
		/datum/action/cooldown/mob_cooldown/lay_web/solid_web,
		/datum/action/cooldown/mob_cooldown/secrete_acid,
		/datum/action/cooldown/mob_cooldown/web_effigy,
	)

/mob/living/basic/spider/giant/badnana_spider/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_STRONG_GRABBER, INNATE_TRAIT)
	AddElement(/datum/element/web_walker, /datum/movespeed_modifier/below_average_web)
