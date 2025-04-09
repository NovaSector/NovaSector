/obj/machinery/replicator
	name = "alien machine"
	desc = "It's some kind of pod with strange wires and gadgets all over it."
	icon = 'modular_nova/modules/xenoarchartifacts/icons/artifacts.dmi'
	icon_state = "replicator"
	density = TRUE
	anchored = FALSE

	idle_power_usage = 100
	active_power_usage = 1000
	use_power = IDLE_POWER_USE

	var/spawn_progress_time = 0
	var/max_spawn_time = 50
	var/last_process_time = 0

	var/list/construction = list()
	var/list/spawning_types = list()
	var/list/stored_materials = list()

	var/fail_message

/obj/machinery/replicator/Initialize(mapload)
	. = ..()

	var/list/viables = list(
		/obj/effect/spawner/random/animalhide,
		/obj/effect/spawner/random/bedsheet/any,
		/obj/effect/spawner/random/bureaucracy/pen,
		/obj/effect/spawner/random/bureaucracy/stamp,
		/obj/effect/spawner/random/bureaucracy/crayon,
		/obj/effect/spawner/random/bureaucracy/paper,
		/obj/effect/spawner/random/bureaucracy/briefcase,
		/obj/effect/spawner/random/bureaucracy/folder,
		/obj/effect/spawner/random/bureaucracy/birthday_wrap,
		/obj/effect/spawner/random/clothing/funny_hats,
		/obj/effect/spawner/random/clothing/backpack,
		/obj/effect/spawner/random/contraband,
		/obj/effect/spawner/random/contraband/plus,
		/obj/effect/spawner/random/contraband/permabrig_weapon,
		/obj/effect/spawner/random/contraband/permabrig_gear,
		/obj/effect/spawner/random/engineering/tool,
		/obj/effect/spawner/random/engineering/tool_advanced,
		/obj/effect/spawner/random/engineering/tool_alien,
		/obj/effect/spawner/random/engineering/material_rare,
		/obj/effect/spawner/random/entertainment/musical_instrument,
		/obj/effect/spawner/random/entertainment/coin,
		/obj/effect/spawner/random/exotic/languagebook,
		/obj/effect/spawner/random/exotic/technology,
		/obj/effect/spawner/random/exotic/antag_gear_weak,
		/obj/effect/spawner/random/food_or_drink/any_snack_or_beverage,
		/obj/effect/spawner/random/maintenance,
		/obj/effect/spawner/random/medical/minor_healing,
		/obj/effect/spawner/random/medical/injector,
		/obj/effect/spawner/random/medical/organs,
		/obj/effect/spawner/random/medical/memeorgans,
		/obj/effect/spawner/random/medical/surgery_tool,
		/obj/effect/spawner/random/medical/surgery_tool_advanced,
		/obj/effect/spawner/random/medical/supplies,
		/obj/effect/spawner/random/mod/maint,
		/obj/effect/spawner/random/sakhno/ammo,
		/obj/effect/spawner/random/techstorage/data_disk,
		/obj/effect/spawner/random/techstorage/arcade_boards,
		/obj/effect/spawner/random/techstorage/service_all,
		/obj/effect/spawner/random/techstorage/rnd_all,
		/obj/effect/spawner/random/techstorage/tcomms_all,
		/obj/effect/spawner/random/trash/garbage,
		/obj/effect/spawner/random/trash/deluxe_garbage,
		/obj/effect/spawner/random/contraband/grenades,
		/obj/effect/spawner/random/contraband/grenades/dangerous, // Now we are talking
		/obj/effect/spawner/random/contraband/armory,
	)

	var/quantity = rand(3,8)
	for (var/i in 1 to quantity)
		var/button_desc = "a [pick("yellow", "purple", "green", "blue", "red", "orange", "white", "black", "lime", "pink", "gray", "bloody")], "
		button_desc += "[pick("round", "square", "diamond", "heart", "dog", "human", "cat", "lizard", "skull", "syringe", "disk", "pen", "circuitboard")]-shaped "
		button_desc += "[pick("toggle", "switch", "lever", "button", "pad", "hole")]"
		construction[button_desc] = pick_n_take(viables)

	fail_message = span_notice("a [pick("loud", "soft", "sinister", "eery", "triumphant", "depressing", "cheerful", "angry")] \
		[pick("horn", "beep", "bing", "bleep", "blat", "honk", "hrumph", "ding")] sounds and a \
		[pick("yellow", "purple", "green", "blue", "red", "golden", "white")] \
		[pick("light", "dial", "meter", "window", "protrusion", "knob", "antenna", "swirly thing")] \
		[pick("swirls", "flashes", "whirrs", "goes schwing", "blinks", "flickers", "strobes", "lights up")] on the \
		[pick("front", "side", "top", "bottom", "rear", "inside")] of [src]. A [pick("slot", "funnel", "chute", "tube")] opens up in the \
		[pick("front", "side", "top", "bottom", "rear", "inside")].")

