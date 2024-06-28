// shit for pentola workers to larp as fixers and stuff. they get a choice beacon with three loadouts


//overwatch glasses. clone of detective spyglasses with bigger range

/obj/item/clothing/accessory/spy_bug/pentola
	name = "overwatch camera"
	icon = 'icons/obj/clothing/accessories.dmi'
	icon_state = "anti_sec"
	desc = "A small, portable camera which allows a fixer to provide overwatch to an operator in the field. Microphone not included."
	/// How far can we actually see? Ranges higher than one can be used to see through walls.
	cam_range = 3
	/// Detects when we move to update the camera view

//to make a version with bigger range we gotta dupe a lot of the procs
/obj/item/clothing/glasses/sunglasses/spy/pentola/proc/show_to_user_pentola(mob/user)//this is the meat of it. most of the map_popup usage is in this.
	var/client/cool_guy = user?.client
	if(!cool_guy)
		return
	if(!linked_bug)
		user.audible_message(span_warning("[src] lets off a shrill beep!"))
	if(cool_guy.screen_maps["spypopup_map"]) //alright, the popup this object uses is already IN use, so the window is open. no point in doing any other work here, so we're good.
		return
	cool_guy.setup_popup("spypopup", 7, 7, 2, "S.P.Y")
	linked_bug.cam_screen.display_to(user)
	RegisterSignal(cool_guy, COMSIG_POPUP_CLEARED, PROC_REF(on_screen_clear))

	linked_bug.update_view()

/obj/item/clothing/glasses/sunglasses/spy/pentola/ui_action_click(mob/user)
	show_to_user_pentola(user)

/obj/item/clothing/glasses/sunglasses/spy/pentola
	name = "overwatch retinal projector"
	desc = "A heads-up display used by fixers to monitor their operators in the field."
	worn_icon = 'modular_nova/modules/modular_items/icons/modular_glasses_mob.dmi'
	icon = 'modular_nova/modules/modular_items/icons/modular_glasses.dmi'
	icon_state = "projector_meson"
	actions_types = list(/datum/action/item_action/activate_remote_view)

/obj/item/door_remote/omni/pentola
	name = "remote airlock override device"
	desc = "A hacking device equal parts useful and illegal, allows the user to remotely open and bolt airlocks."
	department = "omni"
	region_access = REGION_ALL_STATION

/obj/item/modular_computer/laptop/preset/pentola
	desc = "A high-end laptop used by fixers."
	starting_programs = list(
		/datum/computer_file/program/chatclient,
		/datum/computer_file/program/newscaster,
		/datum/computer_file/program/arcade/eazy,
		/datum/computer_file/program/signal_commander,
		/datum/computer_file/program/secureye/syndicate,
	)

/obj/item/storage/box/rxglasses/spyglasskit/pentola
	name = "(WIP) fixer kit"
	desc = "Contains everything you need to provide overwatch to whatever poor gakster you send on a deadly quest. Cash bribe included."

/obj/item/storage/box/rxglasses/spyglasskit/PopulateContents()
	var/obj/item/clothing/accessory/spy_bug/pentola/newbug = new(src)
	var/obj/item/clothing/glasses/sunglasses/spy/pentola/newglasses = new(src)
	newbug.linked_glasses = newglasses
	newglasses.linked_bug = newbug
	new /obj/item/paper/fluff/nerddocs(src)
	new /obj/item/lethalcash/c1000(src)
	new /obj/item/door_remote/omni/pentola(src)
	new /obj/item/modular_computer/laptop/preset/pentola(src)
	new /obj/item/circuitboard/computer/advanced_camera(src)

// medical kit. includes fun items to get a medical-themed character started

/obj/item/storage/box/pentolamedic
	name = "pentola medic kit"
	desc = "Contains everything you need to provide affordable medical care to whatever poor gakster you find bleeding out on the floor."

/obj/item/storage/box/pentolamedic/PopulateContents()
	new /obj/item/storage/backpack/duffelbag/deforest_surgical/stocked(src)
	new /obj/item/reagent_containers/hypospray/medipen/deforest/krotozine(src)
	new /obj/item/reagent_containers/hypospray/medipen/deforest/krotozine(src)
	new /obj/item/defibrillator/loaded(src)
	new /obj/item/clothing/glasses/hud/health(src)
	new /obj/item/lethalcash/c200(src)
	new /obj/item/key_card/pentola/medical(src)
// service kit. stuff to serve people food and drink n shit

// medical kit. includes fun items to get a medical-themed character started

/obj/item/storage/box/pentolachef
	name = "pentola service kit"
	desc = "Contains everything you need to provide affordable food and drink to whatever poor gakster you find hungry in the bar."

/obj/item/storage/box/pentolachef/PopulateContents()
	new /obj/item/knife/butcher(src)
	new /obj/item/kitchen/rollingpin(src)
	new /obj/item/reagent_containers/cup/glass/shaker(src)
	new /obj/item/storage/box/ingredients/random(src)
	new /obj/item/storage/box/ingredients/random(src)
	new /obj/item/storage/box/ingredients/random(src)
	new /obj/item/key_card/pentola/chef(src)
	new /obj/item/lethalcash/c200(src)

