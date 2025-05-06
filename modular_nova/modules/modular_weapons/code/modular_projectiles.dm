/obj/item/ammo_casing
	/// Can this bullet casing be printed at an ammunition workbench without admin intervention?
	var/can_be_printed = TRUE
	/// What ammo categories does this casing fulfill? Used in tandem with the ammo workbench.
	var/ammo_categories = AMMO_CLASS_LETHAL
	/// How many arbitrary printing points does this casing require to print? Used in tandem with the ammo workbench.
	var/print_cost = 1

/*
Future guncoder, turn back before you are overwhelmed by the horrifically scattered nature of ammunition in this codebase.
Or don't, and suffer for your hubris. In all seriousness, ammo overrides are horrendously scattered, and you're going to
have to jump through a lot of different files in case you're doing something stupid, like a categorization project
that tags every bullet with a category for rebalancing the ammo bench, or something vaguely among those lines.

In case that doesn't stop you, you're going to want to look through:
- The entirety of this module, specifically the ammo.dm files
- modular_nova/modules/shotgunrebalance/code/shotgun.dm
- More to be listed as we go along.
*/
