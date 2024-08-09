/**
 * Check if this holder contains a reagent with a `chemical_flags_nova` containing this flag.
 *
 * Arguments:
 * * chemical_flag - The bitflag to search for.
 * * min_volume - Checks for having a specific amount of reagents matching that `chemical_flag`
 */
/datum/reagents/proc/has_chemical_flag_nova(chemical_flag, min_volume = 0)
	var/found_amount = 0
	var/list/cached_reagents = reagent_list
	for(var/datum/reagent/holder_reagent as anything in cached_reagents)
		if (holder_reagent.chemical_flags_nova & chemical_flag)
			found_amount += holder_reagent.volume
			if(found_amount >= min_volume)
				return TRUE

	return FALSE

/* trans_to_equal() Theory of Operation:
Vi = volume of each available reagent.
n = total types of reagents.
V = target volume for each reagent after transfer.

Find V such that the volume of each reagent is as equal as possible.

Total combined volume of all reagents:
          n
Vtotal =  ∑ Vi
         i=1

Initial target volume per reagent:
Vinitial = Vtotal / n

For each reagent, the volume to be transferred is:
Ti = min(Vi, Vinitial)

After an initial transfer, we need to do a second pass.
Calculate the remaining volume after the initial round:
                      n
Vremaining = Vtotal - ∑ Ti
                     i=1

Redistribute remaining volume, for reagents where Vi > Ti:
T'i = Ti + Vremaining x (Vi - Ti) / ∑{j | Vj > Tj} (Vj - Tj)

Final transfer volume for reach reagent:
T"i = Ti + T'i
*/
/**
 * Calculates and transfers even amounts of each reagent to the target atom. Calls trans_to() to do the actual transfer.
 * Unlike trans_to(), amount is auto-calculated, and target_id is replaced with list target_ids.
 *
 * Arguments:
 * * obj/target - Target atom to attempt transfers to
 * * multiplier - multiplies each reagent amount by this number well byond their available volume before transfering. used to create reagents from thin air if you ever need to
 * * list/datum/reagent/target_ids - transfers only the listed reagent types in this holder leaving others untouched
 * * preserve_data - if preserve_data=0, the reagents data will be lost. Usefull if you use data for some strange stuff and don't want it to be transferred.
 * * no_react - passed through to [/datum/reagents/proc/add_reagent]
 * * mob/transferred_by - used for logging
 * * remove_blacklisted - skips transferring of reagents without REAGENT_CAN_BE_SYNTHESIZED in chemical_flags
 * * methods - passed through to [/datum/reagents/proc/expose] and [/datum/reagent/proc/on_transfer]
 * * show_message - passed through to [/datum/reagents/proc/expose]
 * * ignore_stomach - when using methods INGEST will not use the stomach as the target
 */
