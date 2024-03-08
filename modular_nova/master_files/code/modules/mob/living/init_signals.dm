/// Called when [TRAIT_ANALGESIA] is removed from the mob.
/mob/living/proc/on_analgesia_trait_loss(datum/source)
	SIGNAL_HANDLER
	clear_alert("numbed")


/// Called when [TRAIT_ANALGESIA] is added to the mob.
/mob/living/proc/on_analgesia_trait_gain(datum/source)
	SIGNAL_HANDLER
	throw_alert("numbed", /atom/movable/screen/alert/numbed)

