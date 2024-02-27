//Special variation of the suit that applies slight slowdown
/obj/item/clothing/suit/hooded/hostile_environment/boomer_shooter
	slowdown = 0.2

//They speed you up and let you bhop
/obj/item/clothing/shoes/bhop/boomer_shooter
	name = "swag shoes"
	desc = "They got me for my foams!"
	icon_state = "SwagShoes"
	inhand_icon_state = null
	slowdown = -0.2

#define MAX_ATOMIC_CHARGE 100
#define PROJECTILE_HIT_MULTIPLIER 1.5
#define DAMAGE_TO_CHARGE_SCALE 0.75
#define CHARGE_DRAINED_PER_SECOND 5
#define ATOMIC_ATTACK_SPEED_MODIFIER 0.25
/// Trait granted by nukem sunglasses.
#define ATOMIC_TRAIT "atomic_trait"
/// List of lines that might be used on activation.
#define ATOMIC_LINES list(\
	"Hail to the king, baby!",\
	"Oh yeah, it's ass-kicking time!",\
	"Damn, I'm looking good!",\
	"Tonight, you dine in hell!",\
	"Step right up and get some!",\
	"I'm not done with you, pussy!",\
	)

//'Berserk' glasses
/obj/item/clothing/glasses/sunglasses/big/boomer_shooter
	actions_types = list(/datum/action/item_action/atomic_mode)
	/// Current charge of atomic mode, goes from 0 to 100
	var/atomic_charge = 0
	/// Status of atomic mode
	var/atomic_active = FALSE

/obj/item/clothing/glasses/sunglasses/big/boomer_shooter/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, LOCKED_HELMET_TRAIT)

/obj/item/clothing/glasses/sunglasses/big/boomer_shooter/examine()
	. = ..()
	. += span_notice("Atomic mode is [atomic_charge]% charged.")

/obj/item/clothing/glasses/sunglasses/big/boomer_shooter/process(seconds_per_tick)
	if(atomic_active)
		atomic_charge = clamp(atomic_charge - CHARGE_DRAINED_PER_SECOND * seconds_per_tick, 0, MAX_ATOMIC_CHARGE)
	if(!atomic_charge)
		if(ishuman(loc))
			end_atomic(loc)

/obj/item/clothing/glasses/sunglasses/big/boomer_shooter/dropped(mob/user)
	. = ..()
	end_atomic(user)

/obj/item/clothing/glasses/sunglasses/big/boomer_shooter/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK, damage_type = BRUTE)
	if(atomic_active)
		return
	var/atomic_value = damage * DAMAGE_TO_CHARGE_SCALE
	if(attack_type == PROJECTILE_ATTACK)
		atomic_value *= PROJECTILE_HIT_MULTIPLIER
	atomic_charge = clamp(round(atomic_charge + atomic_value), 0, MAX_ATOMIC_CHARGE)
	if(atomic_charge >= MAX_ATOMIC_CHARGE)
		to_chat(owner, span_notice("Atomic mode is fully charged."))
		balloon_alert(owner, "nuke charged")

/obj/item/clothing/glasses/sunglasses/big/boomer_shooter/IsReflect()
	if(atomic_active)
		return TRUE

/// Starts atomic mode, giving the wearer doubled attacking speed, adding a color and giving them the atomic movespeed modifier
/obj/item/clothing/glasses/sunglasses/big/boomer_shooter/proc/atomic_mode(mob/living/carbon/human/user)
	to_chat(user, span_warning("You enter atomic mode."))
	playsound(user, 'sound/magic/staff_healing.ogg', 50)
	user.say(pick(ATOMIC_LINES), forced = type)
	user.add_movespeed_modifier(/datum/movespeed_modifier/atomic)
	user.next_move_modifier *= ATOMIC_ATTACK_SPEED_MODIFIER
	user.add_atom_colour(COLOR_BUBBLEGUM_RED, TEMPORARY_COLOUR_PRIORITY)
	atomic_active = TRUE
	START_PROCESSING(SSobj, src)

/// Ends atomic, reverting the changes from the proc [atomic_mode]
/obj/item/clothing/glasses/sunglasses/big/boomer_shooter/proc/end_atomic(mob/living/carbon/human/user)
	if(!atomic_active)
		return
	atomic_active = FALSE
	if(QDELETED(user))
		return
	to_chat(user, span_warning("You exit atomic mode."))
	playsound(user, 'sound/magic/summonitems_generic.ogg', 50)
	user.remove_movespeed_modifier(/datum/movespeed_modifier/atomic)
	user.next_move_modifier /= ATOMIC_ATTACK_SPEED_MODIFIER
	user.remove_atom_colour(TEMPORARY_COLOUR_PRIORITY, COLOR_BUBBLEGUM_RED)
	STOP_PROCESSING(SSobj, src)

#undef MAX_ATOMIC_CHARGE
#undef PROJECTILE_HIT_MULTIPLIER
#undef DAMAGE_TO_CHARGE_SCALE
#undef CHARGE_DRAINED_PER_SECOND
#undef ATOMIC_ATTACK_SPEED_MODIFIER
#undef ATOMIC_TRAIT

/datum/action/item_action/atomic_mode
	name = "Atomic Mode"
	desc = "Increase your movement and melee speed for a short amount of time."
	button_icon = 'icons/mob/actions/actions_items.dmi'
	button_icon_state = "berserk_mode"
	background_icon_state = "bg_demon"
	overlay_icon_state = "bg_demon_border"

/datum/action/item_action/atomic_mode/Trigger(trigger_flags)
	if(istype(target, /obj/item/clothing/glasses/sunglasses/big/boomer_shooter))
		var/obj/item/clothing/glasses/sunglasses/big/boomer_shooter/nukem = target
		if(nukem.atomic_active)
			to_chat(owner, span_warning("You are already atomic!"))
			return
		if(nukem.atomic_charge < 100)
			to_chat(owner, span_warning("You don't have a full charge."))
			return
		nukem.atomic_mode(owner)
		return
	return ..()

//Big punch gloves
/obj/item/clothing/gloves/fingerless/boomer_shooter/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/wearertargeting/punchcooldown)

//Lightly armored
/obj/item/clothing/under/pants/jeans/boomer_shooter
	armor_type = /datum/armor/hooded_hostile_environment

/datum/movespeed_modifier/atomic
	multiplicative_slowdown = -0.3