/datum/reagents/proc/trans_to_equal(
	atom/target_atom,
	multiplier = 1,
	list/datum/reagent/target_ids,
	preserve_data = TRUE,
	no_react = FALSE,
	mob/transferred_by,
	remove_blacklisted = FALSE,
	methods = NONE,
	show_message = TRUE,
	ignore_stomach = FALSE
)
	// Targeted atom can not hold reagents
	if(isnull(target_atom.reagents))
		return FALSE

	// Maximum amount of reagents which can fit inside the target
	var/max_volume = target_atom.reagents.maximum_volume
	// Total volume of the reagents already inside the target
	var/current_volume = target_atom.reagents.total_volume
	// Total volume of the empty space inside the target
	var/empty_volume = max_volume - current_volume

	// Targeted atom is already full of reagents
	if(empty_volume <= 0)
		return FALSE

	// Total volume of transferable reagents after whitelisting and rounding
	var/possible_transfer_volume = 0
	// Organize targeted reagents into associative list of typepaths to datums
	var/list/datum/reagent/target_reagents = list()
	// TRUE if a reagent whitelist was given
	var/using_whitelist = length(target_ids) != 0
	// Perform whitelisting and rounding, then calculate total possible transfer volume
	for(var/datum/reagent/reagent in reagent_list)
		if(!using_whitelist || target_ids[reagent.type])
			target_reagents[reagent.type] += reagent
			possible_transfer_volume += round(reagent.volume, CHEMICAL_QUANTISATION_LEVEL)

	// There are no transferable reagents
	if(!length(target_reagents))
		return FALSE

	// Total transfer volume can't exceed capacity
	possible_transfer_volume = min(empty_volume, possible_transfer_volume)
	// Ensure there is enough reagent volume to transfer anything
	if(possible_transfer_volume < CHEMICAL_QUANTISATION_LEVEL)
		return FALSE

	// Implements even distribution in first pass if reagent volumes meet this minimum
	var/initial_target_volume = round(possible_transfer_volume / length(target_reagents), CHEMICAL_QUANTISATION_LEVEL)
	// Volume of excess reagents. Redistributed in second pass if not zero.
	var/remaining_transfer_volume = 0
	// Total deficit volume. Enables second pass if not zero.
	var/deficit_transfer_volume = empty_volume
	// Total quantity of reagents with volume above initial_target_volume.
	var/excess_reagents = length(target_reagents)

	// Organize transfer volumes into associative list of typepaths to volumes
	// Used as a scratchpad to calculate transfer volumes and provide reagent transfer amounts to trans_to()
	var/list/datum/reagent/transfer_volumes = list()

	// First pass, calculate initial transfer volumes per reagent
	// Account for reagents with insufficient and excess volumes
	for(var/datum/reagent/reagent in target_reagents)
		var/reagent_volume = round(reagent.volume, CHEMICAL_QUANTISATION_LEVEL)
		var/transfer_volume = min(reagent_volume, initial_target_volume)
		transfer_volumes[reagent.type] = transfer_volume
		remaining_transfer_volume += reagent_volume - transfer_volume
		// Account for insufficient reagent volume
		deficit_transfer_volume = deficit_transfer_volume - transfer_volume
		// This reagent has excess volume. Could be redistributed in the second pass
		if(reagent_volume > initial_target_volume)
			excess_reagents++

	// Second pass, mitigate insufficient volumes via redistribution of excess volumes.
	if((deficit_transfer_volume > 0) && (remaining_transfer_volume > 0))
		for(var/datum/reagent/reagent in target_reagents)
			var/transfer_volume = transfer_volumes[reagent.type]
			// Transfer volume of this reagent is sufficient or higher, so skip it
			if(transfer_volume >= initial_target_volume)
				continue
			// Transfer volume of this reagent is insufficient, so others must be increased
			// Increase transfer volumes of excess reagents to compensate for the deficit
			for(var/datum/reagent/sub_reagent in target_reagents)
				var/sub_transfer_volume = transfer_volumes[sub_reagent.type]
				var/sub_volume = round(sub_reagent.volume, CHEMICAL_QUANTISATION_LEVEL)

				// This reagent has no excess volume, to skip it
				var/remaining_reagent_volume = sub_volume - sub_transfer_volume
				if(remaining_reagent_volume <= 0)
					continue

				// Only this reagent has excess volume, so we can skip a bunch of steps
				if(excess_reagents == 1)
					transfer_volumes[sub_reagent.type] = min(sub_volume, deficit_transfer_volume)
					excess_reagents--
					break

				// Calculate ideal volume adjustment based on deficit volume divided by quantity of excess reagents
				var/proportional_volume_increase = round(deficit_transfer_volume / excess_reagents, CHEMICAL_QUANTISATION_LEVEL)
				// Compensated on a best-effort basis
				var/new_transfer_volume = min(sub_volume, sub_transfer_volume + proportional_volume_increase)
				transfer_volumes[sub_reagent.type] = new_transfer_volume

				// Account for the remaining deficit
				deficit_transfer_volume = min(0, deficit_transfer_volume - proportional_volume_increase)
				if(deficit_transfer_volume == 0)
					break
				// Depleted this reagent after increasing but there's still a deficit
				if(new_transfer_volume == sub_volume)
					// Subtracting increases the proportional adjustment
					excess_reagents--

			// Used up excess reagents in nested loop
			// This also implies that remaining_transfer_volume is zero
			if(excess_reagents == 0)
				break
			// Fully fixed the deficit in nested loop
			if(deficit_transfer_volume == 0)
				break

	// Actually perform the reagent transfers and return total volume transferred
	var/transfer_total = 0
	for(var/datum/reagent/reagent in target_reagents)
		transfer_total += trans_to(
			target = target_atom,
			amount = transfer_volumes[reagent],
			target_id = reagent.type,
			preserve_data = preserve_data,
			no_react = no_react,
			transferred_by = transferred_by,
			remove_blacklisted = remove_blacklisted,
			methods = methods,
			show_message = show_message,
			ignore_stomach = ignore_stomach
		)
	return transfer_total
