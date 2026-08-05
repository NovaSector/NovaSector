GLOBAL_VAR_INIT(ipod_last_upload, 0) //last time of the last upload, to prevent multiple uploads within seconds of eachother
GLOBAL_VAR_INIT(ipod_last_play, 0) //last time of the last played track, to prevent spamming clients too often with play/stop

/obj/item/clothing/ears/ipod
	name = "\improper iZune Spaceman Headphones"
	desc = "An aftermarket Nanotrasen personal portable music player. This thing supports MP3 and OGG file playback, rad!"
	icon = 'modular_nova/master_files/icons/obj/clothing/accessories.dmi'
	worn_icon = 'modular_nova/master_files/icons/mob/clothing/ears.dmi'
	icon_state = "ipod"
	inhand_icon_state = "headphones"
	worn_icon_state = "ipod"
	slot_flags = ITEM_SLOT_EARS | ITEM_SLOT_HEAD | ITEM_SLOT_NECK //Fluff item, put it whereever you want!
	actions_types = list(/datum/action/item_action/upload_ipod, /datum/action/item_action/toggle_ipod)
	custom_price = PAYCHECK_CREW * 10

	/// The current file path
	var/curfile = null
	/// User is currently picking a file to upload
	var/upload_active = FALSE
	/// Playing state
	var/playing = FALSE
	/// Volume
	var/volume = 50
	/// Time of the last upload
	var/lastfilechange = 0
	/// Time of the last upload attempt
	var/uploadattempt  = 0
	/// Currently worn
	var/is_worn = FALSE
	/// Currently got callback on mob wearer death
	var/is_registered_on_death = FALSE
	/// Shared listening mode
	var/datum/weakref/other_ipod_ref = null
	/// What actually plays music to us
	var/datum/jukebox/single_mob/music_player
	/// Current song track selected
	VAR_FINAL/datum/track/current_song = null

/obj/item/clothing/ears/ipod/Initialize(mapload)
	. = ..()
	update_icon()
	AddElement(/datum/element/update_icon_updates_onmob)
	music_player = new(src)
	music_player.set_new_volume(volume)

/obj/item/clothing/ears/ipod/Destroy()
	if(playing && !isnull(music_player.active_song_sound))
		music_player.unlisten_all()
	playing = FALSE
	is_worn = FALSE
	curfile = null
	is_registered_on_death = FALSE
	if(current_song)
		QDEL_NULL(current_song)
	stop_other_headphones(TRUE)
	QDEL_NULL(music_player)
	return ..()

/obj/item/clothing/ears/ipod/update_icon_state()
	. = ..()
	if(other_ipod_ref)
		icon_state = "ipod_sync"
	else
		icon_state = "[initial(icon_state)]"

/obj/item/clothing/ears/ipod/examine(mob/user)
	. = ..()
	if(other_ipod_ref)
		. += "This headphone is in shared listening mode."
		. += "Ctrl click to unlink."
	else
		. += "Tapping this on another headphone will set both to shared listening mode."
	. += "Alt click to set the volume."

/obj/item/clothing/ears/ipod/proc/upload(mob/living/owner)
	if(!istype(owner)) // this should never happen... but doesn't hurt to check
		return
	var/mob/living/user = owner
	if(user.stat != STABLE)
		to_chat(user, span_warning("You can't do that right now."))
		return
	if(loc != user) // headphones no longer on mob, abort
		return
	if(!user.ckey)
		return
	if(lastfilechange)
		if(world.time < lastfilechange + 2 MINUTES)
			to_chat(user, span_warning("You've uploaded a new track too recently, try again later!"))
			return
	if(world.time < uploadattempt + 10 SECONDS) // automatically cancel any attempt to reattempt an upload in less than 10 seconds
		to_chat(user, span_warning("Please wait while attempting to reupload."))
		return
	if(playing)
		to_chat(user, span_warning("You must first stop playing to track to upload a new track."))
		return
	if(upload_active)
		return

	uploadattempt = world.time
	upload_active = TRUE
	playsound(loc, 'sound/misc/menu/ui_select1.ogg', 100, FALSE, -1)
	INVOKE_ASYNC(src, PROC_REF(upload_file), user) // call as thread to avoid halting while waiting for user file input

