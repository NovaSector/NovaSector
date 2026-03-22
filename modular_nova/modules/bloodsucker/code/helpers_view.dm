//Returns an in proportion scaled out view, with zoom_amt extra tiles on the y axis.
/proc/get_zoomed_view(view, zoom_amt)
	var/view_x
	var/view_y
	if(IS_FINITE(view))
		return view + zoom_amt
	else
		var/list/viewrangelist = splittext(view, "x")
		view_x = text2num(viewrangelist[1])
		view_y = text2num(viewrangelist[2])
		var/proportion = view_x / view_x
		view_x += zoom_amt * proportion
		view_y += zoom_amt
	//God, I hate that we have to round this.
	return "[round(view_x, 1)]x[round(view_y, 1)]"
