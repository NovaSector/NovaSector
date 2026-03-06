/obj/structure/sign/poster/timeclock_psa
	name = "HoP Moth - Punch out!"
	desc = "This informational sign uses HoP Moth™ reminding the viewer to do their part in the station's Enterprise Resource Planning efforts, punching out before periods of prolonged absence or leisure time."
	icon = 'modular_nova/modules/plexagon_selfserve/icons/sign.dmi'
	icon_state = "moff-clockout"
	anchored = TRUE

/obj/structure/sign/poster/timeclock_psa/Initialize(mapload)
	if(prob(4))
		name = "Punch Out!!"
		icon_state = "punch-clock"
		desc = "The informational sign for the punch clock is looking more aggressive than usual today. Better punch out before you punch shit!"
	return ..()

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/timeclock_psa, 32)
