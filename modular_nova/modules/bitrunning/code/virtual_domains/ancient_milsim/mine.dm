/obj/effect/mine/explosive/light/ancient_milsim
	arm_delay = 1.5 SECONDS
	light_range = 1
	light_power = 0.5
	light_color = COLOR_VIVID_RED

/obj/effect/mine/explosive/light/ancient_milsim/now_armed()
	. = ..()
	alpha = 155
	set_light_on(TRUE)

/obj/item/minespawner/ancient_milsim
	name = "deactivated low-yield stealth landmine"
	desc = "When activated, will deploy a low-yield low-visibility explosive landmine after 1.5 second passes, perfect for setting traps in tight corridors."
	icon = 'icons/obj/weapons/grenade.dmi'
	icon_state = "landmine-inactive"

	mine_type = /obj/effect/mine/explosive/light/ancient_milsim
