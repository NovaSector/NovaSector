/// List of all holiday-related mail. Do not edit this directly, instead add to var/list/holiday_mail
GLOBAL_LIST_INIT(holiday_mail, list())

/datum/holiday
	///Name of the holiday itself. Visible to players.
	var/name = "Если вы видите это, значит код праздничного календаря сломан."

	///What day of begin_month does the holiday begin on?
	var/begin_day = 1
	///What month does the holiday begin on?
	var/begin_month = 0
	/// What day of end_month does the holiday end? Default of 0 means the holiday lasts a single.
	var/end_day = 0
	/// What month does the holiday end on?
	var/end_month = 0
	/// for christmas neverending, or testing. Forces a holiday to be celebrated.
	var/always_celebrate = FALSE
	/// Held variable to better calculate when certain holidays may fall on, like easter.
	var/current_year = 0
	/// How many years are you offsetting your calculations for begin_day and end_day on. Used for holidays like easter.
	var/year_offset = 0
	///Timezones this holiday is celebrated in (defaults to three timezones spanning a 50 hour window covering all timezones)
	var/list/timezones = list(TIMEZONE_LINT, TIMEZONE_UTC, TIMEZONE_ANYWHERE_ON_EARTH)
	///If this is defined, drones/assistants without a default hat will spawn with this item in their head clothing slot.
	var/obj/item/holiday_hat
	///When this holiday is active, does this prevent mail from arriving to cargo? Overrides var/list/holiday_mail. Try not to use this for longer holidays.
	var/no_mail_holiday = FALSE
	/// The list of items we add to the mail pool. Can either be a weighted list or a normal list. Leave empty for nothing.
	var/list/holiday_mail = list()
	var/poster_name = "gпраздничный плакат «Энерик»"
	var/poster_desc = "Плакат к какому-то празднику. К сожалению, он незакончен, поэтому не видно, что это за праздник."
	var/poster_icon = "holiday_unfinished"
	/// Color scheme for this holiday
	var/list/holiday_colors
	/// The default pattern of the holiday, if the requested pattern is null.
	var/holiday_pattern = PATTERN_DEFAULT

// This proc gets run before the game starts when the holiday is activated. Do festive shit here.
/datum/holiday/proc/celebrate()
	if(no_mail_holiday)
		SSeconomy.mail_blocked = TRUE
	if(LAZYLEN(holiday_mail) && !no_mail_holiday)
		GLOB.holiday_mail += holiday_mail
	return

// When the round starts, this proc is ran to get a text message to display to everyone to wish them a happy holiday
/datum/holiday/proc/greet()
	return "Счастливого вам [name]!"

// Returns special prefixes for the station name on certain days. You wind up with names like "Christmas Object Epsilon". See new_station_name()
/datum/holiday/proc/getStationPrefix()
	//get the first word of the Holiday and use that
	var/i = findtext(name, " ")
	return copytext(name, 1, i)

// Return 1 if this holidy should be celebrated today
/datum/holiday/proc/shouldCelebrate(dd, mm, yyyy, ddd)
	if(always_celebrate)
		return TRUE

	if(!end_day)
		end_day = begin_day
	if(!end_month)
		end_month = begin_month
	if(end_month > begin_month) //holiday spans multiple months in one year
		if(mm == end_month) //in final month
			if(dd <= end_day)
				return TRUE

		else if(mm == begin_month)//in first month
			if(dd >= begin_day)
				return TRUE

		else if(mm in begin_month to end_month) //holiday spans 3+ months and we're in the middle, day doesn't matter at all
			return TRUE

	else if(end_month == begin_month) // starts and stops in same month, simplest case
		if(mm == begin_month && (dd in begin_day to end_day))
			return TRUE

	else // starts in one year, ends in the next
		if(mm >= begin_month && dd >= begin_day) // Holiday ends next year
			return TRUE
		if(mm <= end_month && dd <= end_day) // Holiday started last year
			return TRUE

	return FALSE

/// Procs to return holiday themed colors for recoloring atoms
/datum/holiday/proc/get_holiday_colors(atom/thing_to_color, pattern = holiday_pattern)
	if(!holiday_colors)
		return
	switch(pattern)
		if(PATTERN_DEFAULT)
			return holiday_colors[(thing_to_color.y % holiday_colors.len) + 1]
		if(PATTERN_VERTICAL_STRIPE)
			return holiday_colors[(thing_to_color.x % holiday_colors.len) + 1]

/proc/request_holiday_colors(atom/thing_to_color, pattern)
	switch(pattern)
		if(PATTERN_RANDOM)
			return "#[random_short_color()]"
		if(PATTERN_RAINBOW)
			var/datum/holiday/pride_week/rainbow_datum = new()
			return rainbow_datum.get_holiday_colors(thing_to_color, PATTERN_DEFAULT)
	if(!length(GLOB.holidays))
		return
	for(var/holiday_key in GLOB.holidays)
		var/datum/holiday/holiday_real = GLOB.holidays[holiday_key]
		if(!holiday_real.holiday_colors)
			continue
		return holiday_real.get_holiday_colors(thing_to_color, pattern || holiday_real.holiday_pattern)

// The actual holidays

// JANUARY

