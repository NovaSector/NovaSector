#define NABBER_COLD_THRESHOLD_1 180
#define NABBER_COLD_THRESHOLD_2 140
#define NABBER_COLD_THRESHOLD_3 100

#define NABBER_HEAT_THRESHOLD_1 300
#define NABBER_HEAT_THRESHOLD_2 440
#define NABBER_HEAT_THRESHOLD_3 600

#define ORGAN_ICON_NABBER 'modular_iris/monke_ports/gas/icons/organs/nabber_organs.dmi'

/obj/item/organ/tongue/nabber
	name = "nabber tongue"
	say_mod = "chitters"
	liked_foodtypes = RAW | GORE | GRAIN
	disliked_foodtypes = CLOTH | FRIED | TOXIC
	toxic_foodtypes = DAIRY

/obj/item/organ/ears/nabber
	name = "nabber ears"
	icon = ORGAN_ICON_NABBER
	icon_state = "ears"

/obj/item/organ/heart/nabber
	name = "haemolyph pump"
	icon = ORGAN_ICON_NABBER
	icon_state = "heart"

/obj/item/organ/brain/nabber
	name = "nabber brain"
	icon = ORGAN_ICON_NABBER
	icon_state = "brain"

/obj/item/organ/eyes/nabber
	name = "nictating eyes"
	desc = "Small orange orbs with a pair of welding shield lenses."
	icon = ORGAN_ICON_NABBER
	icon_state = "eyes"
	flash_protect = FLASH_PROTECTION_SENSITIVE
	var/datum/action/cooldown/toggle_welding/shield
	var/active = FALSE

/obj/item/organ/eyes/nabber/on_mob_insert(mob/living/carbon/eye_recipient)
	. = ..()
	shield = new(eye_recipient)
	shield.button_icon = 'modular_iris/monke_ports/gas/icons/actions.dmi'
	shield.button_icon_state = "nabber-shield-0"
	shield.Grant(eye_recipient)
	shield.eyes = src

/obj/item/organ/eyes/nabber/proc/toggle_shielding()
	if(!owner)
		return

	active = !active
	playsound(owner, 'sound/machines/click.ogg', 50, TRUE)

	if(active)
		flash_protect = FLASH_PROTECTION_WELDER
		tint = 2
		owner.update_tint()
		owner.balloon_alert(owner, "Welder eyelids shut!")
		shield.button_icon_state = "nabber-shield-1"
		owner.update_action_buttons()
		return

	flash_protect = FLASH_PROTECTION_SENSITIVE
	tint = 0
	owner.update_tint()
	owner.balloon_alert(owner, "Welder eyelids open!")
	shield.button_icon_state = "nabber-shield-0"
	owner.update_action_buttons()

/obj/item/organ/eyes/nabber/Remove(mob/living/carbon/organ_owner, special = FALSE, movement_flags)
	. = ..()
	QDEL_NULL(shield)
	active = FALSE
	toggle_shielding()

/obj/item/organ/lungs/nabber
	name = "spiracle lungs" //Insects breathe differently
	icon = ORGAN_ICON_NABBER
	icon_state = "lungs"

	cold_message = "frigid cold"
	cold_level_1_threshold = NABBER_COLD_THRESHOLD_1
	cold_level_2_threshold = NABBER_COLD_THRESHOLD_2
	cold_level_3_threshold = NABBER_COLD_THRESHOLD_3
	cold_level_1_damage = COLD_GAS_DAMAGE_LEVEL_1 //Keep in mind with gas damage levels, you can set these to be negative, if you want someone to heal, instead.
	cold_level_2_damage = COLD_GAS_DAMAGE_LEVEL_1
	cold_level_3_damage = COLD_GAS_DAMAGE_LEVEL_2
	cold_damage_type = BRUTE


	hot_message = "scorching heat"
	heat_level_1_threshold = NABBER_HEAT_THRESHOLD_1
	heat_level_2_threshold = NABBER_HEAT_THRESHOLD_2
	heat_level_3_threshold = NABBER_HEAT_THRESHOLD_3
	heat_level_1_damage = HEAT_GAS_DAMAGE_LEVEL_2
	heat_level_2_damage = HEAT_GAS_DAMAGE_LEVEL_3
	heat_level_3_damage = HEAT_GAS_DAMAGE_LEVEL_3
	heat_damage_type = BURN

	safe_plasma_max = 0 //they heal oxygen damage from liquid plasma

/obj/item/organ/liver/nabber
	name = "catalytic processor" //Nabbers convert oxygen -> plasma lorewise in their blood
	icon_state = "liver"
	icon = ORGAN_ICON_NABBER
	liver_resistance = 0.8 //Weaker livers

/obj/item/organ/liver/nabber/handle_chemical(mob/living/carbon/owner, datum/reagent/toxin/chem, seconds_per_tick, times_fired) //converts plasma tox damage to healing oxy damage
	. = ..()
	if(. & COMSIG_MOB_STOP_REAGENT_TICK)
		return
	if(chem.type == /datum/reagent/toxin/plasma || chem.type == /datum/reagent/toxin/hot_ice)
		chem.toxpwr = 0
		owner.adjust_oxy_loss(-0.5 * REM * seconds_per_tick, updating_health = FALSE)
#undef ORGAN_ICON_NABBER
