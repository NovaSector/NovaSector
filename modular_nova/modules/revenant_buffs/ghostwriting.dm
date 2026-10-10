#define INFINITE_CHARGES -1

/datum/action/cooldown/spell/pointed/revenant/ghostwriting
	name = "Ghostwriting"
	desc = "Write messages on the ground. In ANY COLOR, NOT JUST PURPLE!!!"
	button_icon = 'icons/mob/actions/actions_spells.dmi'
	button_icon_state = "arcane_barrage"
	background_icon_state = "bg_revenant"
	overlay_icon_state = "bg_revenant_border"
	antimagic_flags = MAGIC_RESISTANCE_HOLY
	spell_requirements = NONE
	cooldown_time = 0.2 SECONDS

	active_msg = "You start inscribing doodles."
	deactive_msg = "You stop inscribing doodles."
	aim_assist = FALSE
	unset_after_click = FALSE
	///The crayon used for the ghostwriting
	var/obj/item/toy/crayon/revenant/ghost_crayon
	/// Used to save the click's pixel precision in cast, there's not really a better way of moving this into there without a major refactor
	var/list/click_params

/datum/action/cooldown/spell/pointed/revenant/ghostwriting/Destroy(force)
	QDEL_NULL(ghost_crayon)
	return ..()

/datum/action/cooldown/spell/pointed/revenant/ghostwriting/on_activation(mob/on_who)
	. = ..()
	if(!ghost_crayon)
		ghost_crayon = new()
		ghost_crayon.drawtype = pick(ghost_crayon.all_drawables)

	ghost_crayon.forceMove(on_who)
	ghost_crayon.ui_interact(on_who, null)

/datum/action/cooldown/spell/pointed/revenant/ghostwriting/on_deactivation(mob/on_who, refund_cooldown)
	. = ..()
	if(ghost_crayon)
		SStgui.close_uis(ghost_crayon, on_who)
		QDEL_NULL(ghost_crayon)

/datum/action/cooldown/spell/pointed/revenant/ghostwriting/is_valid_target(atom/cast_on)
	return isturf(cast_on)

/datum/action/cooldown/spell/pointed/revenant/ghostwriting/cast(atom/cast_on)
	. = ..()
	if(ghost_crayon)
		if(!IsAvailable())
			return FALSE

		if(!ghost_crayon.can_use_on(cast_on, owner))
			return FALSE
		StartCooldown()
		ghost_crayon.use_on(cast_on, owner, click_params)
		return TRUE
	return FALSE

/datum/action/cooldown/spell/pointed/revenant/ghostwriting/InterceptClickOn(mob/living/clicker, params, atom/target)
	src.click_params = params2list(params) //hacky solution, but I am sick and tired of working on this. I will not fiddle with porting everything in cast() down here.
	return ..()

//Crayon stuff neccessary for this
/obj/item/toy/crayon/revenant
	name = "ghostwriting"
	desc = "If you're reading this, something went wrong. Yell at coders."
	icon = null
	icon_state = null
	item_flags = ABSTRACT | DROPDEL
	charges = INFINITE_CHARGES
	self_contained = FALSE
	edible = FALSE
	can_change_colour = TRUE
	paint_color = LIGHT_COLOR_PURPLE
	actually_paints = TRUE
	instant = TRUE
	pre_noise = FALSE
	post_noise = FALSE

/obj/item/toy/crayon/revenant/ui_state(mob/user)
	return GLOB.always_state

/obj/item/toy/crayon/revenant/ui_data(mob/user)
	. = ..()
	// Force literacy for ghostwriting UI
	.["is_literate_user"] = TRUE

#undef INFINITE_CHARGES
