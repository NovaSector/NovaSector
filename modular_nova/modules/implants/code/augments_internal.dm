/obj/item/organ/internal/cyberimp/brain/anti_sleep
	name = "CNS jumpstarter"
	desc = "This implant will automatically attempt to jolt you awake when it detects you have fallen unconscious outside of REM sleeping cycles. Has a short cooldown. Conflicts with the CNS Rebooter, making them incompatible with eachother."
	icon_state = "brain_implant_rebooter"
	implant_color = "#0356fc"
	slot = ORGAN_SLOT_BRAIN_ANTISTUN //One or the other, not both.
	var/cooldown

/obj/item/organ/internal/cyberimp/brain/anti_sleep/on_life(seconds_per_tick, times_fired)
	var/mob/living/carbon/human/human_owner = owner
	if(human_owner.stat == UNCONSCIOUS && cooldown==FALSE)
		human_owner.AdjustUnconscious(-50 * seconds_per_tick, FALSE)
		human_owner.AdjustSleeping(-50 * seconds_per_tick, FALSE)
		to_chat(owner, span_notice("You feel a rush of energy course through your body!"))
		cooldown = addtimer(CALLBACK(src, PROC_REF(sleepytimerend)), 5 SECONDS)
	else
		return

/obj/item/organ/internal/cyberimp/brain/anti_sleep/proc/sleepytimerend()
	to_chat(owner, span_notice("You hear a small beep in your head as your CNS Jumpstarter finishes recharging."))

/obj/item/organ/internal/cyberimp/brain/anti_sleep/emp_act(severity)
	. = ..()
	var/mob/living/carbon/human/human_owner = owner
	if((organ_flags & ORGAN_FAILING) || . & EMP_PROTECT_SELF)
		return
	organ_flags |= ORGAN_FAILING
	human_owner.AdjustUnconscious(200)
	if(cooldown)
		deltimer(cooldown)
	cooldown = addtimer(CALLBACK(src, PROC_REF(reboot)), (9 SECONDS / severity))

/obj/item/organ/internal/cyberimp/brain/anti_sleep/proc/reboot()
	organ_flags &= ~ORGAN_FAILING

/obj/item/organ/internal/cyberimp/brain/anti_sleep/Destroy(force)
	if(cooldown)
		deltimer(cooldown)
	return ..()
