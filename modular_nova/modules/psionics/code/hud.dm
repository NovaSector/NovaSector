/atom/movable/screen/psionic
	icon = 'modular_nova/modules/psionics/icons/hud.dmi'

/atom/movable/screen/psionic/strain
	name = "psionic strain"
	desc = "A liminal pressure gauge for psionic exertion."
	icon_state = "strain0"
	screen_loc = UI_PSIONIC_STRAIN
	mouse_over_pointer = MOUSE_HAND_POINTER
	maptext_width = 64
	maptext_height = 12
	maptext_x = -16
	maptext_y = -5

	/// Boolean on whether a mouse is hovering over this indicator.
	var/hovering = FALSE
	/// Last displayed strain value.
	var/current_strain = 0
	/// Last displayed maximum strain value.
	var/current_max_strain = PSIONIC_DEFAULT_MAX_STRAIN
	/// Last displayed visual strain level.
	var/current_level = 0
	/// Whether the last displayed state was burnout.
	var/showing_burnout = FALSE

/atom/movable/screen/psionic/strain/Click(location, control, params)
	. = ..()
	var/mob/living/living_mob = hud?.mymob
	var/datum/component/psionic_profile/profile = living_mob?.get_psionic_profile()
	if(!profile)
		return

	to_chat(usr, span_notice("Psionic strain: [round(profile.strain)]/[profile.max_strain]. If it fills, your focus burns out."))

/atom/movable/screen/psionic/strain/MouseEntered(location, control, params)
	if(usr != get_mob())
		return

	. = ..()
	hovering = TRUE
	var/mob/living/living_mob = hud?.mymob
	var/datum/component/psionic_profile/profile = living_mob?.get_psionic_profile()
	if(profile)
		profile.update_strain_hud()

/atom/movable/screen/psionic/strain/MouseExited(location, control, params)
	if(usr != get_mob())
		return

	. = ..()
	hovering = FALSE
	update_maptext()

/atom/movable/screen/psionic/strain/proc/update_strain(new_strain, new_max_strain, burned_out)
	new_strain = max(round(new_strain), 0)
	new_max_strain = max(round(new_max_strain), 1)
	var/new_level = new_strain <= 0 ? 0 : clamp(CEILING((new_strain / new_max_strain) * 5, 1), 1, 5)

	if(current_strain == new_strain && current_max_strain == new_max_strain && current_level == new_level && showing_burnout == burned_out)
		update_maptext()
		return

	current_strain = new_strain
	current_max_strain = new_max_strain
	current_level = new_level
	showing_burnout = burned_out
	icon_state = burned_out ? "strain_burnout" : "strain[current_level]"
	desc = "Your mind is carrying [current_strain]/[current_max_strain] psionic strain."
	update_maptext()
	update_strain_filters()

/atom/movable/screen/psionic/strain/proc/update_maptext()
	if(!hovering)
		maptext = ""
		return

	var/text_color = showing_burnout ? "#ff5cc6" : (current_level >= 4 ? "#ec6cff" : "#8dd8ff")
	maptext = MAPTEXT("<div align='center' valign='middle' style='font-size:6px; -dm-text-outline:1px #050811'><font color='[text_color]'>[current_strain]/[current_max_strain]</font></div>")

/atom/movable/screen/psionic/strain/proc/update_strain_filters()
	remove_filter("psionic_strain_glow")
	remove_filter("psionic_strain_warning")
	if(showing_burnout)
		add_filter("psionic_strain_glow", 1, drop_shadow_filter(0, 0, 3, 0, "#ff5cc6"))
		add_filter("psionic_strain_warning", 2, outline_filter(1, "#ff5cc6", OUTLINE_SHARP))
	else if(current_level >= 4)
		add_filter("psionic_strain_glow", 1, drop_shadow_filter(0, 0, 2, 0, "#ec6cff"))
