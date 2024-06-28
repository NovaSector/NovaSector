// LETHALSTATION FIRE ADJUSTMENTS
// Before: -0.05 fire stacks per tick, always
// After: -0.35 fire stacks per tick (7x increase), but only if below 10 stacks, otherwise no reduction at all.
// The intent here is to keep incendiaries as a viable weapon type but make being clipped by a single shot or flame grenade not be a world-ending experience.

/mob/living
	fire_stack_decay_rate = -0.35

/datum/status_effect/fire_handler/proc/stacks_notify(pre)
	if (!owner.on_fire)
		return

	if (pre < 10 && stacks >= 10)
		owner.visible_message(span_warning("[owner] erupts into a roaring blaze!"), span_boldwarning("The flames surrounding you erupt into a roaring blaze - <i>RESIST</i> to put them out!"))
		return

	if (pre >= 10 && stacks <= 9)
		owner.visible_message(span_warning("The flames engulfing [owner] begin to sputter and die out of their own accord."), span_warning("The flames engulfing you begin to die down on their own..."))
		return

/datum/status_effect/fire_handler/set_stacks(new_stacks)
	var/pre = stacks
	. = ..()
	stacks_notify(pre)

/datum/status_effect/fire_handler/adjust_stacks(new_stacks)
	var/pre = stacks
	. = ..()
	stacks_notify(pre)
