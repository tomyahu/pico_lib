function Deque()
	return {
		elements = {},

		size = function(self)
			return # self.elements
		end,

		push_first = function(self, new_element)
			add( self.elements, new_element, 1 )
		end,

		push_last = function(self, new_element)
			add( self.elements, new_element )
		end,

		first = function(self)
			return self.elements[1]
		end,

		last = function(self)
			return self.elements[self:size()]
		end,

		pop_first = function(self)
			if self:size() == 0 then
				return nil
			end

			local res = self:first()
			deli( self.elements, 1 )
			return res
		end,

		pop_last = function(self)
			if self:size() == 0 then
				return nil
			end

			local res = self:last()
			deli( self.elements, self:size() )
			return res
		end
	}
end