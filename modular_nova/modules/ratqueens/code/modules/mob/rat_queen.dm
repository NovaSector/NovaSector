// Adds rat fashion system
/mob/living/basic/regal_rat
	/// Typepath to what kind of fashion are we rocking
	var/datum/rat_fashion/current_look
	/// Press this to change your rat outfit
	var/datum/action/cooldown/rat_fashion/fashion_select
	gender = PLURAL

/mob/living/basic/regal_rat/Initialize(mapload)
	. = ..()
	fashion_select = new(src)
	fashion_select.Grant(src)
	pick_random_look()

/// Randomise how we look on init
/mob/living/basic/regal_rat/proc/pick_random_look()
	var/list/valid_starting_styles = list()
	for (var/datum/rat_fashion/style_path as anything in subtypesof(/datum/rat_fashion))
		if (!initial(style_path.allow_random))
			continue
		valid_starting_styles += new style_path()
	if (!length(valid_starting_styles))
		return
	set_look(pick(valid_starting_styles))

/// Applies a fashion look to us
/mob/living/basic/regal_rat/proc/set_look(look_path)
	if(isnull(look_path))
		return
	current_look = look_path
	icon = current_look::icon
	update_appearance(UPDATE_ICON_STATE)

/mob/living/basic/regal_rat/update_icon_state()
	. = ..()
	icon_living = current_look::icon_state_living
	icon_dead = current_look::icon_state_dead
	icon_state = stat == DEAD ? icon_dead : icon_living

/mob/living/basic/regal_rat/revive(full_heal_flags, excess_healing, force_grab_ghost)
	. = ..()
	if(!.)
		return
	update_appearance(UPDATE_ICON_STATE)

/mob/living/basic/regal_rat/Destroy(force)
	QDEL_NULL(fashion_select)
	return ..()

/// Regal rat swallows sludge to transform themselves into a different looking rat
/datum/action/cooldown/rat_fashion
	name = "Rat King's Transformation"
	desc = "Assume your true form, whatever you decide it is at the moment."
	check_flags = AB_CHECK_CONSCIOUS
	cooldown_time = 10 SECONDS
	melee_cooldown_time = 0 SECONDS
	button_icon = 'icons/mob/actions/actions_spells.dmi'
	button_icon_state = "exit_possession"
	background_icon_state = "bg_clock"
	overlay_icon_state = "bg_clock_border"

/datum/action/cooldown/rat_fashion/Activate(atom/target)
	var/mob/living/basic/regal_rat/rat_owner = owner
	if (!istype(rat_owner))
		owner.balloon_alert(owner, "not a rat!")
		qdel(src)
		return

	var/list/options = list()
	var/list/rat_styles = subtypesof(/datum/rat_fashion)
	for (var/datum/rat_fashion/style_path as anything in rat_styles)
		var/datum/radial_menu_choice/fashion_choice = new
		fashion_choice.image = image(style_path::icon, style_path::icon_state_living)
		fashion_choice.name = style_path::name
		options[style_path] = fashion_choice

	var/datum/rat_fashion/pick = show_radial_menu(owner, owner, options, require_near = TRUE)
	if (!pick)
		return

	var/turf/origin = get_turf(owner)
	owner.balloon_alert_to_viewers("shudders...")

	if (!do_after(owner, 3 SECONDS, target = origin))
		owner.balloon_alert(owner, "interrupted!")
		return

	if (QDELETED(rat_owner)) // died/deleted somehow
		return

	rat_owner.set_look(pick)
	var/obj/effect/particle_effect/fluid/smoke/poof = new(origin)
	poof.lifetime = 2 SECONDS
	poof.color = "#5f5940"
	return ..()

/// Decides how regal rats can look
/datum/rat_fashion
	var/name = ""
	var/allow_random = TRUE
	var/icon = 'modular_nova/modules/ratqueens/icons/rat.dmi'
	var/icon_state_living
	var/icon_state_dead

/// Normal
/datum/rat_fashion/default
	name = "regal rat"
	icon = 'icons/mob/simple/animal.dmi'
	icon_state_living = "regalrat"
	icon_state_dead = "regalrat_dead"

/// Old sprite
/datum/rat_fashion/classic
	name = "retro rat"
	allow_random = FALSE
	icon_state_living = "classic"
	icon_state_dead = "classic_dead"

/// Rat KING (ported from PR #10294 of space-wizards/space-station-14)

/datum/rat_fashion/swole
	name = "swoleking"
	allow_random = FALSE
	icon_state_living = "buffking"
	icon_state_dead = "buffking_dead"

/// Rat queen (thick rat)

/datum/rat_fashion/rat_queen
	name = "rat queen"
	allow_random = TRUE
	icon_state_living = "ratqueen"
	icon_state_dead = "ratqueen_dead"

/// Rat queen alt (fat rat)

/datum/rat_fashion/rat_queen_alt
	name = "rat queen alt"
	allow_random = TRUE
	icon_state_living = "ratqueen_fat"
	icon_state_dead = "ratqueen_dead"

/// Ringmaster (thick rat but clothed)

/datum/rat_fashion/ringmaster
	name = "ringmaster"
	allow_random = FALSE
	icon_state_living = "ringmaster"
	icon_state_dead = "ratqueen_dead"
