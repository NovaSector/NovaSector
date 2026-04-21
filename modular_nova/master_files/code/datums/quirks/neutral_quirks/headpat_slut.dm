/// ERP-gated neutral quirk. Attaches a head-gated /datum/element/pet_bonus to the holder, so
/// being patted on the head yields a flavorful mood spike for both parties + examine hint.
/datum/quirk/headpat_slut
	name = "Headpat Slut"
	desc = "You love the feeling of others touching your head! Maybe a little too much. Others patting your head will provide a stronger mood boost, along with other sensual reactions."
	value = 0
	gain_text = span_purple("You long for the wonderful sensation of head pats!")
	lose_text = span_purple("Being pat on the head doesn't feel special anymore.")
	medical_record_text = "Patient seems abnormally responsive to being touched on the head."
	mob_trait = TRAIT_HEADPAT_SLUT
	icon = FA_ICON_HAND_HOLDING_HEART
	erp_quirk = TRUE

/datum/quirk/headpat_slut/add(client/client_source)
	// The pet_bonus parent applies `moodlet` to the PETTER, so we pass the "giver" event there;
	// the "recipient" event is applied to the pet (our slut) in the element override below.
	quirk_holder.AddElement(/datum/element/pet_bonus/headpat, "swoon", /datum/mood_event/headpat_slut/giver)
	RegisterSignal(quirk_holder, COMSIG_ATOM_EXAMINE, PROC_REF(on_examined))

/datum/quirk/headpat_slut/remove()
	quirk_holder.RemoveElement(/datum/element/pet_bonus/headpat, "swoon", /datum/mood_event/headpat_slut/giver)
	UnregisterSignal(quirk_holder, COMSIG_ATOM_EXAMINE)

/// Adds the "head could use a good patting" flavor line to anyone examining the holder.
/datum/quirk/headpat_slut/proc/on_examined(datum/source, mob/user, list/examine_list)
	SIGNAL_HANDLER
	examine_list += span_purple("[quirk_holder.p_Their()] head could use a good patting.")

/// Head-zone-gated variant of /datum/element/pet_bonus. Only fires when the petter's selected
/// body zone is the head, so chest-pokes etc. don't count as pats.
/datum/element/pet_bonus/headpat/on_attack_hand(mob/living/pet, mob/living/petter, list/modifiers)
	if(check_zone(petter.zone_selected) != BODY_ZONE_HEAD || petter == pet)
		return
	// Mirror the parent's "this pat can actually land" guards so the giver moodlet only fires
	// when the parent actually dispatched the pat.
	if(pet.stat != CONSCIOUS || petter.combat_mode || LAZYACCESS(modifiers, RIGHT_CLICK))
		return
	. = ..()
	// Parent already applied the giver moodlet to petter via the "petting_bonus" key. We also
	// give the recipient (the headpat_slut holder) their own lingering mood.
	pet.add_mood_event("headpat_recipient", /datum/mood_event/headpat_slut/recipient, petter)

/// Base mood event shared by the giver and recipient variants.
/datum/mood_event/headpat_slut
	description = span_danger("I have an invalid mood event. I should report this.")
	mood_change = 3
	timeout = 4 MINUTES

/datum/mood_event/headpat_slut/recipient
	description = span_purple("I enjoyed receiving head pats.")

/datum/mood_event/headpat_slut/recipient/add_effects(mob/giver)
	if(!giver)
		return
	description = span_purple("[giver.name] gives great head pats!")

/datum/mood_event/headpat_slut/giver
	description = span_purple("I enjoyed patting that person on the head.")

/datum/mood_event/headpat_slut/giver/add_effects(mob/recipient)
	if(!recipient)
		return
	description = span_purple("[recipient.name] was overjoyed by my touch!")