/obj/item/clothing/ears/ipod/proc/upload_file(mob/living/user)
	set waitfor = FALSE
	var/infile = input(user, "CHOOSE A NEW SONG", src) as null|file
	if(QDELETED(src)) // yes, this thread will continue to exist even if headphones are destroyed, so catch it here
		return
	upload_active = FALSE
	if(QDELETED(user)) // somehow the user was destroyed, abort
		return

	if(loc != user) // headphones no longer on mob, abort
		return
	if(!is_worn)
		return
	if(playing)
		return
	if(world.time > uploadattempt + 30 SECONDS) // automatically cancel any attempt to upload if taken more than 30 seconds
		to_chat(user, span_warning("Your connect was timed out, try uploading again!"))
		return
	if(world.time < GLOB.ipod_last_upload + 30 SECONDS)
		to_chat(user, span_warning("Another user has uploaded a new track recently, try again soon!"))
		return
	if(isnull(infile)) // sometimes this fails, thank you BYOND
		to_chat(user, span_warning("Error, could not upload."))
		return
	if(length("[infile]") < length("a.ogg")) // minimum supported filename
		to_chat(user, span_warning("Error, filename too short."))
		return
	if(length("[infile]") > 256) // maximum supported filename
		to_chat(user, span_warning("Error, filename too long."))
		return
	var/file_extension = LOWER_TEXT(copytext("[infile]", -4))
	if(!(file_extension == ".ogg" || file_extension == ".mp3"))
		to_chat(user, span_warning("File type must be OGG or MP3: [infile]"))
		return
	var/filelength = length(infile)
	if(filelength > 6485760)
		to_chat(user, span_warning("Error: Too big, 6MB or less!"))
		return
	if(filelength < 4096)
		to_chat(user, span_warning("Error: Not a valid OOG or MP3!"))
		return

	GLOB.ipod_last_upload = world.time
	var/real_round_time = world.timeofday - SSticker.real_round_start_time
	var/logged_filename = "tmp/ipodupload/round-[GLOB.round_id ? GLOB.round_id : "NULL"]/[user.ckey[1]]/[user.ckey]/[time2text(real_round_time, "hh_mm_ss", 0)][file_extension]"
	if(fexists(logged_filename))
		fdel(logged_filename)
	if(!fcopy(infile, logged_filename))
		to_chat(user, span_warning("Could not upload song."))
		return
	if(QDELETED(user) || QDELETED(src)) // clean up uploaded file if object/user was deleted while upload was in progress
		if(fexists(logged_filename))
			fdel(logged_filename)
		return

	lastfilechange = world.time
	var/uploaded_song = file(logged_filename)
	if(!uploaded_song || !fexists(uploaded_song))
		to_chat(user, span_warning("Upload failed to finish, aborting!"))
		user.log_message("attempted to upload a song: [logged_filename]", LOG_GAME)
		return
	if(length(uploaded_song) != filelength)
		to_chat(user, span_warning("Upload failed to finish, aborting!"))
		user.log_message("attempted to upload a song: [logged_filename]", LOG_GAME)
		fdel(logged_filename)
		return
	var/sound_length = SSsounds.get_sound_length(uploaded_song) // this uses the rust-g library to check if file is valid
	if(isnull(sound_length) || sound_length <= 20) // either an invalid file or 2 seconds or less, abort
		to_chat(user, span_warning("The song codec was invalid, aborting!"))
		user.log_message("uploaded an invalid song: [logged_filename]", LOG_GAME)
		fdel(logged_filename)
		return
	if(loc != user) // headphones no longer on mob, abort
		fdel(logged_filename)
		return

	playsound(loc, 'sound/misc/escape_menu/esc_close.ogg', 100, FALSE, -1)
	to_chat(user, span_warning("The song has been uploaded, ready to play!"))
	user.log_message("uploaded a song to headphones: [logged_filename]", LOG_GAME)

	if(playing && !isnull(music_player.active_song_sound)) // check again after uploading
		music_player.unlisten_all()
		playing = FALSE

	curfile = uploaded_song
	var/datum/track/new_song = new()
	new_song.song_name = "custom track"
	new_song.song_path = curfile
	new_song.song_length = sound_length
	if(current_song)
		qdel(current_song)
	current_song = new_song

	if(other_ipod_ref)
		var/obj/item/clothing/ears/ipod/other_ipod = other_ipod_ref.resolve()
		if(!QDELETED(other_ipod) && istype(other_ipod)) // other headphones ref is valid, stop playing and update their song info
			stop_other_headphones()
			var/datum/track/new_song_other = new()
			new_song_other.song_name = current_song.song_name
			new_song_other.song_path = current_song.song_path
			new_song_other.song_length = current_song.song_length
			if(other_ipod.current_song)
				qdel(other_ipod.current_song)
			other_ipod.current_song = new_song_other
			other_ipod.curfile = curfile
			if(other_ipod.is_worn) // alert them
				var/mob/living/carbon/human/wearer = other_ipod.loc
				if(istype(wearer))
					to_chat(wearer, span_warning("A new song has been uploaded."))
		else
			other_ipod_ref = null

