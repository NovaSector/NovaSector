/obj/item/wallframe/fireplace
	name = "fireplace frame"
	desc = "A do it yourself fireplace installation kit. What do you mean it looks like a tattoo kit? its totally different!"
	// Using the tattoo kit sprite as a placeholder, otherwise this will never be coded.
	icon_state = "tattoo_kit"
	icon = 'icons/obj/maintenance_loot.dmi'
	custom_materials = list(/datum/material/stone= SHEET_MATERIAL_AMOUNT * 7)
	result_path = /obj/structure/fireplace/nova

//We overwrite this one to make it use the reverse direction. 
/obj/item/wallframe/fireplace/after_attach(obj/object)
	object.setDir(REVERSE_DIR(object.dir))
	if (object.dir == NORTH)
		object.pixel_y = - 16 // Look, wall sprites suck, layers do shenanigans that happen from an orientation that doesnt from the other. 
	return ..()

/obj/structure/fireplace/nova
	icon = 'modular_nova/modules/aesthetics/furniture/icons/fireplace.dmi'

/obj/structure/fireplace/nova/ignite()
	START_PROCESSING(SSobj, src)
	burning_loop.start()
	lit = TRUE
	desc = "A large stone brick fireplace, warm and cozy."
	flame_expiry_timer = world.time + fuel_added
	fuel_added = 0
	update_appearance()
	adjust_light()
	var/obj/effect/abstract/shared_particle_holder/smoke_particles
	var/particles_type = /particles/smoke/burning
	var/pixelw
	var/pixelz

	switch(dir)
		if(NORTH)
			particles_type = /particles/smoke/burning/small
			pixelw = 16
			pixelz = -8
		if(SOUTH)
			pixelw = 16
			pixelz = 45
		if(EAST)
			pixelw = -4
			pixelz = 25
		if(WEST)
			pixelw = 36
			pixelz = 25

	smoke_particles = add_shared_particles(particles_type, "fireplace_[dir]")
	smoke_particles.pixel_w = pixelw
	smoke_particles.pixel_z = pixelz
