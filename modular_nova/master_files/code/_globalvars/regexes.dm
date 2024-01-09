//Any EOL char that isn't appropriate punctuation
GLOBAL_DATUM_INIT(has_no_eol_punctuation, /regex, regex(@"[a-zA-Z0-9]$"))

//All non-capitalized 'i' surrounded with whitespace (aka, 'hello >i< am a cat')
GLOBAL_DATUM_INIT(noncapital_i, /regex, regex(@"\b[i]\b", "g"))

//Does the line end in 'unflavored' markdown without a period or other kind of commonly-used accenting text? (aka, +GOD BLESS THE USA+, but not +GOD BLESS THE USA!+)
GLOBAL_DATUM_INIT(ends_in_unflavored_markdown, /regex, regex(@"[^.?!~-][+|_]$"))