//Fleet Day is celebrated on Jan 19th, the date on which moths were merged (#34498)
/datum/holiday/fleet_day
	name = "День флота"
	begin_month = JANUARY
	begin_day = 19
	holiday_hat = /obj/item/clothing/head/mothcap

/datum/holiday/fleet_day/greet()
	return "В этот день отмечается ещё один год успешного выживания на борту флота Великих кочевников Мотыльков. Мотыльков по всей галактике призывают есть, пить и веселиться."

/datum/holiday/fleet_day/getStationPrefix()
	return pick("Моль", "Флот", "Кочевник")

// FEBRUARY

/datum/holiday/groundhog
	name = "День сурка"
	begin_day = 2
	begin_month = FEBRUARY

/datum/holiday/groundhog/getStationPrefix()
	return pick("Дежавю") //I have been to this place before

/datum/holiday/nz
	name = "День Вайтанги"
	timezones = list(TIMEZONE_NZDT, TIMEZONE_CHADT)
	begin_day = 6
	begin_month = FEBRUARY
	holiday_colors = list(
		COLOR_UNION_JACK_BLUE,
		COLOR_WHITE,
		COLOR_UNION_JACK_RED,
		COLOR_WHITE,
	)

/datum/holiday/nz/getStationPrefix()
	return pick("Аотеароа","Киви","Рыба с картофелем фри","Какапо","Южный Крест")

/datum/holiday/nz/greet()
	var/nz_age = text2num(time2text(world.timeofday, "YYYY", TIMEZONE_NZST)) - 1840
	return "В этот день, [nz_age] лет назад, в Новой Зеландии был подписан Договор Вайтанги — учредительный документ государства!"

/datum/holiday/valentines
	name = VALENTINES
	begin_day = 13
	end_day = 15
	begin_month = FEBRUARY
	poster_name = "Любовный постер"
	poster_desc = "A poster celebrating all the relationships built today. Of course, you probably don't have one."
	poster_icon = "holiday_love"
	holiday_mail = list(
		/obj/item/food/bonbon/chocolate_truffle,
		/obj/item/food/candyheart,
		/obj/item/food/grown/rose,
		)

/datum/holiday/valentines/getStationPrefix()
	return pick("Любовь","Аморе","Одинокий","Смутч","Обнимать","Святой Валентин","Романтика")

/datum/holiday/birthday
	name = "День рождения космической станции 13"
	begin_day = 16
	begin_month = FEBRUARY
	holiday_hat = /obj/item/clothing/head/costume/festive
	poster_name = "Плакат ко дню рождения станции"
	poster_desc = "Плакат, отмечающий ещё одну годовщину работы станции. Почему кто-то был бы рад здесь оказаться, вам не понять."
	poster_icon = "holiday_cake" // is a lie
	holiday_mail = list(
		/obj/item/clothing/mask/party_horn,
		/obj/item/food/cakeslice/birthday,
		/obj/item/sparkler,
		/obj/item/storage/box/party_poppers,
	)

/datum/holiday/birthday/greet()
	var/game_age = text2num(time2text(world.timeofday, "YYYY", world.timezone)) - 2003
	var/Fact
	switch(game_age)
		if(16)
			Fact = " SS13 теперь достаточно взрослый, чтобы водить!"
		if(18)
			Fact = " SS13 теперь совершеннолетний!"
		if(21)
			Fact = " SS13 теперь может бухать!"
		if(26)
			Fact = " SS13 теперь можно водить машину!"
		if(30)
			Fact = " SS13 теперь может вернуться домой и стать семьянином!"
		if(35)
			Fact = " SS13 теперь может баллотироваться на пост президента США!"
		if(40)
			Fact = " SS13 теперь может пережить кризис среднего возраста!"
		if(50)
			Fact = " С золотым юбилеем!"
		if(65)
			Fact = " SS13 теперь может задуматься о выходе на пенсию!"
	if(!Fact)
		Fact = " SS13 сейчас [game_age] лет!"

	return "Поздравляем с днём рождения Space Station 13, впервые представленную публике 16 февраля 2003 года![Fact]"

/datum/holiday/random_kindness
	name = "День спонтанного проявления доброты"
	begin_day = 17
	begin_month = FEBRUARY
	poster_name = "плакат с частичкой доброты"
	poster_desc = "Плакат, оповещающий читателя о том, что сегодня — День «Проявления доброты». Какое приятное событие!"
	poster_icon = "holiday_kind"

/datum/holiday/random_kindness/greet()
	return "Сделайте несколько случайных добрых дел для незнакомца!" //haha yeah right

/datum/holiday/leap
	name = "Високосный день"
	begin_day = 29
	begin_month = FEBRUARY

// MARCH

/datum/holiday/pi
	name = "День числа Пи"
	begin_day = 14
	begin_month = MARCH
	poster_name = "плакат ко дню числа Пи"
	poster_desc = "Плакат, посвящённый 3,141529-му дню года. Зато пирог бесплатный."
	poster_icon = "holiday_pi"
	holiday_mail = list(
		/obj/item/food/pieslice/apple,
		/obj/item/food/pieslice/bacid_pie,
		/obj/item/food/pieslice/blumpkin,
		/obj/item/food/pieslice/cherry,
		/obj/item/food/pieslice/frenchsilk,
		/obj/item/food/pieslice/frostypie,
		/obj/item/food/pieslice/meatpie,
		/obj/item/food/pieslice/pumpkin,
		/obj/item/food/pieslice/shepherds_pie,
		/obj/item/food/pieslice/tofupie,
		/obj/item/food/pieslice/xemeatpie,
	)

