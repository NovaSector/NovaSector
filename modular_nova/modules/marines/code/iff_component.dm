/// A component that is added to guns so that its projectiles will have an IFF (Identify Friend/Foe) system. Projectiles will pass through friends without damage, but not through enemies
/datum/component/identify_friend_foe
	/// List of factions through which projectiles should pass without causing any damage
	var/list/iff_factions = list()

/datum/component/identify_friend_foe/Initialize(list/friend_factions)
	. = ..()
	if(!isgun(parent))
		return COMPONENT_INCOMPATIBLE
	src.iff_factions = friend_factions

/datum/component/identify_friend_foe/RegisterWithParent()
	RegisterSignal(parent, COMSIG_GUN_FIRED, PROC_REF(handle_iff))

/datum/component/identify_friend_foe/UnregisterFromParent()
	UnregisterSignal(parent, COMSIG_GUN_FIRED)

/// Triggers when a gun is fired. Adds a list of ignored factions to the chambered projectile
/datum/component/identify_friend_foe/proc/handle_iff(obj/item/gun/gun)
	SIGNAL_HANDLER

	var/obj/item/ammo_casing/casing = gun.chambered
	if(isnull(casing))
		return
	casing.loaded_projectile.ignored_factions = iff_factions.Copy()
