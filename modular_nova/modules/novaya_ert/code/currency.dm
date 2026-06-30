/obj/item/stack/spacecash/shaving
	name = "shaving"
	desc = "A tiny hexagonal flake of pure tungsten carbide. The smallest legal tender in Coalition space, \
		serving as the atomic unit of the Mark for rounding adjustments and micro-transactions."
	special_desc = "The Shaving is the atomic unit of Coalition commerce, the smallest divisible piece of the Mark. \
		Each flake weighs exactly 0.3 grams and is cut with laser precision by KMIF fabricators. In theory, a Shaving buys something. \
		A match. A single breath mint. One minute on a public data terminal. In practice, no one carries a single Shaving. \
		They are too small to be worth the pocket space, too easily lost, too fiddly to count. Shavings exist because the Morozov Matrix \
		demands mathematical perfection — a Mark can be divided into 128 equal parts, and so it shall be. \
		The name is a relic of a darker era: before the Matrix's failsafes made 'coin-shaving' \
		(physically clipping edges off coins to hoard metal) impossible. The hexagonal shape was chosen specifically to make such tampering \
		detectable. These days, Shavings are minted by the quadrillions, stacked in KMIF vaults, and almost never see the light of day. \
		When a transaction requires fractions of a Mark, Soft Mark digital ledgers handle it. The physical Shaving is a ghost, a currency that exists \
		mostly as a concept. Rim-world traders have been known to accept 'half a Shaving' by snapping a flake with their teeth, a practice that \
		ruins the edge and drives logistics officers insane. The old Rim saying goes: 'A Shaving in the hand is worth a Soft Mark in the cloud', \
		but no one actually believes it."
	singular_name = "shaving"
	icon = 'modular_nova/modules/novaya_ert/icons/currency.dmi'
	icon_state = "shaving"
	value = 1
	max_amount = 128
	merge_type = /obj/item/stack/spacecash/shaving
	resistance_flags = LAVA_PROOF|FIRE_PROOF // Tungsten carbide has an extremely high melting point.
	custom_materials = list(/datum/material/titanium = COIN_MATERIAL_AMOUNT * 0.1) //Tungsten carbide also doesn't exist so we'll supplement.

/obj/item/stack/spacecash/shaving/update_desc()
	. = ..()
	desc = "[initial(desc)] <br>" + desc

/obj/item/stack/spacecash/shaving/full
	amount = 128

/obj/item/coin/mark
	icon = 'modular_nova/modules/novaya_ert/icons/currency.dmi'
	icon_state = "coin_mark"
	resistance_flags = LAVA_PROOF|FIRE_PROOF
	override_material_worth = TRUE
	material_flags = NONE
	abstract_type = /obj/item/coin/mark

/obj/item/coin/mark/bit
	name = "bit"
	desc = "A small octagonal tungsten carbide coin, edge-milled and stamped with KMIF seal (really, just a 'K'). \
		One Bit is roughly the cost of a cup of coffee and a bun from a food replicator — a working-class business lunch, \
		in pure feedstock and power alone."
	special_desc = "The Bit occupies a peculiar economic niche: too large for rounding adjustments, too small for serious wealth. Its octagonal shape, a deliberate \
		break from the hexagonal Shaving and round Mark, makes it instantly distinguishable by touch in a dark pocket. The edge-milling is not decorative, as it \
		provides grip for automated dispensers and makes counterfeiting marginally more difficult. What does a Bit actually buy? On a Coalition Core-world, \
		a Bit buys a cup of vending machine coffee, but only if the vendor is feeling generous, because coffee is actually 1 Bit and 3 Shavings, and no one \
		carries Shavings. Most vendors simply round up to 2 Bits when handling coin, unless you are using Soft Marks. The Bit is the currency of 'close enough'. \
		For the Coalition's vast working class, -the precision machinists of industrial Mid-worlds, the agricultural workers of Vistula's agri-arcologies-, \
		the Bit is the unit in which they think about small daily indulgences. A tip for a service performed? A Bit or two. A child's allowance? A handful of Bits. \
		A round of drinks with friends? That's usually Marks. The Bit's enduring design, unchanged for over a century, is a quiet statement of stability. \
		While SolFed's Solari fluctuates with political whims, the Bit buys the same stick of gum today that it bought fifty years ago. \
		Which is to say: almost nothing, but reliably almost nothing."
	icon_state = "bit"
	sideslist = list("bit's heads","bit's tails")
	heads_name = "bit's heads"
	value = 4
	custom_materials = list(/datum/material/titanium = COIN_MATERIAL_AMOUNT)

/obj/item/coin/mark/mark //oh hi mark
	name = "\improper Guild Mark"
	desc = "A 2cm round tungsten carbide coin with serrated edges and the Coalition seal. \
		One Mark is the price of a decent meal at a sit-down Mid-world restaurant, as proper as they can get, when that \
		'proper' sells experience more than the food itself."
	special_desc = "The Mark is the foundational denomination of Coalition currency, the unit from which all others derive their name. A 2cm disc of pure \
		tungsten carbide, its serrated edges are a tactile signature, instantly recognizable in the dark by merchants and soldiers alike. The obverse bears the \
		Coalition sun, while the reverse is stamped with the coin's value and a precision engraved batch code traceable to the KMIF fabricator that produced it. \
		In practical terms, a Mark is a 'proper' amount of money. Not the trivial purchase of a Bit (which buys nothing worth mentioning), not the life-changing \
		sum of a Crown. A Mark buys dinner with table service. A KMIF-licensed hand tool for a workshop. A budget hotel room for a night. A standard-issue eight-cell \
		ammunition magazine on the Rim-world flea market. It is the unit in which salaries are discussed and debts are informally reckoned. 'How much do you make?' \
		'Eighty Marks a week.' That means something. The Coalition's psychological relationship with the Mark is unique among interstellar currencies. \
		Because the Mark is backed equally by tungsten carbide reserves and certified labor hours, spending a Mark feels less like exchanging a token and more \
		like trading a small piece of real, physical value. The Morozov Matrix wants every citizen to feel that their money is real, that it represents something \
		tangible, that it is not merely a number in a distant ledger. Whether this psychological engineering is benevolent or merely efficient is a matter of \
		ongoing debate in Coalition philosophy circles."
	icon_state = "mark"
	sideslist = list("mark's heads","mark's tails")
	heads_name = "mark's heads"
	value = 128
	custom_materials = list(/datum/material/titanium = SMALL_MATERIAL_AMOUNT)

