/datum/bounty/item/interdyne_med/heart
	name = "Heart"
	description = "Corporate needs a few new hearts for scientific study. They will allow cybernetic ones to be submitted, but won't accept any basic cybernetics."
	reward = CARGO_CRATE_VALUE * 10
	wanted_types = list(
		/obj/item/organ/heart = TRUE,
		/obj/item/organ/heart/synth = FALSE,
		/obj/item/organ/heart/cybernetic = FALSE,
		/obj/item/organ/heart/cybernetic/tier2 = TRUE,
		/obj/item/organ/heart/cybernetic/tier3 = TRUE,
	)

/datum/bounty/item/interdyne_med/lung
	name = "Lungs"
	description = "Corporate needs a few new lungs after an unfavorable event, the details of which do not matter. Organic lungs are preferred, but cybernetic are acceptable. Basic cybernetics won't be accepted."
	reward = CARGO_CRATE_VALUE * 10
	required_count = 3
	wanted_types = list(
		/obj/item/organ/lungs = TRUE,
		/obj/item/organ/lungs/synth = FALSE,
		/obj/item/organ/lungs/cybernetic = FALSE,
		/obj/item/organ/lungs/cybernetic/tier2 = TRUE,
		/obj/item/organ/lungs/cybernetic/tier3 = TRUE,
	)

/datum/bounty/item/interdyne_med/appendix
	name = "Appendix"
	description = "Some executives at a... cooperative company need a brand new appendix, get one and they'll pay."
	reward = CARGO_CRATE_VALUE * 5
	wanted_types = list(/obj/item/organ/appendix = TRUE)

/datum/bounty/item/interdyne_med/ears
	name = "Ears"
	description = "After a chemical incident at Interdyne Vessel 29 left them deaf, new ears need to be provided. Cybernetic ones are fine, but basic cybernetics will not be accepted."
	reward = CARGO_CRATE_VALUE * 10
	required_count = 3
	wanted_types = list(
		/obj/item/organ/ears = TRUE,
		/obj/item/organ/ears/synth = FALSE,
		/obj/item/organ/ears/cybernetic = FALSE,
		/obj/item/organ/ears/cybernetic/upgraded = TRUE,
		/obj/item/organ/ears/cybernetic/whisper = TRUE,
		/obj/item/organ/ears/cybernetic/xray = TRUE,
	)

/datum/bounty/item/interdyne_med/liver
	name = "Livers"
	description = "One of our facilities has recently been overwhelmed by many patients with liver failure. Send some organic ones preferably, but cybernetic ones will do. Basic cybernetics will not be accepted."
	reward = CARGO_CRATE_VALUE * 5
	required_count = 3
	wanted_types = list(
		/obj/item/organ/liver = TRUE,
		/obj/item/organ/liver/synth = FALSE,
		/obj/item/organ/liver/cybernetic = FALSE,
		/obj/item/organ/liver/cybernetic/tier2 = TRUE,
		/obj/item/organ/liver/cybernetic/tier3 = TRUE,
	)

/datum/bounty/item/interdyne_med/eye
	name = "Organic Eyes"
	description = "A leading researcher upon IPMV-113 ran out of corpses with organic eyes... Just supply them more, I'll spare you from the details. Cybernetics will not be accepted."
	reward = CARGO_CRATE_VALUE * 10
	required_count = 3
	wanted_types = list(
		/obj/item/organ/eyes = TRUE,
		/obj/item/organ/eyes/synth = FALSE,
		/obj/item/organ/eyes/robotic = FALSE,
	)

/datum/bounty/item/interdyne_med/tongue
	name = "Tongues"
	description = "IPMV-25 recently played a dare based game and decided to be stupid with sulfuric acid. They need some new tongues, so send some if you can. Synthetic tongues will not be accepted."
	reward = CARGO_CRATE_VALUE * 10
	required_count = 3
	wanted_types = list(
		/obj/item/organ/tongue = TRUE,
		/obj/item/organ/tongue/synth = FALSE,
	)

/datum/bounty/item/interdyne_med/lizard_tail
	name = "Lizard Tail"
	description = "A recent near fatal accident happened in a partner company, the patient needs a lizard tail. Supply it and we'll make it worth your while."
	reward = CARGO_CRATE_VALUE * 6
	wanted_types = list(/obj/item/organ/tail/lizard = TRUE)

/datum/bounty/item/interdyne_med/cat_tail
	name = "Cat Tail"
	description = "Due to a mixture of alcohol, unethical thoughts, and questioning if felinids are just humans with cat ears, one of our staff has lost their tail. Send a new cat tail ASAP."
	reward = CARGO_CRATE_VALUE * 6
	wanted_types = list(/obj/item/organ/tail/cat = TRUE)

/datum/bounty/item/interdyne_med/chainsaw
	name = "Chainsaw"
	description = "Doctor Izazel on IPMV-2201 wants a chainsaw for... nevermind, just send one and they'll pay handsomely."
	reward = CARGO_CRATE_VALUE * 5
	wanted_types = list(/obj/item/chainsaw = TRUE)

/datum/bounty/item/interdyne_med/surgerycomp
	name = "Surgery Computer"
	description = "After a recent freak accident with bombs and alcohol, one of our surgical computers went full fubar. Send us one and you'll be paid nicely."
	reward = CARGO_CRATE_VALUE * 12
	wanted_types = list(/obj/machinery/computer/operating = TRUE)

/datum/bounty/item/interdyne_med/surgerytable
	name = "Operating Table"
	description = "After a recent influx of infected crew members, we've seen that masks just aren't cutting it alone. Silver operating tables might just do the trick though, send us one to use."
	reward = CARGO_CRATE_VALUE * 6
	wanted_types = list(/obj/structure/table/optable = TRUE)
