
///artifact energy release method
#define ARTIFACT_EFFECT_TOUCH 0
#define ARTIFACT_EFFECT_AURA 1
#define ARTIFACT_EFFECT_PULSE 2

///list of possible release methods to get
#define ARTIFACT_ALL_RELEASE_METHODS list(\
    ARTIFACT_EFFECT_TOUCH,\
    ARTIFACT_EFFECT_AURA,\
    ARTIFACT_EFFECT_PULSE,\
)

///artifact trigger types
#define TRIGGER_TOUCH (1<<2)
#define TRIGGER_WATER (1<<3)
#define TRIGGER_ACID (1<<4)
#define TRIGGER_VOLATILE (1<<5)
#define TRIGGER_TOXIN (1<<6)
#define TRIGGER_FORCE (1<<7)
#define TRIGGER_ENERGY (1<<8)
#define TRIGGER_HEAT (1<<9)
#define TRIGGER_COLD (1<<10)
#define TRIGGER_PLASMA (1<<11)
#define TRIGGER_OXY (1<<12)
#define TRIGGER_CO2 (1<<13)
#define TRIGGER_NITRO (1<<14)
#define TRIGGER_PROXY (1<<15)
#define TRIGGER_TEMP (TRIGGER_COLD | TRIGGER_HEAT)
#define TRIGGER_GASES (TRIGGER_PLASMA | TRIGGER_OXY | TRIGGER_CO2 | TRIGGER_NITRO)
#define TRIGGER_ATMOS (TRIGGER_HEAT | TRIGGER_COLD | TRIGGER_GASES)

///list of possible artifact triggers
#define ARTIFACT_POSSIBLE_TRIGGERS list(\
    TRIGGER_TOUCH,\
    TRIGGER_WATER,\
    TRIGGER_ACID,\
    TRIGGER_VOLATILE,\
    TRIGGER_TOXIN,\
    TRIGGER_FORCE,\
    TRIGGER_ENERGY,\
    TRIGGER_HEAT,\
    TRIGGER_COLD,\
    TRIGGER_PLASMA,\
    TRIGGER_OXY,\
    TRIGGER_CO2,\
    TRIGGER_NITRO,\
)

///artifact artifact_type_id defines
#define ARTIFACT_WIZARD_LARGE 1
#define ARTIFACT_WIZARD_SMALL 2
#define ARTIFACT_MARTIAN_LARGE 3
#define ARTIFACT_MARTIAN_SMALL 4
#define ARTIFACT_MARTIAN_PINK 5
#define ARTIFACT_CUBE 6
#define ARTIFACT_PILLAR 7
#define ARTIFACT_COMPUTER 8
#define ARTIFACT_VENTS 9
#define ARTIFACT_FLOATING 10
#define ARTIFACT_CRYSTAL_GREEN 11
#define ARTIFACT_CRYSTAL_PURPLE 12
#define ARTIFACT_CRYSTAL_BLUE 13

///artifact type_name

///unknown/none
#define ARTIFACT_EFFECT_UNKNOWN 0
///concentrated energy
#define ARTIFACT_EFFECT_ENERGY 1
///untermittent psionic wavefront
#define ARTIFACT_EFFECT_PSIONIC 2
///electromagnetic energy
#define ARTIFACT_EFFECT_ELECTRO 3
///particle field
#define ARTIFACT_EFFECT_PARTICLE 4
///organically reactive exotic particles
#define ARTIFACT_EFFECT_ORGANIC 5
///bluespace
#define ARTIFACT_EFFECT_BLUESPACE 6
///atomic synthesis
#define ARTIFACT_EFFECT_SYNTH 7

GLOBAL_LIST_INIT(valid_primary_effect_types, list(
	/datum/artifact_effect/temperature/cold,
	/datum/artifact_effect/temperature/heat,
	/datum/artifact_effect/dnaswitch,
	/datum/artifact_effect/emp,
	/datum/artifact_effect/gas,
	/datum/artifact_effect/gravity,
	/datum/artifact_effect/radiate,
	/datum/artifact_effect/sleepy,
	/datum/artifact_effect/stun,
	/datum/artifact_effect/tesla,
	/datum/artifact_effect/teleport,
	/datum/artifact_effect/bodyswap,
	/datum/artifact_effect/bodyhorror,
	/datum/artifact_effect/machinery_mess,
	/datum/artifact_effect/blood_regen,
	/datum/artifact_effect/blood_drain,
))

GLOBAL_LIST_INIT(valid_secondary_effect_types, list(
	/datum/artifact_effect/feelings/bad,
	/datum/artifact_effect/feelings/good,
	/datum/artifact_effect/cellcharge,
	/datum/artifact_effect/celldrain,
	/datum/artifact_effect/heal,
	/datum/artifact_effect/hurt,
	/datum/artifact_effect/light,
	/datum/artifact_effect/light/darkness,
	/datum/artifact_effect/noise,
	/datum/artifact_effect/roboheal,
	/datum/artifact_effect/robohurt,
	/datum/artifact_effect/disgust,
	/datum/artifact_effect/drugs,
))

GLOBAL_LIST_INIT(volatile_reagents, list(
	/datum/reagent/thermite,
	/datum/reagent/toxin/plasma,
	/datum/reagent/nitroglycerin,
	/datum/reagent/clf3,
	/datum/reagent/sorium,
	/datum/reagent/liquid_dark_matter,
	/datum/reagent/gunpowder,
	/datum/reagent/rdx,
	/datum/reagent/tatp,
	/datum/reagent/flash_powder,
	/datum/reagent/phlogiston,
	/datum/reagent/napalm,
	/datum/reagent/pyrosium,
	/datum/reagent/teslium,
))

GLOBAL_LIST_INIT(artifact_turfs, list())
