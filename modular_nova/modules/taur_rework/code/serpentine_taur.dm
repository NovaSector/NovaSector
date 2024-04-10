/obj/item/organ/external/taur_body/serpentine
    left_leg_name = "upper serpentine body"
    right_leg_name = "lower serpentine body"

    var/datum/action/innate/constrict/constrict_ability

/obj/item/organ/external/taur_body/serpentine/synth
    organ_flags = ORGAN_ROBOTIC

/obj/item/organ/external/taur_body/serpentine/on_mob_insert(mob/living/carbon/organ_owner, special, movement_flags)
    . = ..()
    
    constrict_ability = new /datum/action/innate/constrict(organ_owner)
    constrict_ability.Grant(organ_owner)

    /*var/obj/item/bodypart/leg/left/left_leg = organ_owner.get_bodypart(BODY_ZONE_L_LEG)
    var/obj/item/bodypart/leg/right/right_leg = organ_owner.get_bodypart(BODY_ZONE_R_LEG)

    if (left_leg)
        left_leg.wear*/

/obj/item/organ/external/taur_body/serpentine/on_mob_remove(mob/living/carbon/organ_owner, special, movement_flags)
    . = ..()
    
    QDEL_NULL(constrict_ability)
    