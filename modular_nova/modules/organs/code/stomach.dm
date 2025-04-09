/obj/item/organ/stomach
	/// Whether the organ is an oversized version
	var/is_oversized

/obj/item/organ/stomach/oversized
	name = "huge guts"
	desc = "Typically found in huge creatures, this monstrous engine has developed to be highly efficient, made to get an enormous amount of nutrients to an enormous eater."
	icon = 'modular_nova/modules/organs/icons/stomach.dmi'
	icon_state = "stomach_big"
	maxHealth = 1.5 * STANDARD_ORGAN_THRESHOLD
	metabolism_efficiency = 0.07
	is_oversized = TRUE

/obj/item/organ/stomach/synth/oversized
	name = "huge synthetic bio-reactor"
	desc = "Typically found in huge synthetics, this monstrous engine has been developed to be highly efficient, made to provide an enormous amount of power to an enormous machine."
	icon = 'modular_nova/modules/organs/icons/stomach.dmi'
	icon_state = "stomach_big_synth" //ugly placeholder sorry im not an artist hehe
	maxHealth = 1.5 * STANDARD_ORGAN_THRESHOLD
	metabolism_efficiency = 0.07
	is_oversized = TRUE

/obj/item/organ/stomach/slime/oversized
	name = "huge golgi apparatus"
	desc = "Typically found in huge slimes, this monstrous organelle has been developed to be highly efficient, made to provide an enormous amount of nutrients to an enormous ooze."
	maxHealth = 1.5 * STANDARD_ORGAN_THRESHOLD
	metabolism_efficiency = 0.07
	is_oversized = TRUE

// Not a stomach, but suitable for where we keep oversized schtuff.
/obj/item/organ/brain/slime/oversized
	name = "oversized core"
	desc = "The central core of a slimeperson, technically their 'extract.' Where the cytoplasm, membrane, and organelles come from; perhaps this is also a mitochondria? This one is enormous."
	brain_size = 2

/obj/item/organ/stomach/ethereal/proc/ethereal_shock_absorb(mob/living/stomach_owner = owner, shock_damage, shock_source, siemens_coeff = 1, flags = NONE)
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

//lithovore stomach - modified golem - this whole section calls to the vars set under stomach/golem, they work in game
/obj/item/organ/stomach/lithovore
	name = "litho-adapted stomach"
	icon_state = "stomach-p"
	desc = "An unfamiliar digestive organ that excels in material deconstruction."
	color = COLOR_GOLEM_GRAY
	organ_flags = ORGAN_MINERAL
	organ_traits = list(TRAIT_ROCK_EATER)

//i eat MORE ROCKS. WORSE.
/obj/item/organ/stomach/lithovore/oversized
	name = "huge litho-adapted stomach"
	icon = 'modular_nova/modules/organs/icons/stomach.dmi'
	icon_state = "stomach_big_p"
	desc = "A massive and unfamiliar digestive organ that excels in material deconstruction."
	color = COLOR_GOLEM_GRAY
	organ_flags = ORGAN_MINERAL
	organ_traits = list(TRAIT_ROCK_EATER)
	metabolism_efficiency = 0.07
	is_oversized = TRUE