/datum/holiday/pi/getStationPrefix()
	return pick("Синус","Косинус","Тангенс","Секущая", "Косеканс", "Котангенс", "Радиан", "Диаметр", "Окружность", "КОТангенс")

/datum/holiday/no_this_is_patrick
	name = "День Святого Патрика"
	begin_day = 17
	begin_month = MARCH
	holiday_hat = /obj/item/clothing/head/soft/green
	holiday_colors = list(
		COLOR_IRISH_GREEN,
		COLOR_WHITE,
		COLOR_IRISH_ORANGE,
	)
	holiday_pattern = PATTERN_VERTICAL_STRIPE
	/// Could we settle this over a pint?
	holiday_mail = list(
		/obj/item/reagent_containers/cup/glass/bottle/ale,
		/obj/item/reagent_containers/cup/glass/drinkingglass/filled/irish_cream,
	)

/datum/holiday/no_this_is_patrick/getStationPrefix()
	return pick("Бларни","Зеленый","Лепрекон","Выпивка","Клевер","Шамрок","Ирландия")

/datum/holiday/no_this_is_patrick/greet()
	return "С Национальным днем ​​опьянения!"

// APRIL

/datum/holiday/april_fools
	name = APRIL_FOOLS
	begin_month = APRIL
	begin_day = 1
	end_day = 2
	holiday_hat = /obj/item/clothing/head/chameleon/broken
	holiday_mail = list(
		/obj/item/clothing/head/costume/whoopee,
		/obj/item/grown/bananapeel/gros_michel,
	)

/datum/holiday/april_fools/celebrate()
	. = ..()
	SSjob.set_overflow_role(/datum/job/clown)
	SSticker.set_lobby_music('sound/music/lobby_music/clown.ogg', override = TRUE)
	for(var/i in GLOB.new_player_list)
		var/mob/dead/new_player/P = i
		if(P.client)
			P.client.playtitlemusic()

/datum/holiday/april_fools/get_holiday_colors(atom/thing_to_color)
	return "#[random_short_color()]"

/datum/holiday/spess
	name = "День космонавтики"
	begin_day = 12
	begin_month = APRIL
	holiday_hat = /obj/item/clothing/head/syndicatefake

/datum/holiday/spess/greet()
	return "В этот день, более 600 лет назад, товарищ Юрий Гагарин впервые отправился в космос!"

/datum/holiday/fourtwenty
	name = "Четыре-двадцать"
	begin_day = 20
	begin_month = APRIL
	holiday_hat = /obj/item/clothing/head/rasta
	holiday_colors = list(
		COLOR_ETHIOPIA_GREEN,
		COLOR_ETHIOPIA_YELLOW,
		COLOR_ETHIOPIA_RED,
	)
	holiday_mail = list(/obj/item/cigarette/rollie/cannabis)

/datum/holiday/fourtwenty/getStationPrefix()
	return pick("Снуп","Тупой","Жетон","Данк","Чич","Чонг")

/datum/holiday/tea
	name = "Национальный день чая"
	begin_day = 21
	begin_month = APRIL
	holiday_mail = list(/obj/item/reagent_containers/cup/glass/mug/tea)

/datum/holiday/tea/getStationPrefix()
	return pick("Крампет","Ассам","Улун","Пуэр","Сладкий чай","Зелёный","Чёрный")

/datum/holiday/earth
	name = "День Земли"
	begin_day = 22
	begin_month = APRIL

/datum/holiday/anz
	name = "День АНЗАК"
	timezones = list(TIMEZONE_TKT, TIMEZONE_TOT, TIMEZONE_NZST, TIMEZONE_NFT, TIMEZONE_LHST, TIMEZONE_AEST, TIMEZONE_ACST, TIMEZONE_ACWST, TIMEZONE_AWST, TIMEZONE_CXT, TIMEZONE_CCT, TIMEZONE_CKT, TIMEZONE_NUT)
	begin_day = 25
	begin_month = APRIL
	holiday_hat = /obj/item/food/grown/poppy

/datum/holiday/anz/getStationPrefix()
	return pick("Австралийский","Новая Зеландия","Мак","Южный Крест")

// MAY

/datum/holiday/labor
	name = "День Труда"
	begin_day = 1
	begin_month = MAY
	holiday_hat = /obj/item/clothing/head/utility/hardhat
	no_mail_holiday = TRUE

//Draconic Day is celebrated on May 3rd, the date on which the Draconic language was merged (#26780)
/datum/holiday/draconic_day
	name = "День драконьего языка"
	begin_month = MAY
	begin_day = 3

/datum/holiday/draconic_day/greet()
	return "В этот день ящеролюди чествуют свой язык посредством литературы и других культурных произведений."

/datum/holiday/draconic_day/getStationPrefix()
	return pick("Драконий", "Литература", "Чтение")

