// code\modules\projectiles\gun.dm
/obj/item/gun
	/// What Nova-specific lore does this gun have when examined twice (triggering `examine_more()`)?
	/// If this isn't `null`, informs users that they can examine this closer to get the lore blurb.
	var/lore_blurb = null
	can_hold_up = FALSE // originally TRUE

/obj/item/gun/Initialize(mapload)
	. = ..()
	if(lore_blurb)
		AddElement(/datum/element/examine_lore, \
			lore_hint = span_notice("You can [EXAMINE_HINT("look closer")] to learn a little more about [src]."), \
			lore = get_lore_blurb() \
		)

/// Returns the lore blurb as a plain string, to be used for adding to the gun's examine_lore component. Made into a proc to allow overriding,
/// for weapons like the Sol rifle series that have variant-specific blurbs.
/obj/item/gun/proc/get_lore_blurb()
	return lore_blurb
