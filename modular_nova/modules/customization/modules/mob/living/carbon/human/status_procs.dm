/mob/living/carbon/human/become_husk(source)
	if(!HAS_TRAIT(src, TRAIT_NO_HUSK))
		. = ..()

/// Getting stunned interrupts a wagging tail. Upstream moved spec_stun from /datum/species onto the mob itself,
/// so this hooks the mob proc rather than overriding a per-species one.
/mob/living/carbon/human/spec_stun(amount)
	unwag_tail()
	return ..()
