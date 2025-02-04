/obj/item/disk/nifsoft_uploader/summoner/detective
	name = "Grimoire Vacholiere"
	loaded_nifsoft = /datum/nifsoft/summoner/detective

/datum/nifsoft/summoner/detective
	name = "Grimoire Vacholiere"
	program_desc = "Grimoire Vacholiere is a fork of the Grimoire Caeruleam NIFSoft commissioned by numerous Zvirdnyan Colonial Militia officers. \
	Its entirely functional aspect and high requirement for fidelity makes it more expensive than many other Grimoires."
	summonable_items = list(
		/obj/item/detective_scanner/nanite,
		/obj/item/folder/yellow/nanite,
		/obj/item/binoculars/nanite,
		/obj/item/toy/crayon/white/nanite,
	)
	max_summoned_items = 2
	activation_cost = 100
	purchase_price = 350
	name_tag = "vacholiere-"
	buying_category = NIFSOFT_CATEGORY_UTILITY
	ui_icon = FA_ICON_MAGNIFYING_GLASS
	able_to_keep = FALSE

/obj/item/detective_scanner/nanite
	name = "regular forensic tool"
	desc = "You've done it, Officer! Whatever else you are, you're also <b>boring</b> now. It was <b>not</b> easy. \
	You've spent most of your life trying to scoop through every nook and cranny of your crime scene. \
	When someone says something political, the first three thoughts in your head are a ludicrous hodgepodge of unificationalism, xenophilia and 'incorruptibility'. \
	When they ask you why you did something, it's preservation instincts, operating procedures, or the <i><b>mea culpas</b></i> of a cop. \
	It's not easy, reaching for the efficient option — the normal one. But you have. And now you're not <b>just</b> a detective, you're also <b>boring</b>. <br><br>\
	-1 <span style=\"color:purple;\">Inland Empire</span>: Dull and solid<br>\
	-1 <span style=\"color:red;\">Shivers</span>: Victory of metareality"
	range = 4 //^ It's the DE reference as much as it's also me saying 'Good job for going the easy way gamer'.

/obj/item/folder/yellow/nanite
	name = "folder of oblivion"
	desc = "This is the folder you've downloaded from the net. It emits oblivion. A thin veneer of la-la-la, what I don't know can not hurt me covers its pages. \
	You look at it and it makes you feel surprisingly solid, actually. <br><br>\
	+1 <span style=\"color:purple;\">Authority</span>: Threw that shit away<br>\
	+1 <span style=\"color:purple;\">Suggestion</span>: Mentally healthy power-move<br>\
	-1 <span style=\"color:purple;\">Inland Empire</span>: Don't even care"

/obj/item/binoculars/nanite
	name = "searchlight divisioner"
	desc = "Missing persons cases just really get to you. \
	It's hard watching people worry about their loved ones — the little nervous movements, the dark rings around their eyes from sleepless nights. \
	And even if there are no loved ones waiting — you like to have all your ducks in a row, and it really bothers you when whole entire people aren't accounted for.<br><br>\
	+2 <span style=\"color:yellow;\">Perception</span>: Clear-eyed pursuit of truth"

/obj/item/toy/crayon/white/nanite
	name = "actual asphalt grafitter"
	desc = "Yeah, it's another piece of gear — the worst one. The most savage and brutal. The piece of chalk. It's good for nothing. \
	It is <b>shit</b>. You have to employ an armada of adjectives to depict and demean the mediocrity of its use. \
	Really <b>flex</b> that deductive muscle. Until the vocabulary for PUNISHING mediocrity becomes second nature. Here we go...<br><br>\
	-1 <span style=\"color:yellow;\">Hand/Eye Coordination</span>: Hands shake from anger how shit it is"
	charges = -1
	edible = FALSE
