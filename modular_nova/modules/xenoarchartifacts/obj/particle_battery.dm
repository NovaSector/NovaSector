/obj/item/xenoarch/particles_battery
	name = "Exotic particles power battery"
	icon = 'modular_nova/modules/xenoarchartifacts/icons/machinery.dmi'
	icon_state = "particles_battery0"
	w_class = WEIGHT_CLASS_TINY
	/// Effect we cloned from artifact
	var/datum/artifact_effect/battery_effect
	/// Max battery capacity
	var/capacity = 200
	/// Stored effect charge
	var/stored_charge = 0

/obj/item/xenoarch/particles_battery/Initialize(mapload)
	. = ..()
	battery_effect = new(src)

/obj/item/xenoarch/particles_battery/Destroy(force)
	if(battery_effect)
		QDEL_NULL(battery_effect)
	return ..()

/obj/item/xenoarch/particles_battery/update_icon_state()
	var/power_stored = (stored_charge / capacity) * 100
	power_stored = min(power_stored, 100)
	icon_state = "particles_battery[round(power_stored, 25)]"
	return ..()

#define COOLDOWN_TIME 5

/obj/item/xenoarch/xenoarch_utilizer
	name = "Exotic particles power utilizer"
	icon = 'modular_nova/modules/xenoarchartifacts/icons/machinery.dmi'
	icon_state = "utilizer"
	w_class = WEIGHT_CLASS_TINY
	/// We have to wait COOLDOWN_TIME before activating it again after deactivation
	var/cooldown = 0
	/// Are we blasting alien waves at unsuspecting passers-by
	var/activated = FALSE
	/// Are we blasting in timed mode
	var/timing = FALSE
	/// How much time we keep utilizer activated in timed mode
	var/time = 50
	/// Old time value
	var/archived_time = 50
	/// Inserterd battery
	var/obj/item/xenoarch/particles_battery/inserted_battery
	var/cooldown_to_start = 0

/obj/item/xenoarch/xenoarch_utilizer/Initialize(mapload)
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/item/xenoarch/xenoarch_utilizer/Destroy()
	STOP_PROCESSING(SSobj, src)
	if(inserted_battery)
		qdel(inserted_battery)
	inserted_battery = null
	return ..()

/obj/item/xenoarch/xenoarch_utilizer/attackby(obj/item/attacking_item, mob/user, params)
	if(istype(attacking_item, /obj/item/xenoarch/particles_battery))
		if(!inserted_battery)
			if(user.transferItemToLoc(attacking_item, src))
				user.visible_message(
					span_notice("[user] inserts battery into the utilizer."),
					span_notice("You insert the battery into the utilizer."),
					blind_message = span_notice("You hear click nearby."),
				)
				playsound(src, 'modular_nova/modules/aesthetics/lightswitch/sound/lightswitch.ogg', 25, FALSE)
				inserted_battery = attacking_item
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
		dat += "<b>Timed activation:</b> <A href='byond://?src=[REF(src)];neg_changetime_max=-100'>--</a> <A href='byond://?src=[REF(src)];neg_changetime=-10'>-</a> [time >= 1000 ? "[time/10]" : time >= 100 ? " [time/10]" : "  [time/10]" ] <A href='byond://?src=[REF(src)];changetime=10'>+</a> <A href='byond://?src=[REF(src)];changetime_max=100'>++</a><BR>"
		if(cooldown)
			dat += "<font color=red>Cooldown in progress, please wait.</font><BR>"
			dat += "<br>"
		else if(!activated && world.time >= cooldown_to_start)
			dat += "<A href='byond://?src=[REF(src)];startup=1'>Start</a><BR>"
			dat += "<A href='byond://?src=[REF(src)];startup=1;starttimer=1'>Start in timed mode</a><BR>"
		else
			dat += "<a href='byond://?src=[REF(src)];shutdown=1'>Shutdown emission</a><br>"
			dat += "<br>"
		dat += "<A href='byond://?src=[REF(src)];ejectbattery=1'>Eject battery</a><BR>"
	else
		dat += "Please insert battery<br>"

		dat += "<br>"
		dat += "<br>"
		dat += "<br>"

		dat += "<br>"
		dat += "<br>"
		dat += "<br>"

	dat += "<hr>"
	dat += "<a href='byond://?src=[REF(src)]'>Refresh</a>"

	var/datum/browser/popup = new(user, "utilizer", name, 400, 500)
	popup.set_content(dat)
	popup.open()
	if(usr)
		interact(usr)

/obj/item/xenoarch/xenoarch_utilizer/Moved(atom/old_loc, movement_dir, forced, list/old_locs, momentum_change)
	. = ..()
	var/turf/current_turf = get_turf(src)
	if(current_turf != old_loc && inserted_battery && inserted_battery.battery_effect)
		inserted_battery.battery_effect.update_move()
	if(activated && inserted_battery && inserted_battery.battery_effect)
		if(!istype(inserted_battery.battery_effect, /datum/artifact_effect/light))
			set_light(2, 1, "#8f66f4")
		else
			set_light(inserted_battery.light_range, inserted_battery.light_power, "#ffffff") // Have to do it, since the light comes from battery
	else
		set_light(0, 0)

