/obj/item/stack/spacecash/shaving
	name = "shaving"
	desc = "A tiny hexagonal flake of pure tungsten carbide. The smallest legal tender in Coalition space, \
	serving as the atomic unit of the Mark for rounding adjustments and micro-transactions."
	special_desc = "The shaving is the atomic unit of Coalition commerce, the smallest divisible piece of the Mark. \
	Each flake weighs exactly 0.3 grams and is cut with laser precision by KMIF fabricators. The name is a relic of a darker, \
	less stable era: before the Morozov Matrix's failsafes made counterfeiting and 'coin-shaving' impossible. Once, \
	disreputable traders would physically shave edges off coins to hoard the precious metal, eventually remelting the clippings \
	into new, fraudulent currency. The hexagonal flake's weight was chosen specifically to make this practice detectable; a \
	shaving's precise mass makes any alteration immediately obvious to automated scales. The hexagonal shape itself isn't \
	decorative - it allows automated sorting systems to handle millions of shavings per hour without jamming. In practice, \
	physical shavings are rare in the Core worlds; most citizens use Soft Mark digital ledgers for transactions this small. \
	But on the Rim, where quantum encryption is a distant dream and power grids fail as often as they function, the humble \
	shaving is king. Barkeeps and traders have been known to accept 'half a shaving' by snapping a flake with their teeth, a \
	practice that ruins the edge and drives logistics officers insane. The old Rim saying goes: 'A shaving in the hand is worth a Soft Mark in the cloud.'"
	singular_name = "shaving"
	icon = 'modular_nova/modules/novaya_ert/icons/currency.dmi'
	icon_state = "shaving"
	value = 1
	max_amount = 128
	resistance_flags = FIRE_PROOF // Tungsten carbide has an extremely high melting point.
	custom_materials = list(/datum/material/titanium = COIN_MATERIAL_AMOUNT * 0.25) //Tungsten carbide also doesn't exist so we'll supplement.

/obj/item/coin/mark
	resistance_flags = FIRE_PROOF

/obj/item/coin/mark/bit
	name = "bit"
	desc = "A small octagonal tungsten carbide coin, edge-milled and stamped with the Coalition seal. \
	One Bit is roughly the cost of a cup of coffee and a bun from a food replicator — a working-class business lunch, \
	in pure materials and electricity alone."
	special_desc = "The Bit occupies a peculiar economic niche: too large for rounding adjustments, too small for serious wealth. \
	Its octagonal shape, a deliberate break from the hexagonal shaving and round Mark, makes it instantly distinguishable by touch in a pocket or purse. \
	The edge-milling is not decorative; it provides grip for automated dispensers and makes counterfeiting marginally more difficult. \
	Economists call the Bit 'the currency of daily dignity'. A single Bit buys a hot meal, a caffeine dose, a cheap data slate application, \
	or a single dose of a common over-the-counter medication. For the Coalition's vast working class, -the precision machinists of Krasnyy Poyas, \
	the agricultural workers of Vistula's agri-arcologies, the fabricator tenders of a dozen industrial moons-, the Bit is the unit in which they \
	think about their day. A wage is measured in Forge Marks. A budget is measured in Crowns. But a lunch break? A tip for a service performed? \
	A small indulgence at the end of a shift? That is Bits. The Bit's enduring design, unchanged for over a century, is a quiet statement of stability. \
	While SolFed's Solari fluctuates with political whims, the Bit buys the same cup of coffee today that it bought fifty years ago."
	icon_state = "bit"
	value = 4
	custom_materials = list(/datum/material/titanium = COIN_MATERIAL_AMOUNT)

/obj/item/coin/mark/mark //oh hi mark
	name = "\improper Mark"
	desc = "A 2cm round tungsten carbide coin with serrated edges and the Coalition seal. \
	One Mark is the price of a decent meal at a sit-down Mid-world restaurant, as proper as they can get, when that \
	'proper' sells experience more than food alone."
	special_desc = "The Mark is the foundational denomination of Coalition currency, the unit from which all others derive their name. \
	A 2cm disc of pure tungsten carbide, its serrated edges are a tactile signature, instantly recognizable in the dark by merchants and soldiers alike. \
	The obverse bears the Coalition seal, a stylized sunburst over interlocking rings, while the reverse is stamped with the coin's value and a batch code \
	traceable to the KMIF fabricator that produced it. In practical terms, a Mark is a 'proper' amount of money. Not the trivial purchase of a Bit, \
	not the life-changing sum of a Crown. A Mark buys a dinner with table service, a KMIF-licensed tool for a workshop, a budget hotel room for a night, \
	or a standard-issue eight cell ammunition magazine on the Rim-world market. It is the unit in which salaries are discussed and debts are informally reckoned. \
	The Coalition's psychological relationship with the Mark is unique among interstellar currencies. Because the Mark is backed equally by tungsten carbide \
	reserves and certified labor hours, spending a Mark feels less like exchanging a token and more like trading a small piece of real, physical value. \
	This is by design. The Matrix, governing Coalition currency, wants every citizen to feel that their money is real, that it represents something tangible, \
	that it is not merely a number in a distant ledger. Whether this psychological engineering is benevolent or merely efficient is a matter of ongoing \
	debate in Coalition philosophy circles."
	icon_state = "mark"
	value = 128
	custom_materials = list(/datum/material/titanium = SMALL_MATERIAL_AMOUNT)

