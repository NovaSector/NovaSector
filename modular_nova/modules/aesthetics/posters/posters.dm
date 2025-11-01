//Posters//

//Custom Posters Below//
/obj/structure/sign/poster/contraband/syndicate_medical
	name = "Syndicate Medical"
	desc = "This poster celebrates the complete successful revival of an hour-dead, six person mining team by Syndicate Operatives. Written in the corner is a simple message, 'Stay Winning.'"
	icon = 'modular_nova/modules/aesthetics/posters/icons/contraband.dmi'
	icon_state = "poster_sr_syndiemed"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/syndicate_medical, 32)

/obj/structure/sign/poster/contraband/crocin_pool
	name = "SWIM"
	desc = "This poster dramatically states; 'SWIM'. It seems to be advertising the use of Crocin.. 'recreationally', in the home, work, and, most ominously, 'the pool'. A 'MamoTramsem' logo is in the corner."
	icon = 'modular_nova/modules/aesthetics/posters/icons/contraband.dmi'
	icon_state = "poster_sr_crocin"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/crocin_pool, 32)

/obj/structure/sign/poster/contraband/icebox_moment
	name = "As above, so below"
	desc = "This poster seems to be instill that a 'Head of Security's Office being overtop a syndicate installation is only fitting. As above.. so below.'"
	icon = 'modular_nova/modules/aesthetics/posters/icons/contraband.dmi'
	icon_state = "poster_sr_abovebelow"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/icebox_moment, 32)

/obj/structure/sign/poster/contraband/shipstation
	name = "Flight Services - Enlist"
	desc = "This poster depicts the long deprecated 'Ship' class 'station' in its hayday. Surprisingly, the poster seems to be Nanotrasen official; though with how hush they've been on the topic..." //A disaster as big as Ship deserves a scandalous coverup.
	icon = 'modular_nova/modules/aesthetics/posters/icons/contraband.dmi'
	icon_state = "poster_sr_shipstation"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/shipstation, 32)

/obj/structure/sign/poster/contraband/dancing_honk
	name = "DANCE"
	desc = "This poster depicts a 'HONK' class mech ontop of a stage, next to a pole."
	icon = 'modular_nova/modules/aesthetics/posters/icons/contraband.dmi'
	icon_state = "poster_sr_honkdance"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/dancing_honk, 32)

/obj/structure/sign/poster/contraband/operative_duffy
	name = "CASH REWARD"
	desc = "This poster depicts a gas mask, with details on how to 'forward information' on the whereabouts of whoever it means... though it doesn't specify to who."
	icon = 'modular_nova/modules/aesthetics/posters/icons/contraband.dmi'
	icon_state = "poster_sr_duffy"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/operative_duffy, 32)

/obj/structure/sign/poster/contraband/ultra
	name = "ULTRA"
	desc = "This poster has one word on it, 'ULTRA'; it depicts a smiling pill next to a beaker. Ominous."
	icon = 'modular_nova/modules/aesthetics/posters/icons/contraband.dmi'
	icon_state = "poster_sr_ultra"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/ultra, 32)

/obj/structure/sign/poster/contraband/secborg_vale
	name = "Defaced Valeborg Advertisement"
	desc = "This poster originally sought to advertise the sleek utility of the valeborg - but it seems to have been long since defaced. One word lies on top; 'RUN.' - Perhaps fitting, considering the security model shown."
	icon = 'modular_nova/modules/aesthetics/posters/icons/contraband.dmi'
	icon_state = "poster_sr_valeborg"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/secborg_vale, 32)

/obj/structure/sign/poster/contraband/killingjoke // I like Batman :)))
	name = "You don't have to be crazy to work here - but it sure helps!"
	desc = "A poster boldly stating that being insane abord Nanotrasen stations isn't required. But it doesn't hurt to have!"
	icon = 'modular_nova/modules/aesthetics/posters/icons/contraband.dmi'
	icon_state = "poster_sr_killingjoke"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/killingjoke, 32)