/obj/machinery/replicator/process(seconds_per_tick, times_fired)
	if(spawning_types.len && powered())
		spawn_progress_time += world.time - last_process_time
		if(spawn_progress_time > max_spawn_time)
			visible_message(
				span_warning("[src] pings!"),
				blind_message = span_hear("You hear a ping!"),
			)

			var/obj/source_material = pop(stored_materials)
			var/spawn_type = pop(spawning_types)
			var/obj/spawned_obj = new spawn_type(get_turf(src))
			if(source_material)
				if(length_char(source_material.name) < MAX_MESSAGE_LEN)
					spawned_obj.name = "[source_material] " +  spawned_obj.name
				if(length_char(source_material.desc) < MAX_MESSAGE_LEN * 2)
					if(spawned_obj.desc)
						spawned_obj.desc += "It is made of [source_material]."
					else
						spawned_obj.desc = "It is made of [source_material]."
				source_material.loc = null

			spawn_progress_time = 0
			max_spawn_time = rand(30,50)

			if(!spawning_types.len || !stored_materials.len)
				update_use_power(IDLE_POWER_USE)
				icon_state = "replicator"

		else if(SPT_PROB(2.5, seconds_per_tick))
			var/sound_made = pick("clicks", "whizzes", "whirrs", "whooshes", "clanks", "clongs", "clonks", "bangs")
			visible_message(
				span_warning("[src] [sound_made]"),
				blind_message = span_hear("Something [sound_made]!"),
			)

	last_process_time = world.time

/obj/machinery/replicator/ui_interact(mob/user)
	var/dat = "The control panel displays an incomprehensible selection of controls, many with unusual markings or text around them.<br>"
	dat += "<br>"
	for(var/index=1, index<=construction.len, index++)
		dat += "<A href='byond://?src=[REF(src)];activate=[index]'>\[[construction[index]]\]</a><br>"

	var/datum/browser/popup = new(user, "alien_replicator")
	popup.set_content(dat)
	popup.open()

/obj/machinery/replicator/attackby(obj/item/to_insert, mob/living/user)
	if(to_insert.item_flags & (ABSTRACT | DROPDEL))
		user.visible_message(
			span_notice("[user] tries to insert [to_insert] into [src], but the opening is too small."),
			span_notice("[to_insert] doesn't fit into [src]."),
		)
		return
	if(!user.transferItemToLoc(to_insert, src))
		to_chat(user, span_warning("\The [to_insert] is stuck to your hand, you cannot put it in the machine!"))
		return TRUE
	stored_materials.Add(to_insert)
	visible_message(
		span_notice("[user] inserts [to_insert] into [src]."),
		span_notice("You insert [to_insert] into [src]."),
	)

/obj/machinery/replicator/Topic(href, href_list)
	. = ..()
	if(.)
		return
	if(href_list["activate"])
		var/index = text2num(href_list["activate"])
		if(index > 0 && index <= construction.len)
			if(stored_materials.len > spawning_types.len)
				if(spawning_types.len)
					visible_message(span_notice("A [pick("light", "dial", "display", "meter", "pad")] on [src]'s front [pick("blinks", "flashes")] [pick("red", "yellow", "blue", "orange", "purple", "green", "white")]."))
				else
					visible_message(
						span_notice("[src]'s front compartment slides shut."),
						blind_message = span_hear("You hear metal shuffling."),
					)

				spawning_types.Add(construction[construction[index]])
				spawn_progress_time = 0
				update_use_power(ACTIVE_POWER_USE)
				icon_state = "replicator_active"
			else
				visible_message(fail_message)
	if(usr)
		ui_interact(usr)
