overworld_gs = {}
overworld_gs.menu = get_menu({
	{
		'item1'
	},
	{
		'item2'
	},
	{
		'item3'
	},
	{
		'item4'
	},
})



function overworld_gs.init(self)
end

function overworld_gs.update(self)
	if just_pressed(2) then self.menu:back() end
	if just_pressed(3) then self.menu:next() end
end

function overworld_gs.draw(self)
	cls()
	self.menu:draw(0,0)
end

gs = overworld_gs