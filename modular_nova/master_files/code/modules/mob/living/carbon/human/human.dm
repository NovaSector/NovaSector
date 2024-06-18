/mob/living/carbon/human/Initialize(mapload)
	. = ..()
	mob_examine_panel = new(src) //create the datum
	AddComponent(/datum/component/interactable)
	//Removing ERP IC verbs depending on config
	if(CONFIG_GET(flag/disable_erp_preferences))
		verbs -= /mob/living/carbon/human/verb/toggle_genitals
		verbs -= /mob/living/carbon/human/verb/toggle_arousal
	if(CONFIG_GET(flag/disable_erp_preferences))
		verbs -= /mob/living/carbon/human/verb/climax_verb
	if(CONFIG_GET(flag/disable_lewd_items))
		verbs -= /mob/living/carbon/human/verb/safeword


/mob/living/carbon/human/Destroy()
	QDEL_NULL(mob_examine_panel)
	return ..()


// so the lewd straight jacket behaves (and because the reason behind this is /too/ lewd for upstream) - also allows for more downstream freedom
/mob/living/carbon/human/resist_restraints()
	if(wear_suit?.breakouttime)
		changeNext_move(wear_suit.resist_cooldown)
		last_special = world.time + wear_suit.resist_cooldown
		cuff_resist(wear_suit)
	else
		return ..()