/datum/holiday/firefighter
	name = "День пожарного"
	begin_day = 4
	begin_month = MAY
	holiday_hat = /obj/item/clothing/head/utility/hardhat/red
	holiday_mail = list(/obj/item/extinguisher/mini)

/datum/holiday/firefighter/getStationPrefix()
	return pick("Горящий","Пылающий","Плазма","Огонь")

/datum/holiday/bee
	name = "День пчел"
	begin_day = 20
	begin_month = MAY
	holiday_mail = list(
		/obj/item/clothing/suit/hooded/bee_costume,
		/obj/item/food/honeycomb,
		/obj/item/food/monkeycube/bee,
		/obj/item/toy/plush/beeplushie,
	)

/datum/holiday/bee/getStationPrefix()
	return pick("Пчела","Мед","Улей","Африканизированный","Мёд","Жужжание", "Трутень", "Жжжжжж")

/datum/holiday/goth
	name = "День гота"
	begin_day = 22
	begin_month = MAY
	holiday_mail = list(
		/obj/item/lipstick,
		/obj/item/lipstick/black,
		/obj/item/clothing/suit/costume/gothcoat,
	)
	holiday_colors = list(
		COLOR_WHITE,
		COLOR_BLACK,
	)

/datum/holiday/goth/getStationPrefix()
	return pick("Гот", "Сангвин", "Тенебрис", "Лакримоза", "Умбра", "Ноктис")
// JUNE

//The Festival of Atrakor's Might (Tizira's Moon) is celebrated on June 15th, the date on which the lizard visual revamp was merged (#9808)
/datum/holiday/atrakor_festival
	name = "Фестиваль мощи Атракора"
	begin_month = JUNE
	begin_day = 15

/datum/holiday/atrakor_festival/greet()
	return "В этот день ящеры традиционно отмечают Фестиваль могущества Атракора, во время которого они чтят бога луны, щедро украшая его одеждами, угощая большими порциями еды и устраивая масштабное празднование до самой ночи."

/datum/holiday/atrakor_festival/getStationPrefix()
	return pick("Луна", "Ночное небо", "Торжество")

/// Garbage DAYYYYY
/// Huh?.... NOOOO
/// *GUNSHOT*
/// AHHHGHHHHHHH
/datum/holiday/garbageday
	name = GARBAGEDAY
	begin_day = 17
	end_day = 17
	begin_month = JUNE
	holiday_mail = list(
		/obj/effect/spawner/random/trash/garbage,
		/obj/item/storage/bag/trash,
	)

/datum/holiday/summersolstice
	name = "Летнее солнцестояние"
	begin_day = 21
	begin_month = JUNE
	holiday_hat = /obj/item/clothing/head/costume/garland

/datum/holiday/pride_week
	name = PRIDE_WEEK
	begin_month = JUNE
	// Stonewall was June 28th, this captures its week.
	begin_day = 23
	end_day = 29
	holiday_colors = list(
		COLOR_PRIDE_PURPLE,
		COLOR_PRIDE_BLUE,
		COLOR_PRIDE_GREEN,
		COLOR_PRIDE_YELLOW,
		COLOR_PRIDE_ORANGE,
		COLOR_PRIDE_RED,
	)
	holiday_mail = list(
		/obj/item/bedsheet/rainbow,
		/obj/item/clothing/accessory/pride,
		/obj/item/clothing/gloves/color/rainbow,
		/obj/item/clothing/head/costume/garland/rainbowbunch,
		/obj/item/clothing/head/soft/rainbow,
		/obj/item/clothing/shoes/sneakers/rainbow,
		/obj/item/clothing/under/color/jumpskirt/rainbow,
		/obj/item/clothing/under/color/rainbow,
		/obj/item/food/egg/rainbow,
		/obj/item/food/grown/rainbow_flower,
		/obj/item/food/snowcones/rainbow,
		/obj/item/toy/crayon/rainbow,
	)

// JULY

/datum/holiday/doctor
	name = "День доктора"
	begin_day = 1
	begin_month = JULY
	holiday_hat = /obj/item/clothing/head/costume/nursehat
	holiday_mail = list(
		/obj/item/stack/medical/gauze,
		/obj/item/stack/medical/ointment,
		/obj/item/storage/box/bandages,
	)

/datum/holiday/ufo
	name = "День НЛО"
	begin_day = 2
	begin_month = JULY
	holiday_hat = /obj/item/clothing/head/collectable/xenom
	holiday_mail = list(
		/obj/item/toy/plush/abductor,
		/obj/item/toy/plush/abductor/agent,
		/obj/item/toy/plush/rouny,
		/obj/item/toy/toy_xeno,
	)

/datum/holiday/ufo/getStationPrefix() //Is such a thing even possible?
	return pick("Ага","Правда","Цукалос","Малдер","Скалли") //Yes it is!

/datum/holiday/usa
	name = "День независимости США"
	timezones = list(TIMEZONE_EDT, TIMEZONE_CDT, TIMEZONE_MDT, TIMEZONE_MST, TIMEZONE_PDT, TIMEZONE_AKDT, TIMEZONE_HDT, TIMEZONE_HST)
	begin_day = 4
	begin_month = JULY
	no_mail_holiday = TRUE
	holiday_hat = /obj/item/clothing/head/cowboy/brown
	holiday_colors = list(
		COLOR_OLD_GLORY_BLUE,
		COLOR_OLD_GLORY_RED,
		COLOR_WHITE,
		COLOR_OLD_GLORY_RED,
		COLOR_WHITE,
	)