/obj/item/coin/mark/crown
	name = "\improper Crown"
	desc = "A 3cm tungsten carbide coin with a central hole and a red trace band. One Crown buys three Zaibas plasma rifles on the Rim. A significant purchase, \
		the kind of money that changes a frontier settlement's defensive capabilities."
	special_desc = "The Crown is where the Mark ceases to be 'pocket change' and becomes 'real money'. A 3cm coin of tungsten carbide alloyed with trace \
		elements that give it a distinctive reddish sheen when held to light, the Crown features a central hole — a deliberate design choice allowing the coins to be \
		strung on a cord or wire for secure transport. Frontier traders have been known to wear belts of Crowns, a conspicuous display of wealth that doubles as a \
		last-resort emergency fund. The red trace band around the coin's edge is not decorative. It is a visible authentication feature, a strip of specially treated \
		alloy that reacts to common counterfeit detection wands. What does a Crown buy? In the Coalition Core, a Crown buys one Zaibas rifle and leaves you with \
		22.60Ɱ in change, enough for ammunition, a knife, a bag of chips, and a very nice dinner. On the Rim, where everything is marked up and the Coalition's reach \
		is thin, that same Crown buys three Zaibas rifles. The difference is transport costs, risk premiums, and the simple fact that a Rim-world militia will pay \
		anything for reliable firepower. The practice of stringing Crowns on leather cords has given rise to a peculiar frontier idiom: a 'string' of Crowns means \
		a substantial amount of money, while a 'loose Crown' means an unexpected expense. 'Counting Crowns' is Rim slang for taking stock of one's situation, financial \
		or otherwise. The EPF's extended field manual notes that a patrol can often de-escalate a tense situation simply by producing a visible string of Crowns, \
		a demonstration of material backing that speaks louder than any verbal reassurance."
	icon_state = "crown"
	sideslist = list("crown's heads(?)","crown's tails(?)")
	heads_name = "crown's heads(?)"
	value = 4096
	custom_materials = list(/datum/material/titanium = SMALL_MATERIAL_AMOUNT * 4)

/obj/item/coin/mark/forge_mark
	name = "\improper Forge Mark"
	desc = "A 5x3x1cm bar of tungsten carbide with an embedded KMIF canister chip, worth 128 Marks. One Forge Mark is approximately one deployment's pre-bonus, \
		pre-tax salary for an Expeditionary Police Force officer. The wage that buys competence, loyalty, and the willingness to face the Rim's dangers."
	special_desc = "The Forge Mark is not a coin, but a small bar, precisely 5 by 3 by 1 centimeters, stamped from solid tungsten carbide. Embedded within its core \
		is a KMIF canister chip — a miniature quantum-sealed authentication device that cannot be removed without destroying the bar. Attempting to counterfeit a Forge \
		Mark is theoretically possible. In practice, no one has ever succeeded, and the three individuals who tried are now serving sentences in Coalition detention \
		facilities, their equipment confiscated and their methods added to KMIF's counterfeiting database. A Forge Mark is serious wealth. 128 Marks. 16,384 Shavings. \
		What does that buy? In the Coalition Core: a leased second-hand cargo shuttle (small, used, probably needs maintenance). A down payment on a small asteroid mining \
		claim. An emergency medical treatment that would otherwise bankrupt a frontier family. A year's tuition at a technical university. A small apartment in a \
		Mid-world city. Thirteen Zaibas rifles. The one-deployment pay of an EPF officer before bonuses and taxes — the wage that buys competence, loyalty, and the \
		willingness to face the Rim's dangers. In the Core-worlds, Soft Marks handle transactions of this magnitude, quantum-encrypted digital transfers verified by \
		the Morozov Matrix. But on the Rim, the Forge Mark's physicality is its entire point. It can be tested. It can be passed from hand to hand without a network, \
		without a power source, without the Matrix's blessing. The EPF's unwritten rule: never flash a Forge Mark in a bar. Not because someone will steal it, \
		-though they will certainly try-, but because the sight of that much concentrated value tends to make people behave unpredictably. A Forge Mark is four \
		months' wages for an unskilled worker. It is the difference between life and death for a Rim-world settlement. Let the Forge Mark sit in its belt pouch, \
		a quiet reassurance, a promise that the Coalition's reach extends even here, even now, even to the edge of nowhere."
	icon_state = "forge_mark"
	sideslist = list("forge_mark_up", "forge_mark_down")
	value = 16384
	custom_materials = list(/datum/material/titanium = SMALL_MATERIAL_AMOUNT * 16)

/obj/item/coin/mark/forge_mark/attack_self(mob/user)
	if(icon_state == "coin_forge_mark_down")
		to_chat(user, span_notice("You flip [src] over to its correct side."))
		icon_state = "coin_forge_mark_up"
		update_appearance()
		return TRUE
	else
		to_chat(user, span_notice("You flip [src] over to its incorrect side."))
		icon_state = "coin_forge_mark_down"
		update_appearance()
		return TRUE
