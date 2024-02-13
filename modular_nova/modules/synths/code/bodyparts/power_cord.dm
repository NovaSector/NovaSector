#define SYNTH_CHARGE_MAX 150
#define SYNTH_CHARGE_MIN 50
#define SYNTH_CHARGE_PER_NUTRITION 10
#define SYNTH_CHARGE_DELAY_PER_100 10
#define SYNTH_DRAW_NUTRITION_BUFFER 30
#define SYNTH_APC_MINIMUM_PERCENT 20

/obj/item/organ/internal/cyberimp/arm/power_cord
	name = "power cord implant"
	desc = "An internal power cord. Useful if you run on elecricity. Not so much otherwise."
	contents = newlist(/obj/item/apc_powercord)
	zone = "l_arm"
	cannot_confiscate = TRUE

/obj/item/apc_powercord
	name = "power cord"
	desc = "An internal power cord. Useful if you run on electricity. Not so much otherwise."
	icon = 'icons/obj/stack_objects.dmi'
	icon_state = "wire1"
	///Object basetypes which the powercord is allowed to connect to.
	var/static/list/charge_whitelist = typecacheof(list(
		/obj/item/stock_parts/cell,
		/obj/machinery/power/apc,
	))

///Connects to a power cell.
/obj/item/apc_powercord/attackby(obj/item/item, mob/living/user, params)
	if(istype(item, /obj/item/stock_parts/cell))
		power_draw(item, user)
	else
		return ..()

/obj/item/apc_powercord/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	if(!ishuman(user) || !proximity_flag || !is_type_in_typecache(target, charge_whitelist))
		return ..()
	user.changeNext_move(CLICK_CD_MELEE)
	power_draw(target, user)

/obj/item/apc_powercord/proc/power_draw(obj/target, mob/living/carbon/human/user)
	var/obj/item/stock_parts/cell/target_cell
	var/obj/machinery/power/apc/target_apc

	if(istype(target, /obj/machinery/power/apc))
		target_apc = target
		target_cell = target_apc.cell
	else
		target_cell = target

	if(target_apc && !target_cell)
		to_chat(user, span_warning("[target] has no charge to draw from."))
		return
		
	var/mob/living/carbon/human/ipc = user
	var/obj/item/organ/internal/stomach/synth/synth_cell = ipc.organs_slot[ORGAN_SLOT_STOMACH]

	if(!synth_cell)
		to_chat(ipc, span_warning("You try to siphon energy from the [target], but you have no stomach! How are you still standing?"))
		return

	if(!istype(synth_cell))
		to_chat(ipc, span_warning("You plug into the [target], but nothing happens! It seems you don't have a cell to charge!"))
		return

	if(target_cell.percent() < SYNTH_APC_MINIMUM_PERCENT)
		to_chat(user, span_warning("[target] has no charge to draw from."))
		return

	if(ipc.nutrition >= NUTRITION_LEVEL_ALMOST_FULL)
		to_chat(user, span_warning("You are already fully charged!"))
		return

	user.visible_message(span_notice("[user] inserts a power connector into the [target]."), span_notice("You begin to draw power from the [target]."))
	powerdraw_loop(target_cell, ipc)
	user.visible_message(span_notice("[user] unplugs from the [target]."), span_notice("You unplug from the [target]."))

	if(target_apc && target_apc.main_status <= APC_HAS_POWER)
		target_apc.charging = APC_CHARGING
		target_apc.update_appearance()

/**
 * Runs a loop to charge a synth cell (stomach) via powercord from a APC or power cell.
 *
 * Stops when:
 * - The user's internal cell is full.
 * - The APC or cell has less than 20% charge.
 * - The APC has machine power turned off.
 * - The APC is unable to provide charge for any other reason.
 * - The user moves, or anything else that can happen to interrupt a do_after.
 *
 * Arguments:
 * * target_apc - The APC to drain.
 * * user - The carbon draining the APC.
 */
/obj/item/apc_powercord/proc/powerdraw_loop(obj/item/stock_parts/cell/target_cell, mob/living/carbon/human/user)
	var/power_needed
	var/power_delay
	var/power_use
	while(TRUE)
		if(QDELETED(target_cell))
			return

		// Check if the user is "fully charged" yet.
		// Ensures minimum draw is always lower than this margin to prevent wasteful loops.
		power_needed = NUTRITION_LEVEL_ALMOST_FULL - user.nutrition
		if(power_needed <= SYNTH_CHARGE_MIN * 2)
			to_chat(user, span_notice("You are fully charged."))
			break

		// Check if the charge level of the cell is low.
		// 20%, to prevent synths from overstepping and murdering power for department machines and potentially doors.
		if(target_cell.percent() < SYNTH_APC_MINIMUM_PERCENT)
			to_chat(user, span_warning("[target_cell]'s power is too low to charge you."))
			break

		// Calculate how much to draw from the cell this cycle.
		power_use = clamp(power_needed, SYNTH_CHARGE_MIN, SYNTH_CHARGE_MAX)
		power_use = clamp(power_use, 0, target_cell.charge)
		if(power_use <= 0)
			to_chat(user, span_warning("[target_cell] lacks the power to charge you."))
			break

		// Drain charge from the cell, increase user nutrition, and emit sparks.
		do_after(user, power_delay, target_cell)
		target_cell.use(power_use)
		user.nutrition += power_use / SYNTH_CHARGE_PER_NUTRITION
		do_sparks(1, FALSE, target_cell.loc)

		power_delay = (power_use / 100) * SYNTH_CHARGE_DELAY_PER_100

#undef SYNTH_CHARGE_MAX
#undef SYNTH_CHARGE_MIN
#undef SYNTH_CHARGE_PER_NUTRITION
#undef SYNTH_CHARGE_DELAY_PER_100
