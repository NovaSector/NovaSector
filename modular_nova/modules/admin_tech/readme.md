https://github.com/NovaSector/NovaSector/pull/6628

## Title: Advanced loadouts, tools, items, and machines for admins

MODULE ID: admin_tech

### Description:

Add Nova specific admin outfits, tools, debug items, and other quality of life considerations
This module aims to migrate admin 'god-hand the world is changing magically around you' into the in-character sphere by providing nearly every concievable solution to problems that a staffer might encounter in the course of preparing for events or resolving problems with a body instead of tools like buildmode.

'Bluespace' items are a baseline admin tool, identified usually by /admin as the breakpoint in it's path.
'Subspace' items are meant to be the 'badmin' variant of the above, with additional extras tacked ontop of the Bluespace parent items. Some items only exist in this variant state.
You should be really careful giving these items to players without supervision.

Subspace refers to Telecommunications, or general data. If we consider a blackhole to be the ultimate medium for storage of information, then 'subspace' is the layer of data and information.
I viewed this as these items existing from simply containing data into a form. It's writing on a fourth wall. I don't think it particularly makes sense, but it doesn't need to.
Lore Team can skin me later and help me update this if they please.

Links in with icspawning module from skyrat era, integrates some of its content more relevantly into this module's organization, and updates many of that module's original features.

### TG Code Changes and Modular Additions:

code\datums\elements\strippable.dm - Adds NOSTRIP trait to /datum/strippable_item/proc/try_unequip
code\modules\mob\living\carbon\examine.dm - Adds TRAIT_ADMIN_STEALTH which provides a unique obscuration flavor while blocking examines.
code\_\_HELPERS\pronouns.dm - TRAIT_ADMIN_STEALTH
code\modules\mob\mob.dm - can_see_target helper addition
code_onclick\click.dm - TRAIT_ADMIN_REACHABLE early-return in IsReachableBy
code\game\machinery_machinery.dm - TRAIT_ADMIN_REACHABLE early-return in interact gating
code\_\_DEFINES\inventory.dm - ITEM_SLOT_ADMIN define
code\_\_DEFINES\machines.dm - ADMIN_TECHWEB define
config\admins.txt - added moonridden as Game Admin
icons\map_icons\items\encryptionkey.dmi - (needs justification or revert, see below)
icons\map_icons\items\pda.dmi - (needs justification or revert, see below)
// Also fix: "code\modules\mob\mob.dm - can_see_target helper addition" is wrong path,
// can_see_target is actually in code\game\atoms_movable.dm

### Defines:

ADMIN_OBJ_FLAGS - code\_\_DEFINES\~nova_defines/obj_flags.dm - code\_\_DEFINES\~nova_defines_globalvars\bitfields.dm

### Traits:

TRAIT_NOSTRIP - Prevents item removal by Strip Menu
TRAIT_ADMIN_STEALTH - Provides identity masking similar to the UNKNOWN_APPEARANCE trait, but special inspect texts
TRAIT_ADMIN_REACHABLE - Provides early TRUE returns on IsReachableBy in code_onclick\click.dm and can_perform_action code\modules\mob\living\living.dm. Also provides additions to code\game\machinery_machinery.dm
TRAIT_SHOW_ALL_WIRES - Adds another method of showing the global wire legend without having to hold an abductor multi tool / be a borg / be holding a copy of the blueprints modular_nova\master_files\code\datums\wires_wires.dm

### Included files:

lol i'm not populating this until I'm done.

### Credits:

moonridden - creation, general design, most items, some sprites
plejek - debug headset and encryption key
fluffles - code advice
iamgoofball - lots of code advice
internetizen - lots of code advice
melon_a2 - a few feature ideas
realwinterfrost - bluespace belt sprites, animations sampled

Original PR: https://github.com/Skyrat-SS13/Skyrat-tg/pull/104
Gandalf2k15 - Porting
BunBun - Cration ([sic] from the original PR credits)

### Remaining To-Do

Search TODO on this folder to find remaining known issues / missing content
Icons. Everywhere. They all need icons. Either you do it, or hope I eventually do it. And I am anything but an artist.

Player appropriate tech loadout with considerations to reduce the need for admins to support them when they wish to test mechanics
subclass admin capsules for useful testing setups, such as instant departments and test environments. 'oh just use xyz location, it already exists-' shut up nerd

Integrate the new alien tools
Update subspace reagent gun reagent container size if you havent already

Talk to sammy about the tgui machinery ui interact at distance situation

// code\game\objects\items\tools\control_wand.dm

//TODO: recreational drugs box
//TODO: fix all the slime boxes, those suck
//TODO: Antag box, Research box, Security box, Service Box, Cargo Box, Medical Box revisit
