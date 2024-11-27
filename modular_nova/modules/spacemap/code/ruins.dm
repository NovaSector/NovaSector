/datum/map_template/ruin/space
	/// The icon this ruin should use on the spacemap once discovered.
	var/spacemap_icon = "satellite"
	/// Whether or not this ruin should start discovered.
	var/starts_discovered = FALSE
	/// Indicates whether the ruin should be considered as big by the Spacemap,
	/// meaning that it requires being in bigger space zones due to its size,
	/// so that it can also still allow ships to land around it inside of its
	/// space zone.
	var/requires_big_zone = FALSE
	/// Indicates whether this ruin contains a ghost role or not.
	var/contains_ghost_role = FALSE
