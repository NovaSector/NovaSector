/obj/item/melee/baton/nunchaku
	stamina_damage = 35
	force = 21
	special_desc_requirement = EXAMINE_CHECK_SYNDICATE
	special_desc = "A part of Syndicate fitness equipment used in training and spec-ops. \
		It is painted in the syndicate's colors and has the organization's logo."

/obj/item/melee/baton/security/add_deep_lore()
	AddElement(/datum/element/examine_lore, \
		lore_hint = span_notice("You can [EXAMINE_HINT("look closer")] to learn a little more about [src]."), \
		lore = "The Secure Apprehension Device (sometimes referred to as the SAD in officer training manuals) is \
			the unholy union of a mace and a cattleprod. This nonlethal device was designed to put a stop to ruffians, \
			scoundrels, ne'er-do-wells and criminals wherever they may rear their ugly heads.<br>\
			<br>\
			A symbol of Nanotrasen security forces, the stun baton is the primary tool officers employ against the \
			unlawful scum and villainy of the Nova Sector and abroad. Trained to 'baton first, interrogate later', \
			Nanotrasen security has long since earned itself a mixed reputation. Able to rapidly shut down the \
			central nervous system of a criminal with only a few direct applications of the conductive striking head \
			of the device, few would-be troublemakers want to find themselves on the wrong end of an officer brandishing \
			this baton.<br>\
			<br>\
			SolFed law enforcement has generally avoided the adoption of stun batons due to various ethical dilemmas posed by \
			their usage, largely because of the long-term physical and mental ramifications of being struck by a human cattleprod. \
			Citizens' rights advocacy groups protest against the proliferation of stun batons as a policing tool, \
			arguing that they are 'inhumane' and 'authoritarian'. Nanotrasen, on the other hand, has had no such qualms \
			when deploying stun batons as a compliance measure across all of their existing stations and facilities against \
			unruly members of staff." \
	)

// Contractor Baton

/obj/item/melee/baton/telescopic/contractor_baton/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_CYBERSUN)

/obj/item/melee/baton/telescopic/contractor_baton/add_deep_lore()
	AddElement(/datum/element/examine_lore, \
		lore_hint = span_notice("You can [EXAMINE_HINT("look closer")] to learn a little more about [src]."), \
		lore = "The Contract Acquisition Device (sometimes referred to as the CAD in encrypted correspondence) is \
			one of the more frequently encountered examples of Cybersun Industries weaponry. Extremely similar to Nanotrasen's \
			own Secure Apprehension Device (also simply known as the stun baton), the contractor baton is able to induce \
			CNS disruption in a target to render them helpless. It is also capable of devastating blunt force trauma if \
			used as a bludgeon. The contractor baton is also capable of telescopic deployment, allowing for discretion while \
			making an approach towards a target, and attachment to MODsuit forearms, if utilizing a specialized magnetic holster.<br>\
			<br>\
			The contractor baton is famously associated with contractors, elite Syndicate field agents. While the standard \
			agent would often be tasked with sabotage, terrorism, murder or theft, contractors have the critical task of \
			kidnapping high value personnel. Anyone with the potential to possess classified or sensitive data about Nanotrasen \
			security systems and devices could be a target for the Syndicate's information gathering operations.<br>\
			<br>\
			Extracting this information is most easily performed on living subjects. As such, the contractor baton was designed \
			with nonlethal incapacitation in mind. However, the Syndicate has long since found workarounds for extracting \
			data from the recently deceased, should the contractor find themselves with only a corpse left to send back. Death \
			may not spare you from the machinations of the Syndicate if they deem you a valuable asset towards their goals.<br>\
			<br>\
			Nanotrasen utilizes a number of countermeasures to contractor insurgencies, such as employing selective memory wiping \
			or falsified memory injection, the establishment of 'dummy' command staff through the artificial acceleration \
			of otherwise incompetent but useful crewmembers (whose incompetence will often result in an acceptable degree \
			of operational disruption), which provides convenient scapegoats in the event of a security breach as well as \
			frequent staff turnover and reassignment." \
	)
