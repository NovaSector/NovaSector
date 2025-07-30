#define BLOOD_VOLUME_OVERSIZED 1120

#define PULL_OVERSIZED_SLOWDOWN 2

#define HUMAN_HEALTH_MODIFIER 1.35

#define HUMAN_MAXHEALTH MAX_LIVING_HEALTH * HUMAN_HEALTH_MODIFIER

#define UNDERWEAR_HIDE_SOCKS (1<<0)
#define UNDERWEAR_HIDE_SHIRT (1<<1)
#define UNDERWEAR_HIDE_UNDIES (1<<2)
#define UNDERWEAR_HIDE_BRA (1<<3)
#define UNDERWEAR_HIDE_ALL (UNDERWEAR_HIDE_SOCKS | UNDERWEAR_HIDE_SHIRT | UNDERWEAR_HIDE_UNDIES | UNDERWEAR_HIDE_BRA)

//Appends to the bottom of Defib fails - DNR TRAIT
#define DEFIB_FAIL_DNR (1<<11)

///Defines for icons used for modular bodyparts, created to make it easier to relocate the module or files if necessary.
#define BODYPART_ICON_HUMAN 'modular_nova/modules/bodyparts/icons/human_parts_greyscale.dmi'
#define BODYPART_ICON_MAMMAL 'modular_nova/modules/bodyparts/icons/mammal_parts_greyscale.dmi'
#define BODYPART_ICON_AKULA 'modular_nova/modules/bodyparts/icons/akula_parts_greyscale.dmi'
#define BODYPART_ICON_AQUATIC 'modular_nova/modules/bodyparts/icons/aquatic_parts_greyscale.dmi'
#define BODYPART_ICON_GHOUL 'modular_nova/modules/bodyparts/icons/ghoul_bodyparts.dmi'
#define BODYPART_ICON_INSECT 'modular_nova/modules/bodyparts/icons/insect_parts_greyscale.dmi'
#define BODYPART_ICON_LIZARD 'modular_nova/modules/bodyparts/icons/lizard_parts_greyscale.dmi'
#define BODYPART_ICON_MOTH 'modular_nova/modules/bodyparts/icons/moth_parts_greyscale.dmi'
#define BODYPART_ICON_ROUNDSTARTSLIME 'modular_nova/modules/bodyparts/icons/slime_parts_greyscale.dmi'
#define BODYPART_ICON_SKRELL 'modular_nova/modules/bodyparts/icons/skrell_parts_greyscale.dmi'
#define BODYPART_ICON_TAUR 'modular_nova/modules/bodyparts/icons/taur_invisible_legs.dmi'
#define BODYPART_ICON_TESHARI 'modular_nova/modules/bodyparts/icons/teshari_parts_greyscale.dmi'
#define BODYPART_ICON_VOX 'modular_nova/modules/bodyparts/icons/vox_parts_greyscale.dmi'
#define BODYPART_ICON_XENO 'modular_nova/modules/bodyparts/icons/xeno_parts_greyscale.dmi'
#define BODYPART_ICON_SYNTHMAMMAL 'modular_nova/modules/bodyparts/icons/synthmammal_parts_greyscale.dmi'
#define BODYPART_ICON_IPC 'modular_nova/modules/bodyparts/icons/ipc_parts.dmi'
#define BODYPART_ICON_SYNTHLIZARD 'modular_nova/modules/bodyparts/icons/synthliz_parts_greyscale.dmi'
#define BODYPART_ICON_SNAIL 'modular_nova/modules/bodyparts/icons/snail_parts_greyscale.dmi'
#define BODYPART_ICON_RAMATAE 'modular_nova/modules/bodyparts/icons/ramatae_parts_greyscale.dmi'
///Defines for special modular bodypart variants, like harpy legs.
#define BODYPART_ICON_HARPY 'modular_nova/modules/bodyparts/icons/bespoke/harpy_parts_greyscale.dmi'
#define BODYPART_ICON_HARPY_HUMAN 'modular_nova/modules/bodyparts/icons/bespoke/harpy_parts_skintone.dmi'
#define BODYPART_ICON_HUMAN_CRITTER 'modular_nova/modules/bodyparts/icons/bespoke/mutant_parts_skintone.dmi'
