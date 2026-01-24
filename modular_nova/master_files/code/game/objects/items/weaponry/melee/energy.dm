// at the time of balancing this, chance was 75 and pain mult 10, but it was not taking Huge weight class into account.
/datum/embedding/esword/surplus
	embed_chance = 50
	impact_pain_mult = 5

/obj/item/melee/energy/sword/surplus
	embed_type = /datum/embedding/esword/surplus

/obj/item/melee/energy/sword/surplus/improvised
	name = "\improper Pattern I/H 'Bokuto' energy sword" // type I/Handmade
	desc = "A handmade energy sword, used for live training and pest control, modeled after the infamous Type I 'Iaito'. It can be recharged with the dynamos in the handle."
	block_chance = 25 // Surplus is 50
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 3.25, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 0.37)

/obj/item/melee/energy/sword/surplus/improvised/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/examine_lore, \
		lore_hint = span_notice("You can [EXAMINE_HINT("look closer")] to learn a little more about [src]."), \
		lore = "Cobbled-together energy swords like this can be found across the frontier in the hands of... a lot of people, really. \
			From ne'er-do-wells to enthusiasts and everything in between, the ease of acquiring parts means that anyone with a semblance of \
			craftsmanship can make something that works as a sword.<br>\
			<br>\
			When handmade energy swords are patterened after earlier energy swords such as the Pattern I 'Iaito', they're typically designated with \
			the H suffix to denote the circumstances of their manufacture and given a different nickname. \
			Typically, for Iaito-likes, the designation of choice is the 'Bokuto'. \
			While remarkably similar to recovered Iaitos, thanks to the designs for homemade prototypes having long been leaked to the exonet, \
			they're noted as being a little more unwieldy, making them perform less well in regards to blocking attacks. \
			Much like their parent design, examples of the Bokuto are typically found in the hands of various \
			grunts, mooks, goons, criminals, wannabe assassins, lunatics, or those otherwise embroiled in a desperate struggle. \
			If you're actually trying to kill someone with this sword, you may or may not fit into one or more of those categories.", \
	)
