/datum/component/iff
	var/list/iff_factions = list()

/datum/component/iff/Initialize(list/frend_factions)
	. = ..()
	if(!isgun(parent))
		return COMPONENT_INCOMPATIBLE
	src.iff_factions = frend_factions

/datum/component/iff/RegisterWithParent()
	RegisterSignal(parent, COMSIG_GUN_FIRED, PROC_REF(handle_iff))
	
/datum/component/iff/UnregisterFromParent()
	UnregisterSignal(parent, COMSIG_GUN_FIRED)

/datum/component/iff/proc/handle_iff(obj/item/gun/gun)
	SIGNAL_HANDLER

	var/obj/item/ammo_casing/casing = gun.chambered
	if(isnull(casing))
		return
	casing.loaded_projectile.ignored_factions = iff_factions.Copy()
