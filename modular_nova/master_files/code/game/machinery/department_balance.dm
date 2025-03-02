/obj/machinery/status_display/department_balance
	name = "department balance display"
	desc = "A digital screen displaying the current budget."

	current_mode = SD_MESSAGE
	text_color = COLOR_DISPLAY_GREEN
	header_text_color = COLOR_DISPLAY_YELLOW

	/// The account to display balance
	var/credits_account = ""
	/// The account to display balance
	var/default_logo = "default"

	/// The resolved bank account
	var/datum/bank_account/synced_bank_account = null
	/// If the screen is actively resetting or not
	var/display_reset_state = 0

/obj/machinery/status_display/department_balance/post_machine_initialize()
	. = ..()
	start_process()
	display_reset_state = 0

/// Update the active balance of the screens to be consistent with the department's budget
/obj/machinery/status_display/department_balance/proc/update_balance(seconds_per_tick)
	current_mode = SD_MESSAGE
	switch(SSticker.current_state)
		if(GAME_STATE_STARTUP, GAME_STATE_PREGAME, GAME_STATE_SETTING_UP)
			set_messages("CASH", "", "")
			update_appearance(UPDATE_OVERLAYS)
			return

	if(display_reset_state)
		if(display_reset_state < 10) // show a generic splash screen for 5 seconds
			display_reset_state += seconds_per_tick
			current_mode = SD_PICTURE
			set_picture(default_logo)
			return
		display_reset_state = 0 // we now return to our regularly scheduled programming
		text_color = COLOR_DISPLAY_GREEN
		set_messages("CASH", " ", " ")
		update_appearance(UPDATE_OVERLAYS)
		return
	else if(!display_reset_state && SPT_PROB(0.5, seconds_per_tick)) // force a reset of the display randomly (resolves red text when power is lost)
		display_reset_state = seconds_per_tick
		text_color = COLOR_DISPLAY_GREEN
		set_messages(" ", " ", " ")
		update_appearance(UPDATE_OVERLAYS)
		return

	if(isnull(synced_bank_account))
		synced_bank_account = SSeconomy.get_dep_account(credits_account == "" ? ACCOUNT_CAR : credits_account)
	var/balance = !synced_bank_account ? 0 : synced_bank_account.account_balance
	var/balance_remainder = round((balance % 1000) / 100)
	switch(balance)
		if(99999 to INFINITY)
			text_color = COLOR_DISPLAY_GREEN
		if(74999 to 99999)
			text_color = COLOR_SLIME_GOLD
		if(49999 to 74999)
			text_color = COLOR_DISPLAY_YELLOW
		if(14999 to 49999)
			text_color = COLOR_DISPLAY_ORANGE
		if(-INFINITY to 14999)
			text_color = COLOR_DISPLAY_RED
#define BALANCE_THRESHOLD_1M 1000000
#define BALANCE_THRESHOLD_1K 1000
	/// Rounds the number to a deecimal point and sets it to its corresponding letter variable (EX: 50,251cr = 50.2K cr)
	if(balance > 999999)
		balance_remainder = round((balance % BALANCE_THRESHOLD_1M) / 100000)
		set_messages("CASH", "[round(balance / BALANCE_THRESHOLD_1M)].[balance_remainder]M", "")
	else if(balance > 99999 || balance > BALANCE_THRESHOLD_1K && balance_remainder == 0)
		set_messages("CASH", "[round(balance / BALANCE_THRESHOLD_1K)]K", "")
	else if(balance > BALANCE_THRESHOLD_1K)
		set_messages("CASH", "[round(balance / BALANCE_THRESHOLD_1K)].[balance_remainder]K", "")
	else
		set_messages("CASH", "[balance]", "")
	update_appearance(UPDATE_OVERLAYS)
#undef BALANCE_THRESHOLD_1M
#undef BALANCE_THRESHOLD_1K

/obj/machinery/status_display/department_balance/process(seconds_per_tick)
	update_balance(seconds_per_tick)

/obj/machinery/status_display/department_balance/receive_signal(datum/signal/signal)
	return

/obj/machinery/status_display/department_balance/Destroy()
	stop_process()
	return ..()

/**
 * Adds the display to the SSdigital_clock process list
 */
/obj/machinery/status_display/department_balance/proc/start_process()
	START_PROCESSING(SSdigital_clock, src)

/**
 * Removes the display to the SSdigital_clock process list
 */
/obj/machinery/status_display/department_balance/proc/stop_process()
	STOP_PROCESSING(SSdigital_clock, src)
