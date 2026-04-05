/datum/emote
/// Message displayed if the user is a Synthetic Humanoid.  Originally robot+message was just a blanket term for synthetics, cyborgs and pAIs.
	var/message_synthetic = ""

/datum/emote/living/sigh_exasperated
	message_AI = "simulates an exasperated sigh."
	message_robot = "simulates an exasperated sigh."

/datum/emote/living/sigh
	message_AI = "simulates a sigh."
	message_robot = "simulates a sigh."

/datum/emote/living/laugh
	message_AI = "synthesizes a laugh."
	message_robot = "synthesizes a laugh."

/datum/emote/living/chuckle
	message_AI = "synthesizes a chuckle."
	message_robot = "synthesizes a chuckle."

/datum/emote/living/carbon/cry
	message_AI = "makes a crying sound."
	message_robot = "makes a crying sound."
