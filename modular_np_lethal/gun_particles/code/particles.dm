/particles/firing_smoke
	icon = 'modular_np_lethal/gun_particles/icons/firesmoke.dmi'
	icon_state = "smoke5"
	width = 500
	height = 500
	count = 5
	spawning = 15
	lifespan = 0.5 SECONDS
	fade = 2.4 SECONDS
	grow = 0.12
	drift = generator(GEN_CIRCLE, 8, 8)
	scale = 0.1
	spin = generator(GEN_NUM, -20, 20)
	velocity = list(50, 0)
	friction = generator(GEN_NUM, 0.3, 0.6)

/obj/effect/muzzle_flash
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	icon = 'modular_np_lethal/gun_particles/icons/muzzle_flash.dmi'
	icon_state = "muzzle_flash"
	layer = ABOVE_ALL_MOB_LAYER
	plane = GAME_PLANE
	appearance_flags = KEEP_APART|TILE_BOUND|NO_CLIENT_COLOR
	var/applied = FALSE


/obj/effect/muzzle_flash/Initialize(mapload, new_icon_state)
	. = ..()
	if(new_icon_state)
		icon_state = new_icon_state
