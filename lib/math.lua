function round(v)
	return flr( v + 0.5 )
end

function point_in_rect( x, y, x1, y1, width, height )
	return mid(x1, x, x1+width) == x and mid(y1, y, y1+height) == y
end

function rects_intersect( x1, y1, w1, h1, x2, y2, w2, h2 )
	local res = true
	res = res and x1 < x2+w2
	res = res and x2 > x1+w1
	res = res and y1 < y2+h2
	res = res and y2 < y2+h2
end