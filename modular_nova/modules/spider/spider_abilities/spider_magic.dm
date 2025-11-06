/*
* Spider Phantom - same same as the elephant graveyard one but tailored towards spiders. Probably will be gained upon destroying a Spider Totem
*/
/datum/brain_trauma/magic/spider
	name = "Stalking Phantom Spider"
	desc = "Patient is stalked by a phantom only they can see."
	scan_desc = "extra-sensory paranoia"
	gain_text = span_warning("You feel like something wants to kill you...")
	lose_text = span_notice("You no longer feel many eyes on your back.")
	resilience = TRAUMA_RESILIENCE_BASIC
	/// The image holder var for the very real spider
	var/obj/effect/client_image_holder/spider_phantom/spider
	/// we only want to start panicing if the spider's getting closer
	var/close_spider = FALSE //For heartbeat

/datum/brain_trauma/magic/spider/Destroy()
	QDEL_NULL(spider)
	return ..()

/datum/brain_trauma/magic/spider/on_gain()
	create_spider()
	return ..()

/// Creates the '''spider''' just off screen in a corner, breaks immersion if someone see sit POOF in after all
/datum/brain_trauma/magic/spider/proc/create_spider()
	var/turf/spider_source = locate(owner.x + pick(-12, 12), owner.y + pick(-12, 12), owner.z) //random corner
	spider = new(spider_source, owner)

/datum/brain_trauma/magic/spider/on_lose()
	QDEL_NULL(spider)
	return ..()

// we don't really care if they're dead or a ghost, only the person with the trauma can 'see' it since it's not really real.
/datum/brain_trauma/magic/spider/on_life(seconds_per_tick, times_fired)
	// Dead and unconscious people are not interesting to the ethereal spider.
	if(owner.stat != CONSCIOUS)
		return

	// Not even nullspace can keep the spider from haunting you
	if(isnull(spider) || !spider.loc || spider.z != owner.z)
		if(!QDELETED(spider))
			qdel(spider)
		create_spider()

	if(get_dist(owner, spider) <= 1)
		playsound(owner, 'sound/effects/magic/demon_attack1.ogg', 50)
		owner.visible_message(span_warning("[owner] is torn apart by invisible teeth!"), span_userdanger("Ghostly teeth tear your body apart!"))
		owner.take_bodypart_damage(rand(20, 50), wound_bonus = CANT_WOUND)
	else if(SPT_PROB(30, seconds_per_tick))
		spider.forceMove(get_step_towards(spider, owner))
	if(get_dist(owner, spider) <= 8)
		if(!close_spider)
			var/sound/slowbeat = sound('sound/effects/health/slowbeat.ogg', repeat = TRUE)
			owner.playsound_local(owner, slowbeat, 40, 0, channel = CHANNEL_HEARTBEAT, use_reverb = FALSE)
			close_spider = TRUE
	else
		if(close_spider)
			owner.stop_sound_channel(CHANNEL_HEARTBEAT)
			close_spider = FALSE
	return ..()

// the Image holder, which in this case is just a spider icon - it isn't real and cant hurt you (or can it)
/obj/effect/client_image_holder/spider_phantom
	name = "???"
	desc = "It's coming closer..."
	image_icon = 'modular_nova/modules/spider/icons/spider.dmi'
	image_state = "pepper"
