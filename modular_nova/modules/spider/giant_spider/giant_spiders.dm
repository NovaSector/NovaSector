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
	speed = 5
	player_speed_modifier = -3.1
	gold_core_spawnable = NO_SPAWN
	menu_description = "somewhat slow, throw webs to ensnare."
	innate_actions = list(
		/datum/action/cooldown/mob_cooldown/command_spiders/communication_spiders,
		/datum/action/cooldown/mob_cooldown/sneak/webslinger,
		/datum/action/cooldown/mob_cooldown/wrap,
		/datum/action/cooldown/mob_cooldown/lay_web/web_passage,
		/datum/action/cooldown/spell/pointed/projectile/web_restraints = BB_ARACHNID_RESTRAIN,
	)

/mob/living/basic/spider/giant/webslinger/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_STRONG_GRABBER, INNATE_TRAIT)
	AddElement(/datum/element/web_walker, /datum/movespeed_modifier/slow_web)

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
	maxHealth = 115
	health = 115

	melee_damage_lower = 8
	melee_damage_upper = 8
	poison_per_bite = 2
	poison_type = /datum/reagent/teslium
	speed = 2.8
	player_speed_modifier = -3.1
	gold_core_spawnable = NO_SPAWN
	menu_description = "fast but not sturdy, your bites inject teslium"
	innate_actions = list(
		/datum/action/cooldown/mob_cooldown/command_spiders/communication_spiders,
		/datum/action/cooldown/mob_cooldown/wrap,
	)

/mob/living/basic/spider/giant/voltaic/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_STRONG_GRABBER, INNATE_TRAIT)
	AddElement(/datum/element/web_walker, /datum/movespeed_modifier/slow_web)

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
	speed = 5
	player_speed_modifier = -4
	sight = SEE_TURFS
	menu_description = "Has the ability to destroy walls and limbs, and to send warnings to the nest."
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
	maxHealth = 600 // hah fat
	health = 600
	damage_coeff = list(BRUTE = 1, BURN = 1, TOX = 1, STAMINA = 1, OXY = 1)
	poison_per_bite = 1
	poison_type = /datum/reagent/toxin/hunterspider
	melee_damage_lower = 5
	melee_damage_upper = 5
	obj_damage = 15
	speed = 5
	player_speed_modifier = -4
	menu_description = "Extremely tanky with very poor offense. Able to self-heal and lay reflective silk screens, passages, and traps."
	innate_actions = list(
		/datum/action/cooldown/mob_cooldown/wrap,
		/datum/action/cooldown/mob_cooldown/command_spiders/communication_spiders,
		/datum/action/cooldown/mob_cooldown/lay_web/solid_web,
		/datum/action/cooldown/mob_cooldown/lay_web/sticky_web,
		/datum/action/cooldown/mob_cooldown/lay_web/web_passage,
		/datum/action/cooldown/mob_cooldown/lay_web/web_spikes,
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