/datum/holiday/usa/getStationPrefix()
	return pick("Независимый","американский","Бургер","Белоголовый орлан","Звездно-полосатый", "Фейерверк")

/datum/holiday/writer
	name = "День писателя"
	begin_day = 8
	begin_month = JULY
	holiday_mail = list(/obj/item/pen/fountain)

/datum/holiday/france
	name = "День взятия Бастилии"
	timezones = list(TIMEZONE_CEST)
	begin_day = 14
	begin_month = JULY
	holiday_hat = /obj/item/clothing/head/beret
	no_mail_holiday = TRUE
	holiday_colors = list(
		COLOR_FRENCH_BLUE,
		COLOR_WHITE,
		COLOR_FRENCH_RED
	)
	holiday_pattern = PATTERN_VERTICAL_STRIPE

/datum/holiday/france/getStationPrefix()
	return pick("французский", "Сыр", "Проклятие", "Дерьмо", "Сакребле", "Багет", "Вино")

/datum/holiday/france/greet()
	return "Слышишь, как поют люди?"

/datum/holiday/hotdogday
	name = HOTDOG_DAY
	begin_day = 17
	begin_month = JULY
	holiday_mail = list(/obj/item/food/hotdog)

/datum/holiday/hotdogday/greet()
	return "С Национальным днем ​​хот-дога!"

//Gary Gygax's birthday, a fitting day for Wizard's Day
/datum/holiday/wizards_day
	name = "День мага"
	begin_month = JULY
	begin_day = 27
	holiday_hat = /obj/item/clothing/head/wizard

/datum/holiday/wizards_day/getStationPrefix()
	return pick("Подземный", "Эльфийский", "Магия", "D20", "Издание")

/datum/holiday/friendship
	name = "День дружбы"
	begin_day = 30
	begin_month = JULY
	holiday_mail = list(/obj/item/food/grown/apple)

/datum/holiday/friendship/greet()
	return "Пусть у тебя будет волшебное [name]!"

// AUGUST

/datum/holiday/indigenous //Indigenous Peoples' Day from Earth!
	name = "Международный день коренных народов мира"
	begin_month = AUGUST
	begin_day = 9

/datum/holiday/indigenous/getStationPrefix()
	return pick("Исчезающий язык", "Слово", "Язык", "Возрождение языка", "Картофель", "Кукуруза")

// AUGUST

/datum/holiday/ukraine
	name = "День независимости Малоруссии"
	begin_month = AUGUST
	begin_day = 24
	holiday_colors = list(COLOR_TRUE_BLUE, COLOR_TANGERINE_YELLOW)

/datum/holiday/ukraine/getStationPrefix()
	return pick("Киев", "Малороссия", "Новороссия", "Слабожанщина", "Галичина")

// SEPTEMBER

//Tiziran Unification Day is celebrated on Sept 1st, the day on which lizards were made a roundstart race
/datum/holiday/tiziran_unification
	name = "День объединения Тизирана"
	begin_month = SEPTEMBER
	begin_day = 1
	holiday_hat = /obj/item/clothing/head/costume/lizard
	holiday_mail = list(/obj/item/toy/plush/lizard_plushie)

/datum/holiday/tiziran_unification/greet()
	return "В этот день более 400 лет назад ящерообразные впервые объединились под единым знаменем, готовые встретить звезды как единый народ."

/datum/holiday/tiziran_unification/getStationPrefix()
	return pick("Тизира", "Ящерица", "Имперская")

/datum/holiday/ianbirthday
	name = IAN_HOLIDAY //github.com/tgstation/tgstation/commit/de7e4f0de0d568cd6e1f0d7bcc3fd34700598acb
	begin_month = SEPTEMBER
	begin_day = 9
	end_day = 10
	holiday_mail = list(
		/obj/item/bedsheet/ian,
		/obj/item/bedsheet/ian/double,
		/obj/item/clothing/suit/costume/wellworn_shirt/graphic/ian,
		/obj/item/clothing/suit/costume/wellworn_shirt/messy/graphic/ian,
		/obj/item/clothing/suit/costume/wellworn_shirt/wornout/graphic/ian,
		/obj/item/clothing/suit/hooded/ian_costume,
		/obj/item/radio/toy,
		/obj/item/toy/figure/ian,
	)

/datum/holiday/ianbirthday/greet()
	return "С днем ​​рождения, Иэн!"

/datum/holiday/ianbirthday/getStationPrefix()
	return pick("Иэн", "Корги", "Эрро")

/datum/holiday/pirate
	name = "День пиратских говоров"
	begin_day = 19
	begin_month = SEPTEMBER
	holiday_hat = /obj/item/clothing/head/costume/pirate
	holiday_mail = list(/obj/item/clothing/head/costume/pirate)

/datum/holiday/pirate/greet()
	return "Сегодня ты говоришь как пират, а не то пойдёшь на доску, приятель!"

