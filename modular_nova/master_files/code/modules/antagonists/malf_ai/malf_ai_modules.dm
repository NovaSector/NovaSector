/datum/action/innate/ai
	/// Typecache of areas that should not be affected by AI abilities
	var/static/protected_areas

/datum/action/innate/ai/New()
	. = ..()
	if(!protected_areas)
		protected_areas = typecacheof(GLOB.ghost_cafe_areas + typesof(/area/ruin/space/has_grav/port_tarkon) + list(/area/centcom/interlink))
