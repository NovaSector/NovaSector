// Core balance principles with these roundstart augments is that they are SLOW. 2 toolspeed minimum where possible - finding actual things in round should always be better, this is for flavor and accessibility. The accessibility alone already provides these with a lot of value.

// EYE IMPLANTS

/obj/item/organ/eyes/robotic/binoculars
	name = "digital magnification optics"
	desc = "Commonly used on frontier worlds with comparatively vast overland distances to aid in visual acquisition of coworkers and targets."
	actions_types = list(/datum/action/item_action/organ_action/toggle)
	var/zoomed = FALSE
	var/range_power = 2 // what kind of range modifier do we feed to the scope component?

/obj/item/organ/eyes/robotic/binoculars/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/scope, range_modifier = range_power)

/obj/item/organ/eyes/robotic/binoculars/ui_action_click(mob/user, actiontype)
	if (istype(actiontype, /datum/action/item_action/organ_action/toggle))
		toggle_active(user)

/obj/item/organ/eyes/robotic/binoculars/proc/toggle_active(mob/user)
	//this is so unbelievably, hysterically jank. i actually cannot believe this works. what the fuck
	var/datum/component/scope/zoom = src.GetComponent(/datum/component/scope)
	if (zoomed)
		zoom.stop_zooming(user)
		zoomed = FALSE
	else
		//check if they're blind
		if (user.is_blind())
			user.balloon_alert(user, "can't activate magnification while blind!")
			return

		zoom.zoom(user)
		zoomed = TRUE

/obj/item/organ/eyes/robotic/binoculars/emp_act(severity)
	. = ..()
	if((. & EMP_PROTECT_SELF) || !owner)
		return
	var/do_nothing_chance = 100
	switch(severity)
		if(EMP_LIGHT)
			do_nothing_chance = 20
		if(EMP_HEAVY)
			do_nothing_chance = 10
	if(prob(do_nothing_chance))
		return
	to_chat(owner, span_warning("Your vision magnification glitches erratically!"))
	// Apply static vision overlay
	owner.overlay_fullscreen("emp_static", /atom/movable/screen/fullscreen/flash/static)
	addtimer(CALLBACK(owner, TYPE_PROC_REF(/mob, clear_fullscreen), "emp_static"), severity == EMP_LIGHT ? 0.75 SECONDS : 1.5 SECONDS)
	owner.set_eye_blur_if_lower(severity == EMP_LIGHT ? 1.5 SECONDS : 3 SECONDS)

// ARM IMPLANTS
/obj/item/organ/cyberimp/arm/toolkit/adjuster
	name = "adjuster arm implant"
	desc = "A miniaturized toolset implant containing a simple fingertip-mounted universal screwdriver bit with an inverted torque-wrench head. Most commonly used when rearranging furniture or other station machinery."
	items_to_create = list(/obj/item/wrench/integrated, /obj/item/screwdriver/integrated)

/obj/item/organ/cyberimp/arm/toolkit/adjuster/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF || !IS_ROBOTIC_ORGAN(src))
		return
	var/effect_chance = 0
	switch(severity)
		if(EMP_LIGHT)
			effect_chance = 15
		if(EMP_HEAVY)
			effect_chance = 30
	if(prob(effect_chance) && owner)
		owner.visible_message(
			span_danger("[owner]'s [active_item] suddenly spins and vibrates wildly!"),
			span_warning("Your adjuster implant malfunctions, making your arm shake uncontrollably!")
		)
		if(active_item)
			Retract()
		owner.set_jitter_if_lower(severity == EMP_LIGHT ? 5 SECONDS : 10 SECONDS)
		do_sparks(2, TRUE, owner)
		playsound(owner, 'sound/items/tools/change_drill.ogg', 40, TRUE)

/obj/item/organ/cyberimp/arm/toolkit/adjuster/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_NAKAMURA)

/obj/item/organ/cyberimp/arm/toolkit/electrical_toolset
	name = "electrical toolset implant"
	desc = "Bereft of any kind of insulation to speak of, this aug has a very distinct nickname amongst frontier outpost crews: 'the sizzler'. Often used in high verticality environments where loadout space is at a premium."
	items_to_create = list(/obj/item/screwdriver/integrated, /obj/item/multitool/integrated, /obj/item/wirecutters/integrated)

/obj/item/organ/cyberimp/arm/toolkit/electrical_toolset/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF || !IS_ROBOTIC_ORGAN(src))
		return
	var/effect_chance = 0
	switch(severity)
		if(EMP_LIGHT)
			effect_chance = 25
		if(EMP_HEAVY)
			effect_chance = 50
	if(prob(effect_chance) && owner)
		owner.visible_message(
			span_danger("[owner]'s electrical toolset crackles with arcing electricity!"),
			span_warning("Your electrical toolset sparks wildly, making your arm tingle!")
		)
		if(active_item)
			Retract()
		owner.adjust_stutter(severity == EMP_LIGHT ? 5 SECONDS : 10 SECONDS)
		owner.set_jitter_if_lower(severity == EMP_LIGHT ? 7.5 SECONDS : 15 SECONDS)
		do_sparks(5, TRUE, owner)

