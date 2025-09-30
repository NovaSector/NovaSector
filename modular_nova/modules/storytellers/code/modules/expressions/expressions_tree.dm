// Storyteller Expression Engine
// Builds an expression tree from JSON and evaluates it against a provided context

/datum/story_expr
	/// Root node spec (decoded JSON list describing the expression) or raw string expression
	var/root

	/// Optional: the original JSON path for debugging
	var/json_path

/// Construct from an already-parsed list (decoded JSON object) or raw string
/datum/story_expr/New(spec)
	..()
	if(islist(spec) || istext(spec))
		root = spec


/// Load expression from a JSON file path and store the root node
/// Returns TRUE on success, FALSE on failure
/datum/story_expr/proc/load_from_json_path(path)
	json_path = path
	if(!fexists(path))
		return FALSE
	var/text = file2text(path)
	if(isnull(text) || !length(text))
		return FALSE
	var/data = safe_json_decode(text)
	if(!islist(data) && !istext(data))
		return FALSE
	root = data
	return TRUE

/// Set expression from raw string text
/datum/story_expr/proc/load_from_string(text)
	if(!istext(text) || !length(text))
		return FALSE
	root = text
	return TRUE


/// Evaluate the root expression against a context map
/// context may include keys like "inputs", "owner", "vault", or any other values needed by expressions
/datum/story_expr/proc/evaluate(list/context)
	if(islist(root))
		return eval_node(root, context)
	if(istext(root))
		return eval_text(root, context)
	return null

/// Recursively evaluate a JSON node (backwards compatibility)
/datum/story_expr/proc/eval_node(list/node, list/context)
	if(!islist(node))
		return node

	var/type = node["type"]
	switch(type)
		if("const")
			return node["value"]

		if("var")
			return resolve_path(node["name"], context)

		if("exists")
			return !isnull(resolve_path(node["name"], context))

		if("unary")
			var/op = node["op"]
			var/val = eval_node(node["expr"], context)
			return eval_unary(op, val)

		if("binary")
			var/op_b = node["op"]
			var/lhs = eval_node(node["left"], context)
			var/rhs = eval_node(node["right"], context)
			return eval_binary(op_b, lhs, rhs)

		if("logic")
			var/op_l = node["op"] // and, or, not
			if(op_l == "not")
				var/v = eval_node(node["expr"], context)
				return !to_bool(v)
			var/l = eval_node(node["left"], context)
			if(op_l == "and")
				return to_bool(l) && to_bool(eval_node(node["right"], context))
			if(op_l == "or")
				return to_bool(l) || to_bool(eval_node(node["right"], context))
			return FALSE

		if("if")
			var/c = eval_node(node["cond"], context)
			if(to_bool(c))
				return eval_node(node["then"], context)
			return eval_node(node["else"], context)

		if("call")
			var/name = lowertext("[node["name"]]")
			var/list/node_args = node["args"]
			return eval_call(name, node_args, context)

		else
			// Unknown node type; return null to be safe
			return null

/// Evaluate a string expression using shunting-yard to RPN and then stack evaluation
/datum/story_expr/proc/eval_text(expr, list/context)
	var/list/tokens = tokenize(expr)
	if(!islist(tokens) || !tokens.len)
		return null
	var/list/rpn = to_rpn(tokens)
	return eval_rpn(rpn, context)

