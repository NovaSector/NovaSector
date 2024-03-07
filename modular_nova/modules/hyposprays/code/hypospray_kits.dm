/obj/item/storage/hypospraykit
	name = "hypospray kit"
	desc = "A hypospray kit with foam insets for hypovials and a mounting point on the bottom."
	icon = 'modular_nova/modules/hyposprays/icons/hypokits.dmi'
	icon_state = "firstaid-mini"
	worn_icon_state = "healthanalyzer" // Get a better sprite later
	inhand_icon_state = "medkit"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	// Small hypokits can be pocketed, but don't have much storage.
	w_class = WEIGHT_CLASS_SMALL
	slot_flags = ITEM_SLOT_BELT
	throw_speed = 3
	throw_range = 7
	var/empty = FALSE
	var/current_case = "firstaid"
	var/static/list/case_designs
	var/static/list/case_designs_xl
	var/is_xl = FALSE

	/// Tracks if a hypospray is attached to the case or not.
	var/obj/item/hypospray/mkii/attached_hypo

//Code to give hypospray kits selectable paterns.
/obj/item/storage/hypospraykit/examine(mob/living/user)
	. = ..()
	. += span_notice("Ctrl-Shift-Click to reskin this")
	if(attached_hypo)
		. += span_notice("[attached_hypo] is mounted on the bottom. Right-click to take it off.")
	else
		. += span_notice("Right-click with a hypospray to mount it.")

/obj/item/storage/hypospraykit/Initialize(mapload)
	. = ..()
	if(!length(case_designs))
		populate_case_designs()
	atom_storage.max_slots = 7
	atom_storage.can_hold = typecacheof(list(
		/obj/item/hypospray/mkii,
		/obj/item/reagent_containers/cup/vial
	))
	update_icon_state()
	update_icon()


/obj/item/storage/hypospraykit/Destroy()
	for(var/obj/item in contents)
		if(item.resistance_flags & INDESTRUCTIBLE)
			atom_storage.remove_single(null, item, drop_location(src), TRUE)
	if(attached_hypo)
		if(attached_hypo.resistance_flags & INDESTRUCTIBLE)
			var/atom/drop_loc = drop_location()
			if(!QDELETED(drop_loc))
				attached_hypo.forceMove(drop_loc)
			else
				qdel(attached_hypo)
			UnregisterSignal(attached_hypo, COMSIG_QDELETING)
			attached_hypo = null // clear the ref, it's been moved out safely.
		if(attached_hypo)
			QDEL_NULL(attached_hypo) // otherwise, for non indestructible hypos--make sure we delete it too, since it's not in contents, and clear its ref
	return ..()


/obj/item/storage/hypospraykit/proc/populate_case_designs()
	case_designs = list(
		"firstaid" = image(icon = src.icon, icon_state = "firstaid-mini"),
		"brute" = image(icon = src.icon, icon_state = "brute-mini"),
		"burn" = image(icon = src.icon, icon_state = "burn-mini"),
		"toxin" = image(icon = src.icon, icon_state = "toxin-mini"),
		"oxy" = image(icon = src.icon, icon_state = "oxy-mini"),
		"advanced" = image(icon = src.icon, icon_state = "advanced-mini"),
		"buffs" = image(icon = src.icon, icon_state = "buffs-mini"))
	case_designs_xl = list(
		"cmo" = image(icon = src.icon, icon_state = "cmo-mini"),
		"emt" = image(icon = src.icon, icon_state = "emt-mini"),
		"tactical" = image(icon = src.icon, icon_state = "tactical-mini"))

/obj/item/storage/hypospraykit/update_overlays()
	. = ..()
	if(attached_hypo)
		var/mutable_appearance/hypo_overlay = mutable_appearance(icon, attached_hypo.icon_state)
		. += hypo_overlay

/obj/item/storage/hypospraykit/attackby_secondary(obj/item/weapon, mob/user, params)
	if(istype(weapon, /obj/item/hypospray/mkii))
		if(attached_hypo != null)
			balloon_alert(user, "Mount point full!  Remove [attached_hypo] first!")
		else
			weapon.moveToNullspace()
			attached_hypo = weapon
			RegisterSignal(weapon, COMSIG_QDELETING, PROC_REF(on_attached_hypo_qdel))
			balloon_alert(user, "Attached [attached_hypo].")
			update_appearance()
			// This stops atom_storage from hogging your right-click and opening the inventory.
			return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
	return ..()

/obj/item/storage/hypospraykit/attack_hand_secondary(mob/user, list/modifiers)
	if(attached_hypo != null)
		if(user.put_in_hands(attached_hypo))
			balloon_alert(user, "Removed [attached_hypo].")
			UnregisterSignal(attached_hypo, COMSIG_QDELETING)
			attached_hypo = null
			update_appearance()
			// Ditto here.
			return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
		else
			balloon_alert(user, "Couldn't pull the hypo!")
	return ..()

/obj/item/storage/hypospraykit/proc/on_attached_hypo_qdel()
	attached_hypo = null
	update_appearance()