/obj/item/organ/cyberimp/arm/toolkit/electrical_toolset/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_NAKAMURA)

/obj/item/organ/cyberimp/arm/toolkit/arc_welder
	name = "shipbreaker's toolset implant"
	desc = "A specialized salvage-grade implant that houses an arc welder, miniaturized crowbar within the bearer's arm, plus a fingertip torque-wrench rated for enough newtons to get the job done. Renowned across the frontier for being the 'trashy tattoo' equivalent of someone's first aug."
	items_to_create = list(/obj/item/wrench/integrated, /obj/item/crowbar/integrated, /obj/item/weldingtool/electric/arc_welder/integrated)

/obj/item/organ/cyberimp/arm/toolkit/arc_welder/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF || !IS_ROBOTIC_ORGAN(src))
		return
	var/effect_chance = 0
	switch(severity)
		if(EMP_LIGHT)
			effect_chance = 20
		if(EMP_HEAVY)
			effect_chance = 40
	if(prob(effect_chance) && owner)
		owner.visible_message(
			span_danger("[owner]'s arc welder discharges with a shower of sparks!"),
			span_warning("Your arc welder implant short circuits, temporarily blinding you!")
		)
		if(active_item)
			Retract()
		owner.flash_act(1, 1)
		owner.set_eye_blur_if_lower(severity == EMP_LIGHT ? 5 SECONDS : 10 SECONDS)
		do_sparks(5, TRUE, owner)
		playsound(owner, 'sound/items/tools/welder.ogg', 50, TRUE)

/obj/item/organ/cyberimp/arm/toolkit/arc_welder/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_FRONTIER)

/obj/item/organ/cyberimp/arm/toolkit/emt_triage
	name = "triage actuator implant"
	desc = "Pioneered by Interdyne Pharmaceuticals for use in their frontier postings, this set of in-arm augments allows medical staff to perform basic life-saving surgeries out on the field with the assistance of a bladed instrument."
	items_to_create = list(/obj/item/surgical_drapes/integrated, /obj/item/retractor/integrated, /obj/item/hemostat/integrated)

/obj/item/organ/cyberimp/arm/toolkit/emt_triage/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF || !IS_ROBOTIC_ORGAN(src))
		return
	var/effect_chance = 0
	switch(severity)
		if(EMP_LIGHT)
			effect_chance = 12.5
		if(EMP_HEAVY)
			effect_chance = 25
	if(prob(effect_chance) && owner)
		owner.visible_message(
			span_danger("[owner]'s triage implant's actuators twitch erratically!"),
			span_warning("Your triage implant malfunctions, making your hand shake!")
		)
		if(active_item)
			Retract()
		owner.set_jitter_if_lower(severity == EMP_LIGHT ? 7.5 SECONDS : 15 SECONDS)
		do_sparks(2, TRUE, owner)

/obj/item/organ/cyberimp/arm/toolkit/emt_triage/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_INTERDYNE)

/obj/item/organ/cyberimp/arm/toolkit/civilian_barstaff
	name = "waitstaff implant"
	desc = "The galactic service industry demands only the finest from its (underpaid) employees, leading to the development of this sordid piece of technology which substitutes a user's organic arm for a food storage space and an integrated chamois cleaning cloth. Why?"
	items_to_create = list(/obj/item/storage/bag/tray/integrated, /obj/item/rag/integrated)

/obj/item/organ/cyberimp/arm/toolkit/civilian_barstaff/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF || !IS_ROBOTIC_ORGAN(src))
		return
	var/effect_chance = 0
	switch(severity)
		if(EMP_LIGHT)
			effect_chance = 17.5
		if(EMP_HEAVY)
			effect_chance = 35
	if(prob(effect_chance) && owner)
		// Find the tray in our items and spill its contents
		for(var/datum/weakref/item_ref in items_list)
			var/obj/item/storage/bag/tray/tray = item_ref.resolve()
			if(!istype(tray))
				continue
			var/spilled_items = FALSE
			for(var/obj/item/stored_item in tray.contents)
				stored_item.forceMove(get_turf(owner))
				var/throw_target = get_edge_target_turf(owner, pick(GLOB.cardinals))
				stored_item.throw_at(throw_target, rand(1, 2), rand(1, 2))
				spilled_items = TRUE
			if(spilled_items)
				owner.visible_message(
					span_danger("[owner]'s serving tray violently ejects its contents!"),
					span_warning("Your serving tray implant malfunctions, spilling everything!")
				)
				do_sparks(2, TRUE, owner)
				playsound(owner, 'sound/items/trayhit/trayhit1.ogg', 50, TRUE)
			break

/obj/item/organ/cyberimp/arm/toolkit/civilian_lighter
	name = "thumbtip lighter implant"
	desc = "This extraordinarily useless implant was a product of market demand, and it exists because the galactic diaspora apparently craves the ability to light things with their thumbtips."
	items_to_create = list(/obj/item/lighter/integrated)

