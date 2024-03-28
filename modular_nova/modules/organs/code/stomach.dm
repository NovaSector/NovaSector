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

/obj/item/organ/internal/stomach/ethereal/proc/ethereal_shock_absorb(mob/living/stomach_owner = owner, shock_damage, shock_source, siemens_coeff = 1, flags = NONE)
	do_sparks(number = 5, cardinal_only = TRUE, source = shock_source)
	playsound(src, SFX_SPARKS, 75, TRUE, -1)
	adjust_charge(25)
	if(!(flags & SHOCK_SUPPRESS_MESSAGE))
		stomach_owner.visible_message(
			span_danger("[stomach_owner] was shocked by \the [shock_source], absorbing it into [stomach_owner.p_their()] body!"), \
			span_userdanger("You feel a powerful shock coursing through your body, easily handling it!"), \
			span_hear("You hear a heavy electrical crack.") \
		)
	if (!(flags & SHOCK_NO_HUMAN_ANIM))
		if(ishuman(stomach_owner))
			var/mob/living/carbon/human/human_target = stomach_owner
			human_target.electrocution_animation(1 SECONDS)
	return COMPONENT_LIVING_BLOCK_SHOCK
