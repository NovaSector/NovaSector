/mob/living/basic/drone/handmade
	name = "maintanse drone shell"
	shy = FALSE
	default_storage = null
	desc = "drone shell"
	icon = 'modular_regzt/icons/mob/drone.dmi'
	icon_state = "drone_handmade"
	health = 40
	maxHealth = 40
	picked = TRUE
	hud_type = /datum/hud/dextrous/drone
	hud_possible = list(DIAG_STAT_HUD, DIAG_HUD)

	var/obj/item/mmi/mmi = null
	var/obj/item/card/id/internal_id

/mob/living/basic/drone/handmade/Initialize(mapload)
	// 1. Создаем карту сразу
	internal_id = new /obj/item/card/id(src)
	internal_id.registered_name = name
	internal_id.assignment = "Maintenance Drone"

	. = ..()

	// 2. Очищаем старые доступы, которые выдал родитель /mob/living/basic/drone
	// Родитель выдает REGION_ALL_GLOBAL по умолчанию [cite: 16]
	var/datum/component/simple_access/SA = GetComponent(/datum/component/simple_access)
	if(SA)
		qdel(SA)

	// 3. Устанавливаем нашу карту как единственный источник доступа
	AddComponent(/datum/component/simple_access, internal_id)

	// 4. Удаляем трейт кремниевого доступа, который дает врожденные права [cite: 18]
	REMOVE_TRAIT(src, TRAIT_SILICON_ACCESS, INNATE_TRAIT)

/mob/living/basic/drone/handmade/attackby(obj/item/I, mob/user, params)
	// Копирование ID карты
	if(istype(I, /obj/item/card/id))
		var/obj/item/card/id/target_card = I
		if(internal_id)
			// ПОЛНАЯ ЗАМЕНА: используем Copy() для очистки старых прав
			internal_id.access = target_card.access.Copy()
			internal_id.assignment = target_card.assignment

			to_chat(user, span_notice("Вы синхронизировали [I] с [src]. Старые доступы удалены."))
			to_chat(src, span_notice("Ваш доступ перезаписан: [target_card.assignment]."))
			return TRUE

	// Вставка MMI (логика из rjl.txt) [cite: 4]
	if(istype(I, /obj/item/mmi))
		if(mmi)
			to_chat(user, span_warning("[src] already has an MMI!"))
			return TRUE
		var/obj/item/mmi/new_mmi = I
		if(!new_mmi.brainmob?.mind)
			to_chat(user, span_warning("[I] has no mind!"))
			return TRUE

		user.transferItemToLoc(I, src)
		mmi = new_mmi
		if(client)
			client.mob = null
		new_mmi.brainmob.mind.transfer_to(src)
		update_diag_hud()
		return TRUE

	// Снятие ломом [cite: 4]
	if(istype(I, /obj/item/crowbar) && mmi)
		to_chat(user, span_notice("You start removing the MMI..."))
		if(do_after(user, 3 SECONDS, src))
			remove_mmi(user)
		return TRUE

	return ..()

/mob/living/basic/drone/handmade/proc/remove_mmi(mob/user)
	if(!mmi) return FALSE
	if(mind && mmi.brainmob)
		mind.transfer_to(mmi.brainmob)
	mmi.forceMove(get_turf(src))
	if(user)
		user.put_in_hands(mmi)
	mmi = null
	return TRUE

/mob/living/basic/drone/handmade/death(gibbed)
	if(mmi)
		mmi.forceMove(get_turf(src))
		if(mind && mmi.brainmob)
			mind.transfer_to(mmi.brainmob)
		mmi = null
	return ..()

/mob/living/basic/drone/handmade/proc/update_diag_hud()
	var/datum/atom_hud/data/diagnostic/diag_hud = GLOB.huds[DATA_HUD_DIAGNOSTIC]
	diag_hud.add_atom_to_hud(src)
