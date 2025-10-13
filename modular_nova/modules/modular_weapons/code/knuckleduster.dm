// Knuckleduster that grants Evil Boxing while wielded

/obj/item/melee/knuckleduster
    name = "knuckleduster"
    desc = "Weighted rings for the knuckles. While wielded, you fall back on 'Evil Boxing' techniques — no rules, just results."
    icon = 'modular_nova/modules/modular_weapons/icons/obj/melee.dmi'
    icon_state = "knuckleduster"
    inhand_icon_state = "hand"
    w_class = WEIGHT_CLASS_SMALL
    obj_flags = CONDUCTS_ELECTRICITY
    hitsound = 'sound/items/weapons/punch1.ogg'
    force = 20
    throwforce = 4
    throw_speed = 3
    throw_range = 5
    attack_verb_continuous = list("clocks", "smashes", "jabs", "cracks")
    attack_verb_simple = list("clock", "smash", "jab", "crack")
    armour_penetration = 5
    wound_bonus = 10
    exposed_wound_bonus = 20
    /// Whether to apply the style gate on attack
    var/ensure_style_on_attack = TRUE
    /// Our evil boxing style instance to teach/unteach
    var/datum/martial_art/boxing/evil/given_style
    /// Track if we've announced learning to avoid spam
    var/announced_learn = FALSE
    /// Stamina-only damage dealt on RMB jab
    var/stamina_rmb_damage = 35

    /// Short helper readout for Evil Boxing tricks
    proc/show_boxing_help(mob/living/user)
        if(!istype(user))
            return
        to_chat(user, span_notice("Evil Boxing: No-rules striking and finishers."))
        to_chat(user, span_notice("- Harm punches deal stamina damage and can stagger."))
        to_chat(user, span_notice("- Target head to disorient more effectively."))
        to_chat(user, span_notice("- Watch for openings after blocks and staggers to press the advantage."))

/obj/item/melee/knuckleduster/Initialize(mapload)
    . = ..()
    given_style = new(src)
    // Listen for equip/drop so we can apply/remove style even before first attack
    RegisterSignal(src, COMSIG_ITEM_EQUIPPED, PROC_REF(knuckle_on_equipped))
    RegisterSignal(src, COMSIG_ITEM_DROPPED, PROC_REF(knuckle_on_dropped))
    // If we spawned already held by someone, simulate equipped behavior
    var/mob/living/holder = loc
    if(istype(holder))
        knuckle_on_equipped(src, holder, holder.get_slot_by_item(src))
    return .

/// Ensure Evil Boxing is applied only while this item is in the user's active hand during attacks
/obj/item/melee/knuckleduster/proc/ensure_active_hand_style(mob/living/user)
    if(!istype(user))
        return
    var/obj/item/active = user.get_active_held_item()
    if(active == src)
        if(given_style)
            given_style.teach(user)
            if(!announced_learn)
                user.balloon_alert(user, "Evil Boxing ready")
                show_boxing_help(user)
                announced_learn = TRUE
    else
        if(given_style)
            given_style.unlearn(user)
            announced_learn = FALSE

/// Signal: equipped (unique name to avoid conflicts)
/obj/item/melee/knuckleduster/proc/knuckle_on_equipped(obj/item/source, mob/user, slot)
    SIGNAL_HANDLER
    if(!istype(user))
        return
    // Only apply when in active hand
    if(user.get_active_held_item() == src)
        if(given_style)
            given_style.teach(user)
            if(!announced_learn)
                user.balloon_alert(user, "Evil Boxing ready")
                show_boxing_help(user)
                announced_learn = TRUE
    else
        if(given_style)
            given_style.unlearn(user)
            announced_learn = FALSE

/// Signal: dropped (unique name to avoid conflicts)
/obj/item/melee/knuckleduster/proc/knuckle_on_dropped(obj/item/source, mob/user)
    SIGNAL_HANDLER
    if(istype(user) && given_style)
        given_style.unlearn(user)
    announced_learn = FALSE

/// Gate style just-in-time before the swing lands
/obj/item/melee/knuckleduster/pre_attack(atom/target, mob/living/user, list/modifiers, list/attack_modifiers)
    if(ensure_style_on_attack)
        ensure_active_hand_style(user)
    return ..()

/// Right-click: stamina-only jab (no brute)
/obj/item/melee/knuckleduster/pre_attack_secondary(atom/target, mob/living/user, list/modifiers, list/attack_modifiers)
    . = ..()
    if(. != SECONDARY_ATTACK_CALL_NORMAL)
        return .
    if(!isliving(target))
        return SECONDARY_ATTACK_CALL_NORMAL
    // zero out brute on RMB chain; we'll apply stamina in afterattack
    SET_ATTACK_FORCE(attack_modifiers, 0)
    return SECONDARY_ATTACK_CONTINUE_CHAIN

/obj/item/melee/knuckleduster/afterattack(atom/target, mob/user, list/modifiers, list/attack_modifiers)
    . = ..()
    if(!isliving(target))
        return
    if(!LAZYACCESS(modifiers, RIGHT_CLICK))
        return
    var/mob/living/L = target
    L.apply_damage(stamina_rmb_damage, STAMINA)
    if(hitsound)
        playsound(src, hitsound, 50, TRUE)

/// Defensive cleanup if the item is dropped
/obj/item/melee/knuckleduster/dropped(mob/living/user)
    . = ..()
    if(istype(user) && given_style)
        given_style.unlearn(user)

/// Also cleanup on deletion
/obj/item/melee/knuckleduster/Destroy()
    var/mob/living/wearer = loc
    if(istype(wearer) && given_style)
        given_style.unlearn(wearer)
    UnregisterSignal(src, list(COMSIG_ITEM_EQUIPPED, COMSIG_ITEM_DROPPED))
    return ..()

/obj/item/melee/knuckleduster/traitor
    name = "reinforced knuckleduster"
    desc = "Reinforced knuckle-dusters for those who don't play fair. Wielding these invokes 'Evil Boxing' instincts."
    icon_state = "knuckleduster_syndie"
    force = 30
    armour_penetration = 10
    wound_bonus = 14
    exposed_wound_bonus = 25


