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

/obj/structure/mannequin/operative_barracks
	material = "plastic"
	anchored = TRUE

///
/// Guaranteed mannequins
/obj/structure/mannequin/operative_barracks/operative
	name = "operative mannequin"
	starting_items = list(
	//	/obj/item/clothing/head/costume/maidheadband/syndicate,
	//	/obj/item/clothing/under/syndicate/nova/maid,
	//	/obj/item/clothing/gloves/combat/maid,
	//	/obj/item/clothing/shoes/laceup,
		)


///
/// Wildcard mannequins
/obj/structure/mannequin/operative_barracks/wildcard
	name = "wildcard mannequin"

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

// List begins here
/obj/structure/mannequin/operative_barracks/wildcard/maid
	body_type = FEMALE
	starting_items = list(
		/obj/item/clothing/head/costume/maidheadband/syndicate,
		/obj/item/clothing/under/syndicate/nova/maid,
		/obj/item/clothing/gloves/combat/maid,
		/obj/item/clothing/shoes/laceup,
		)
