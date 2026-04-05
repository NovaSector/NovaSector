/datum/action/cooldown/toggle_welding
	name = "Toggle welding shield"
	desc = "Toggle your eyes welding shield"

	var/obj/item/organ/eyes/nabber/eyes
	cooldown_time = 1 SECONDS

/datum/action/cooldown/toggle_welding/Activate()
	. = ..()
	var/owner = eyes.owner
	var/mob/living/carbon/human/nabber = owner
	if(!do_after(nabber, 1 SECONDS, nabber)) //Makes it so its difficult to abuse these in combat to avoid flashes
		StartCooldown()
		nabber.balloon_alert(nabber, "Stand still!")
		return FALSE
	eyes.toggle_shielding()
	StartCooldown()

/datum/action/cooldown/toggle_welding/Destroy()
	eyes = null
	return ..()
