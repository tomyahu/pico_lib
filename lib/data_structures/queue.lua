function queue()
	return {
		elements = {},

		size = function(self)
			return # self.elements
		end,

		push = function(self, new_element)
			add( self.elements, new_element )
		end,

		top = function(self)
			return self.elements[1]
		end,

		pop = function(self)
			if self:size() == 0 then
				return nil
			end

			local res = self:top()
			deli( self.elements, 1 )
			return res
		end
	}
end