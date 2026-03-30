/// This is the master quirk that allows one to have a belly.
/datum/quirk/belly
	name = "Big Boned"
	desc = "Your midriff just stands out more than others'..."
	icon = FA_ICON_PERSON_PREGNANT
	value = 0
	mob_trait = TRAIT_PREDATORY
	gain_text = span_notice("You feel like your suit doesn't quite fit.")
	lose_text = span_notice("You feel like your suit fits again.")
	medical_record_text = "Patient's midriff is well defined." //Why does QUIRK_HIDE_FROM_SCAN not cut this from medical records too?
	quirk_flags = QUIRK_PROCESSES | QUIRK_CHANGES_APPEARANCE | QUIRK_HIDE_FROM_SCAN
	maximum_process_stat = null
	erp_quirk = TRUE
	tum_quirk = TRUE
	/// Local reference to our connected belly helper object.
	var/obj/item/belly_function/the_bwelly

/datum/quirk/belly/add_unique(client/client_source)
	the_bwelly = new /obj/item/belly_function(quirk_holder)

	/// Main sprite color.
	the_bwelly.color = client_source?.prefs.read_preference(/datum/preference/color/erp_bellyquirk_color) || "#FFFFFF"
	/// Skintone toggle - this adjusts the sprite files.
	the_bwelly.use_skintone = client_source?.prefs.read_preference(/datum/preference/toggle/erp_bellyquirk_skintone) || FALSE
	/// Slime alpha toggle - this reduces the alpha to 155, as per normal slimepeople.
	the_bwelly.use_slime_alpha = client_source?.prefs.read_preference(/datum/preference/toggle/erp_bellyquirk_use_slime_alpha) || FALSE

	/// Size modifier - overall.
	the_bwelly.sizemod = client_source?.prefs.read_preference(/datum/preference/numeric/erp_bellyquirk_sizemod) || 1
	/// Size modifier - auto-calculated stuffed size.
	the_bwelly.sizemod_autostuffed = client_source.prefs.read_preference(/datum/preference/numeric/erp_bellyquirk_sizemod_autostuffed) || 1
	/// Size modifier - audio size.
	the_bwelly.sizemod_audio = client_source?.prefs.read_preference(/datum/preference/numeric/erp_bellyquirk_sizemod_audio) || 1
	/// Maximum display size for this belly.
	the_bwelly.maxsize = client_source?.prefs.read_preference(/datum/preference/numeric/erp_bellyquirk_maxsize) || 16

	/// Base cosmetic size.
	the_bwelly.base_size_cosmetic = client_source?.prefs.read_preference(/datum/preference/numeric/erp_bellyquirk_size_base) || 0
	/// Base fullness size - permanent and not dependent on actually having someone nommed.
	the_bwelly.base_size_full = client_source?.prefs.read_preference(/datum/preference/numeric/erp_bellyquirk_size_full) || 0
	/// Base stuffed size - permanent and not dependent on actually having high nutrition or a bunch of stomach regaents.
	the_bwelly.base_size_stuffed = client_source?.prefs.read_preference(/datum/preference/numeric/erp_bellyquirk_size_stuffed) || 0

	/// Sound toggle: full groans.  All but cosmetic size adds to these.
	the_bwelly.allow_sound_groans =client_source?.prefs.read_preference(/datum/preference/toggle/erp_bellyquirk_groans) || FALSE
	/// Sound toggle: stuffed gurgles.  Only stuffed sizes add to these.
	the_bwelly.allow_sound_gurgles = client_source?.prefs.read_preference(/datum/preference/toggle/erp_bellyquirk_gurgles) || FALSE
	/// Sound toggle: Full creaks when moving.  All but cosmetic size adds to these.
	the_bwelly.allow_sound_move_creaks = client_source?.prefs.read_preference(/datum/preference/toggle/erp_bellyquirk_move_creaks) || FALSE
	/// Sound toggle: stuffed sloshes when moving.  Only stuffed sizes add to these.
	the_bwelly.allow_sound_move_sloshes = client_source?.prefs.read_preference(/datum/preference/toggle/erp_bellyquirk_move_sloshes)|| FALSE

	/// Pred prefs mode
	the_bwelly.pred_mode = client_source?.prefs.read_preference(/datum/preference/choiced/erp_bellyquirk_pred_pref) || "Never"
	/// Default endosoma size
	the_bwelly.endo_size = client_source?.prefs.read_preference(/datum/preference/numeric/erp_bellyquirk_size_endo) || 1000

	/// Manually run add() for dummies so we get preview on the character screen.
	if(isdummy(quirk_holder))
		add()

/// Manually run an initial sprite calculation & other initializations during addition.
/// This means your sprite is instantly visible on spawnin & appears properly in chargen.
/datum/quirk/belly/add()
	. = ..()
	if(the_bwelly != null)
		if(the_bwelly.overlay_south != null && the_bwelly.lastuser != null)
			the_bwelly.remove_from_user(the_bwelly.lastuser)
		the_bwelly.loc = quirk_holder
		the_bwelly.apply_to_user(quirk_holder)
		the_bwelly.belly_process(0)

/// Redundant calculations in case add() errors out or doesn't work as expected.
/datum/quirk/belly/post_add()
	. = ..()
	if(the_bwelly != null)
		if(the_bwelly.overlay_south != null && the_bwelly.lastuser != null)
			the_bwelly.remove_from_user(the_bwelly.lastuser)
		the_bwelly.loc = quirk_holder
		the_bwelly.apply_to_user(quirk_holder)
		the_bwelly.belly_process(0)

/// The meat of the processing happens in the equippable_belly file.
/// This is largely sanity checks & things designed to *stop* it from processing if it's not appropriate.
/datum/quirk/belly/process(seconds_per_tick)
	if(the_bwelly == null)
		return
	/// If something has gone catastrophically wrong, stash the helper in pseudo-nullspace before anyone can see it.
	if(the_bwelly.loc != quirk_holder || quirk_holder == null)
		the_bwelly.loc = src
		if(the_bwelly.overlay_south != null && the_bwelly.lastuser != null)
			the_bwelly.remove_from_user(the_bwelly.lastuser)
	/// Search for the client connected to the mob- and if it doesn't have the quirk, do NOT keep treating this as active.
	/// This is primarily a fallback in case people do brain swaps for some reason.  There are...very few other ways this could come up.
	if(quirk_holder?.client?.prefs)
		if(!(src.name in quirk_holder.client.prefs.all_quirks))
			if(the_bwelly.loc != src)
				the_bwelly.loc = src
				if(the_bwelly.overlay_south != null && the_bwelly.lastuser != null)
					the_bwelly.remove_from_user(the_bwelly.lastuser)
		else
			/// If the helper was nullspaced or otherwise messed with, reapply it to the associated mob once things are clear.
			if(the_bwelly.loc != quirk_holder && quirk_holder != null)
				the_bwelly.loc = quirk_holder
				the_bwelly.apply_to_user(quirk_holder)
	/// If the helper is where it should be, only then do we actually let it process.
	if(the_bwelly.loc == quirk_holder)
		the_bwelly.belly_process(seconds_per_tick)

/// Final removal checks for sanity happen here.
/datum/quirk/belly/remove()
	. = ..()
	the_bwelly.loc = src
	if(the_bwelly.overlay_south != null && the_bwelly.lastuser != null)
		the_bwelly.remove_from_user(the_bwelly.lastuser)

/// Extra qdels and nulling to minimize GC issues and CI errors.
/datum/quirk/belly/Destroy()
	. = ..()
	qdel(the_bwelly)
