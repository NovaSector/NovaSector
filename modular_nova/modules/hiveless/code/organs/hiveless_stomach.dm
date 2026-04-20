/obj/item/organ/stomach/hiveless
	name = "hiveless gullet"
	desc = "A dense bioreactor bristling with hairy vesicles. It only seems to care about meat."
	icon_state = "stomach"
	food_reagents = list(/datum/reagent/consumable/nutriment/organ_tissue/stomach_lining = 5)

	/// Current protein reserves.
	var/protein = HIVELESS_PROTEIN_MAX
	/// Maximum protein capacity.
	var/protein_max = HIVELESS_PROTEIN_MAX
	/// Protein gained per 1u of protein reagent absorbed.
	var/protein_per_unit = HIVELESS_PROTEIN_PER_REAGENT_UNIT
	/// `world.time` of the last starvation warning, for throttling.
	var/last_starve_warning = 0
	/// HUD element showing current reserves.
	var/atom/movable/screen/hiveless_protein/protein_display

/obj/item/organ/stomach/hiveless/on_life(seconds_per_tick)
	// Siphon before the parent metabolism transfers reagents out of the stomach.
	if(owner && !(organ_flags & ORGAN_FAILING))
		absorb_protein(seconds_per_tick)
	. = ..()
	if(!owner || (organ_flags & ORGAN_FAILING))
		return
	var/decay = HIVELESS_PROTEIN_DECAY * seconds_per_tick
	if(wearing_hiveless_armor())
		decay += HIVELESS_ARMOR_UPKEEP * seconds_per_tick
	adjust_protein(-decay)
	if(protein <= 0)
		apply_starvation(seconds_per_tick)

/obj/item/organ/stomach/hiveless/on_mob_insert(mob/living/carbon/receiver, special, movement_flags)
	. = ..()
	install_protein_hud(receiver)

/obj/item/organ/stomach/hiveless/on_mob_remove(mob/living/carbon/organ_owner, special, movement_flags)
	uninstall_protein_hud(organ_owner)
	return ..()

/obj/item/organ/stomach/hiveless/Destroy()
	if(owner)
		uninstall_protein_hud(owner)
	QDEL_NULL(protein_display)
	return ..()

/// Siphons any protein reagent in the stomach into the reserves.
/obj/item/organ/stomach/hiveless/proc/absorb_protein(seconds_per_tick)
	if(!reagents?.reagent_list)
		return
	var/datum/reagent/protein_reagent = locate(/datum/reagent/consumable/nutriment/protein) in reagents.reagent_list
	if(!protein_reagent)
		return
	if(protein >= protein_max)
		return
	var/drain = min(protein_reagent.volume, seconds_per_tick * 2)
	if(drain <= 0)
		return
	reagents.remove_reagent(protein_reagent.type, drain)
	adjust_protein(drain * protein_per_unit)

/// Adds `amount` to reserves, clamped, and refreshes the HUD. Pings owning abilities so their
/// button greyed-out state can repaint when protein crosses a cost threshold.
/obj/item/organ/stomach/hiveless/proc/adjust_protein(amount)
	protein = clamp(protein + amount, 0, protein_max)
	update_protein_hud()
	if(owner)
		SEND_SIGNAL(owner, COMSIG_HIVELESS_PROTEIN_CHANGED)

/// Deducts `amount` if available. Returns TRUE on success, FALSE on shortfall.
/obj/item/organ/stomach/hiveless/proc/try_spend_protein(amount, mob/living/spender)
	if(protein < amount)
		if(spender)
			spender.balloon_alert(spender, "not enough protein!")
		return FALSE
	adjust_protein(-amount)
	return TRUE

/// TRUE if the owner is currently wearing hiveless-summoned chitinous armor.
/obj/item/organ/stomach/hiveless/proc/wearing_hiveless_armor()
	var/mob/living/carbon/human/wearer = owner
	if(!istype(wearer))
		return FALSE
	return istype(wearer.wear_suit, /obj/item/clothing/suit/armor/changeling) || istype(wearer.head, /obj/item/clothing/head/helmet/changeling)

/obj/item/organ/stomach/hiveless/proc/apply_starvation(seconds_per_tick)
	if(!isliving(owner))
		return
	var/mob/living/starving = owner
	starving.adjust_brute_loss(HIVELESS_PROTEIN_STARVE_BRUTE * seconds_per_tick, updating_health = FALSE)
	starving.adjust_tox_loss(HIVELESS_PROTEIN_STARVE_TOX * seconds_per_tick, updating_health = FALSE)
	starving.updatehealth()
	if(world.time - last_starve_warning >= 15 SECONDS)
		last_starve_warning = world.time
		to_chat(starving, span_danger("Your flesh gnaws at itself — you hunger for raw protein."))

/obj/item/organ/stomach/hiveless/examine(mob/user)
	. = ..()
	if(isobserver(user) || (isliving(user) && user == owner))
		. += span_notice("Protein reserves: [round(protein)]/[protein_max].")

/// Adds the protein HUD element to the receiver, or defers until its HUD exists.
/obj/item/organ/stomach/hiveless/proc/install_protein_hud(mob/living/carbon/receiver)
	if(!receiver)
		return
	if(!receiver.hud_used)
		RegisterSignal(receiver, COMSIG_MOB_HUD_CREATED, PROC_REF(on_hud_created))
		return
	if(protein_display)
		return
	protein_display = new(null, receiver.hud_used)
	receiver.hud_used.infodisplay += protein_display
	receiver.hud_used.show_hud(receiver.hud_used.hud_version)
	update_protein_hud()

/// Retries HUD install once the mob's HUD is ready.
/obj/item/organ/stomach/hiveless/proc/on_hud_created(datum/source)
	SIGNAL_HANDLER
	UnregisterSignal(source, COMSIG_MOB_HUD_CREATED)
	install_protein_hud(source)

/// Removes and deletes the protein HUD element.
/obj/item/organ/stomach/hiveless/proc/uninstall_protein_hud(mob/living/carbon/losing_owner)
	UnregisterSignal(losing_owner, COMSIG_MOB_HUD_CREATED)
	if(losing_owner?.hud_used && protein_display)
		losing_owner.hud_used.infodisplay -= protein_display
	QDEL_NULL(protein_display)

/// Repaints the HUD maptext — max capacity on hover, current reserves otherwise.
/obj/item/organ/stomach/hiveless/proc/update_protein_hud()
	if(!protein_display)
		return
	if(protein_display.hovering)
		protein_display.maptext = MAPTEXT("<div align='center' valign='middle' style='position:relative; top:0px; left:6px'><font color='#dd2828'>[round(protein_max)]</font></div>")
	else
		protein_display.maptext = MAPTEXT("<div align='center' valign='middle' style='position:relative; top:0px; left:6px'><font color='#c8402f'>[round(protein)]</font></div>")
