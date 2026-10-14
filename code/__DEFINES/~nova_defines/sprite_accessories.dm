/// The flag to show that snouts should use the muzzled sprite.
#define SPRITE_ACCESSORY_USE_MUZZLED_SPRITE (1<<0)
/// The flag to show that this tail sprite can wag.
#define SPRITE_ACCESSORY_WAG_ABLE (1<<1)
/// The flag that controls whether or not this sprite accessory should force the wearer to hide its shoes.
#define SPRITE_ACCESSORY_HIDE_SHOES (1<<2)
/// The flag to that controls whether or not this sprite accessory should force worn facewear to use layers 5 (for glasses) and 4 (for masks and hats).
#define SPRITE_ACCESSORY_USE_ALT_FACEWEAR_LAYER (1<<3)

// Flags for rendering hardlight overlays
/// Must have boots active to render hardlight overlays
#define MOD_ACCESSORY_BOOTS (1 << 0)
/// Must have gauntlets active to render hardlight overlays
#define MOD_ACCESSORY_GAUNTLETS (1 << 1)
/// Must have a chestplate active to render hardlight overlays
#define MOD_ACCESSORY_CHESTPLATE (1 << 2)
/// Must have a helmet active to render hardlight overlays
#define MOD_ACCESSORY_HELMET (1 << 3)
