/obj/item/melee/baton/nunchaku
	stamina_damage = 35
	force = 21
	special_desc_requirement = EXAMINE_CHECK_SYNDICATE
	special_desc = "A part of Syndicate fitness equipment used in training and spec-ops. \
		It is painted in the syndicate's colors and has the organization's logo."

/obj/item/melee/baton/security/add_deep_lore()
	AddElement(/datum/element/examine_lore, \
		lore_hint = span_notice("You can [EXAMINE_HINT("look closer")] to learn a little more about [src]."), \
		lore = "The Secure Apprehension Device (sometimes referred to as the SAD, in officer training manuals) is \
			an unholy union of mace and cattleprod. Designed to stop criminals in their tracks, Nanotrasen security members \
			are rarely without their trusty stun baton... assuming they haven't lost it somewhere.<br>\
			<br>\
			Trained to 'baton first, interrogate later', Nanotrasen security has long since earned itself a mixed reputation. \
			The device is able to rapidly shut down the central nervous system of a criminal with only a few direct applications \
			of the conductive striking head.<br>\
			<br>\
			SolFed law enforcement has generally avoided the adoption of stun batons due to various ethical dilemmas posed by \
			their utilization. Studies of their usage have shown numerous longterm physical and mental ramifications caused by \
			being struck by a human cattleprod. Citizens' rights advocacy groups protest against the proliferation of stun \
			batons as a policing tool, arguing that they are 'inhumane' and 'authoritarian'. Nanotrasen, on the other hand, \
			has had no such qualms when deploying stun batons as a compliance measure across all of their existing stations \
			and facilities against their own unruly members of staff." \
	)

// Contractor Baton

/obj/item/melee/baton/telescopic/contractor_baton/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_CYBERSUN)

/obj/item/melee/baton/telescopic/contractor_baton/add_deep_lore()
	AddElement(/datum/element/examine_lore, \
		lore_hint = span_notice("You can [EXAMINE_HINT("look closer")] to learn a little more about [src]."), \
		lore = "The Contract Acquisition Device (sometimes referred to as the CAD, in encrypted correspondence) is \
			one of the most frequently encountered examples of Cybersun Industries weaponry in Syndicate hands. \
			Similar in purpose to Nanotrasen's own Secure Apprehension Device, the contractor baton \
			is capable of inducing rapid CNS disruption in a target to render them \
			helpless. It also makes for an effective bludgeon, a quality shared with the stun baton. To maximize \
			ease of concealment, the baton is also able to be telescopically collapsed, to then be rapidly deployed at the \
			pull of a trigger.<br>\
			<br>\
			The contractor baton is famously associated with contractors, elite Syndicate field agents sent to kidnap and extract \
			high value enemy personnel for interrogation. Anyone with the potential to possess classified or sensitive data about \
			Nanotrasen could find themselves a target for Syndicate interrogation. \
			The company relentlessly employs contractors to probe Nanotrasen for vulnerabilities, starting with their employees." \
	)
