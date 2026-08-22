/*
 * Requisitions: getting building materials into a home without an admin having to be involved.
 *
 * A home is somewhere people want to build, and the cafe is not a place to shop. The console can
 * call down a drop pod of materials or tools on a cooldown, no approval needed. Anything past the
 * basics - refined alloys, an RCD, or a written request for something odd - goes to the admins with
 * approve and deny buttons instead of shipping straight away.
 *
 * IMPORTANT: everything a pod delivers is marked TRAIT_HOME_FURNISHING, which means it belongs to
 * the residence and can never be carried out of it. That is what makes the no-approval tier safe to
 * hand out freely: a player can request iron every five minutes forever and not one sheet of it can
 * reach the round's economy. If you ever add a delivery path that skips mark_delivery(), you have
 * turned this into a free materials printer.
 */

/// One line in the requisition catalogue.
/datum/home_supply
	/// Shown on the console.
	var/name
	/// Groups the catalogue in the UI.
	var/category = "Materials"
	/// One line of detail under the name.
	var/desc
	/// What lands: path -> amount. For stacks the amount is the stack size; for anything else it is
	/// how many separate copies to send.
	var/list/manifest
	/// TRUE if an admin has to sign this off before it ships.
	var/needs_approval = FALSE

/// A short label for the manifest, so the console can say what a line actually contains.
/datum/home_supply/proc/manifest_summary()
	var/list/parts = list()
	for(var/atom/movable/thing_path as anything in manifest)
		parts += "[manifest[thing_path]]x [initial(thing_path.name)]"
	return parts.Join(", ")

// ---------------------------------------------------------------------------------------------
//  The catalogue. Add to it freely - the subsystem picks up subtypes automatically.
// ---------------------------------------------------------------------------------------------

/datum/home_supply/iron
	name = "Iron sheets"
	desc = "The bones of most things worth building."
	manifest = list(/obj/item/stack/sheet/iron = 50)

/datum/home_supply/glass
	name = "Glass sheets"
	manifest = list(/obj/item/stack/sheet/glass = 50)

/datum/home_supply/reinforced_glass
	name = "Reinforced glass"
	manifest = list(/obj/item/stack/sheet/rglass = 30)

/datum/home_supply/wood
	name = "Wooden planks"
	desc = "Warmer underfoot than plating."
	manifest = list(/obj/item/stack/sheet/mineral/wood = 50)

/datum/home_supply/sandstone
	name = "Sandstone blocks"
	manifest = list(/obj/item/stack/sheet/mineral/sandstone = 50)

/datum/home_supply/rods
	name = "Metal rods"
	manifest = list(/obj/item/stack/rods = 50)

/datum/home_supply/cable
	name = "Cable coil"
	manifest = list(/obj/item/stack/cable_coil = 30)

/datum/home_supply/floor_tiles
	name = "Floor tiles"
	category = "Fittings"
	manifest = list(/obj/item/stack/tile/iron = 60)

/datum/home_supply/carpet
	name = "Carpet"
	category = "Fittings"
	manifest = list(/obj/item/stack/tile/carpet = 60)

/datum/home_supply/mechanical_tools
	name = "Mechanical toolbox"
	category = "Tools"
	desc = "Everything needed to put a wall up and take it down again."
	manifest = list(/obj/item/storage/toolbox/mechanical = 1)

/datum/home_supply/electrical_tools
	name = "Electrical toolbox"
	category = "Tools"
	manifest = list(/obj/item/storage/toolbox/electrical = 1)

/datum/home_supply/welding_kit
	name = "Welding kit"
	category = "Tools"
	desc = "A welding tool and something to save your eyes with."
	manifest = list(
		/obj/item/weldingtool = 1,
		/obj/item/clothing/glasses/welding = 1,
	)

/datum/home_supply/painter
	name = "Airlock painter"
	category = "Tools"
	manifest = list(/obj/item/airlock_painter = 1)

// --- Everything below needs an admin to sign it off. ---

/datum/home_supply/plasteel
	name = "Plasteel sheets"
	desc = "Structural alloy. Requires approval."
	manifest = list(/obj/item/stack/sheet/plasteel = 30)
	needs_approval = TRUE

/datum/home_supply/titanium
	name = "Titanium sheets"
	desc = "Requires approval."
	manifest = list(/obj/item/stack/sheet/mineral/titanium = 30)
	needs_approval = TRUE

/datum/home_supply/plastitanium
	name = "Plastitanium sheets"
	desc = "Requires approval."
	manifest = list(/obj/item/stack/sheet/mineral/plastitanium = 30)
	needs_approval = TRUE

/datum/home_supply/precious
	name = "Precious metals"
	desc = "Gold and diamond, for the discerning resident. Requires approval."
	manifest = list(
		/obj/item/stack/sheet/mineral/gold = 20,
		/obj/item/stack/sheet/mineral/diamond = 10,
	)
	needs_approval = TRUE

