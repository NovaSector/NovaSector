/obj/item/domain_anchor
	name = "domain connection anchor"
	desc = "A disposable tablet with a set of programs and utilities meant to stabilize the local square meter of domain infospace for new connections to be hopefully-safe. <br>\
	In layman's terms, this creates additional bitrunning spawn points."
	icon = 'modular_nova/modules/bitrunning/icons/remote.dmi'
	icon_state = "delivery_running"

/obj/item/domain_anchor/examine(mob/user)
	. = ..()
	. += span_notice("Use in-hand to create a new spawn point.")

/obj/item/domain_anchor/attack_self(mob/user, modifiers)
	for(var/obj/machinery/quantum_server/server in SSmachines.get_machines_by_type(/obj/machinery/quantum_server))
		if(server.current_anchors >= server.max_anchors)
			user.balloon_alert(user, "bandwidth limit reached!")
			return FALSE
		server.exit_turfs += get_turf(src)
		server.retries_spent -= 1
		server.threat += 1
		server.current_anchors += 1
		var/obj/machinery/announcement_system/aas = get_announcement_system(source = server)
		if(aas)
			aas.broadcast("Potential secure datastream detected. Locking on the new spawn point.", list(RADIO_CHANNEL_SUPPLY))
	new /obj/effect/landmark/bitrunning/domain_anchor(drop_location())
	user.balloon_alert(user, "connection stabilized!")
	qdel(src)

/obj/effect/landmark/bitrunning/domain_anchor
	name = "anchored secure connection"
	desc = "Highly stable connection protocol, and consequentially a trojan, used by bitrunners during attacks on high-value targets when numbers are key and \
	just three attempts aren't enough.<br>\
	In several seconds it will merge itself with the code, becoming nigh-invisible to any means of detection."
	icon = 'icons/effects/effects.dmi'
	icon_state = "curse"
	invisibility = INVISIBILITY_NONE

/obj/effect/landmark/bitrunning/domain_anchor/Initialize(mapload)
	. = ..()
	animate(src, alpha = 0, 10 SECONDS)
	QDEL_IN(src, 10 SECONDS)
