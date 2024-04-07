/mob/living/simple_animal/examine(mob/user)
	. = ..()
	//Temporary flavor text addition:
	if(temporary_flavor_text)
		if(length_char(temporary_flavor_text) < TEMPORARY_FLAVOR_PREVIEW_LIMIT)
			. += span_revennotice("<br>They look different than usual: [temporary_flavor_text]")
		else
			. += span_revennotice("<br>They look different than usual: [copytext_char(temporary_flavor_text, 1, TEMPORARY_FLAVOR_PREVIEW_LIMIT)]... <a href='?src=[REF(src)];temporary_flavor=1'>More...</a>")
