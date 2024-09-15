function btoi(b)
	return b and 1 or 0
end

function round(v)
	return flr( v + 0.5 )
end


function print_center(txt, x, y, c)
	txt = tostr(txt);
	x -= (#txt)*2
	y -= 3
	print(txt, x, y, c)
end


function soft_copy( orig )
	local orig_type = type(orig)
	if orig_type != 'table' then return orig end

	local copy = {}
	for orig_key, orig_value in pairs(orig) do
		copy[orig_key] = orig_value
	end

	return copy
end


function deep_copy( orig )
	local orig_type = type(orig)
	if orig_type != 'table' then return orig end

	local copy = {}
	for orig_key, orig_value in pairs(orig) do
		copy[orig_key] = deep_copy( orig_value )
	end

	return copy
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