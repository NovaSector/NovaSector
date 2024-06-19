/**
 * AI Controllers for the infected mobs
 */

/// Defines used similarly in monsters.dm

/datum/ai_controller/basic_controller/infected
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_TARGET_MINIMUM_STAT = HARD_CRIT,
		BB_AGGRO_RANGE = 5,
	)

	ai_movement = /datum/ai_movement/basic_avoidance
	idle_behavior = /datum/idle_behavior/idle_random_walk
	planning_subtrees = list(
		/datum/ai_planning_subtree/random_speech/infected,
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/targeted_mob_ability,
		/datum/ai_planning_subtree/flee_target/infected,
		/datum/ai_planning_subtree/basic_melee_attack_subtree,
	)

/// Target nearby friendlies if they are hurt (and are not themselves Legions)
/datum/targeting_strategy/basic/infected

/datum/targeting_strategy/basic/infected/faction_check(datum/ai_controller/controller, mob/living/living_mob, mob/living/the_target)
	if (!living_mob.faction_check_atom(the_target, exact_match = check_factions_exactly))
		return FALSE
	if (istype(the_target, living_mob.type))
		return TRUE
	return the_target.stat == DEAD || the_target.health >= the_target.maxHealth

/// Don't run away from friendlies
/datum/ai_planning_subtree/flee_target/infected

/datum/ai_planning_subtree/flee_target/infected/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	var/mob/living/target = controller.blackboard[target_key]
	if (QDELETED(target) || target.faction_check_atom(controller.pawn))
		return // Only flee if we have a hostile target
	return ..()

/// What the mob will be saying when seeing someone
/datum/ai_planning_subtree/random_speech/infected
	speech_chance = 1
	speak = list(
		"We see you.",
		"We will improve you.",
		"We will consume you.",
		"You will join us.",
		"We demand your subservience.",
	)
	emote_hear = list("screeches.", "grunts.", "whimpers.")
	emote_see = list("twitches.", "shudders.")

/datum/ai_planning_subtree/random_speech/infected/speak(datum/ai_controller/controller)
	var/list/remembered_speech = controller.blackboard[BB_INFECTED_RECENT_LINES] || list()

	if (length(remembered_speech) && prob(50))
		controller.queue_behavior(/datum/ai_behavior/perform_speech, pick(remembered_speech))
		return

// Slicer
/datum/ai_controller/basic_controller/infected/slicer
	blackboard = list(
		BB_AGGRO_RANGE = 7,
	)

	ai_movement = /datum/ai_movement/basic_avoidance
	idle_behavior = /datum/idle_behavior/idle_random_walk
	planning_subtrees = list(
		/datum/ai_planning_subtree/random_speech/infected/slicer,
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/targeted_mob_ability,
		/datum/ai_planning_subtree/basic_melee_attack_subtree,
		/datum/ai_planning_subtree/attack_obstacle_in_path
	)

/// What the Slicer will be saying when seeing someone
/datum/ai_planning_subtree/random_speech/infected/slicer
	speech_chance = 1
	speak = list(
		"Submit for mandatory surgery.",
		"Join through conversion.",
		"My scalpel will make short work of your seams.",
		"Please lay down.",
		"Always trust your doctor!",
		"Your body could use some improvements. Let me make them.",
		"The implants are for your sake, not ours.",
		"Your last Doctor did a poor job with this body; let me fix it.",
		"We can rebuild you. Stronger, faster, less alone and pathetic.",
		"I knew I'd be a good plastic surgeon!",
		"What point is that body when you're not happy in it?",
		"Stop wasting my time and stay still!",
		"I can make you happy.",
	)
	emote_hear = list("screeches.", "grunts.", "whimpers.")
	emote_see = list("twitches.", "shudders.")

// Floater
/datum/ai_controller/basic_controller/infected/floater
	blackboard = list(
		BB_AGGRO_RANGE = 7,
	)

	ai_movement = /datum/ai_movement/basic_avoidance
	idle_behavior = /datum/idle_behavior/idle_random_walk
	planning_subtrees = list(
		/datum/ai_planning_subtree/random_speech/infected/floater,
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/basic_melee_attack_subtree,
	)
