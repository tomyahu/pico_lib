function new_camera()
	return {
		offset_x = 0,
		offset_y = 0,
		current_time = t(),
		shake_end_time = 0,
		shake_x = 0,
		shake_y = 0,
		shake_t = 0,
		_x = 0,
		_y = 0,
		update = function(self)
			local shake_dt = self.shake_end_time - self.current_time
			if shake_dt > 0 then
				self._x = self.shake_x * shake_dt / self.shake_t
				self._y = self.shake_y * shake_dt / self.shake_t
			else
				self._x = 0
				self._y = 0
			end

			camera(self._x + self.offset_x, self._y + self.offset_y)
			self.current_time = t()
		end,
		screenshake = function(self, amount, time)
			if time == nil then time = 1 end
			if amount == nil then amount = 1 end


			self.shake_end_time = self.current_time + time
			self.shake_t = time

			local aux = rnd()
			self.shake_x = cos(aux) * amount
			self.shake_y = sin(aux) * amount
		end
	} 
end