/datum/holiday/pirate/getStationPrefix()
	return pick("Ярр","Цинга","Йо-хо-хо")

/datum/holiday/questions
	name = "День глупых вопросов"
	begin_day = 28
	begin_month = SEPTEMBER

/datum/holiday/questions/greet()
	return "У вас счастливые дни [name]?"

// OCTOBER

/datum/holiday/animal
	name = "День животных"
	begin_day = 4
	begin_month = OCTOBER

/datum/holiday/animal/getStationPrefix()
	return pick("Попугай","Корги","Кот","Мопс","Козел","Лиса","Енот","Панда","Ежик","Волк","Тигр")

/datum/holiday/smile
	name = "День Улыбки"
	begin_day = 7
	begin_month = OCTOBER
	holiday_hat = /obj/item/clothing/head/costume/papersack/smiley
	holiday_mail = list(/obj/item/sticker/smile)

/datum/holiday/boss
	name = "День босса"
	begin_day = 16
	begin_month = OCTOBER
	holiday_hat = /obj/item/clothing/head/hats/tophat

/datum/holiday/un_day
	name = "Годовщина основания Организации Объединенных Наций"
	begin_month = OCTOBER
	begin_day = 24

/datum/holiday/un_day/greet()
	return "В этот день в 1945 году была основана Организация Объединенных Наций, заложив основу единого правительства человечества!"

/datum/holiday/un_day/getStationPrefix()
	return pick("Соединенные", "Сотрудничество", "Гуманитарный")

/datum/holiday/halloween
	name = HALLOWEEN
	begin_day = 29
	begin_month = OCTOBER
	end_day = 2
	end_month = NOVEMBER
	holiday_colors = list(COLOR_MOSTLY_PURE_ORANGE, COLOR_PRISONER_BLACK)
	holiday_mail = list(
		/obj/item/food/cookie/sugar/spookycoffin,
		/obj/item/food/cookie/sugar/spookyskull,
		)

/datum/holiday/halloween/greet()
	return "Желаем вам жуткого Хэллоуина!"

/datum/holiday/halloween/getStationPrefix()
	return pick("Грохочущий кости","Собственность мистера Костяна","Очень жуткий","Жуткий","Страшный","Скелеты")

// NOVEMBER

/datum/holiday/vegan
	name = "День вегана"
	begin_day = 1
	begin_month = NOVEMBER
	holiday_mail = list(/obj/item/food/tofu)

/datum/holiday/vegan/getStationPrefix()
	return pick("Тофу", "Темпе", "Сейтан", "Тофуркей")

/datum/holiday/october_revolution
	name = "Октябрьская революция"
	begin_day = 6
	begin_month = NOVEMBER
	end_day = 7
	holiday_colors = list(
		COLOR_MEDIUM_DARK_RED,
		COLOR_GOLD,
		COLOR_MEDIUM_DARK_RED,
	)

/datum/holiday/october_revolution/getStationPrefix()
	return pick("Коммунистический", "Советский", "Большевик", "Социалистический", "Красный", "Рабочие'")

/datum/holiday/remembrance_day
	name = "Remembrance Day"
	begin_month = NOVEMBER
	begin_day = 11
	holiday_hat = /obj/item/food/grown/poppy
	holiday_mail = list(
		/obj/item/food/grown/harebell,
		/obj/item/food/grown/poppy,
		/obj/item/storage/fancy/candle_box,
	)

/datum/holiday/remembrance_day/greet()
	return "Чтобы мы не забывали."

/datum/holiday/remembrance_day/getStationPrefix()
	return pick("Мир", "Перемирие", "Мак", "Память")

/datum/holiday/lifeday
	name = "День жизни"
	begin_day = 17
	begin_month = NOVEMBER

/datum/holiday/lifeday/getStationPrefix()
	return pick("Зудящий", "Комковатый", "Малла", "Казук") //he really pronounced it "Kazook", I wish I was making shit up

/datum/holiday/kindness
	name = "День доброты"
	begin_day = 13
	begin_month = NOVEMBER

/datum/holiday/flowers
	name = "День цветов"
	begin_day = 19
	begin_month = NOVEMBER
	holiday_hat = /obj/item/food/grown/moonflower
	holiday_mail = list(
		/obj/item/food/grown/harebell,
		/obj/item/food/grown/moonflower,
		/obj/item/food/grown/poppy,
		/obj/item/food/grown/poppy/geranium,
		/obj/item/food/grown/poppy/geranium/fraxinella,
		/obj/item/food/grown/poppy/lily,
		/obj/item/food/grown/rose,
		/obj/item/food/grown/sunflower,
		/obj/item/grown/carbon_rose,
		/obj/item/grown/novaflower,
	)

/datum/holiday/hello
	name = "День приветствия"
	begin_day = 21
	begin_month = NOVEMBER

/datum/holiday/hello/greet()
	return "[pick(list("Aloha", "Halo", "Hello", "Hi", "Greetings", "Salutations", "Bienvenidos", "Hola", "Howdy", "Ni hao", "Guten Tag", "Konnichiwa", "G'day cunt"))]! " + ..()

