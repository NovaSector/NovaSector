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

	if(isnull(target_atom.reagents))
		return FALSE

	if(target_atom.reagents.total_volume == target_atom.reagents.maximum_volume)
		return FALSE

	// Ignore reagents not in target_ids
	var/list/datum/reagent/target_reagents = list()
	if(length(target_ids))
		for(var/datum/reagent/target_type in target_ids)
			if(reagent_list[target_type])
				target_reagents += reagent_list[target_type]
	else
		target_reagents = reagent_list

	if(!length(target_reagents))
		return FALSE

	// Calculate available reagent volume to transfer VS available capacity
	var/max_volume = target_atom.reagents.maximum_volume
	var/current_volume = target_atom.reagents.total_volume
	max_volume = max_volume - current_volume
	var/available_volume = 0
	for(var/datum/reagent/reagent in target_reagents)
		available_volume += round(reagent.volume, CHEMICAL_QUANTISATION_LEVEL)

	if(available_volume < CHEMICAL_QUANTISATION_LEVEL)
		return FALSE

	// Total transfer volume can't exceed capacity
	available_volume = min(available_volume, max_volume)

	// Calculate initial target volume per reagent
	var/initial_target_volume = available_volume / length(target_reagents)

	// Calculate the initial reagent transfer volumes
	var/list/datum/reagent/initial_transfer_volumes = list()
	var/remaining_volume = 0
	for(var/datum/reagent/reagent in target_reagents)
		var/transfer_volume = min(round(reagent.volume, CHEMICAL_QUANTISATION_LEVEL), initial_target_volume)
		initial_transfer_volumes[reagent] = transfer_volume
		// Also sum remaining total transfer volume here to save time
		remaining_volume += transfer_volume

	// Re-distribute the remaining reagent volumes
	var/datum/reagent/adjusted_transfer_volumes = list()
	for(var/datum/reagent/reagent in target_reagents)
		var/adjusted_transfer_volume = 0
		if(reagent.volume > adjusted_transfer_volume)
			var/proportional_transfer_volume = 0
			for(reagent in target_reagents)
				var/initial_volume = initial_transfer_volumes[reagent]
				var/reagent_volume = round(reagent.volume, CHEMICAL_QUANTISATION_LEVEL)
				if(reagent_volume > initial_volume)
					proportional_transfer_volume = proportional_transfer_volume + (reagent_volume - initial_volume)
			adjusted_transfer_volume = adjusted_transfer_volume + (remaining_volume * proportional_transfer_volume)
		else
			adjusted_transfer_volumes[reagent] = adjusted_transfer_volume

	// Limit total ajusted transfer volumes to maximum capacity of target
	var/final_transfer_volume = assoc_value_sum(adjusted_transfer_volumes)
	var/final_transfer_volumes = list()
	if(final_transfer_volume > max_volume)
		var/excess_volume = final_transfer_volume - max_volume
		for(var/datum/reagent/reagent in target_reagents)
			var/adjusted_volume = adjusted_transfer_volumes[reagent]
			final_transfer_volumes[reagent] = adjusted_volume - (adjusted_volume / final_transfer_volume) * excess_volume

	for(var/datum/reagent/reagent in target_reagents)
		trans_to(
			target = target_atom,
			amount = final_transfer_volumes[reagent],
			target_id = reagent,
			preserve_data = preserve_data,
			no_react = no_react,
			transferred_by = transferred_by,
			remove_blacklisted = remove_blacklisted,
			methods = methods,
			show_message = show_message,
			ignore_stomach = ignore_stomach
		)
