/obj/item/summoning_flute
	name = "summoning flute (Mega Arachnid)"
	desc = "A flute which calls out to the spirit of a vanquished fauna when played. The tune of this one will attract a Mega Arachnid."
	icon = 'icons/obj/art/musician.dmi'
	icon_state = "recorder"
	var/summoned_mega = /mob/living/basic/mega_arachnid
	custom_materials = list(/datum/material/bone = SHEET_MATERIAL_AMOUNT * 2.1)

/obj/item/summoning_flute/examine(mob/user)
	. = ..()
	if(HAS_TRAIT(user, TRAIT_NOBREATH))
		. += span_notice("You seem to be able to play it without breathing, how neat!")

/obj/item/summoning_flute/attack_self(mob/user, modifiers)
	. = ..()
	if(do_after(user, 3 SECONDS, src))
		var/list/ice_megas = list(
			/mob/living/simple_animal/hostile/megafauna/dragon,
			/mob/living/simple_animal/hostile/megafauna/wendigo,
			/mob/living/simple_animal/hostile/megafauna/clockwork_defender,
			/mob/living/simple_animal/hostile/megafauna/demonic_frost_miner,
			/mob/living/basic/boss/thing
		)
		if(!is_mining_level(user.z) || ((summoned_mega in ice_megas) && !(user.z == 2)))
			to_chat(user, span_warning("In this environment, the flute produces no sound."))
			return
		to_chat(user, span_userdanger("A terrifying rumbling portends the arrival of the summoned one..."))
		var/turf/spawn_location = get_turf(src)
		new /obj/effect/temp_visual/dragon_swoop/spawn_marker(spawn_location)
		sleep(2 SECONDS)
		var/mob/living/our_mega = new summoned_mega(spawn_location)
		our_mega.visible_message(span_userdanger("From a swirling, warping, vortex of spacetime, [our_mega] emerges, born anew!"))
		message_admins("[our_mega] respawned at [ADMIN_VERBOSEJMP(spawn_location)] by [ADMIN_LOOKUPFLW(user)].")
		log_game("[our_mega] respawned at [AREACOORD(spawn_location)] by [user] / [user.ckey].")
		to_chat(user, span_warning("With its magic spent, [src] crumbles into dust."))
		qdel(src)

/obj/item/summoning_flute/drake
	name = "summoning flute (Ash Drake)"
	desc = "A flute which calls out to the spirit of a vanquished fauna when played. The tune of this one will attract an Ash Drake."
	summoned_mega = /mob/living/simple_animal/hostile/megafauna/dragon

/obj/item/summoning_flute/bubblegum
	name = "summoning flute (Bubblegum)"
	desc = "A flute which calls out to the spirit of a vanquished fauna when played. The tune of this one will attract Bubblegum."
	summoned_mega = /mob/living/simple_animal/hostile/megafauna/bubblegum

/obj/item/summoning_flute/hierophant
	name = "summoning flute (Hierophant)"
	desc = "A flute which calls out to the spirit of a vanquished fauna when played. The tune of this one will attract the Hierophant."
	summoned_mega = /mob/living/simple_animal/hostile/megafauna/hierophant

/obj/item/summoning_flute/colossus
	name = "summoning flute (Colossus)"
	desc = "A flute which calls out to the spirit of a vanquished fauna when played. The tune of this one will attract a Colossus."
	summoned_mega = /mob/living/simple_animal/hostile/megafauna/colossus

/obj/item/summoning_flute/blood_drunk_miner
	name = "summoning flute (Blood-Drunk Miner)"
	desc = "A flute which calls out to the spirit of a vanquished fauna when played. The tune of this one will attract the Blood-Drunk Miner."
	summoned_mega = /mob/living/basic/boss/blood_drunk_miner

/obj/item/summoning_flute/legion
	name = "summoning flute (Legion)"
	desc = "A flute which calls out to the spirit of a vanquished fauna when played. The tune of this one will attract Legion."
	summoned_mega = /mob/living/simple_animal/hostile/megafauna/legion

/obj/item/summoning_flute/the_marked_one
	name = "summoning flute (The Marked One)"
	desc = "A flute which calls out to the spirit of a vanquished fauna when played. The tune of this one will attract The Marked One."
	summoned_mega = /mob/living/simple_animal/hostile/megafauna/gladiator

/obj/item/summoning_flute/wendigo
	name = "summoning flute (Wendigo)"
	desc = "A flute which calls out to the spirit of a vanquished fauna when played. The tune of this one will attract a Wendigo."
	summoned_mega = /mob/living/simple_animal/hostile/megafauna/wendigo

/obj/item/summoning_flute/clockwork_defender
	name = "summoning flute (Clockwork Defender)"
	desc = "A flute which calls out to the spirit of a vanquished fauna when played. The tune of this one will attract a Clockwork Defender."
	summoned_mega = /mob/living/simple_animal/hostile/megafauna/clockwork_defender

/obj/item/summoning_flute/demonic_frost_miner
	name = "summoning flute (Demonic-Frost Miner)"
	desc = "A flute which calls out to the spirit of a vanquished fauna when played. The tune of this one will attract the Demonic-Frost Miner."
	summoned_mega = /mob/living/simple_animal/hostile/megafauna/demonic_frost_miner

/obj/item/summoning_flute/the_thing
	name = "summoning flute (The Thing)"
	desc = "A flute which calls out to the spirit of a vanquished fauna when played. The tune of this one will attract The Thing."
	summoned_mega = /mob/living/basic/boss/thing
