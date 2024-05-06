/mob/living/carbon/human/can_piggyback(mob/living/carbon/target)
    . = ..()
    if (!.)
        return FALSE

    if (!ishuman(target))
        return TRUE

    var/mob/living/carbon/human/human_target = target

    var/obj/item/organ/external/taur_body/taur_body = locate(/obj/item/organ/external/taur_body) in organs
    var/obj/item/organ/external/taur_body/other_taur_body = locate(/obj/item/organ/external/taur_body) in human_target.organs

    if (isnull(taur_body) || isnull(other_taur_body))
        return TRUE

    if (!taur_body.can_piggyback_taurs && !other_taur_body.can_piggyback_taurs) // no stacking, sorry
        return FALSE

    return TRUE
