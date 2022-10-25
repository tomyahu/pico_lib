gs = {}
gs.init = function() end
gs.update = function() end
gs.draw = function() end

__btn = {}
__mouse = 0
function just_pressed(i)
	return btn(i) and not __btn[i]
end


function mouse_pos()
	poke(0x5F2D, 1)
	return{
		stat(32),
		stat(33)
	}
end


function mouse_click()
	poke(0x5F2D, 1)
	return stat(34)
end


function just_clicked()
	return mouse_click() & (~__mouse)
end


-- MAIN LOOP
function _init()
	gs:init()
	for i=0,5 do __btn[i] = btn(i) end
end


function _update()
	gs:update()
end


function _draw()
	gs:draw()
	for i=0,5 do __btn[i] = btn(i) end
	__mouse = mouse_click()
end