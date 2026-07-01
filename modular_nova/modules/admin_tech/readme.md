github link for pr here

## Title: Advanced loadouts, tools, items, and machines for admins

MODULE ID: admin_tech

### Description:

Add Nova specific admin outfits, tools, debug items, and other quality of life considerations
This module aims to migrate admin 'god-hand the world is changing magically around you' into the in-character sphere by providing nearly every concievable solution to problems that a staffer might encounter in the course of preparing for events or resolving problems with a body instead of tools like buildmode.

'Bluespace' items are a baseline admin tool, identified usually by /admin as the breakpoint in it's path.
'Subspace' items are meant to be the 'badmin' variant of the above, with additional extras tacked ontop of the Bluespace parent items. Some items only exist in this variant state. You should be really careful giving these items to players without supervision.

Subspace refers to Telecommunications, or general data. If we consider a blackhole to be the ultimate medium for storage of information, then 'subspace' is the layer of data and information.
I viewed this as these items existing from simply containing data into a form. It's writing on a fourth wall. I don't think it particularly makes sense, but it doesn't need to.
Lore Team can skin me later and help me update this if they please.

Links in with icspawning module from skyrat era, integrates some of its content more relevantly into this module's organization, and updates many of that module's original features.

### TG Code Changes and Modular Additions:

N/A

### Defines:

none _yet_

### Included files:

lol i'm not populating this until I'm done.

### Credits:

moonridden - creation, general design, most items, some sprites
plejek - debug headset and encryption key
fluffles - code advice
iamgoofball - code advice
internetizen - code advice
melon_a2 - a few feature ideas
realwinterfrost - bluespace belt sprites, animations sampled

Original PR: https://github.com/Skyrat-SS13/Skyrat-tg/pull/104
Gandalf2k15 - Porting
BunBun - Cration ([sic] from the original PR credits)

### Remaining To-Do

Search TODO on this folder to find remaining known issues / missing content
Icons. Everywhere. They all need icons. Either you do it, or hope I eventually do it. And I am anything but an artist
Defines
Globs file
Atomize admin_items.dm?
Revisit the currently used spawner wands and retheme / update them. Human spawner wand doesnt use tguilist for example.
Add active outlines to click-toggle altered items
Player appropriate tech loadout with considerations to reduce the need for admins to support them when they wish to test mechanics
subspace boxcutter, to replace the energy axe. probably sub-path the spess knife. split state checks for combat mode -> interact to toggle the combat function, or non-combat mode for tool adjustments. add action to rclick open turf to tear hole in reality that only admins can enter to despawn. integrate the subspace baseball bat onto this. radial navigation menu, with tgui input functions. expand the radial, reduce popup times, make this a true omnitool.
admin cyborgs and modules. /obj/item/soap/omega. subspace mop / liquids solution? new admin dune shield to replace the energy shield, seeds box
subclass admin capsules for useful testing setups, such as instant departments and test environments. 'oh just use xyz location, it already exists-' shut up nerd
find a solution for reach_length passing a collisions check for BST radio headset. TRAIT_SKIP_BASIC_REACH_CHECK.
/obj/item/pen/screwdriver/get_all_tool_behaviours()
return list(TOOL_SCREWDRIVER)
admin manufacturing company
strip speed checks on admin items
check traits list from protean mage cloak you made on the syndiehomepod
investigate robotact pda app functionality
investigate lifeline pda app functionality
update the syndie infiltration module, dont subtype, make a new bespoke one for admins that explains exactly what players are looking at and how they should react. currently techs are not inspectable, and this cannot be disabled w/o powering down their modsuit. this needs to be changed into a toggleable modules, and with information on the inspect blocking updated. what staff have equipped in these outfits should be irrelevant to players. the inspect check should also have a check for admin perms, so staff can bypass regardless. this should really be updated on the central module, as currently even staff are inspect blocked. big oversight.
Fix digi icons for suits
Instant no effect spawn option
Admin donk pockets
