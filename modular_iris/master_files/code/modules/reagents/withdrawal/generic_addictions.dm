//Coffee, port of https://github.com/Monkestation/Monkestation2.0/pull/5623
/datum/addiction/coffee
	name = "coffee"
	withdrawal_stage_messages = list("You feel a bit woozy...A cup of coffee would help", "You are getting rather drowsy", "Need...Coffee...")

/datum/addiction/coffee/withdrawal_enters_stage_1(mob/living/carbon/affected_carbon)
	. = ..()
	affected_carbon.apply_status_effect(/datum/status_effect/woozy)

/datum/addiction/coffee/withdrawal_enters_stage_2(mob/living/carbon/affected_carbon)
	. = ..()
	affected_carbon.apply_status_effect(/datum/status_effect/drowsiness)

/datum/addiction/coffee/withdrawal_enters_stage_3(mob/living/carbon/affected_carbon)
	. = ..()
	affected_carbon.add_actionspeed_modifier(/datum/actionspeed_modifier/stimulants)
	affected_carbon.add_movespeed_modifier(/datum/movespeed_modifier/stimulants)

/datum/addiction/coffee/end_withdrawal(mob/living/carbon/affected_carbon)
	. = ..()
	affected_carbon.remove_status_effect(/datum/status_effect/woozy)
	affected_carbon.remove_status_effect(/datum/status_effect/drowsiness)
	affected_carbon.remove_actionspeed_modifier(ACTIONSPEED_ID_STIMULANTS)
	affected_carbon.remove_movespeed_modifier(MOVESPEED_ID_STIMULANTS)
