/atom/movable/screen/tracking_arrow
	icon = 'modular_nova/modules/bloodsucker/icons/arrow.dmi'
	icon_state = "hud_arrow"
	screen_loc = "CENTER,CENTER"
	color = "#960000"
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/atom/movable/screen/tracking_arrow/proc/update(mob/user, atom/target)
	var/turf/our_turf = get_turf(user)
	var/turf/their_turf = get_turf(target)
	if(!our_turf || !their_turf)
		invisibility = INVISIBILITY_ABSTRACT
		return
	invisibility = INVISIBILITY_NONE
	var/matrix/rotation_matrix = matrix()
	rotation_matrix.Scale(1.5)
	rotation_matrix.Translate(0, -20)
	rotation_matrix.Turn(get_angle(their_turf, our_turf))
	var/new_alpha = 240
	var/new_color = "#808080"
	if(their_turf.z == our_turf.z)
		switch(get_dist(their_turf, our_turf))
			if(0)
				new_alpha = 0
			if(1)
				new_alpha = 60
			if(2)
				new_alpha = 100
			if(3)
				new_alpha = 150
			else
				new_alpha = 240
		new_color = "#960000"
	animate(src, alpha = new_alpha, color = new_color, transform = rotation_matrix, time = 0.2 SECONDS)

/datum/antagonist/vampire/proc/update_all_trackers()
	SIGNAL_HANDLER
	if(QDELETED(owner.current) || !length(vassals))
		return
	for(var/datum/antagonist/vassal/vassal as anything in vassals)
		var/mob/living/vassal_mob = vassal.owner.current
		if(QDELETED(vassal_mob))
			continue
		vassal.tracking_arrow?.update(vassal_mob, owner.current)
