Description :
This module adds a selection of items and recipes to use by tribal ghostroles.

List of file changed in the core code:
None (that I am aware of, this module existed without a readme.dm when I wrote this. -Diltyrr)

Elaborated documentation:
I cannot write for the older content but as far as the runic weapons, found under code/weapons/tribal*crushers.dm the idea is to give the hearthkins a way to get and use trophies, which is something their lore encourages. As only through using a crusher can one loot trophies from hunts. As well as encourage trading with the station or Interdyne. As the best way to get the amount of strange rocks needed to get the rare material required for their crafting is through a boulder machine.
The recipes are added to "/datum/antagonist/primitive_catgirl" in "modular_nova*/modules_primitive_catgirls/code/spawner.dm" which is the code used to attribute hearthkin recipes
The sprites are a bit scuffed, a mix of reusing already existing sprites, one imported and edited roguetown sprite for the axe and one hand made sprite for the spear, anyone with actual artistic skill feel free to just replace the sprite by something nice. Though if you add a greatsword sprite with a wielded icon, you'll want to remove "/obj/item/kinetic_crusher/runic_greatsword/update_icon_state()" after assigning the new sprites to the item. I'm using this code to avoid the current sprite vanishing when the weapon is wielded since the moonlight greatsword doesn't have a wielded sprite.
There is also the possibility to add ways for the station to use the ship fragments that are part of the runice weapons' recipe but I don't have any good idea at the moment. - Diltyrr

Credits
Diltyyrr - https://github.com/Diltyrr