//The Festival of Holy Lights is celebrated on Nov 28th, the date on which ethereals were merged (#40995)
/datum/holiday/holy_lights
	name = "Фестиваль Святого Огня"
	begin_month = NOVEMBER
	begin_day = 28
	/// If there's more of them I forgot
	holiday_mail = list(
		/obj/item/food/energybar,
		/obj/item/food/pieslice/bacid_pie,
	)

/datum/holiday/holy_lights/greet()
	return "Праздник Святого Света — последний день эфириальского календаря. Обычно это день молитвы, за которым следует праздничное празднование, чтобы торжественно завершить год."

/datum/holiday/holy_lights/getStationPrefix()
	return pick("Эфериальский", "Фонарь", "Святой", "Огонь", "Свет")

// DECEMBER

/datum/holiday/festive_season
	name = FESTIVE_SEASON
	begin_day = 1
	begin_month = DECEMBER
	end_day = 31
	holiday_hat = /obj/item/clothing/head/costume/santa

/datum/holiday/festive_season/greet()
	return "Хороших вам праздников!"

/datum/holiday/human_rights
	name = "День прав человека"
	begin_day = 10
	begin_month = DECEMBER

/datum/holiday/monkey
	name = MONKEYDAY
	begin_day = 14
	begin_month = DECEMBER

/datum/holiday/monkey/celebrate()
	. = ..()
	SSstation.setup_trait(/datum/station_trait/job/pun_pun)

/datum/holiday/doomsday
	name = "Годовщина Судного дня майя"
	begin_day = 21
	begin_month = DECEMBER

/datum/holiday/xmas
	name = CHRISTMAS
	begin_day = 18
	begin_month = DECEMBER
	end_day = 27
	holiday_hat = /obj/item/clothing/head/costume/santa
	no_mail_holiday = TRUE
	holiday_colors = list(
		COLOR_CHRISTMAS_GREEN,
		COLOR_CHRISTMAS_RED,
	)

/datum/holiday/xmas/getStationPrefix()
	return pick(
		"Библейская",
		"День рождения Христова",
		"Камин",
		"Клаус",
		"Распятие",
		"Эльф",
		"Пихта",
		"Хо! Хо! Хо!",
		"Иисус",
		"Весёлье",
		"Счастливая",
		"Подарок",
		"Мешок",
		"Санта",
		"Сани",
		"Святки",
	)

/datum/holiday/xmas/greet()
	return "Счастливого Рождества!"

/datum/holiday/boxing
	name = "День подарков"
	begin_day = 26
	begin_month = DECEMBER
	holiday_mail = list(
		/obj/item/clothing/gloves/boxing,
		/obj/item/clothing/gloves/boxing/blue,
		/obj/item/clothing/gloves/boxing/green,
		/obj/item/clothing/gloves/boxing/yellow,
	)

/datum/holiday/new_year
	name = NEW_YEAR
	begin_day = 31
	begin_month = DECEMBER
	end_day = 2
	end_month = JANUARY
	holiday_hat = /obj/item/clothing/head/costume/festive
	no_mail_holiday = TRUE

/datum/holiday/new_year/getStationPrefix()
	return pick("Вечеринка","Новая","Похмелье","Разрешение", "Старого Нового Года")

// MOVING DATES

/datum/holiday/friday_thirteenth
	name = "Пятница 13-е"

/datum/holiday/friday_thirteenth/shouldCelebrate(dd, mm, yyyy, ddd)
	if(dd == 13 && ddd == FRIDAY)
		return TRUE
	return FALSE

/datum/holiday/friday_thirteenth/getStationPrefix()
	return pick("Майк","Пятница","Зло","Майерс","Убийство","Смертельный","Джейсон", "Вурхиз")

/datum/holiday/programmers
	name = "День программиста"
	holiday_mail = list(/obj/item/sticker/robot)

/datum/holiday/programmers/shouldCelebrate(dd, mm, yyyy, ddd) //Programmer's day falls on the 2^8th day of the year
	if(mm == 9)
		if(yyyy/4 == round(yyyy/4)) //Note: Won't work right on September 12th, 2200 (at least it's a Friday!)
			if(dd == 12)
				return TRUE
		else
			if(dd == 13)
				return TRUE
	return FALSE

/datum/holiday/programmers/getStationPrefix()
	return pick("span>","DEBUG: ","null","/list","EVENT PREFIX NOT FOUND") //Portability

// ISLAMIC

/datum/holiday/islamic
	name = "Код исламского календаря сломан"

/datum/holiday/islamic/shouldCelebrate(dd, mm, yyyy, ddd)
	var/datum/foreign_calendar/islamic/cal = new(yyyy, mm, dd)
	return ..(cal.dd, cal.mm, cal.yyyy, ddd)

/datum/holiday/islamic/ramadan
	name = "Начало Рамадана"
	begin_month = 9
	begin_day = 1
	end_day = 3

/datum/holiday/islamic/ramadan/getStationPrefix()
	return pick("Харам","Халяль","Джихад","Муслим", "Аль", "Мохаммед", "Рашидун", "Омейяды", "Аббасиды", "Абдул", "Фатимид", "Айюбиды", "Альмохады", "Абу")

/datum/holiday/islamic/ramadan/end
	name = "Конец Рамадана"
	end_month = 10
	begin_day = 28
	end_day = 1

