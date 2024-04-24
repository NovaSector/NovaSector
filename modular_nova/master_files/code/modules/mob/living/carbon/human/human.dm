/mob/living/carbon/human/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/interactable)
	//Removing ERP IC verbs depending on config
	if(CONFIG_GET(flag/disable_erp_preferences))
		verbs -= /mob/living/carbon/human/verb/toggle_genitals
		verbs -= /mob/living/carbon/human/verb/toggle_arousal
	if(CONFIG_GET(flag/disable_erp_preferences))
		verbs -= /mob/living/carbon/human/verb/climax_verb
	if(CONFIG_GET(flag/disable_lewd_items))
		verbs -= /mob/living/carbon/human/verb/safeword

// so the lewd straight jacket behaves (and because the reason behind this is /too/ lewd for upstream) - also allows for more downstream freedom
/mob/living/carbon/human/resist_restraints()
	var/obj/item/I = null
	var/type = 0
	if(wear_suit)
		I = wear_suit
		type = 1
	if(I)
		if(type == 1)
			changeNext_move(I.resist_cooldown)
			last_special = world.time + I.resist_cooldown
		cuff_resist(I)
	else
		..()
