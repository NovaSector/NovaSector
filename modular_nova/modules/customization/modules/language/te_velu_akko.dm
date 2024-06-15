/datum/language/akulan
    name = "Te Velu Akko"
    desc = "Translating to 'The Song of the King', this language was custom-made in Agurkrral to allow those with little education, including aliens, to better integrate into Azulean society. \
			It's easy to learn as a result and is characterised by hard consonants followed by soft vowel strings. \
			An underwater element exists, featuring great emphasis on close physical proximity, variations in pitch, high-frequency sounds, and clicking. \
			This part may require genemods for non-Azulean speakers."


    key = "Z"
    flags = TONGUELESS_SPEECH
    space_chance = 70
    // Syllables derived from the Maori language.
    syllables = list (
        "ā", "ē", "ī", "ō", "a", "e", "i", "o", "u", "ha", "he", "hi", "ho", "hu", "ka", "ke", "ki", "ko", "ku", "ma", "me", "mi", "mo", "mu", "na", "ne", "ni", "no", "nu",
        "nga", "nge", "ngi", "ngo", "ngu", "pa", "pe", "pi", "po", "pu", "ra", "re", "ri", "ro", "ru", "ta", "te", "ti", "to", "tu", "wa", "we", "wi", "wo", "wu", "wha", "whe", "whi",
    )
    icon_state = "azulean"
    icon = 'modular_nova/master_files/icons/misc/language.dmi'
    default_priority = 94