// HEBREW

/datum/holiday/hebrew
	name = "Если вы видите это, значит код еврейского праздничного календаря поврежден."

/datum/holiday/hebrew/shouldCelebrate(dd, mm, yyyy, ddd)
	var/datum/foreign_calendar/hebrew/cal = new(yyyy, mm, dd)
	return ..(cal.dd, cal.mm, cal.yyyy, ddd)

/datum/holiday/hebrew/hanukkah
	name = "Ханука"
	begin_day = 25
	begin_month = 9
	end_day = 2
	end_month = 10

/datum/holiday/hebrew/hanukkah/greet()
	return "Счастливой [pick("Хануки", "Ханука")]!"

/datum/holiday/hebrew/hanukkah/getStationPrefix()
	return pick("Дрейдл", "Менора", "Латкес", "Гелт")

/datum/holiday/hebrew/passover
	name = "Пасха"
	begin_day = 15
	begin_month = 1
	end_day = 22

/datum/holiday/hebrew/passover/getStationPrefix()
	return pick("Маца", "Моисей", "Красное море")

// HOLIDAY ADDONS

/datum/holiday/xmas/celebrate()
	. = ..()
	SSticker.OnRoundstart(CALLBACK(src, PROC_REF(roundstart_celebrate)))
	GLOB.maintenance_loot += list(
		list(
			/obj/item/clothing/head/costume/santa = 1,
			/obj/item/gift/anything = 1,
			/obj/item/toy/xmas_cracker = 3,
		) = maint_holiday_weight,
	)

/datum/holiday/xmas/proc/roundstart_celebrate()
	for(var/obj/machinery/computer/security/telescreen/entertainment/Monitor as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/computer/security/telescreen/entertainment))
		Monitor.icon_state_on = "entertainment_xmas"

	for(var/mob/living/basic/pet/dog/corgi/ian/Ian in GLOB.mob_living_list)
		Ian.place_on_head(new /obj/item/clothing/head/helmet/space/santahat(Ian))


// EASTER (this having its own spot should be understandable)

/datum/holiday/easter
	name = EASTER
	holiday_hat = /obj/item/clothing/head/costume/rabbitears
	holiday_mail = list(
		/obj/item/clothing/head/costume/rabbitears,
		/obj/item/food/chocolatebunny,
		/obj/item/food/chocolateegg,
		/obj/item/food/egg/blue,
		/obj/item/food/egg/green,
		/obj/item/food/egg/orange,
		/obj/item/food/egg/purple,
		/obj/item/food/egg/rainbow,
		/obj/item/food/egg/red,
		/obj/item/food/egg/yellow,
	)
	var/const/days_early = 1 //to make editing the holiday easier
	var/const/days_extra = 1

/datum/holiday/easter/shouldCelebrate(dd, mm, yyyy, ddd)
	if(!begin_month)
		current_year = text2num(time2text(world.timeofday, "YYYY", world.timezone))
		var/list/easterResults = EasterDate(current_year+year_offset)

		begin_day = easterResults["day"]
		begin_month = easterResults["month"]

		end_day = begin_day + days_extra
		end_month = begin_month
		if(end_day >= 32 && end_month == MARCH) //begins in march, ends in april
			end_day -= 31
			end_month++
		if(end_day >= 31 && end_month == APRIL) //begins in april, ends in june
			end_day -= 30
			end_month++

		begin_day -= days_early
		if(begin_day <= 0)
			if(begin_month == APRIL)
				begin_day += 31
				begin_month-- //begins in march, ends in april

	return ..()

/datum/holiday/easter/celebrate()
	. = ..()
	GLOB.maintenance_loot += list(
		list(
			/obj/item/surprise_egg = 15,
			/obj/item/storage/basket/easter = 15
		) = maint_holiday_weight,
	)

/datum/holiday/easter/greet()
	return "Привет! Счастливой Пасхи и ждите пасхальных кроликов!"

/datum/holiday/easter/getStationPrefix()
	return pick("Пушистый","Кролик","Пасха","Яйцо","Шоколад","Весенний")

/// Takes a holiday datum, a starting month, ending month, max amount of days to test in, and min/max year as input
/// Returns a list in the form list("yyyy/m/d", ...) representing all days the holiday runs on in the tested range
/proc/poll_holiday(datum/holiday/path, min_month, max_month, min_year, max_year, max_day)
	var/list/deets = list()
	for(var/year in min_year to max_year)
		for(var/month in min_month to max_month)
			for(var/day in 1 to max_day)
				var/datum/holiday/new_day = new path()
				if(new_day.shouldCelebrate(day, month, year, iso_to_weekday(day_of_month(year, month, day))))
					deets += "[year]/[month]/[day]"
	return deets

/// Does the same as [/proc/poll_holiday], but prints the output to admins instead of returning it
/proc/print_holiday(datum/holiday/path, min_month, max_month, min_year, max_year, max_day)
	var/list/deets = poll_holiday(path, min_month, max_month, min_year, max_year, max_day)
	message_admins("The accepted dates for [path] in the input range [min_year]-[max_year]/[min_month]-[max_month]/1-[max_day] are [deets.Join("\n")]")