/obj/item/storage/hypospraykit/update_icon_state()
	. = ..()
	icon_state = "[current_case]-mini"

/obj/item/storage/hypospraykit/proc/case_menu(mob/user)
	if(.)
		return
	var/list/designs = case_designs
	if(is_xl)
		designs = case_designs_xl
	var/choice = show_radial_menu(user, src, designs, custom_check = CALLBACK(src, PROC_REF(check_menu), user), radius = 42, require_near = TRUE)
	if(!choice)
		return FALSE
	current_case = choice
	update_icon()

/obj/item/storage/hypospraykit/proc/check_menu(mob/user)
	if(!istype(user))
		return FALSE
	if(user.incapacitated() || !user.is_holding(src))
		return FALSE
	return TRUE


/obj/item/storage/hypospraykit/CtrlShiftClick(mob/user, obj/item/I)
	case_menu(user)

//END OF HYPOSPRAY CASE MENU CODE

/obj/item/storage/hypospraykit/PopulateContents()
	if(empty)
		return
	new /obj/item/hypospray/mkii(src)

/obj/item/storage/hypospraykit/empty
	empty = TRUE

/// Deluxe hypokit: more storage, but you can't pocket it.
/obj/item/storage/hypospraykit/cmo
	name = "deluxe hypospray kit"
	desc = "An extended hypospray kit with foam insets for hypovials & a mounting point on the bottom."
	icon_state = "cmo-mini"
	current_case = "cmo"
	is_xl = TRUE
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/storage/hypospraykit/cmo/Initialize(mapload)
	. = ..()
	atom_storage.max_slots = 14

/obj/item/storage/hypospraykit/cmo/PopulateContents()
	if(empty)
		return
	new /obj/item/hypospray/mkii/cmo(src)

/obj/item/storage/hypospraykit/cmo/empty
	desc = "An extended hypospray kit with foam insets for hypovials & a mounting point on the bottom."
	icon_state = "emt-mini"
	current_case = "emt"
	empty = TRUE

/// Preloaded version: this is what goes in the locker.
/obj/item/storage/hypospraykit/cmo/preloaded
	name = "CMO's deluxe hypospray kit"
	desc = "The CMO's precious extended hypospray kit, preloaded with a deluxe hypospray & a handful of vials.  Retains the usual insets and mounting point of smaller hypokits."

/obj/item/storage/hypospraykit/cmo/preloaded/PopulateContents()
	if(empty)
		return
	new /obj/item/hypospray/mkii/cmo(src)
	new /obj/item/reagent_containers/cup/vial/large/deluxe(src)
	new /obj/item/reagent_containers/cup/vial/large/multiver(src)
	new /obj/item/reagent_containers/cup/vial/large/salglu(src)
	new /obj/item/reagent_containers/cup/vial/large/synthflesh(src)

/// Combat hypokit
/obj/item/storage/hypospraykit/cmo/combat
	name = "combat hypospray kit"
	desc = "A larger tactical hypospray kit containing a combat-focused deluxe hypospray and vials."
	icon_state = "tactical-mini"
	current_case = "tactical"

/obj/item/storage/hypospraykit/cmo/combat/PopulateContents()
	if(empty)
		return
	new /obj/item/hypospray/mkii/cmo/combat(src)
	new /obj/item/reagent_containers/cup/vial/large/advbrute(src)
	new /obj/item/reagent_containers/cup/vial/large/advburn(src)
	new /obj/item/reagent_containers/cup/vial/large/advtox(src)
	new /obj/item/reagent_containers/cup/vial/large/advoxy(src)
	new /obj/item/reagent_containers/cup/vial/large/advcrit(src)
	new /obj/item/reagent_containers/cup/vial/large/advomni(src)
	new /obj/item/reagent_containers/cup/vial/large/numbing(src)

/// Boxes of empty hypovials, coming in every style.
/obj/item/storage/box/vials
	name = "box of hypovials"

/obj/item/storage/box/vials/PopulateContents()
	for(var/vialpath in subtypesof(/obj/item/reagent_containers/cup/vial/small/style))
		new vialpath(src)

// Ditto, just large vials.
/obj/item/storage/box/vials/deluxe
	name = "box of deluxe hypovials"

/obj/item/storage/box/vials/deluxe/PopulateContents()
	for(var/vialpath in subtypesof(/obj/item/reagent_containers/cup/vial/large/style))
		new vialpath(src)

// A box of small hypospray kits, pre-skinned to each variant to remind people what styles are available.
/obj/item/storage/box/hypospray
	name = "box of hypospray kits"

/obj/item/storage/box/hypospray/PopulateContents()
	var/list/case_designs = list("firstaid", "brute", "burn", "toxin", "oxy", "advanced", "buffs")
	for(var/label in case_designs)
		var/obj/item/storage/hypospraykit/newkit = new /obj/item/storage/hypospraykit(src)
		newkit.current_case = label
		newkit.update_icon_state()