/obj/item/clothing/ears/ipod/proc/toggle(mob/living/owner)
	var/mob/living/user = owner
	if(user.stat != STABLE  || !is_worn)
		to_chat(user, span_warning("You can't do that right now."))
		return
	if(!playing)
		if(curfile)
			if(world.time < GLOB.ipod_last_play + 7 SECONDS)
				to_chat(user, span_warning("Headphones are buffering..."))
				return
			GLOB.ipod_last_play = world.time
			playing = TRUE
			music_player.selection = current_song
			music_player.sound_loops = TRUE
			music_player.start_music(user)
			play_other_headphones(user)
			playsound(loc, 'modular_nova/master_files/sound/items/ipod/on.ogg', 20, FALSE)
			user.log_message("played song on headphones: [curfile]", LOG_GAME)
		else
			to_chat(user, span_warning("No track is currently uploaded."))
			return
	else
		playing = FALSE
		if(!isnull(music_player.active_song_sound))
			music_player.unlisten_all()
		stop_other_headphones()
		playsound(loc, 'modular_nova/master_files/sound/items/ipod/off.ogg', 20, FALSE)
	to_chat(user, span_notice("You turn the music [playing? "on. Untz Untz Untz!" : "off."]"))

/obj/item/clothing/ears/ipod/proc/stop_other_headphones(do_unlink = FALSE)
	if(!other_ipod_ref)
		return
	var/obj/item/clothing/ears/ipod/other_ipod = other_ipod_ref.resolve()
	if(!QDELETED(other_ipod) && istype(other_ipod)) // other headphones ref is valid
		if(other_ipod.playing && !isnull(other_ipod.music_player.active_song_sound))
			other_ipod.playing = FALSE
			other_ipod.music_player.unlisten_all()
			playsound(other_ipod, 'modular_nova/master_files/sound/items/ipod/off.ogg', 20, FALSE)
		if(do_unlink)
			other_ipod.other_ipod_ref = null
			if(other_ipod.is_worn)
				var/mob/living/carbon/human/wearer = other_ipod.loc
				if(istype(wearer))
					to_chat(wearer, span_warning("The headphone's connection suddenly disconnects."))
			other_ipod.update_play_button_state_icon()
	else
		other_ipod_ref = null
		return
	if(do_unlink)
		other_ipod_ref = null

/obj/item/clothing/ears/ipod/proc/play_other_headphones(mob/user)
	if(!other_ipod_ref)
		return
	var/obj/item/clothing/ears/ipod/other_ipod = other_ipod_ref.resolve()
	if(QDELETED(other_ipod) || !istype(other_ipod)) // other headphones ref has been deleted
		other_ipod_ref = null
		return
	if(!other_ipod.is_worn)
		return
	var/mob/living/carbon/human/wearer = other_ipod.loc
	if(!istype(wearer))
		return
	wearer.log_message("was shared a song by [user] on headphones: [curfile]", LOG_GAME)
	if(isnull(wearer?.mind))
		return
	if(other_ipod.playing && !isnull(other_ipod.music_player.active_song_sound))
		other_ipod.music_player.unlisten_all()
	other_ipod.playing = TRUE
	other_ipod.curfile = curfile
	var/datum/track/new_song = new()
	new_song.song_name = current_song.song_name
	new_song.song_path = current_song.song_path
	new_song.song_length = current_song.song_length
	if(other_ipod.current_song)
		qdel(other_ipod.current_song)
	other_ipod.current_song = new_song
	other_ipod.music_player.selection = other_ipod.current_song
	other_ipod.music_player.sound_loops = TRUE
	other_ipod.music_player.start_music(wearer)
	playsound(other_ipod, 'modular_nova/master_files/sound/items/ipod/on.ogg', 20, FALSE)

/obj/item/clothing/ears/ipod/proc/unlink_refs()
	if(playing && !isnull(music_player.active_song_sound)) // turn off music
		playing = FALSE
		music_player.unlisten_all()
	if(!other_ipod_ref) // if there doesn't exists any linked headphones
		return
	var/obj/item/clothing/ears/ipod/other_ipod = other_ipod_ref.resolve()
	if(!QDELETED(other_ipod) && istype(other_ipod))
		if(other_ipod.playing && !isnull(other_ipod.music_player.active_song_sound)) // turn off music for other headphones
			other_ipod.playing = FALSE
			other_ipod.music_player.unlisten_all()
			playsound(other_ipod, 'modular_nova/master_files/sound/items/ipod/off.ogg', 20, FALSE)
		other_ipod.other_ipod_ref = null
		if(other_ipod.is_worn)
			var/mob/living/carbon/human/wearer = other_ipod.loc
			if(istype(wearer))
				to_chat(wearer, span_notice("The headphone's connection suddenly disconnects."))
		other_ipod.update_play_button_state_icon()
	other_ipod_ref = null
	update_play_button_state_icon()

