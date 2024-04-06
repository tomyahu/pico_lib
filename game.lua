overworld_gs = {}
overworld_gs.menu = {
	{
		name='item1'
	},
	{
		name='item2'
	},
}



function overworld_gs.init(self)
end

function overworld_gs.update(self)
end

function overworld_gs.draw(self)
	cls()
	draw_menu(self.menu, 1, 2, 2, 40)
end

gs = overworld_gs