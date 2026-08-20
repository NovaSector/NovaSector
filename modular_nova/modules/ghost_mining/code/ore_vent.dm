// tm until tgstation#97854 or equivalent is merged.
// wave_cooldown is COOLDOWN_DECLARE'd, so the var never actually clears and the
// vent can never be re-scanned after a failed wave.
/obj/structure/ore_vent/initiate_wave_loss(loss_message)
	. = ..()
	COOLDOWN_RESET(src, wave_cooldown)
