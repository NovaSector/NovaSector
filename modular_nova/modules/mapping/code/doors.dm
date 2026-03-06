// Special door stuff, not airlock related

/obj/machinery/door/poddoor/shuttledock/interlink
	checkdir = SOUTH // NuInterlink has these set where space is SOUTH, subtyping in the event we need to use CC

/obj/machinery/door/poddoor/shutters/window/indestructible/roundend

/obj/machinery/door/poddoor/shutters/window/indestructible/roundend/Initialize(mapload)
	. = ..()
	RegisterSignal(SSticker, COMSIG_TICKER_ROUND_ENDED, PROC_REF(game_ended))

/obj/machinery/door/poddoor/shutters/window/indestructible/roundend/proc/game_ended()
	SIGNAL_HANDLER
	INVOKE_ASYNC(src, PROC_REF(open))
