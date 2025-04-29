/**
 * RGB Benches
 *
 * greyscale_colors. Set this to what you want in the
 * base color path of your choosing, then duplicate
 * the children with pathing adjusted accordingly.
 * If it's for a ruin or ghost role, try to create a
 * parent folder so mapping is easier.
 * See /Interdyne/IceMoonBlue for an example!
 */

//Default
/obj/structure/chair/sofa/bench/color
	name = "bench"
	desc = "Perfectly designed to be comfortable to sit on, and hellish to sleep on."
	icon_state = "bench_middle"
	greyscale_config = /datum/greyscale_config/bench_middle
	greyscale_colors = "#FFFFFF"

// Icemoon Blue sofa (Used on \_maps\RandomRuins\IceRuins\nova\icemoon_underground_interdyne_base1.dmm)
/obj/structure/chair/sofa/bench/color/Interdyne/IceMoonBlue
	greyscale_colors = "#263188"

/obj/structure/chair/sofa/bench/color/interdyne/icemoon_blue/left
	icon_state = "bench_left"
	greyscale_config = /datum/greyscale_config/bench_left

/obj/structure/chair/sofa/bench/color/interdyne/icemoon_blue/right
	icon_state = "bench_right"
	greyscale_config = /datum/greyscale_config/bench_right

/obj/structure/chair/sofa/bench/color/interdyne/icemoon_blue/corner
	icon_state = "bench_corner"
	greyscale_config = /datum/greyscale_config/bench_corner

/obj/structure/chair/sofa/bench/color/interdyne/icemoon_blue/solo
	icon_state = "bench_solo"
	greyscale_config = /datum/greyscale_config/bench_solo
