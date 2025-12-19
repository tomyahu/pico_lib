--[[
Requires a table in this form:
menu = {
	{
		'item1',
		function()
	},
	{
		'item2',
		function()
	}
}
]]--
function get_menu(options, witdh)
	if width == nil then width = 40 end

	return {
		menu = options,
		w = width,
		selected = 0,

		next = function(self)
			self.selected = (self.selected + 1) % (#self.menu)
		end,
		back = function(self)
			self.selected = (self.selected + (#self.menu) - 1) % (#self.menu)
		end,

		-- execute the selected option's action
		execute_option = function(self)
			self.menu[self.selected + 1][2]()
		end,
		
		-- draw
		draw = function(self, x, y)
			local height = ( # self.menu ) * 8+2
			rectfill(x, y, x+self.w, y+height, 1)
			rect(x, y, x+self.w, y+height, 7)

			for i, option in pairs( self.menu ) do
				if i == self.selected+1 then
					print( '▶', x+3, y - 5 + i*8, 7)
				end
				print( option[1], x+10, y - 5 + i*8, 7)
			end
		end
	}
end

function draw_menu(menu, selected, x, y, width)
	local height = ( # menu ) * 8 + 1
	rectfill(x, y, x+width, y+height, 1)
	rect(x, y, x+width, y+height, 7)

	for i, option in pairs( menu ) do
		if i == selected then
			print( '★', x+2, y - 6 + i*8, 7)
		end
		print( option.name, x+10, y - 6 + i*8, 7)
	end
end


function draw_text_box( string, x, y,  c1, c2, c3)
	local rect_x = x - (#string)*2 - 2
	local rect_x2 = rect_x + (#string)*4 + 2
	rectfill(rect_x, y, rect_x2, y+8, c2)
	rect(rect_x, y, rect_x2, y+8, c1)
	print_center( string, x, y+2, c3 )
end


function draw_message_box( string, c1, c2, c3 )
	rectfill(0, 112, 127, 127, c2)
	rect(0, 112, 127, 127, c1)
	local s_string = split( string, " " )
	local s_y = 114
	local aux_str = s_string[1]
	for i=2,(#s_string) do
		local word = s_string[i]
		if( (#aux_str) + (#word) + 1 < 31 ) then
			aux_str ..= " " .. word
		else
			print(aux_str, 2, s_y, c3)
			aux_str = word
			s_y += 6

			if s_y > 120 then
				return
			end
		end
	end
	print(aux_str, 2, s_y, c3)
end