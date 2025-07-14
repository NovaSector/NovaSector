/obj/structure/mannequin/operative_barracks
	material = "plastic"
	anchored = TRUE

/obj/structure/mannequin/operative_barracks/Initialize(mapload)
	..()
	return INITIALIZE_HINT_LATELOAD

/obj/structure/mannequin/operative_barracks/LateInitialize()
	//turn off those pesky soup sensors
	var/obj/item/clothing/under/uniform
	for(var/obj/item/clothing/clothing as anything in contents)
		if(istype(clothing, /obj/item/clothing/under))
			uniform = clothing
			break
	if(!uniform)
		return
	if(!uniform.has_sensor)
		return
	uniform.sensor_mode = NO_SENSORS

/obj/structure/mannequin/operative_barracks/wildcard

/obj/structure/mannequin/operative_barracks/wildcard/Initialize(mapload)
	/// If we are anything but the abstract type, it implies we already generated and are ready for a normal initialization
	if(type != /obj/structure/mannequin/operative_barracks/wildcard)
		return ..()
	/// Build a list of all wildcard subtypes and pick one to load
	var/wildcard_mannequins = list()
	var/picked_mannequin
	for(var/path in subtypesof(/obj/structure/mannequin/operative_barracks/wildcard))
		wildcard_mannequins += path
	picked_mannequin = pick(wildcard_mannequins)
	new picked_mannequin(loc)
	return INITIALIZE_HINT_QDEL


/*⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⡤⠤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠈⠂⢀⠉⠢⢄⠀⠀⢠⣾⡶⡾⠁⢀⣠⣠⡀
⠀⠀⠀⠀⠸⡋⠍⣉⠁⠒⠣⠤⣀⢉⠐⠄⡑⢦⡹⣿⣿⣴⣿⣿⣿⣿⠏⠀⠀⠀⣠⣴⣺⣅⡀⣀
⠀⠀⠀⠀⠀⠑⢄⠀⠈⠑⢄⠒⠂⠬⢱⡒⠬⣣⠙⢆⠸⣿⣿⣿⣿⣿⣦⠀⢀⣾⠏
⠀⠀⠀⠀⠀⠀⠈⠳⡒⠂⠠⢬⠐⠂⠠⠥⢢⣈⠑⠤⡳⡙⢿⣿⣿⣿⡿⢀⣾⡟
⠀⠀⠀⠀⠀⠀⠀⠀⠈⠲⣈⠁⠈⠀⢒⠒⠦⠤⠩⠶⢌⣳⣸⣿⣿⣡⣴⣿⠟⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⢶⣄⡉⠁⠚⠒⢒⣲⣦⣤⣶⣿⢿⣿⣿⣿⣿⡟⠁
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠛⠻⠶⠶⢿⠿⣛⠿⣫⢟⠃⡜⣿⣿⣿⣿⠃
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡠⢒⠡⡮⡪⢋⢂⠎⣤⠁⣿⣿⣿⠃⠀⠀⠀⠀⠀\
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⠣⠥⡜⡠⠑⡙⢋⣠⣧⣾⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀\⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣔⡠⠔⠓⣹⣿⣿⣿⣿⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀ ( This is a dress-up game now, the following atoms are outfits
⠀⠀⠀⠀⠀⠀⢀⣠⣶⣤⣠⣤⣤⣤⣤⣄⣀⠀⣠⣿⣿⣿⢿⡿⠀⠀⠀⠀⠀⠀⠀⠀⠀  supplied to the midround antag. There is only room for six
⠀⠀⠀⠀⠀⠴⠛⠋⠉⠉⠉⠉⠛⠛⣻⣿⣿⣿⣿⡿⠛⠁⠈⠁⠀⠀⠀⠀⠀⠀⠀⠀   mannequins, if you want to add an outfit instead of change,
⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⠀⣠⣴⣿⣿⠿⠟⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀please do so by moving an existing outfit onto the 'wildcard'
⠀⠀⠀⠀⠀⠀⠀⠀⣸⣿⠟⠋⠉							 mannequins, or consider if your new outfit would be suited
⠀⠀⠀⠀⠀⠀⠀⢰⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀  to fit on those randomly picked 'wildcard' mannequins. )
*/

///
/// Guaranteed mannequins
/obj/structure/mannequin/operative_barracks/operative
	name = "operative mannequin"
	desc = ""
	starting_items = list(

		)

///
/// Wildcard mannequins
/obj/structure/mannequin/operative_barracks/wildcard/maid
	name = "maid mannequin"
	desc = ""
	body_type = FEMALE
	starting_items = list(
		/obj/item/clothing/head/costume/maidheadband/syndicate,
		/obj/item/clothing/under/syndicate/nova/maid,
		/obj/item/clothing/gloves/combat/maid,
		/obj/item/clothing/shoes/laceup,
		)