/obj/item/clothing/ears/ipod/attackby(obj/item/attacking_item, mob/user, list/modifiers, list/attack_modifiers)
	if(istype(attacking_item, /obj/item/clothing/ears/ipod))
		unlink_refs()
		var/obj/item/clothing/ears/ipod/other_ipod = attacking_item
		other_ipod.unlink_refs()
		other_ipod_ref = WEAKREF(other_ipod)
		other_ipod.other_ipod_ref = WEAKREF(src)
		if(other_ipod.curfile) // update song info
			var/datum/track/new_song_other = new()
			new_song_other.song_name = other_ipod.current_song.song_name
			new_song_other.song_path = other_ipod.current_song.song_path
			new_song_other.song_length = other_ipod.current_song.song_length
			if(current_song)
				qdel(current_song)
			current_song = new_song_other
			curfile = other_ipod.curfile
			music_player.selection = current_song
		update_play_button_state_icon()
		other_ipod.update_play_button_state_icon()
		balloon_alert(user, "successfully linked headphones")
		return TRUE
	return ..()

/obj/item/clothing/ears/ipod/item_ctrl_click(mob/living/user)
	if(!istype(user))
		return NONE
	if(!other_ipod_ref)
		return NONE
	if(isnull(user?.mind) || user.stat != STABLE)
		to_chat(user, span_warning("You can't do that right now."))
		return NONE
	if(playing)
		playing = FALSE
		if(!isnull(music_player.active_song_sound))
			music_player.unlisten_all()
	unlink_refs()
	return CLICK_ACTION_SUCCESS

/obj/item/clothing/ears/ipod/click_alt(mob/living/user)
	if(!istype(user))
		return NONE
	if(isnull(user?.mind) || user.stat != STABLE)
		to_chat(user, span_warning("You can't do that right now."))
		return NONE
	var/new_volume = tgui_input_number(user, "", "Set volume", volume, 100)
	if(QDELETED(src) || QDELETED(user) || !isnum(new_volume) || loc != user || !user.can_perform_action(src, FORBID_TELEKINESIS_REACH))
		return NONE
	volume = new_volume
	music_player.set_new_volume(volume)
	return CLICK_ACTION_SUCCESS

/obj/item/clothing/ears/ipod/equipped(mob/living/user, slot)
	. = ..()
	is_worn = slot_flags & slot
	if(is_worn && !is_registered_on_death)
		RegisterSignal(user, COMSIG_LIVING_DEATH, PROC_REF(on_mob_death))
		is_registered_on_death = TRUE

/obj/item/clothing/ears/ipod/dropped(mob/living/carbon/human/user)
	. = ..()
	if(playing)
		playing = FALSE
		if(!isnull(music_player.active_song_sound))
			music_player.unlisten_all()
		to_chat(user, span_notice("The headphones turn off and go into standby mode."))
	is_worn = FALSE
	if(is_registered_on_death)
		UnregisterSignal(user, COMSIG_LIVING_DEATH)
		is_registered_on_death = FALSE

/obj/item/clothing/ears/ipod/proc/on_mob_death(mob/living/source)
	SIGNAL_HANDLER
	if(playing)
		playing = FALSE
		if(!isnull(music_player.active_song_sound))
			music_player.unlisten_all()
	UnregisterSignal(source, COMSIG_LIVING_DEATH)
	is_registered_on_death = FALSE

/obj/item/clothing/ears/ipod/proc/update_play_button_state_icon()
	var/datum/action/item_action/toggle_ipod/button = locate(/datum/action/item_action/toggle_ipod) in actions

	update_icon_state()
	update_icon()
	if(button)
		button.button_icon_state = icon_state
		button.build_all_button_icons()

/datum/action/item_action/upload_ipod
	name = "Upload Track"
	desc = "Upload a track to your headphones"
	button_icon = 'modular_nova/master_files/icons/obj/clothing/accessories.dmi'
	button_icon_state = "ipod_upload"

/datum/action/item_action/toggle_ipod
	name = "Play Track"
	desc = "UNTZ UNTZ UNTZ"
	button_icon = 'modular_nova/master_files/icons/obj/clothing/accessories.dmi'
	button_icon_state = "ipod"

/datum/action/item_action/upload_ipod/Trigger(trigger_flags)
	. = ..()
	if(!.)
		return
	var/obj/item/clothing/ears/ipod/H = target
	if(istype(H) && !QDELETED(owner) && isliving(owner))
		H.upload(owner)

/datum/action/item_action/toggle_ipod/Trigger(trigger_flags)
	. = ..()
	if(!.)
		return
	var/obj/item/clothing/ears/ipod/H = target
	if(istype(H) && !QDELETED(owner) && isliving(owner))
		H.toggle(owner)
