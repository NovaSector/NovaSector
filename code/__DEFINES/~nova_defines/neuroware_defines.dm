// Global bitflags for what companies neuroware chips should belong to.
// Gets used in [/obj/item/disk/neuroware/proc/Initialize()] to modify desc.
#define NEUROWARE_BISHOP (1<<0)
#define NEUROWARE_DEFOREST (1<<1)
#define NEUROWARE_DONK (1<<2)
#define NEUROWARE_MAINT (1<<3)
#define NEUROWARE_NT (1<<4)
#define NEUROWARE_SYNDIE (1<<5)
#define NEUROWARE_WARD (1<<6)
#define NEUROWARE_ZENGHU (1<<7)

///Allow neuroware status effect to remove itself when program_count reaches 0
#define NEUROWARE_METABOLIZE_HELPER(path) ##path/on_mob_end_metabolize(mob/living/affected_mob) {\
	. = ..(); \
	var/datum/status_effect/neuroware/neuro_status = affected_mob.has_status_effect(/datum/status_effect/neuroware); \
	if(!isnull(neuro_status)) \
		neuro_status.adjust_program_count(-1); \
}

///Returns a random neuroware reagent type. Excludes aphrodisiac reagents.
/proc/get_random_neuroware()
	return GLOB.name2neuroware_safe[pick(GLOB.name2neuroware_safe)]
