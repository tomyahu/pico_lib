-- Draws a triangle given 3 points and a color
-- Only draws the borders
function tri(x1, y1, x2, y2, x3, y3, c)
    line(x1, y1, x2, y2, c)
    line(x2, y2, x3, y3, c)
    line(x3, y3, x1, y1, c)
end

-- Draws and fills a triangle given 3 points and a color
function trifill(x1, y1, x2, y2, x3, y3, c)
    if y1 == y2 then return trifill_aux(x3, x1, x2, y3, y1, c) end
    if y2 == y3 then return trifill_aux(x1, x2, x3, y1, y2, c) end
    if y3 == y1 then return trifill_aux(x2, x3, x1, y2, y3, c) end

    tri(x1, y1, x2, y2, x3, y3, c)

    local py_dict = {}
    py_dict[y1] = 1 
    py_dict[y2] = 2 
    py_dict[y3] = 3 
    
    local px_dict = {x1, x2, x3}

    local min_y = min(y1,min(y2,y3))
    local mid_y = mid(y1,y2,y3)
    local max_y = max(y1,max(y2,y3))

    local min_x = px_dict[py_dict[min_y]]
    local mid_x = px_dict[py_dict[mid_y]]
    local max_x = px_dict[py_dict[max_y]]

    trifill_aux(
        min_x, mid_x, min_x + (max_x - min_x) * (mid_y - min_y) / (max_y - min_y),
        min_y, mid_y, c
    )
    trifill_aux(
        max_x, mid_x, max_x + (min_x - max_x) * (max_y - mid_y) / (max_y - min_y),
        max_y, mid_y, c
    )
end

-- Draws amd fills a triangle assuming the second and third point share the same y coordinate
function trifill_aux(x1, x2, x3, y1, y2, c)
    for i=y1,y2,sgn(y2-y1) do
        local tx1 = x1 + (x2-x1) * (i-y1)/(y2-y1)
        local tx2 = x1 + (x3-x1) * (i-y1)/(y2-y1)
        line(tx1, i, tx2, i, c)
    end
end