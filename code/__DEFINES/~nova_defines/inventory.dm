// mutant_styles - flags for outfits that have mutant variants: Most of these require additional sprites to work.
#define STYLE_TAUR_GENERIC (1<<0) // For when you just want the leg cropping
#define STYLE_TAUR_SNAKE (1<<1) //taur-friendly suits
#define STYLE_TAUR_PAW (1<<2)
#define STYLE_TAUR_HOOF (1<<3)
#define STYLE_TAUR_BIG_LEGS (1<<4)
#define STYLE_TAUR_BIG_LEGS_STANCED (1<<5)
#define STYLE_DIGI (1<<6)

#define STYLE_TAUR_BIG_LEGS_ALL (STYLE_TAUR_BIG_LEGS|STYLE_TAUR_BIG_LEGS_STANCED)
#define STYLE_TAUR_ALL (STYLE_TAUR_SNAKE|STYLE_TAUR_PAW|STYLE_TAUR_HOOF|STYLE_TAUR_GENERIC)

// We don't use the HUD for these, they have their own menu.
#define LEWD_SLOT_VAGINA (1<<0)
#define LEWD_SLOT_PENIS (1<<1)
#define LEWD_SLOT_ANUS (1<<2)
#define LEWD_SLOT_NIPPLES (1<<3)
