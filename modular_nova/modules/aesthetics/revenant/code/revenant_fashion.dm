/mob/living/basic/revenant
	/// Typepath to what kind of fashion are we rocking
	var/datum/revenant_fashion/current_look
	/// Press this to change your revenant outfit
	var/datum/action/cooldown/revenant_fashion/fashion_select

/mob/living/basic/revenant/Initialize(mapload)
	. = ..()
	fashion_select = new(src)
	fashion_select.Grant(src)
	pick_random_look()

/// Randomise how we look on init
/mob/living/basic/revenant/proc/pick_random_look()
	var/list/valid_starting_styles = list()
	for (var/datum/revenant_fashion/style_path as anything in subtypesof(/datum/revenant_fashion))
		if (!initial(style_path.allow_random))
			continue
		valid_starting_styles += new style_path()
	if (!length(valid_starting_styles))
		return
	set_look(pick(valid_starting_styles))

/// Applies a fashion look to us
/mob/living/basic/revenant/proc/set_look(look_path)
	if(isnull(look_path))
		return
	current_look = look_path
	icon = current_look::icon
	// Update the icon states for all our appearances
	icon_idle = current_look::icon_state_idle
	icon_reveal = current_look::icon_state_revealed
	icon_stun = current_look::icon_state_stun
	icon_drain = current_look::icon_state_drain
	update_appearance(updates = UPDATE_ICON_STATE)

/mob/living/basic/revenant/Destroy(force)
	QDEL_NULL(fashion_select)
	return ..()

// Revenant transforms into a different looking revenant
/datum/action/cooldown/revenant_fashion
	name = "Revenant's Visage"
	desc = "Assume your true form, whatever you decide it is at the moment."
	check_flags = AB_CHECK_CONSCIOUS
	cooldown_time = 10 SECONDS
	melee_cooldown_time = 0 SECONDS
	button_icon = 'icons/mob/actions/actions_revenant.dmi'
	button_icon_state = "r_nightvision"
	background_icon_state = "bg_revenant"
	overlay_icon_state = "bg_revenant_border"

/datum/action/cooldown/revenant_fashion/Activate(atom/target)
	var/mob/living/basic/revenant/revenant_owner = owner
	if(!istype(revenant_owner))
		owner.balloon_alert(owner, "not a revenant!")
		qdel(src)
		return

	if(revenant_owner.dormant)
		owner.balloon_alert(owner, "can't change while dormant!")
		return

	if(HAS_TRAIT(revenant_owner, TRAIT_NO_TRANSFORM))
		owner.balloon_alert(owner, "can't change right now!")
		return

	var/list/options = list()
	var/list/revenant_styles = subtypesof(/datum/revenant_fashion)
	for(var/datum/revenant_fashion/style_path as anything in revenant_styles)
		var/datum/radial_menu_choice/fashion_choice = new
		fashion_choice.image = image(style_path::icon, style_path::icon_state_idle)
		fashion_choice.name = style_path::name
		options[style_path] = fashion_choice

	var/datum/revenant_fashion/pick = show_radial_menu(owner, owner, options, require_near = TRUE)
	if(!pick)
		return

	if(QDELETED(revenant_owner))
		return

	revenant_owner.set_look(pick)
	Remove(revenant_owner)
	return ..()

// Decides how revenants can look
/datum/revenant_fashion
	var/name = ""
	var/icon = 'modular_nova/modules/aesthetics/revenant/icons/revenant.dmi'
	var/icon_state_idle = "revenant_idle"
	var/icon_state_revealed = "revenant_revealed"
	var/icon_state_stun = "revenant_stun"
	var/icon_state_drain = "revenant_draining"
	var/allow_random = TRUE

// New/Modern sprite (default)
/datum/revenant_fashion/modern
	name = "modern revenant"
	icon = 'modular_nova/modules/aesthetics/revenant/icons/revenant.dmi'

// Classic/Old sprite
/datum/revenant_fashion/classic
	name = "classic revenant"
	icon = 'icons/mob/simple/mob.dmi'
	allow_random = FALSE