/obj/item/coin/mark/crown
	name = "\improper Crown"
	desc = "A 3cm tungsten carbide coin with a central hole and a red trace band. One Crown buys three Zaibas plasma rifles on the Rim. A significant purchase, \
	the kind of money that changes a frontier settlement's defensive capabilities."
	special_desc = "The Crown is where the Mark ceases to be 'pocket change' and becomes 'real money'. A 3cm coin of tungsten carbide alloyed with \
	trace elements that give it a distinctive reddish sheen when held to light, the Crown features a central hole, a deliberate design choice allowing the coins to \
	be strung on a cord or wire for secure transport. Frontier traders have been known to wear belts of Crowns, a conspicuous display of wealth that \
	doubles as a last-resort emergency fund. The red trace band around the coin's edge is not decorative. It is a visible authentication feature, \
	a strip of specially treated alloy that reacts to common counterfeit detection wands. A single Crown is a month's rent on a small workshop. \
	A squad's worth of sidearms. A used industrial fabricator's down payment. On the Rim, where the Coalition's reach is thin and Solaris is \
	treated with suspicion, Crowns are the language of serious negotiation. The practice of stringing Crowns on leather cords has given rise to a \
	peculiar frontier idiom: a 'string' of Crowns means a substantial amount of money, while a 'loose Crown' means an unexpected expense. \
	'Counting Crowns' is Rim slang for taking stock of one's situation, financial or otherwise. The EPF's extended field manual notes that a patrol can \
	often de-escalate a tense situation simply by producing a visible string of Crowns, a demonstration of material \
	backing that speaks louder than any verbal reassurance."
	icon_state = "crown"
	value = 4096
	custom_materials = list(/datum/material/titanium = SMALL_MATERIAL_AMOUNT * 4)

/obj/item/coin/mark/forge_mark
	name = "\improper Forge Mark"
	desc = "A 5x3x1cm bar of tungsten carbide with an embedded KMIF canister chip, worth 128 Marks. One Forge Mark is approximately one deployment's pre-bonus, \
	pre-tax salary for an Expeditionary Police Force officer. The wage that buys competence, loyalty, and the willingness to face the Rim's dangers."
	special_desc = "The Forge Mark is not a coin. It is a small bar, precisely 5 centimeters by 3 centimeters by 1 centimeter, stamped from solid tungsten carbide. \
	Embedded within its core is a KMIF canister chip — a miniature quantum-sealed authentication device that cannot be removed without destroying the bar. \
	Attempting to counterfeit a Forge Mark is theoretically possible. In practice, no one has ever succeeded, and the three individuals who tried are now serving \
	sentences in Coalition detention facilities, their equipment confiscated and their methods added to KMIF's counterfeiting database. A Forge Mark is serious \
	wealth. 128 Marks. The one deployment wage of an EPF officer before bonuses and taxes. The price of a second-hand cargo shuttle. A down payment on a small asteroid \
	claim. An emergency medical treatment that would otherwise bankrupt a frontier family. The Forge Mark's existence as a physical object is itself a statement. \
	In the Core-worlds, Soft Marks handle transactions of this magnitude, quantum-encrypted digital transfers verified by the Morozov Matrix. But on the Rim, \
	the Forge Mark's physicality is its entire point. A Forge Mark can be held. It can be tested. It can be bitten (though this is not recommended; \
	tungsten carbide is harder than tooth enamel). It can be passed from hand to hand without a network, without a power source, without the Matrix's blessing. \
	The EPF's unwritten rule: never flash a Forge Mark in a bar. Not because someone will steal it, -though they will certainly try-, but because the sight of \
	that much concentrated value tends to make people behave unpredictably. Better to pay in Crowns. Let the Forge Mark sit in its belt pouch, a quiet reassurance, \
	a promise that the Coalition's reach extends even here, even now, even to the edge of nowhere."
	icon_state = "forge_mark"
	value = 16384
	custom_materials = list(/datum/material/titanium = SMALL_MATERIAL_AMOUNT * 16)
