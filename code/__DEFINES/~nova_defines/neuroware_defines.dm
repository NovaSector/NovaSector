// Global bitflags for what companies neuroware chips should belong to.
// Gets used in [/obj/item/disk/neuroware/proc/Initialize()] to modify desc.
///Bishop Cybernetics, Inc: Beneficial medical chips. Subsidiary company of Zeng-Hu.
#define NEUROWARE_BISHOP (1<<0)
///DeForest Medical Corporation: Important medical chips, like system reset and corruption repair.
#define NEUROWARE_DEFOREST (1<<1)
///Donk Corporation: Somewhat dangerous recreation/fun chips, like drugs.
#define NEUROWARE_DONK (1<<2)
///XLR8.EXE: Label for the Maintenance Pump-Up chip, not used on anything else.
#define NEUROWARE_MAINT (1<<3)
///Nanotrasen Systems, Inc: Harmless recreation/fun chips, like gimmicks and musical instruments.
#define NEUROWARE_NT (1<<4)
///Cybersun Industries: Harmful and powerful (suspicious) chips, for traitor/opfor.
#define NEUROWARE_SYNDIE (1<<5)
///Ward-Takahashi Manufacturing: Utility chips for industrial and engineering purposes.
#define NEUROWARE_WARD (1<<6)
///Zeng-Hu Pharmaceuticals: Beneficial, medical, and performance enhancing chips.
#define NEUROWARE_ZENGHU (1<<7)

///Allow neuroware status effect to remove itself when program_count reaches 0
#define NEUROWARE_METABOLIZE_HELPER(path) ##path/on_mob_end_metabolize(mob/living/affected_mob) {\
	ASSERT(ispath(path, /datum/reagent), "NEUROWARE_METABOLIZE_HELPER() was passed an invalid typepath! ([path]). It needs to be a typepath derived from /datum/reagent."); \
	. = ..(); \
	var/datum/status_effect/neuroware/neuro_status = affected_mob.has_status_effect(/datum/status_effect/neuroware); \
	if(!isnull(neuro_status)) \
		neuro_status.adjust_program_count(-1); \
}

///Returns a random neuroware reagent type. Excludes aphrodisiac reagents.
/proc/get_random_neuroware()
	return GLOB.name2neuroware_safe[pick(GLOB.name2neuroware_safe)]
