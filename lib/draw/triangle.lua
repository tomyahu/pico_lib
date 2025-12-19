-- Draws a triangle given 3 points and a color
function tri(x1, y1, x2, y2, x3, y3, c)
    line(x1, y1, x2, y2, c)
    line(x2, y2, x3, y3, c)
    line(x3, y3, x1, y1, c)
end