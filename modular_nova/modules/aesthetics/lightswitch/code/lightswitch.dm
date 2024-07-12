/obj/machinery/light_switch
	icon = 'modular_nova/modules/aesthetics/lightswitch/icons/lightswitch.dmi'

/obj/machinery/light_switch/interact(mob/user)
	. = ..()
	playsound(src, 'modular_nova/modules/aesthetics/lightswitch/sound/lightswitch.ogg', 100, 1)

#ifndef UNIT_TESTS
/obj/machinery/light_switch/post_machine_initialize()
	. = ..()
	if(prob(50) && area.lightswitch) //50% chance for area to start with lights off.
		turn_off()
#endif

/obj/machinery/light_switch/proc/turn_off()
	if(!area.lightswitch)
		return
	area.lightswitch = FALSE
	area.update_appearance()

	for(var/obj/machinery/light_switch/light_switch as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/light_switch))
		if(light_switch.area != area)
			continue
		light_switch.update_appearance()
		SEND_SIGNAL(light_switch, COMSIG_LIGHT_SWITCH_SET, FALSE)

	area.power_change()
