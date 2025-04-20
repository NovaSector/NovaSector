/obj/item/implanter
	icon = 'modular_nova/modules/aesthetics/implanter/implanter.dmi'

/obj/item/implantpad
	icon = 'modular_nova/modules/aesthetics/implanter/implanter.dmi'

/obj/item/implantcase
	icon = 'modular_nova/modules/aesthetics/implanter/implanter.dmi'

 //Code to make the breathing tube aug_overlay toggleable
/obj/item/organ/cyberimp/mouth/breathing_tube/examine()
	. = ..()
	. += span_info("It will currently be [aug_overlay ? "physicially visible" : "practically invisible"] upon installation. \
	This could be changed by using a [EXAMINE_HINT("screwdriver")].")

/obj/item/organ/cyberimp/mouth/breathing_tube/screwdriver_act(mob/living/user, obj/item/tool)
	. = ..()
	if(!aug_overlay)
		name = "breathing tube implant"
		aug_overlay = "breathing_tube"
	else
		name = "integrated breathing tube implant"
		aug_overlay = null

//And a preset for the loadout
/obj/item/organ/cyberimp/mouth/breathing_tube/hidden
	name = "integrated breathing tube implant"
	aug_overlay = null
