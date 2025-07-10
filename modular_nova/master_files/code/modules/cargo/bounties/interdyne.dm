/datum/bounty/item/interdyne/heart
	name = "Heart"
	description = "Upper members of corporate wants better hearts for some of the benefactors of the company, dont dissapoint."
	reward = CARGO_CRATE_VALUE * 5
	wanted_types = list(
		/obj/item/organ/heart = TRUE,
		/obj/item/organ/heart/synth = FALSE,
		/obj/item/organ/heart/cybernetic = FALSE,
		/obj/item/organ/heart/cybernetic/tier2 = TRUE,
		/obj/item/organ/heart/cybernetic/tier3 = TRUE,
	)
