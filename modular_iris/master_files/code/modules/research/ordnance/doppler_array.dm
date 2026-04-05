// A subtype that only accepts explosions from TTV's
/obj/machinery/doppler_array/tank_only
	name = "fine-tuned tachyon-doppler array"

/obj/machinery/doppler_array/tank_only/examine(mob/user)
	. = ..()
	. += span_notice("Due to the fine-tuning this one won't pickup non-tank explosions, if it were to get destroyed you probably couldn't re-tune it.")

/obj/machinery/doppler_array/tank_only/sense_explosion(datum/source, turf/epicenter, devastation_range, heavy_impact_range, light_impact_range,
			took, orig_dev_range, orig_heavy_range, orig_light_range, explosion_cause, explosion_index)
	if(!istype(explosion_cause, /obj/item/tank))
		return FALSE

	return ..()