/// Token structure: list of dicts {"type"="num|str|ident|op|lpar|rpar|comma|func", "value"=<text or num>}
/datum/story_expr/proc/tokenize(expr)
	var/list/tokens = list()
	var/i = 1
	while(i <= length(expr))
		var/ch = copytext_char(expr, i, i+1)
		if(ch == " " || ch == "\t" || ch == "\n")
			i++
			continue
		// Numbers
		if(isnum(text2num(ch)) || ch == ".")
			var/start = i
			i++
			while(i <= length(expr))
				var/cc = copytext_char(expr, i, i+1)
				if(!(isnum(text2num(cc)) || cc == ".")) break
				i++
			var/numtxt = copytext(expr, start, i)
			var/num = text2num(numtxt)
			tokens += list(list("type"="num", "value"=num))
			continue
		// Identifiers (variables or function names): letters, _, ., digits
		if((ch >= "A" && ch <= "Z") || (ch >= "a" && ch <= "z") || ch == "_")
			var/start2 = i
			i++
			while(i <= length(expr))
				var/cc2 = copytext_char(expr, i, i+1)
				// Accept letters, digits, underscore, or dot
				if(!((cc2 >= "A" && cc2 <= "Z") || (cc2 >= "a" && cc2 <= "z") || isnum(text2num(cc2)) || cc2 == "_" || cc2 == ".")) break
				i++
			var/word = copytext(expr, start2, i)
			// Peek next non-space to see if function call
			var/j = i
			while(j <= length(expr) && copytext_char(expr, j, j+1) == " ") j++
			if(j <= length(expr) && copytext_char(expr, j, j+1) == "(")
				tokens += list(list("type"="func", "value"=lowertext(word)))
			else
				tokens += list(list("type"="ident", "value"=lowertext(word)))
			// String literals (single or double quoted)
			if(ch == "\"" || ch == "'")
				var/quote = ch
				var/start3 = i + 1
				i++
				while(i <= length(expr) && copytext_char(expr, i, i+1) != quote) i++
				var/val = copytext(expr, start3, i)
				tokens += list(list("type"="str", "value"=val))
				i++ // skip closing quote
				continue
		var/next = i < length(expr) ? copytext_char(expr, i+1, i+2) : ""
		var/op2 = ch + next
		if(op2 in list("<=", ">=", "==", "!=", "&&", "||"))
			tokens += list(list("type"="op", "value"=op2))
			i += 2
			continue
		if(ch == ",")
			tokens += list(list("type"="comma", "value"=","))
			i++
			continue
		if(ch == "(")
			tokens += list(list("type"="lpar", "value"="("))
			i++
			continue
		if(ch == ")")
			tokens += list(list("type"="rpar", "value"=")"))
			i++
			continue
		if(ch in list("+","-","*","/","%","<",">","!","~"))
			tokens += list(list("type"="op", "value"=ch))
			i++
			continue
		// Unknown char
		i++
	return tokens

/// Operator precedence and associativity
/datum/story_expr/proc/op_precedence(op)
	switch(op)
		if("||") return 1
		if("&&") return 2
		if("==","!=","<","<=",">",">=") return 3
		if("+","-") return 4
		if("*","/","%") return 5
		if("!","~") return 6 // unary
		else return 0

/datum/story_expr/proc/is_right_associative(op)
	return op in list("!","~")

/// Convert tokens to RPN (supports functions with arguments)
/datum/story_expr/proc/to_rpn(list/tokens)
	var/list/output = list()
	var/list/stack = list()
	for(var/i = 1 to tokens.len)
		var/list/t = tokens[i]
		var/tt = t["type"]
		var/tv = t["value"]
		if(tt == "num" || tt == "str" || tt == "ident")
			output += list(t)
			continue
		if(tt == "func")
			stack += list(t)
			continue
		if(tt == "comma")
			while(length(stack))
				var/list/top = stack[stack.len]
				if(top["type"] == "lpar") break
				output += list(top); stack.Cut(stack.len, stack.len+1)
			continue
		if(tt == "op")
			var/p1 = op_precedence(tv)
			while(length(stack))
				var/list/top2 = stack[stack.len]
				if(!(top2["type"] == "op")) break
				var/p2 = op_precedence(top2["value"])
				if((!is_right_associative(tv) && p1 <= p2) || (is_right_associative(tv) && p1 < p2))
					output += list(top2); stack.Cut(stack.len, stack.len+1)
				else
					break
			stack += list(t)
			continue
		if(tt == "lpar")
			stack += list(t)
			continue
		if(tt == "rpar")
			while(length(stack) && stack[stack.len]["type"] != "lpar")
				output += list(stack[stack.len]); stack.Cut(stack.len, stack.len+1)
			if(length(stack) && stack[stack.len]["type"] == "lpar")
				stack.Cut(stack.len, stack.len+1)
			// If function on top, pop to output
			if(length(stack) && stack[stack.len]["type"] == "func")
				output += list(stack[stack.len]); stack.Cut(stack.len, stack.len+1)
			continue
	// Drain stack
	while(length(stack))
		output += list(stack[stack.len]); stack.Cut(stack.len, stack.len+1)
	return output

