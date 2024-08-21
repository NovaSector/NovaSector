/obj/item/xenoarch/particles_battery
	name = "Exotic particles power battery"
	icon = 'modular_nova/modules/xenoarchartifacts/icons/machinery.dmi'
	icon_state = "particles_battery0"
	w_class = WEIGHT_CLASS_TINY
	var/datum/artifact_effect/battery_effect
	var/capacity = 200
	var/stored_charge = 0
	var/effect_id = ""

/obj/item/xenoarch/particles_battery/New()
	. = ..()
	battery_effect = new()


/obj/item/xenoarch/particles_battery/update_icon()
	..()
	var/power_stored = (stored_charge / capacity) * 100
	power_stored = min(power_stored, 100)
	icon_state = "particles_battery[round(power_stored, 25)]"

#define COOLDOWN_TIME 5

/obj/item/xenoarch/xenoarch_utilizer
	name = "Exotic particles power utilizer"
	icon = 'modular_nova/modules/xenoarchartifacts/icons/machinery.dmi'
	icon_state = "utilizer"
	w_class = WEIGHT_CLASS_TINY
	var/cooldown = 0
	var/activated = FALSE
	var/timing = FALSE
	var/time = 50
	var/archived_time = 50
	var/obj/item/xenoarch/particles_battery/inserted_battery
	var/turf/archived_loc
	var/cooldown_to_start = 0

/obj/item/xenoarch/xenoarch_utilizer/New()
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/item/xenoarch/xenoarch_utilizer/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/xenoarch/particles_battery))
		if(!inserted_battery)
			if(user.transferItemToLoc(I, src))
				user.visible_message(
					span_notice("[user] inserts battery into the utilizer."),
					span_notice("You insert the battery into the utilizer."),
					blind_message = span_notice("You hear click nearby."),
				)
				playsound(src, 'modular_nova/modules/aesthetics/lightswitch/sound/lightswitch.ogg', 25, FALSE)
				inserted_battery = I
				update_icon()
	else
		return ..()

/obj/item/xenoarch/xenoarch_utilizer/attack_self(mob/user)
	if(Adjacent(user))
		return interact(user)

/obj/item/xenoarch/xenoarch_utilizer/interact(mob/user)

	var/dat = "<b>Exotic Particles Energy Utilizer</b><br>"
	if(inserted_battery)
		if(activated)
			dat += "Device active"
			if(timing)
				dat += " in timed mode.<br>"
			else
				dat += ".<br>"
		else
			dat += "Device is inactive.<br>"

		dat += "<b>Total Power:</b> [round(inserted_battery.stored_charge, 1)]/[inserted_battery.capacity]<BR><BR>"
		dat += "<b>Timed activation:</b> <A href='?src=[REF(src)];neg_changetime_max=-100'>--</a> <A href='?src=[REF(src)];neg_changetime=-10'>-</a> [time >= 1000 ? "[time/10]" : time >= 100 ? " [time/10]" : "  [time/10]" ] <A href='?src=[REF(src)];changetime=10'>+</a> <A href='?src=[REF(src)];changetime_max=100'>++</a><BR>"
		if(cooldown)
			dat += "<font color=red>Cooldown in progress, please wait.</font><BR>"
			dat += "<br>"
		else if(!activated && world.time >= cooldown_to_start)
			dat += "<A href='?src=[REF(src)];startup=1'>Start</a><BR>"
			dat += "<A href='?src=[REF(src)];startup=1;starttimer=1'>Start in timed mode</a><BR>"
		else
			dat += "<a href='?src=[REF(src)];shutdown=1'>Shutdown emission</a><br>"
			dat += "<br>"
		dat += "<A href='?src=[REF(src)];ejectbattery=1'>Eject battery</a><BR>"
	else
		dat += "Please insert battery<br>"

		dat += "<br>"
		dat += "<br>"
		dat += "<br>"

		dat += "<br>"
		dat += "<br>"
		dat += "<br>"

	dat += "<hr>"
	dat += "<a href='?src=[REF(src)]'>Refresh</a>"

	var/datum/browser/popup = new(user, "utilizer", name, 400, 500)
	popup.set_content(dat)
	popup.open()
	interact(usr)

/obj/item/xenoarch/xenoarch_utilizer/process()
	update_icon()
	if(cooldown > 0)
		cooldown -= 1
		if(cooldown <= 0)
			cooldown = 0
			visible_message(
				span_notice("[src] chimes."),
				blind_message = span_notice("You hear something chime."),
			)
	else if(activated && inserted_battery?.battery_effect)
		// make sure the effect is active
		if(!inserted_battery.battery_effect.activated)
			inserted_battery.battery_effect.ToggleActivate(TRUE)

		// update the effect loc
		var/turf/T = get_turf(src)
		if(T != archived_loc)
			archived_loc = T
			inserted_battery.battery_effect.update_move()

		// process the effect
		inserted_battery.battery_effect.process()
		// if someone is holding the device, do the effect on them
		if(inserted_battery.battery_effect.release_method == ARTIFACT_EFFECT_TOUCH && ismob(src.loc))
			inserted_battery.battery_effect.do_effect_touch(src.loc)

		// handle charge
		inserted_battery.stored_charge -= 1
		if(inserted_battery.stored_charge <= 0)
			shutdown_emission()

		// handle timed mode
		if(timing)
			time -= 1
			if(time <= 0)
				shutdown_emission()