/obj/item/organ/cyberimp/arm/toolkit/civilian_lighter/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF || !IS_ROBOTIC_ORGAN(src))
		return
	var/effect_chance = 0
	switch(severity)
		if(EMP_LIGHT)
			effect_chance = 15
		if(EMP_HEAVY)
			effect_chance = 30
	if(prob(effect_chance) && owner)
		owner.visible_message(
			span_danger("[owner]'s thumbtip lighter sparks repeatedly!"),
			span_warning("Your thumbtip lighter malfunctions, sparking uncontrollably!")
		)
		do_sparks(3, TRUE, owner)
		owner.adjust_fire_stacks(1)
		playsound(owner, 'sound/items/lighter/lighter_on.ogg', 50, TRUE)

/obj/item/organ/cyberimp/arm/toolkit/blacksteel_forging
	name = "Blacksteel 'Starforge' metalworking toolset implant"
	desc = "A galactic favorite amongst burgeoning starfarer races with a fascination for basic metallurgy or mundane weaponry, this unlikely toolset augmentation is one of the Foundation's most popular products."
	items_to_create = list(/obj/item/forging/hammer/integrated, /obj/item/forging/tongs/integrated, /obj/item/forging/billow/integrated)

/obj/item/organ/cyberimp/arm/toolkit/blacksteel_forging/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF || !IS_ROBOTIC_ORGAN(src))
		return
	var/effect_chance = 0
	switch(severity)
		if(EMP_LIGHT)
			effect_chance = 17.5
		if(EMP_HEAVY)
			effect_chance = 35
	if(prob(effect_chance) && owner)
		owner.visible_message(
			span_danger("[owner]'s forging implant hisses and steams!"),
			span_warning("Your forging implant overheats uncomfortably!")
		)
		if(active_item)
			Retract()
		owner.adjust_bodytemperature(severity == EMP_LIGHT ? 10 * BODYTEMP_NORMAL : 5 * BODYTEMP_NORMAL)
		do_sparks(3, TRUE, owner)
		playsound(owner, 'sound/items/tools/welder.ogg', 40, TRUE)

/obj/item/organ/cyberimp/arm/toolkit/blacksteel_forging/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_BLACKSTEEL)

/obj/item/organ/cyberimp/arm/toolkit/bureaucracy
	name = "bureaucrat's 'Jacent' toolset implant"
	desc = "Popular amongst coreworld corporates, this integrated toolset includes a wrist-sheathed four-colour pen, a special motorized sheaf hollow for holding up to ten pieces of galactic-standard A4 paper and a set of two fingertip stamps for approving and denying things. Does not replenish."
	items_to_create = list(/obj/item/pen/fourcolor/integrated, /obj/item/paper_bin/integrated, /obj/item/stamp/granted/integrated, /obj/item/stamp/denied/integrated)

/obj/item/organ/cyberimp/arm/toolkit/bureaucracy/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF || !IS_ROBOTIC_ORGAN(src))
		return
	if(!owner)
		return
	// Find the paper bin in our items
	for(var/datum/weakref/item_ref in items_list)
		var/obj/item/paper_bin/bin = item_ref.resolve()
		if(!istype(bin))
			continue
		// Spew out all the paper dramatically
		var/papers_spat_out = 0 // how much paper have we spewed so far
		while(bin.total_paper > 0 && papers_spat_out < 5) // Limit to 5 papers to avoid spam
			var/obj/item/paper/paper = new(get_turf(owner))
			paper.pixel_x = rand(-10, 10)
			paper.pixel_y = rand(-10, 10)
			var/throw_target = get_edge_target_turf(owner, pick(GLOB.cardinals))
			paper.throw_at(throw_target, rand(1, 3), rand(1, 2))
			bin.total_paper--
			papers_spat_out++
		if(papers_spat_out > 0)
			owner.visible_message(
				span_warning("[owner]'s arm suddenly spews out paper in all directions!"),
				span_warning("Your bureaucracy implant malfunctions, spewing papers everywhere!")
			)
			playsound(owner, 'sound/items/poster/poster_ripped.ogg', 50, TRUE)
		break

/obj/item/organ/cyberimp/arm/toolkit/cargo
	name = "FTU 'Deckhand' toolset implant"
	desc = "Containing a fingertip-mounted universal scanner and a boxcutter, deck workers across the sector favor this cheap and effective implant as both a means of self-defense from irate consumers and for keeping a set of handy scanners quite literally, close at hand."
	items_to_create = list(/obj/item/universal_scanner/integrated, /obj/item/boxcutter/extended/integrated)

/obj/item/organ/cyberimp/arm/toolkit/cargo/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF || !IS_ROBOTIC_ORGAN(src))
		return
	var/effect_chance = 0
	switch(severity)
		if(EMP_LIGHT)
			effect_chance = 12.5
		if(EMP_HEAVY)
			effect_chance = 25
	if(prob(effect_chance) && owner)
		owner.visible_message(
			span_danger("[owner]'s cargo implant sparks and malfunctions!"),
			span_warning("Your cargo implant shorts out briefly!")
		)
		do_sparks(3, TRUE, owner)
		if(active_item)
			Retract()
		owner.set_jitter_if_lower(severity == EMP_LIGHT ? 4 SECONDS : 8 SECONDS)
