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
