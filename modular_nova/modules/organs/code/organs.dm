/// Copy traits from one organ to another - e.g. with custom roundstart organs that should still get species traits applied.
/obj/item/organ/proc/copy_traits_from(obj/item/organ/old_organ, copy_actions = TRUE)
	if(isnull(old_organ))
		return

	if(copy_actions)
		// for when you want to make sure the organ gets any actions from the old one
		for (var/datum/action/old_action as anything in old_organ.actions)
			// Skip if we already have an action of this type, so we don't get duplicates
			var/exists = FALSE
			for (var/datum/action/existing_action as anything in actions)
				if (existing_action.type == old_action.type)
					exists = TRUE
					break
			if (exists)
				continue

			add_item_action(old_action.type)