//Replacement for the deathsquad poster
//Given permission by Rai Montroyal's player @81fm (hey i pr'd this in)
/obj/structure/sign/poster/official/enlist
	name = "Enlist" // deathsquad mention removed in favour of asset protection
	desc = "An advertisement for the Central Command Asset Protection strike team."
	icon = 'modular_nova/modules/aesthetics/posters/official.dmi'
	icon_state = "nova_enlist"

/obj/structure/sign/poster/official/enlist/examine_more(mob/user)
	. = ..()
	. += span_notice("<i>You browse some of the poster's information...</i>")
	. += "\t[span_info("The Nanotrasen Central Command Asset Protection team comprises of some of the best individuals in the company.")]"
	. += "\t[span_info("Their main objective is the protection of assets critical to the company and it's continued dominance in the market, as well as people of critical importance to the company.")]"
	. += "\t[span_info("These include but are not limited to:")]"
	. += "\t[span_info("High-Ranking Nanotrasen Navy officers, such as those in the Admiralty; Foreign Diplomats; and company secrets.")]"
	. += "\t[span_info("If you think you have what it takes, enlist today with the Master-At-Arms of your nearest Nanotrasen Interlink facility!")]"
	. += span_notice("<i>You notice it features a certain white-haired cat.</i>")
	return .

/obj/structure/sign/poster/official/nova_signup
	name = "Sign Up"
	desc = "A poster advertising Nanotrasen. Sign up today!"
	icon = 'modular_nova/modules/aesthetics/posters/official.dmi'
	icon_state = "nova_signup"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/nova_signup, 32)

//Given permission by Michael Dudley's player @aganoo, sprite pulled from the wiki
/obj/structure/sign/poster/official/nova_join
	name = "Shield Programme"
	desc = "A poster telling you to join the 'Shield' Protection Programme, one of Nanotrasen's initiatives aimed at keeping their command staff alive. Join today! "
	icon = 'modular_nova/modules/aesthetics/posters/official.dmi'
	icon_state = "nova_join"

/obj/structure/sign/poster/official/join/examine_more(mob/user)
	. = ..()
	. += span_notice("<i>You browse some of the poster's information...</i>")
	. += "\t[span_info("The 'Shield' Protection Programme is a recent security initiative designed to ensure the survival of command staff aboard the numerous stations of Nanotrasen.")]"
	. += "\t[span_info("With threats ranging from pirates to hostile lifeforms and infiltrators from the Sothra Syndicate, Nanotrasen spares little expense in protecting its leaders.")]"
	. += "\t[span_info("'Shield' Operatives are extensively trained in combat, rapid threat assessment, VIP protection, and more, ensuring they can neutralize threats or take those enjoying their protection to safety before the threat can carry out their evil schemes.")]"
	. += "\t[span_info("Their presence is as much a deterrent as they are a fighting force, given a number of exclusive technologies, items, and gear not available to ordinary security forces.")]"
	. += "\t[span_info("Whether escorting captains through hostile zones or reinforcing station security against external threats, the 'Shield' stands as the last line of defense between order and total chaos")]"
	. += "\t[span_info("If you think you have what it takes, join today!")]"
	. += span_notice("<i>You note that it features a certain divorced binturong.</i>")
	return .

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/nova_join, 32)

//Given permission by Orlando Stelle's player @ceciie
/obj/structure/sign/poster/official/nova_mining
	name = "Welcome to the Caves"
	desc = "A poster showing a miner in the Caves of Indicepheries."
	icon = 'modular_nova/modules/aesthetics/posters/official.dmi'
	icon_state = "nova_mining"

/obj/structure/sign/poster/official/mining/examine_more(mob/user)
	. = ..()
	. += span_notice("<i>You look closer at the poster...</i>")
	. += "\t[span_info("The poster has scorch marks on the corners. Typical of the fauna that miners have to fight.")]"
	. += span_notice("<i>You notice it features a certain white-haired excavator.</i>")
	return .

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/nova_mining, 32)
