// code\modules\projectiles\gun.dm
/obj/item/gun
	/// What Nova-specific lore does this gun have when examined twice (triggering `examine_more()`)?
	/// If this isn't `null`, informs users that they can examine this closer to get the lore blurb.
	var/lore_blurb = null

/obj/item/gun/examine(mob/user)
	. = ..()
	if(lore_blurb)
		. += span_notice("You can [EXAMINE_HINT("examine more")] to learn a little more about [src].")

/obj/item/gun/examine_more(mob/user)
	. = ..()
	if(lore_blurb)
		. += "<i>[get_lore_blurb()]</i>"

/// Returns the lore blurb as a plain string. This gets italicized by the gun's examine_more(). Made a proc to allow overriding.
/obj/item/gun/proc/get_lore_blurb()
	return lore_blurb