/obj/item/xenoarch/xenoarch_utilizer/proc/shutdown_emission()
	if(activated)
		activated = FALSE
		timing = FALSE
		visible_message(
				span_notice("[src] buzzes."),
				blind_message = span_notice("You hear something buzz."),
		)
		cooldown = COOLDOWN_TIME

	inserted_battery.battery_effect.turn_effect_off()
	interact(usr)

/obj/item/xenoarch/xenoarch_utilizer/Topic(href, href_list)

	if((get_dist(src, usr) > 1))
		return
	if(href_list["neg_changetime_max"])
		playsound(src, 'sound/machines/click.ogg', 25, FALSE)
		time += -100
		if(time > inserted_battery.capacity)
			time = inserted_battery.capacity
		else if (time < 0)
			time = 0
	if(href_list["neg_changetime"])
		playsound(src, 'sound/machines/click.ogg', 25, FALSE)
		time += -10
		if(time > inserted_battery.capacity)
			time = inserted_battery.capacity
		else if (time < 0)
			time = 0
	if(href_list["changetime"])
		playsound(src, 'sound/machines/click.ogg', 25, FALSE)
		time += 10
		if(time > inserted_battery.capacity)
			time = inserted_battery.capacity
		else if (time < 0)
			time = 0
	if(href_list["changetime_max"])
		playsound(src, 'sound/machines/click.ogg', 25, FALSE)
		time += 100
		if(time > inserted_battery.capacity)
			time = inserted_battery.capacity
		else if (time < 0)
			time = 0
	if(href_list["startup"])
		playsound(src, 'sound/machines/click.ogg', 25, FALSE)
		activated = TRUE
		timing = FALSE
		cooldown_to_start = world.time + 10 // so we cant abuse the startup button
		update_icon()
		if(!inserted_battery.battery_effect.activated)
			message_admins("anomaly battery [inserted_battery.battery_effect.artifact_id]([inserted_battery.battery_effect]) emission started by [key_name(usr)]")
			inserted_battery.battery_effect.ToggleActivate(TRUE)
	if(href_list["shutdown"])
		playsound(src, 'sound/machines/click.ogg', 25, FALSE)
		shutdown_emission()
	if(href_list["starttimer"])
		timing = TRUE
		archived_time = time
	if(href_list["ejectbattery"])
		playsound(src, 'sound/machines/click.ogg', 25, FALSE)
		shutdown_emission()
		inserted_battery.update_icon()
		inserted_battery.forceMove(get_turf(src))
		if(ishuman(usr))
			var/mob/living/carbon/human/H = usr
			if(!H.get_active_hand())
				H.put_in_hands(inserted_battery)
		inserted_battery.battery_effect.turn_effect_off()
		inserted_battery = null
		update_icon()
	interact(usr)
	..()
	update_icon()

/obj/item/xenoarch/xenoarch_utilizer/update_icon()
	..()
	if(!inserted_battery)
		icon_state = "utilizer"
		return
	var/is_emitting = "_off"
	if(activated && inserted_battery && inserted_battery.battery_effect)
		is_emitting = "_on"
		set_light(2, 1, "#8f66f4")
	else
		set_light(0)
	var/power_battery = (inserted_battery.stored_charge / inserted_battery.capacity) * 100
	power_battery = min(power_battery, 100)
	icon_state = "utilizer[round(power_battery, 25)][is_emitting]"

/obj/item/xenoarch/xenoarch_utilizer/Destroy()
	if(inserted_battery)
		qdel(inserted_battery)
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/xenoarch/xenoarch_utilizer/attack(mob/living/M, mob/living/user, def_zone)
	if (!istype(M))
		return

	if(!isnull(inserted_battery) && activated && inserted_battery.battery_effect && inserted_battery.battery_effect.release_method == ARTIFACT_EFFECT_TOUCH )
		inserted_battery.battery_effect.do_effect_touch(M)
		inserted_battery.stored_charge -= min(inserted_battery.stored_charge, 20) // we are spending quite a big amount of energy doing this
		user.visible_message(
			span_notice("[user] taps [M] with [src], and it shudders on contact."),
			span_notice("You tap [M] with [src], and it shudders on contact."),
			blind_message = span_hear("You hear silent zapping sounds."),
		)
	else
		user.visible_message(
			span_notice("[user] taps [M] with [src], but nothing happens."),
			span_notice("You tap [M] with [src], but nothing happens."),
		)

	if(inserted_battery.battery_effect)
		log_combat(user, M, "tapped", src, "(EFFECT: [inserted_battery.battery_effect.log_name]) ")

#undef COOLDOWN_TIME