/obj/item/storage/box/pentolamechanic
	name = "pentola mechanic's kit"
	desc = "Contains everything you need to provide affordable repairs and exosuits to whatever poor gakster you find with a broken down hovercar."

/obj/item/storage/box/pentolamechanic/PopulateContents()
	new /obj/item/storage/toolbox/mechanical(src)
	new /obj/item/clothing/head/utility/welding(src)
	new /obj/item/lethalcash/c100(src)
	new /obj/item/key_card/pentola/engineer(src)
	new /obj/item/clothing/gloves/color/yellow(src)


// choice beacon: lets pentola gamers pick who they wanna be

/obj/item/choice_beacon/pentola
	name = "black company delivery beacon"
	desc = "Summon the tools of your trade."
	icon_state = "self_delivery"
	inhand_icon_state = "self_delivery"
	company_source = "Black Company"
	company_message = span_bold("Request recieved, kit en route. Your offplanet account has been charged 5000cr for delivery fees.")
	w_class = WEIGHT_CLASS_TINY

//beacon pentolagoers spawn with to pick class
/obj/item/choice_beacon/pentola/generate_display_names()
	var/static/list/pentola_list
	if(!pentola_list)
		pentola_list = list()
		var/list/selectable_types = list(
			/obj/item/storage/box/pentolamedic,
			/obj/item/storage/box/rxglasses/spyglasskit/pentola,
			/obj/item/storage/box/pentolachef,
			/obj/item/storage/box/pentolamechanic,
		)
		for(var/obj/item/storage/box as anything in selectable_types)
			pentola_list[initial(box.name)] = box
	return pentola_list

// MORUGA APARTMENTS

/obj/machinery/vending/pentola
	name = "Moruga Apartments Discount Motel Services"
	desc = "Pay your rent and recieve your housekey. More expensive apartments are nicer. All apartments include access to the laundry room."
	icon = 'icons/obj/machines/vending.dmi'
	icon_state = "custom"
	default_price = 1000
	products = list(
				/obj/item/key_card/hotel_room/pentola/one = 1,
				/obj/item/key_card/hotel_room/pentola/two = 1,
				/obj/item/key_card/hotel_room/pentola/three = 1,
				/obj/item/key_card/hotel_room/pentola/four = 1,
				/obj/item/key_card/hotel_room/pentola/five = 1,
				/obj/item/key_card/hotel_room/pentola/six = 1,
				/obj/item/key_card/hotel_room/pentola/seven = 1,
	)
//Space Hotel Keycards and Room Doors
/obj/item/key_card/hotel_room/pentola
	name = "\improper Moruga Apartments keycard"
	desc = "A scuffed keycard, to open a keycard-locked motel room."
	access_id = "guest_room_"

/obj/item/key_card/hotel_room/pentola/one
	color = "#E0E000"
	room_number = 1

/obj/item/key_card/hotel_room/pentola/two
	color = "#C4004E"
	room_number = 2

/obj/item/key_card/hotel_room/pentola/three
	color = "#00C074"
	room_number = 3

/obj/item/key_card/hotel_room/pentola/four
	color = "#2CAF2C"
	room_number = 4
	custom_price = 2000

/obj/item/key_card/hotel_room/pentola/five
	color = "#E55C01"
	room_number = 5
	custom_price = 2000

/obj/item/key_card/hotel_room/pentola/six
	color = "#AC00AC"
	room_number = 6
	custom_price = 2000

/obj/item/key_card/hotel_room/pentola/seven
	color = "#0AA7E9"
	room_number = 7
	custom_price = 5000

/obj/item/key_card/hotel_room/medical
	color = "#0AA7E9"
	room_number = 8

/obj/machinery/door/airlock/keyed/hotel_room/medical
	greyscale_accent_color = "#0AA7E9"
	room_number = 8

//keycards for jobs

/obj/machinery/door/airlock/keyed/pentola/medical
	name = "locked medical airlock"
	desc = "This door only opens when a keycard with the proper access is swiped. It looks virtually indestructible."
	access_id = "pentola_medical"

/obj/item/key_card/pentola/medical
	name = "Black Company medical keycard"
	desc = "Opens doors in the pentola's medical bay. Smells of saline and amollin."
	access_id = "pentola_medical"

/obj/machinery/door/airlock/keyed/pentola/engineer
	name = "locked engineer airlock"
	desc = "This door only opens when a keycard with the proper access is swiped. It looks virtually indestructible."
	access_id = "pentola_engineer"

/obj/item/key_card/pentola/engineer
	name = "Black Company mechanic's keycard"
	desc = "Opens doors in the pentola's mechanic garage. Smells of sweat and oil"
	access_id = "pentola_engineer"

/obj/machinery/door/airlock/keyed/pentola/chef
	name = "locked cold room airlock"
	desc = "This door only opens when a keycard with the proper access is swiped. It looks virtually indestructible."
	access_id = "pentola_chef"

/obj/item/key_card/pentola/chef
	name = "Black Company's service keycard."
	desc = "Opens doors in the pentola's bar and hotel. Smells of smoke and cheap beer."
	access_id = "pentola_chef"
