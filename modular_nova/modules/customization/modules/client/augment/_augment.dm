/datum/augment_item
	abstract_type = /datum/augment_item
	// The augment's name
	var/name
	/// Category in which the augment belongs to. check "code\__DEFINES\~nova_defines\augment.dm"
	var/category
	/// Slot in which the augment belongs to - this is also the display name of its category. See "code\__DEFINES\~nova_defines\augment.dm"
	var/slot
	/// Description of the loadout augment, automatically set by New() if null
	var/description
	/// Typepath to the actual augment item
	var/obj/item/path
	/// How much quirky points does it cost?
	var/cost = 0
	/// Any extra information to display in the hoverover tooltip
	var/extra_info
	/// Which species IDs are forbidden from getting this augment
	var/list/species_blacklist
	/// The species IDs in this whitelist are the only ones which can get this augment
	var/list/species_whitelist
	/// If set, it's a list containing ckeys which only can get the item
	var/list/ckey_whitelist

/datum/augment_item/New()
	if(!description && path)
		description = path::desc
	if(LAZYLEN(species_blacklist))
		species_blacklist = string_assoc_list(species_blacklist)
	if(LAZYLEN(species_whitelist))
		species_whitelist = string_assoc_list(species_whitelist)

/datum/augment_item/proc/apply(mob/living/carbon/human/H, character_setup = FALSE, datum/preferences/prefs)
	return
