// Replaces the name and traits for the original syndicate jumpercable, as it was abused to break the economy and power hard with minimal investment and afk effort.
/obj/item/fish/jumpercable
	name = "sterile jumpercable"
	desc = "A once runaway experiment from the syndicate fish labs. Its reckless self-breeding burned out its \
			own genetics, leaving it sterile. Still hungrily self-feeds, generating power like a living cable \
			plugged into the void."
	fish_traits = list(
		/datum/fish_trait/no_mating,
		/datum/fish_trait/mixotroph,
		/datum/fish_trait/electrogenesis,
	)
