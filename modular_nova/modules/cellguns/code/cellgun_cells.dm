/obj/item/weaponcell
	name = "default weaponcell"
	desc = "Used to add ammo types to guns."
	icon = 'modular_nova/modules/cellguns/icons/obj/guns/mediguns/medicells.dmi'
	icon_state = "Oxy1"
	w_class = WEIGHT_CLASS_SMALL
	/// The ammo type that is added by default when inserting a cell.
	var/ammo_type = /obj/item/ammo_casing/energy/medical
	/// The name of the current firing mode.
	var/shot_name
	/// Enables Medigun specific examine text.
	var/medicell_examine = FALSE

/obj/item/weaponcell/proc/refresh_shot_name() //refreshes the shot name
	var/obj/item/ammo_casing/energy/shot = ammo_type

	if(initial(shot.select_name))
		shot_name = initial(shot.select_name)
		return TRUE
	else
		return FALSE

/obj/item/weaponcell/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/item_scaling, 0.5, 1)
	refresh_shot_name()

/obj/item/weaponcell/examine(mob/user)
	. = ..()
	if(shot_name)
		. += span_noticealien("Using this on a cell-based gun will unlock the [shot_name] firing mode.")
	return .

/obj/item/weaponcell/attack_self(mob/living/user)
	if(refresh_shot_name())
		balloon_alert(user, "set to [shot_name]")

	return