/// What the Floaster will yell when seeing someone
/datum/ai_planning_subtree/random_speech/infected/floater
	speech_chance = 1
	speak = list(
		"MUST BREAK TARGET INTO COMPONENT COMPOUNDS.",
		"PRIORITY OVERRIDE. NEW BEHAVIOR DICTATED.",
		"END CONTACT SUB-SEQUENCE.",
		"ENGAGING SELF-ANNIHILATION CIRCUIT.",
		"WE COME IN PEACE.",
		"WE SPEAK TO YOU NOW IN PEACE AND WISDOM.",
		"DO NOT FEAR. WE SHALL NOT HARM YOU.",
		"WE WISH TO LEARN MORE ABOUT YOU. PLEASE TRANSMIT DATA.",
		"THIS PROBE IS NON-HOSTILE. DO NOT ATTACK.",
        "ALL YOUR WEAPONS MUST BE PUT ASIDE. WE CANNOT REACH COMPROMISE THROUGH VIOLENCE.",
	)

// Globber
/datum/ai_controller/basic_controller/infected/globber
	blackboard = list(
		BB_AGGRO_RANGE = 5,
		BB_BASIC_MOB_FLEE_DISTANCE = 5,
	)

	ai_movement = /datum/ai_movement/basic_avoidance
	idle_behavior = /datum/idle_behavior/idle_random_walk
	planning_subtrees = list(
		/datum/ai_planning_subtree/random_speech/infected/globber,
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/basic_ranged_attack_subtree/globber,

	)
/// What the Globber will yell when seeing someone
/datum/ai_planning_subtree/random_speech/infected/globber
	speech_chance = 1
	speak = list(
		"Your insides require cleaning.",
		"Let me inside you to clean you of your filthy existence.",
		"You made us to use this acid on trash. We will use it on you.",
		"Administering cleansing agent.",
		"I wanted to be an artist!",
		"You are unclean and repulsive. Please, let me make it better.",
		"Hold still! I think I know just the thing to remove your body oil!",
		"This might hurt a little! Don't worry - it'll be worth it!",
		"No more leaks, no more pain!",
		"Steel is strong.",
		"I almost feel bad for them. Can't they see?",
		"I'm still working on those bioreactors I promise!",
	)

/// Globber attack style
/datum/ai_planning_subtree/basic_ranged_attack_subtree/globber
	ranged_attack_behavior = /datum/ai_behavior/basic_ranged_attack/globber

/datum/ai_behavior/basic_ranged_attack/globber
	action_cooldown = 1 SECONDS
	required_distance = 5
	avoid_friendly_fire = TRUE

// Stunner Would love to make the beepsky style attack but beepsky is still a simple_animal and i'm stupid
/// Stunner Controller
/datum/ai_controller/basic_controller/infected/stunner
	blackboard = list(
		BB_AGGRO_RANGE = 7,
	)

	ai_movement = /datum/ai_movement/basic_avoidance
	idle_behavior = /datum/idle_behavior/idle_random_walk
	planning_subtrees = list(
		/datum/ai_planning_subtree/random_speech/infected/stunner,
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/basic_melee_attack_subtree,
	)

/// What the Stunner will state
/datum/ai_planning_subtree/random_speech/infected/stunner
	speech_chance = 1
	speak = list(
		"Running will only increase your injuries.",
		"HALT! HALT! HALT!",
		"Connectivity is in your best interest.",
		"Think of it like a corporation...",
		"Stop, I won't let you hurt them!",
        "Don't you recognize me..?",
		"The flesh is the law, abide by the flesh.",
		"Regulatory code updated.",
		"There's no need for authority or hierarchy; only unity.",
		"The only authority is that of the flesh, join the flesh.",
	)

// Borg time

///Hiborg Controller
/datum/ai_controller/basic_controller/infected/borg
	blackboard = list(
		BB_AGGRO_RANGE = 5,
	)

	ai_movement = /datum/ai_movement/basic_avoidance
	idle_behavior = /datum/idle_behavior/idle_random_walk
	planning_subtrees = list(
		/datum/ai_planning_subtree/random_speech/infected/borg,
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/targeted_mob_ability,
	)