/datum/home_supply/bluespace
	name = "Bluespace crystals"
	desc = "Requires approval."
	manifest = list(/obj/item/stack/sheet/bluespace_crystal = 5)
	needs_approval = TRUE

/datum/home_supply/rcd
	name = "Rapid construction device"
	category = "Tools"
	desc = "Builds walls and floors on its own. Requires approval."
	manifest = list(/obj/item/construction/rcd/loaded = 1)
	needs_approval = TRUE

/datum/home_supply/rpd
	name = "Rapid pipe dispenser"
	category = "Tools"
	desc = "Requires approval."
	manifest = list(/obj/item/pipe_dispenser = 1)
	needs_approval = TRUE

// ---------------------------------------------------------------------------------------------
//  Requesting, shipping, and the admin queue
// ---------------------------------------------------------------------------------------------

/// A requisition sitting in front of the admins. Round-scoped: an approval that outlives the round
/// is not worth the bookkeeping, and the player can simply ask again.
/datum/home_requisition
	var/id
	var/static/next_id = 0
	var/requester_ckey
	var/requester_name
	/// The catalogue line asked for. Null for a written request.
	var/datum/home_supply/entry
	/// Free text, when somebody wants something the catalogue does not carry.
	var/written_request
	var/timestamp
	/// Set once an admin has ruled on it, so the buttons cannot be pressed twice.
	var/handled = FALSE

/datum/home_requisition/New(ckey, mob/user, datum/home_supply/asked_for, written)
	id = ++next_id
	requester_ckey = ckey
	requester_name = key_name(user, FALSE)
	entry = asked_for
	written_request = written
	timestamp = world.time

/datum/home_requisition/Destroy(force)
	entry = null
	return ..()

/// What the admins and the player are told this request is for.
/datum/home_requisition/proc/summary()
	if(!isnull(entry))
		return "[entry.name] ([entry.manifest_summary()])"
	return "written request: \"[written_request]\""

/datum/home_requisition/Topic(href, list/href_list)
	. = ..()
	if(.)
		return
	if(!href_list["home_requisition"])
		return
	if(!check_rights(R_ADMIN))
		CRASH("Player homes: possible HREF exploit on a requisition by [usr]!")
	if(handled)
		to_chat(usr, span_warning("That requisition has already been dealt with."), confidential = TRUE)
		return TRUE

	switch(href_list["home_requisition"])
		if("approve")
			SShomes.approve_requisition(src, usr)
		if("deny")
			SShomes.deny_requisition(src, usr)
	return TRUE

/// Builds the catalogue once at init, the same way the starter templates are collected.
/datum/controller/subsystem/homes/proc/preload_supply_catalogue()
	for(var/datum/home_supply/supply_type as anything in subtypesof(/datum/home_supply))
		if(!initial(supply_type.name))
			continue
		supply_catalogue += new supply_type()

/// Deciseconds left before this player may file another requisition. 0 when they are clear.
/datum/controller/subsystem/homes/proc/supply_cooldown_remaining(ckey)
	var/ready_at = supply_cooldowns[ckey]
	if(isnull(ready_at))
		return 0
	return max(0, ready_at - world.time)

/**
 * Files a requisition. Returns TRUE if something happened, FALSE if it was turned away.
 *
 * The cooldown is spent on filing rather than on delivery, so the queue cannot be spammed with
 * approval requests any more than the free tier can.
 */
/datum/controller/subsystem/homes/proc/request_supplies(datum/home_instance/home, mob/user, datum/home_supply/entry, written)
	if(isnull(home) || !home.is_owner(user))
		return FALSE
	if(isnull(entry) && !written)
		return FALSE

	var/waiting = supply_cooldown_remaining(home.owner_ckey)
	if(waiting > 0)
		to_chat(user, span_warning("The requisition line is still busy. Try again in [DisplayTimeText(waiting)]."))
		return FALSE
	supply_cooldowns[home.owner_ckey] = world.time + (CONFIG_GET(number/player_home_supply_cooldown) SECONDS)

	// The free tier: straight down the chute, nobody consulted.
	if(!isnull(entry) && !entry.needs_approval)
		deliver_supplies(home, entry.manifest)
		to_chat(user, span_notice("Requisition accepted. Stand clear - a pod is inbound."))
		log_game("[key_name(user)] requisitioned '[entry.name]' to their home.")
		return TRUE

	var/datum/home_requisition/pending = new(home.owner_ckey, user, entry, written)
	pending_requisitions += pending
	notify_admins_of_requisition(pending)
	to_chat(user, span_notice("Requisition filed for review. You will be told when somebody has looked at it."))
	log_game("[key_name(user)] filed a home requisition for review: [pending.summary()]")
	return TRUE

