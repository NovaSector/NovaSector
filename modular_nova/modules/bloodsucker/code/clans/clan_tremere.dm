/datum/bloodsucker_clade/tremere
	name = CLADE_HEMOKINETIC
	description = "Clade Hemokinetic develops a dense external vascular network, enabling direct blood manipulation. \n\
		The symbiont's deep circulatory integration makes you violently reactive to concentrated faith-based neurotoxins -- \n\
		the Chapel's atmosphere will burn you. \n\
		Your adaptations are unique: Blood Lance, Sanguine Blink, and Neural Override -- each upgradeable through ranks. \n\
		Creating Thralls deepens the symbiont's network, granting additional ranks. \n\
		The Bonded Thrall develops a Chiropteran Shift -- a temporary bat-like morphological transformation."
	clan_objective = /datum/objective/bloodsucker/tremere_power
	join_icon_state = "tremere"
	join_description = "Burns in the Chapel. Lose all default adaptations, \
		but gain Hemokinetic powers that upgrade with each rank."
	buy_power_flags = HEMOKINETIC_CAN_BUY|CAN_BUY_OWNED

/datum/bloodsucker_clade/tremere/New(mob/living/carbon/user)
	. = ..()
	bloodsuckerdatum.remove_nondefault_powers(return_levels = TRUE)
	for(var/datum/action/cooldown/bloodsucker/power as anything in bloodsuckerdatum.all_bloodsucker_powers)
		if((initial(power.purchase_flags) & buy_power_flags) && initial(power.level_current) == 1)
			bloodsuckerdatum.BuyPower(power)

/datum/bloodsucker_clade/tremere/Destroy(force)
	for(var/datum/action/cooldown/bloodsucker/power in bloodsuckerdatum.powers)
		if(power.purchase_flags & buy_power_flags)
			bloodsuckerdatum.RemovePower(power)
	return ..()

/datum/bloodsucker_clade/tremere/handle_clan_life(datum/antagonist/bloodsucker/source, seconds_per_tick, times_fired)
	. = ..()
	var/area/current_area = get_area(bloodsuckerdatum.owner.current)
	if(istype(current_area, /area/station/service/chapel))
		to_chat(bloodsuckerdatum.owner.current, span_warning("The Chapel's atmosphere triggers a violent reaction in your vascular network! You're burning!"))
		bloodsuckerdatum.owner.current.adjust_fire_loss(10)
		bloodsuckerdatum.owner.current.adjust_fire_stacks(2)
		bloodsuckerdatum.owner.current.ignite_mob()

/datum/bloodsucker_clade/tremere/level_up_powers(datum/antagonist/bloodsucker/source)
	return

/datum/bloodsucker_clade/tremere/level_message(power_name)
	var/mob/living/carbon/human/human_user = bloodsuckerdatum.owner.current
	human_user.balloon_alert(human_user, "upgraded [power_name]!")
	to_chat(human_user, span_notice("The symbiont's vascular network has evolved -- [power_name] has been upgraded!"))

// redefine the default args
/datum/bloodsucker_clade/tremere/list_available_powers(already_known, powers_list)
	already_known = list()
	powers_list = bloodsuckerdatum.powers
	return ..()

/datum/bloodsucker_clade/tremere/purchase_choice(datum/antagonist/bloodsucker/source, datum/action/cooldown/bloodsucker/purchased_power)
	return purchased_power.upgrade_power()

/datum/bloodsucker_clade/tremere/favorite_ghoul_gain(datum/antagonist/bloodsucker/source, datum/antagonist/ghoul/ghouldatum)
	var/datum/action/cooldown/spell/shapeshift/bat/batform = new(ghouldatum.owner || ghouldatum.owner.current)
	batform.Grant(ghouldatum.owner.current)

/datum/bloodsucker_clade/tremere/favorite_ghoul_loss(datum/antagonist/bloodsucker/source, datum/antagonist/ghoul/ghouldatum)
	var/datum/action/cooldown/spell/shapeshift/bat/batform = locate() in ghouldatum.owner.current.actions
	batform.Remove(ghouldatum.owner.current)

/datum/bloodsucker_clade/tremere/on_ghoul_made(datum/antagonist/bloodsucker/source, mob/living/user, mob/living/target)
	. = ..()
	to_chat(bloodsuckerdatum.owner.current, span_danger("Creating a Thrall has expanded your vascular network. You have gained an additional Rank!"))
	bloodsuckerdatum.AdjustUnspentRank(1)
