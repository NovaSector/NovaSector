//antag job
/datum/job/lone_infiltrator
	title = ROLE_LONE_INFILTRATOR

//antag
/datum/antagonist/traitor/lone_infiltrator
	name = "Lone Infiltrator"
	job_rank = ROLE_LONE_INFILTRATOR
	roundend_category = "Infiltrators"
	preview_outfit = /datum/outfit/lone_infiltrator_preview
	give_uplink = FALSE
	///The turf inside the lazy_template marked as this antag's spawn
	var/turf/spawnpoint

/datum/antagonist/traitor/lone_infiltrator/on_gain()
	equip_guy()
	move_to_spawnpoint()
	return ..()

/datum/antagonist/traitor/lone_infiltrator/proc/equip_guy()
	var/mob/living/carbon/human/lone_infil = owner.current
	lone_infil.equipOutfit(/datum/outfit/lone_infiltrator)
	return

/datum/antagonist/traitor/lone_infiltrator/proc/set_spawnpoint(infil_number)
	spawnpoint = GLOB.lone_infil_start[infil_number]

/datum/antagonist/traitor/lone_infiltrator/proc/move_to_spawnpoint()
	owner.current.forceMove(spawnpoint)


/obj/item/infil_shuttle_sender
	name = "Shuttle Remote"
	desc = ""
	icon = 'icons/obj/devices/voice.dmi'
	icon_state = "nukietalkie"
	w_class = WEIGHT_CLASS_SMALL
	///var which will hold the navi computer
	var/obj/machinery/computer/shuttle/lone_infil/our_computer
	///var which will hold the mobile port
	var/obj/docking_port/mobile/our_port
	///has it been sent off?
	var/sent_off = FALSE

/obj/item/infil_shuttle_sender/Initialize(mapload)
	. = ..()
	if(!mapload)
		log_mapping("[src] spawned outside of mapload!")
		return
	var/obj/machinery/computer/shuttle/lone_infil/computer = locate(/obj/machinery/computer/shuttle/lone_infil) in loc
	if(!computer)
		log_mapping("[src] failed to find a navigation computer at [AREACOORD(src)]")
		return
	our_computer = computer
	our_computer.remote_control = WEAKREF(src)

/obj/item/infil_shuttle_sender/attack_self(mob/user)
	if(!our_computer)
		balloon_alert(user, "no nav computer!")
		return
	if(!our_port)
		our_port = SSshuttle.getShuttle(our_computer.shuttleId)
	if(our_computer.locked)
		balloon_alert(user, "nav computer locked!")
		return
	if(our_port.mode != SHUTTLE_IDLE)
		balloon_alert(user, "engines cooling!")
		return
	if(!sent_off)
		switch(tgui_alert(user, "Are you sure you want to send off your shuttle into deep space?", "Send Off Shuttle?", list("Yes", "No")))
			if("Yes")
				sent_off = TRUE
				send_off_shuttle(user)
	else
		switch(tgui_alert(user, "Are you sure you want to call your shuttle to station arrivals?", "Call Shuttle?", list("Yes", "No")))
			if("Yes")
				sent_off = FALSE
				call_shuttle(user)

/obj/item/infil_shuttle_sender/proc/send_off_shuttle(mob/user)
	our_computer.send_shuttle("lone_infil_home", user)
	our_computer.destination = "lone_infil_home"

/obj/item/infil_shuttle_sender/proc/call_shuttle(mob/user)
	our_computer.send_shuttle("whiteship_home", user)
	our_computer.destination = "whiteship_home"
