function new_scheduler()
	return {
		current_time = 0,
		scheduled_functions={},
		schedule_function= function(self, func, frames)
			local time_hash = "" .. (frames+self.current_time)
			if self.scheduled_functions[time_hash] == nil then
				self.scheduled_functions[time_hash] = {}
			end
			add(self.scheduled_functions[time_hash], func)
		end,
		update=function(self)
			self.current_time += 1
			
			local time_hash = "" .. self.current_time
			if self.scheduled_functions[time_hash] != nil then
				for func in all(self.scheduled_functions[time_hash]) do
					func()
				end
				self.scheduled_functions[time_hash] = nil
			end

		end,
		clear=function(self)
			self.scheduled_functions = {}
		end
	}
end