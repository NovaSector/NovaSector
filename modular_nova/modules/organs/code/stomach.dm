/obj/item/organ/internal/stomach/oversized
	name = "huge guts"
	desc = "Typically found in huge creatures, this monstrous engine has developed to be highly efficient, made to get an enormous amount of nutrients to an enormous eater."
	icon = 'modular_nova/modules/organs/icons/stomach.dmi'
	icon_state = "stomach_big"
	maxHealth = 1.5 * STANDARD_ORGAN_THRESHOLD
	metabolism_efficiency = 0.07

/obj/item/organ/internal/stomach/synth/oversized
	name = "huge synthetic bio-reactor"
	desc = "Typically found in huge synthetics, this monstrous engine has been developed to be highly efficient, made to provide an enormous amount of power to an enormous machine."
	icon = 'modular_nova/modules/organs/icons/stomach.dmi'
	icon_state = "stomach_big_synth" //ugly placeholder sorry im not an artist hehe
	maxHealth = 1.5 * STANDARD_ORGAN_THRESHOLD
	metabolism_efficiency = 0.07

/obj/item/organ/internal/stomach/ethereal/on_mob_insert(mob/living/carbon/stomach_owner)
	. = ..()
	RegisterSignal(stomach_owner, COMPONENT_LIVING_BLOCK_SHOCK, PROC_REF(on_electrocute))

/obj/item/organ/internal/stomach/ethereal/on_mob_remove(mob/living/carbon/stomach_owner)
	. = ..()
	UnregisterSignal(stomach_owner, COMPONENT_LIVING_BLOCK_SHOCK)

/obj/item/organ/internal/stomach/ethereal/proc/ethereal_shock_absorb(datum/source, shock_damage, siemens_coeff = 1, flags = NONE, mob/living/user)
	SIGNAL_HANDLER
	do_sparks(5, TRUE, source)
	playsound(src, SFX_SPARKS, 75, TRUE, -1)
	if(!(flags & SHOCK_SUPPRESS_MESSAGE))
		visible_message(
			span_danger("[src] was shocked by \the [source], absorbing it into their body!"), \
			span_userdanger("You feel a powerful shock coursing through your body, easily handling it!"), \
			span_hear("You hear a heavy electrical crack.") \
		)
	if (!(flags & SHOCK_NO_HUMAN_ANIM))
		if(ishuman(user))
			var/mob/living/carbon/human/human_target = user
			human_target.electrocution_animation(1 SECONDS)
	return COMPONENT_LIVING_BLOCK_SHOCK
