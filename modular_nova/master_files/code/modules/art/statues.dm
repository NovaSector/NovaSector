//Initializing the glow for the steles.
/obj/structure/statue/Initialize(mapload)
	. = ..()
	update_appearance(UPDATE_OVERLAYS)

//Adding the glowing runes overlay to the steles.
/obj/structure/statue/update_overlays()
	. = ..()
	. += add_statue_glow()

/obj/structure/statue/silver
	max_integrity = 50
	impressiveness = 15
	custom_materials = list(/datum/material/sandstone=SHEET_MATERIAL_AMOUNT*5)
	abstract_type = /obj/structure/statue/sandstone

/obj/structure/statue/proc/add_statue_glow() /// Will attempt to add glow to ALL statues if possible, otherwise do nothing

	return emissive_appearance(
		src.icon,
		"[icon_state]-emissive",
		src,
		alpha = src.alpha
	)

/// Smol statues

/obj/structure/statue/silver/nova/small
	name = "letter statue"
	desc = "a statue depicting a letter"
	icon = 'modular_nova/master_files/icons/obj/art/statue.dmi'
	icon_state = "statue_a"

/obj/structure/statue/silver/nova/small/b
	icon_state = "statue_b"

/obj/structure/statue/silver/nova/small/c
	icon_state = "statue_c"

/obj/structure/statue/silver/nova/small/d
	icon_state = "statue_d"

/obj/structure/statue/silver/nova/small/e
	icon_state = "statue_e"

/obj/structure/statue/silver/nova/small/f
	icon_state = "statue_f"

/obj/structure/statue/silver/nova/small/g
	icon_state = "statue_g"

/obj/structure/statue/silver/nova/small/h
	icon_state = "statue_h"

/obj/structure/statue/silver/nova/small/i
	icon_state = "statue_i"

/obj/structure/statue/silver/nova/small/j
	icon_state = "statue_j"

/obj/structure/statue/silver/nova/small/k
	icon_state = "statue_k"

/obj/structure/statue/silver/nova/small/l
	icon_state = "statue_l"

/obj/structure/statue/silver/nova/small/m
	icon_state = "statue_m"

/obj/structure/statue/silver/nova/small/n
	icon_state = "statue_n"

/obj/structure/statue/silver/nova/small/o
	icon_state = "statue_o"

/obj/structure/statue/silver/nova/small/p
	icon_state = "statue_p"

/obj/structure/statue/silver/nova/small/q
	icon_state = "statue_q"

/obj/structure/statue/silver/nova/small/r
	icon_state = "statue_r"

/obj/structure/statue/silver/nova/small/s
	icon_state = "statue_s"

/obj/structure/statue/silver/nova/small/t
	icon_state = "statue_t"

/obj/structure/statue/silver/nova/small/u
	icon_state = "statue_u"

/obj/structure/statue/silver/nova/small/v
	icon_state = "statue_v"

/obj/structure/statue/silver/nova/small/w
	icon_state = "statue_w"

/obj/structure/statue/silver/nova/small/x
	icon_state = "statue_x"

/obj/structure/statue/silver/nova/small/y
	icon_state = "statue_y"

/obj/structure/statue/silver/nova/small/z
	icon_state = "statue_z"

/obj/structure/statue/silver/nova/small/heart
	name = "heart statue"
	desc = "A small statue depicting a heart..."
	icon_state = "statue_heart"

// Large statues

/obj/structure/statue/silver/nova
	name = "statue of ancient twinss"
	desc = "A statue of twin sisters, giving life to the flame of the universe, keeping the universe alive and well kept... each ember a star, in its infinite chaos."
	icon = 'modular_nova/master_files/icons/obj/art/statuelarge.dmi'
	icon_state = "twins"

/obj/structure/statue/silver/nova/twins_light
	icon_state = "twins_light"

/obj/structure/statue/silver/nova/telekenesis
	name = "statue of telekenesis"
	desc = "A statue, depicting telekinetic behaviour... but yet it feels like your mind is being invaded by the statue..."
	icon_state = "telekenesis"

/obj/structure/statue/silver/nova/honor
	name = "Statue of the Honourbound"
	desc = "An elaborately made statue, depicting that of honour, dignity, and solitude, in which one's own honour must never be broken."
	icon_state = "honour"

/obj/structure/statue/silver/nova/honor_lights
	icon_state = "honour_light"

/obj/structure/statue/silver/nova/truelight
	name = "statue of light"
	desc = "An iron statue, made depicting darkness, but that following the light will guide you home."
	icon_state = "light_statue"

/obj/structure/statue/silver/nova/order
	name = "Statue of order"
	desc = "A statue, with a great feeling of order, and community, through unity aand order."
	icon_state = "order"

/obj/structure/statue/silver/nova/federation
	name = "Sol Federation Memorium"
	desc = "To all the soldiers, whom have fallen bravely in the line of duty protecting this beautiful galaxy..."
	icon_state = "obelisk_solfed"

/obj/structure/statue/silver/nova/obelisk
	name = "Obelisk"
	desc = "You're not sure why its here... its just a block of iron, but yet... its menacing... like a pillar... such cleanly cut... its corners looking too sharp to touch..."
	icon_state = "obelisk_base"

/obj/structure/statue/silver/nova/obelisk/dark
	icon_state = "obelisk_base_dark"

/obj/structure/statue/silver/nova/love
	name = "Statue of love"
	desc = "A faint feeling of affection and care, seems present in your mind as you look at the statue... but yet... you feel nothing..."
	icon_state = "statue_love"