/// Evaluate an RPN list
/datum/story_expr/proc/eval_rpn(list/rpn, list/context)
	var/list/stack = list()
	for(var/i = 1 to rpn.len)
		var/list/t = rpn[i]
		var/tt = t["type"]
		var/tv = t["value"]
		if(tt == "num" || tt == "str")
			stack += list(tv)
			continue
		if(tt == "ident")
			stack += list(resolve_path(tv, context))
			continue
		if(tt == "op")
			// unary vs binary
			if(tv in list("!","~"))
				var/a = stack[stack.len]; stack.Cut(stack.len, stack.len+1)
				stack += list(eval_unary(tv, a))
			else
				var/b = stack[stack.len]; stack.Cut(stack.len, stack.len+1)
				var/a2 = stack[stack.len]; stack.Cut(stack.len, stack.len+1)
				stack += list(eval_binary(tv, a2, b))
			continue
		if(tt == "func")
			// We cannot know arity from token; reconstruct by name with safe patterns by peeking backwards for '(' count.
			// For RPN, arguments are already on stack in order pushed; determine arity from intrinsic name
			var/name = tv
			var/arity = intrinsic_arity(name)
			if(arity < 0)
				// variable-arity like min/max: consume until marker? Here we assume 2 for min/max by default
				arity = 2
			var/list/n_args = list()
			for(var/k in 1 to arity)
				n_args.Insert(1, stack[stack.len])
				stack.Cut(stack.len, stack.len+1)
			stack += list(eval_call(name, n_args, context))
			continue
	return length(stack) ? stack[1] : null

/// Provide arity for safe intrinsics; -1 means variable-arity (handled as 2 by default)
/datum/story_expr/proc/intrinsic_arity(name)
	switch(name)
		if("min","max") return -1
		if("clamp") return 3
		if("ratio") return 2
		if("get") return 2
		else return -1

/// Evaluate a whitelisted intrinsic function
/datum/story_expr/proc/eval_call(name, list/arg_nodes, list/context)
	var/list/values = list()
	if(islist(arg_nodes))
		for(var/i in 1 to arg_nodes.len)
			var/av = islist(arg_nodes[i]) ? eval_node(arg_nodes[i], context) : arg_nodes[i]
			values += list(av)

	switch(name)
		if("min")
			if(!values.len) return null
			var/vmin = values[1]
			for(var/i in 2 to values.len)
				if(values[i] < vmin) vmin = values[i]
			return vmin

		if("max")
			if(!values.len) return null
			var/vmax = values[1]
			for(var/i in 2 to values.len)
				if(values[i] > vmax) vmax = values[i]
			return vmax

		if("clamp")
			if(values.len < 3) return null
			var/v = values[1]
			var/lo = values[2]
			var/hi = values[3]
			if(v < lo) return lo
			if(v > hi) return hi
			return v

		if("ratio")
			if(values.len < 2) return null
			var/a = values[1]
			var/b = values[2]
			if(isnull(b) || b == 0) return null
			return a / b

		if("get")
			// get(container, key)
			if(values.len < 2) return null
			var/container = values[1]
			var/key = values[2]
			if(islist(container))
				return container[key]
			if(isdatum(container))
				var/datum/D = container
				if(istext(key) && (key in D.vars))
					return D.vars[key]
			return null

		// Extend here with more safe intrinsics as needed
		else
			return null

/// Numeric/logical binary operators
/datum/story_expr/proc/eval_binary(op, lhs, rhs)
	switch(op)
		if("+") return lhs + rhs
		if("-") return lhs - rhs
		if("*") return lhs * rhs
		if("/") return rhs == 0 ? null : lhs / rhs
		if("%") return rhs == 0 ? null : lhs % rhs
		if("==") return lhs == rhs
		if("!=") return lhs != rhs
		if("<") return lhs < rhs
		if("<=") return lhs <= rhs
		if(">") return lhs > rhs
		if(">=") return lhs >= rhs
		if("&&") return to_bool(lhs) && to_bool(rhs)
		if("||") return to_bool(lhs) || to_bool(rhs)
		else return null

/// Unary operators: logical not and numeric negation/bitwise not
/datum/story_expr/proc/eval_unary(op, val)
	switch(op)
		if("!") return !to_bool(val)
		if("-") return -val
		if("~") return ~val
		else return null

/// Boolean coercion that treats null/0/"" as false
/datum/story_expr/proc/to_bool(val)
	if(isnull(val)) return FALSE
	if(isnum(val)) return val != 0
	if(istext(val)) return length(val) > 0
	return !!val

/// Resolve a dotted variable path like "inputs.crew_weight" or "vault.some_key"
/datum/story_expr/proc/resolve_path(name, list/context)
	if(isnull(name)) return null
	var/path = "[name]"
	var/list/parts = splittext(path, ".")
	var/current = context
	for(var/i in 1 to parts.len)
		var/key = parts[i]
		if(islist(current))
			current = current[key]
			continue
		if(isdatum(current))
			var/datum/D = current
			if(key in D.vars)
				current = D.vars[key]
				continue
			else
				return null
		return null
	return current

// Convenience proc to evaluate a JSON or string expression file in one call
/proc/story_expr_eval_json(path, list/context)
	var/datum/story_expr/E = new
	if(!E.load_from_json_path(path))
		return null
	return E.evaluate(context)