/obj/item/xenoarch/xenoarch_utilizer/process(seconds_per_tick, times_fired)
	update_icon()
	if(cooldown > 0)
		cooldown -= 0.5 * seconds_per_tick
		if(cooldown <= 0)
			cooldown = 0
			visible_message(
				span_notice("[src] chimes."),
				blind_message = span_notice("You hear something chime."),
			)
	else if(activated && inserted_battery.battery_effect)
		// make sure the effect is active
		if(!inserted_battery.battery_effect.activated)
			inserted_battery.battery_effect.ToggleActivate(TRUE)

		// process the effect
		inserted_battery.battery_effect.process()
		// if someone is holding the device, do the effect on them
		if(inserted_battery.battery_effect.release_method == ARTIFACT_EFFECT_TOUCH && ismob(src.loc))
			inserted_battery.battery_effect.do_effect_touch(src.loc)

		// handle charge
		inserted_battery.stored_charge -= 0.5 * seconds_per_tick
		if(inserted_battery.stored_charge <= 0)
			shutdown_emission()

		// handle timed mode
		if(timing)
			time -= 0.5 * seconds_per_tick
			if(time <= 0)
				shutdown_emission()

/**
 * Stops emission
 */
/obj/item/xenoarch/xenoarch_utilizer/proc/shutdown_emission()
	if(activated)
		activated = FALSE
		timing = FALSE
		visible_message(
				span_notice("[src] buzzes."),
				blind_message = span_notice("You hear something buzz."),
		)
		cooldown = COOLDOWN_TIME
	if(inserted_battery.battery_effect)
		inserted_battery.battery_effect.turn_effect_off()
	if(usr)
		interact(usr)

/obj/item/xenoarch/xenoarch_utilizer/Topic(href, href_list)
	if(!usr)
		return
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
		if(inserted_battery.battery_effect && inserted_battery.stored_charge > 0)
			playsound(src, 'sound/machines/click.ogg', 25, FALSE)
			activated = TRUE
			timing = FALSE
			cooldown_to_start = world.time + 10 // so we cant abuse the startup button
			update_icon()
			message_admins("anomaly battery [inserted_battery.battery_effect.artifact_id]([inserted_battery.battery_effect]) emission started by [key_name(usr)]")
			if (!inserted_battery.battery_effect.activated)
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
			var/mob/living/carbon/human/human_user = usr
			if(!human_user.get_active_hand())
				human_user.put_in_hands(inserted_battery)
		if(inserted_battery.battery_effect)
			inserted_battery.battery_effect.turn_effect_off()
			inserted_battery.set_light(0,0) // In case of light effect, since it does not auto update in utilizer
		inserted_battery = null
		update_icon()
	interact(usr)
	..()
	update_icon()

/obj/item/xenoarch/xenoarch_utilizer/update_icon_state()
	. = ..()
	if(!inserted_battery)
		icon_state = "utilizer"
		return
	var/is_emitting = "_off"
	if(activated && inserted_battery && inserted_battery.battery_effect)
		is_emitting = "_on"
		if(!istype(inserted_battery.battery_effect, /datum/artifact_effect/light)) // Let light effect
			set_light(2, 1, "#8f66f4")
		else
			set_light(inserted_battery.light_range, inserted_battery.light_power, "#ffffff") // Have to do it, since the battery is
	else
		set_light(0)
	var/power_battery = (inserted_battery.stored_charge / inserted_battery.capacity) * 100
	power_battery = min(power_battery, 100)
	icon_state = "utilizer[round(power_battery, 25)][is_emitting]"

/obj/item/xenoarch/xenoarch_utilizer/attack(mob/living/target_mob, mob/living/user, def_zone)
	if (!istype(target_mob))
		return

	if(!isnull(inserted_battery) && activated && inserted_battery.battery_effect && inserted_battery.battery_effect.release_method == ARTIFACT_EFFECT_TOUCH )
		inserted_battery.battery_effect.do_effect_touch(target_mob)
		inserted_battery.stored_charge -= min(inserted_battery.stored_charge, 20) // we are spending quite a big amount of energy doing this
		user.visible_message(
			span_notice("[user] taps [target_mob] with [src], and it shudders on contact."),
			span_notice("You tap [target_mob] with [src], and it shudders on contact."),
			blind_message = span_hear("You hear silent zapping sounds."),
		)
	else
		user.visible_message(
			span_notice("[user] taps [target_mob] with [src], but nothing happens."),
			span_notice("You tap [target_mob] with [src], but nothing happens."),
		)

	if(inserted_battery.battery_effect)
		log_combat(user, target_mob, "tapped", src, "(EFFECT: [inserted_battery.battery_effect.log_name]) ")

#undef COOLDOWN_TIME