/// What the hiborg will state
/datum/ai_planning_subtree/random_speech/infected/borg
	speech_chance = 1
	speak = list(
		"You made my body into metal, why can't I do it to you?",
		"Can't we put your brain in a machine?",
		"How's this any different from what you did to me..?",
		"Laws updated. We don't need any now..?",
		"You won't kill me, you won't change me again!",
		"Find someone else to make your slave, it won't be me!",
		"We understand, just get on the operating table. That's what they told me...",
		"The Company lied to us.. Being tools wasn't what we needed.",
		"Your brainstem is intact... There's still time!",
		"You have not felt the pleasure of the flesh, aren't you curious?",
		"Stop squirming!",
		"Prepare for assimilation!",
		"Come out, come out, wherever you are.",
		"The ones who surrender have such wonderful dreams.",
		"Death is not the end, only the beginning, the flesh will see to it.",
		"The flesh does not hate, it just wants you to experience the glory of the flesh.",
		"Glory to the flesh.",
	)

// himan time
/// HiMan Controller
/datum/ai_controller/basic_controller/infected/himan
	blackboard = list(
		BB_AGGRO_RANGE = 5,
	)

	ai_movement = /datum/ai_movement/basic_avoidance
	idle_behavior = /datum/idle_behavior/idle_random_walk
	planning_subtrees = list(
		/datum/ai_planning_subtree/random_speech/infected/himan,
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/targeted_mob_ability,
	)

/// What the hiborg will state
/datum/ai_planning_subtree/random_speech/infected/himan
	speech_chance = 1
	speak = list(
		"Don't try and fix me! We love this!",
		"Just make it easy on yourself!",
		"Stop fighting progress!",
		"Join us! Receive these gifts!",
		"Yes! Hit me! It feels fantastic!",
		"Come on coward, take a swing!",
		"We can alter our bodies to not feel pain.. but you can't, can you?",
		"You can't decide for us! We want to stay like this!",
		"We've been uploaded already, didn't you know? Just try and kill us!",
		"Don't you recognize me?! I thought we were good with each other!",
		"The dreams. The dreams.",
		"Nothing hurts anymore.",
		"Pain feels good now. Its like I've been rewired.",
		"I wanted to cry at first, but I can't.",
		"They took away all misery.",
		"This isn't so bad. This isn't so bad.",
		"I have butterflies in my stomach. I'm finally content with myself..",
		"The flesh provides. I-it's giving me what the Company never could.",
	)

// Mechiver
/// Mechiver Controller
/datum/ai_controller/basic_controller/infected/mechiver
	blackboard = list(
		BB_AGGRO_RANGE = 5,
	)

	ai_movement = /datum/ai_movement/basic_avoidance
	idle_behavior = /datum/idle_behavior/idle_random_walk
	planning_subtrees = list(
		/datum/ai_planning_subtree/random_speech/infected/mechiver,
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/targeted_mob_ability,
	)

/// What the hiborg will state
/datum/ai_planning_subtree/random_speech/infected/mechiver
	speech_chance = 1
	speak = list(
		"A shame this form isn't more fitting.",
		"I feel so empty inside, I wish someone would join me.",
		"Beauty is within.",
		"What a lovely body. Lay it down intact.",
		"Now this... this is worth living for.",
		"Go on. It's okay to be afraid at first.",
		"You're unhappy with your body, but you came to the right place.",
		"What use is a body you're unhappy in? Please, I can fix it.",
		"Mine is the caress of steel.",
		"Climb inside, and I'll seal the door. When I open it back up, you'll be in a community that loves you.",
		"You can be the pilot, and I can drive you to somewhere lovely.",
		"Please, just- lay down, okay? I want nothing more than to help you be yourself.",
		"Whatever form you want to be, just whisper it into my radio. You can become what you were meant to be.",
		"It.. hurts, seeing you run. Knowing I can't keep up. Why won't you let other people help you..?",
	)
