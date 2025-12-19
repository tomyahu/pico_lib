function mapcircfill(sx, sy, sr, mx, my, mr)
	tline(sx, sy-sr, sx, sy+sr, mx, my - mr, 0, mr / sr)
	for dx=1, sr do
		local mdx = dx / sr * mr
		
		local dy = sqrt( sr*sr - dx*dx )
		local mdy = sqrt( mr*mr - mdx*mdx )

		tline(
			sx-dx, sy-dy, sx-dx, sy+dy,
			mx-mdx, my-mdy, 0, mdy/dy
		)
		tline(
			sx+dx, sy-dy, sx+dx, sy+dy,
			mx+mdx, my-mdy, 0, mdy/dy
		)
	end
end