/datum/controller/subsystem/homes/proc/notify_admins_of_requisition(datum/home_requisition/pending)
	var/message = "[span_pink("HOME REQUISITION:")] [span_admin("[pending.requester_name] requests [pending.summary()] \
		(<a href='byond://?src=[REF(pending)];home_requisition=approve'>APPROVE</a>) \
		(<a href='byond://?src=[REF(pending)];home_requisition=deny'>DENY</a>)")]"
	to_chat(GLOB.admins, type = MESSAGE_TYPE_ADMINLOG, html = message, confidential = TRUE)

/datum/controller/subsystem/homes/proc/approve_requisition(datum/home_requisition/pending, mob/approver)
	pending.handled = TRUE
	pending_requisitions -= pending

	var/list/manifest = pending.entry?.manifest
	var/datum/home_instance/home = active_homes[pending.requester_ckey]
	if(!isnull(manifest))
		if(isnull(home))
			// They have stepped out. Hold it rather than dropping a pod into an empty reservation.
			LAZYADD(pending_deliveries[pending.requester_ckey], list(manifest))
			to_chat(approver, span_notice("They are not home - the pod will land the next time they step inside."), confidential = TRUE)
		else
			deliver_supplies(home, manifest)
	else
		// A written request has no manifest; the admin is expected to hand over the goods themselves.
		to_chat(approver, span_notice("Written request approved - you will need to provide the goods yourself."), confidential = TRUE)

	tell_requester(pending, span_notice("Your requisition for [pending.summary()] was approved."))
	message_admins("[key_name_admin(approver)] approved [pending.requester_name]'s home requisition: [pending.summary()]")
	log_admin("[key_name(approver)] approved [pending.requester_ckey]'s home requisition: [pending.summary()]")
	qdel(pending)

/datum/controller/subsystem/homes/proc/deny_requisition(datum/home_requisition/pending, mob/denier)
	var/reason = tgui_input_text(denier, "Why is this being refused? Left blank, they are told nothing.", "Deny Requisition", max_length = MAX_MESSAGE_LEN)
	if(pending.handled) // somebody else ruled on it while this prompt was open
		return
	pending.handled = TRUE
	pending_requisitions -= pending

	tell_requester(pending, span_warning("Your requisition for [pending.summary()] was refused.[reason ? " Reason: [reason]" : ""]"))
	message_admins("[key_name_admin(denier)] denied [pending.requester_name]'s home requisition: [pending.summary()][reason ? " ([reason])" : ""]")
	log_admin("[key_name(denier)] denied [pending.requester_ckey]'s home requisition: [pending.summary()]")
	qdel(pending)

/// Gets word back to whoever filed it, wherever they have got to since.
/datum/controller/subsystem/homes/proc/tell_requester(datum/home_requisition/pending, message)
	var/client/requester = GLOB.directory[pending.requester_ckey]
	if(!isnull(requester))
		to_chat(requester, message)

/// Drops a pod of goods into a loaded home and marks everything in it as belonging there.
/// Returns the pod, so a caller (or a test) can look at what is actually inside it.
/datum/controller/subsystem/homes/proc/deliver_supplies(datum/home_instance/home, list/manifest)
	var/turf/drop_zone = home.get_delivery_turf()
	if(isnull(drop_zone))
		return null

	var/obj/structure/closet/supplypod/pod = podspawn(list("target" = drop_zone))
	if(isnull(pod))
		return null

	for(var/atom/movable/thing_path as anything in manifest)
		var/amount = manifest[thing_path] || 1
		if(ispath(thing_path, /obj/item/stack))
			mark_delivery(new thing_path(pod, amount))
			continue
		for(var/copy in 1 to amount)
			mark_delivery(new thing_path(pod))
	return pod

/// Marks a delivered item, and everything inside it, as the home's property. A toolbox arrives full
/// of tools, and unmarked tools inside a marked box would walk straight out in somebody's pocket.
/datum/controller/subsystem/homes/proc/mark_delivery(atom/movable/delivered)
	ADD_TRAIT(delivered, TRAIT_HOME_FURNISHING, HOME_FURNISHING_TRAIT)
	for(var/atom/movable/piece as anything in delivered.get_all_contents())
		ADD_TRAIT(piece, TRAIT_HOME_FURNISHING, HOME_FURNISHING_TRAIT)

/// Ships anything an admin approved while the player was out. Called once the home is loaded.
/datum/controller/subsystem/homes/proc/flush_pending_deliveries(datum/home_instance/home)
	var/list/held = pending_deliveries[home.owner_ckey]
	if(!LAZYLEN(held))
		return
	pending_deliveries -= home.owner_ckey
	for(var/list/manifest as anything in held)
		deliver_supplies(home, manifest)

ADMIN_VERB(player_home_requisitions, R_ADMIN, "Player Homes - Pending Requisitions", "Show home requisitions still waiting on a decision.", ADMIN_CATEGORY_DEBUG)
	if(!length(SShomes.pending_requisitions))
		to_chat(user, span_notice("No home requisitions are waiting."), confidential = TRUE)
		return
	for(var/datum/home_requisition/pending as anything in SShomes.pending_requisitions)
		SShomes.notify_admins_of_requisition(pending)
