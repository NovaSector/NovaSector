#define GENITAL_SKIP_VISIBILITY 0
#define GENITAL_NEVER_SHOW 1
#define GENITAL_HIDDEN_BY_CLOTHES 2
#define GENITAL_ALWAYS_SHOW 3
/// Special layering defines beyond normal genital visibility modes.
#define GENITAL_LAYER_NORMAL 4
#define GENITAL_LAYER_HIGH 5


/// Whether something is repairable by the anvil
#define ANVIL_REPAIR (1<<0)
/// Whether obj is used for ERP
#define ERP_ITEM (1<<1)
/// If toggled, the obj cannot be stored by cryopods
#define NO_CRYO_FREEZE (1<<2)
/// Prevents an item from being stripped unless you are an admin privileges holder.
#define NOSTRIP (1<<50)
/// Is this an Admin item? Adds an 'admistrative' obj detail, similar to how sec gloves show they cuff quickly or insuls provide insulation
#define ADMIN_ITEM (1<<51)

/// Admin Items and Flags
/// Prevents removal through strip menu
#define ADMIN_OBJ_FLAGS (XENOMORPH_HOLDABLE | CASTING_CLOTHES | UNIQUE_RENAME | SNUG_FIT | INEDIBLE_CLOTHING | NOSTRIP | ADMIN_ITEM)
