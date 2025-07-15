//some drinks
/obj/item/reagent_containers/cup/glass/drinkingglass/filled/martini
	list_reagents = list(/datum/reagent/consumable/ethanol/martini = 50)

/obj/item/reagent_containers/cup/glass/drinkingglass/filled/fringe_weaver
	list_reagents = list(/datum/reagent/consumable/ethanol/fringe_weaver = 50)

/obj/item/reagent_containers/cup/glass/drinkingglass/filled/doctor_delight
	list_reagents = list(/datum/reagent/consumable/doctor_delight = 50)

//papers
/obj/item/paper/fluff/midround_traitor/voucher_instruction
	default_raw_text = {"holy shit i am so bored. does this even matter? i'm stranded here. they said they'd come for me after a few months and i have plenty of stores. i tried listening to station stuff... but-
	<br> ugh. i caught some chatter about some sort of disk, but i think it was cross-ference with ourselves? some gas station jingle came on, some feedback from... not even sure what that is
	<br> the "old guy" did a good job around this base. it's not finished in the lobby, but everything else is nice.
	<br> they expressly told me to <i>never</i> leave this post, but i think "old guy" didn't listen for putting up those signs. i did a lap around with a spacewalk, that was fun.
	<br> i'll stay tuned.
	"}

/obj/item/paper/fluff/midround_traitor/greeting
	can_become_message_in_bottle = FALSE

/obj/item/paper/fluff/midround_traitor/greeting/Initialize(mapload)
	. = ..()
	return INITIALIZE_HINT_LATELOAD

/obj/item/paper/fluff/midround_traitor/greeting/LateInitialize()
	write_note(get_name())
	update_appearance()

/obj/item/paper/fluff/midround_traitor/greeting/proc/get_name()
	var/instance = 0
	for(var/antag in GLOB.antagonists)
		if(istype(antag, /datum/antagonist/traitor/marauder))
			instance++
	for(var/datum/antagonist/traitor/marauder/antag as anything in GLOB.antagonists)
		if(antag.owner.name && (antag.marauder_no == instance))
			return antag.owner.name

/obj/item/paper/fluff/midround_traitor/greeting/proc/write_note(name)
	var/addressed_to
	if(is_mononym(name))
		addressed_to = name
	else
		addressed_to = "[first_name(name)]"
	//add it to the note
	add_raw_text("[addressed_to],")
	add_raw_text("Hi.")
	add_raw_text("[pick(GLOB.first_names)]")
