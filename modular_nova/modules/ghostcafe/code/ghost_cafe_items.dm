/obj/structure/showcase/fake_cafe_console
	name = "civilian console"
	desc = "A stationary computer. This one comes preloaded with generic programs."
	icon = 'icons/obj/machines/computer.dmi'
	icon_state = "computer"

/obj/structure/showcase/fake_cafe_console/rd
	name = "R&D Console"
	desc = "A console used to interface with R&D tools."

/obj/structure/showcase/fake_cafe_console/rd/Initialize(mapload)
	. = ..()
	add_overlay("rdcomp")
	add_overlay("rd_key")

// more parts. no megacells. moderate amount of cables
/obj/item/storage/part_replacer/bluespace/tier4/cafe/PopulateContents()
	for(var/i in 1 to 30)
		new /obj/item/stock_parts/servo/femto(src)
		new /obj/item/stock_parts/micro_laser/quadultra(src)
		new /obj/item/stock_parts/matter_bin/bluespace(src)
		new /obj/item/stock_parts/capacitor/quadratic(src)
		new /obj/item/stock_parts/scanning_module/triphasic(src)
		new /obj/item/stock_parts/power_store/cell/bluespace(src)
	new /obj/item/stack/cable_coil/thirty(src)

// concerningly high capacity. listen there were varedited 500u beakers but they were hard to read because they were bluespace beakers
// this is like. logical conclusion
/obj/item/reagent_containers/cup/beaker/large/cafe
	name = "quantum beaker"
	desc = "A beaker that's, inexplicably, much bigger on the inside. Can hold up to 600 units."
	possible_transfer_amounts = list(5,10,20,30,50,100,300,600)
	volume = 600

/obj/item/storage/box/beakers/cafe
	name = "box of quantum beakers"
	desc = "Don't worry, we're not sure how they hold that much either."

/obj/item/storage/box/beakers/cafe/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/reagent_containers/cup/beaker/large/cafe(src)
