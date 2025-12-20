START_STR = 97 -- First character (a)
BYTE_SIZE = 5 -- Amount of entropy (32)


function get_bit(number, i)
	return (number >> i) & 1
end


function string_to_numbers( string )
	local res = {}

	for i=1,#string do
		add(
			res,
			mid(
				0,
				ord(
					charat(string, i)
				) - START_STR,
				make_mask(1, BYTE_SIZE)
			)
		)
	end

	return res
end


function numbers_to_string( numbers )
	local res = ""

	for _, n in pairs(numbers) do
		res ..= chr(n + START_STR)
	end

	return res
end


-- make_mask: int, int ->
-- makes a mask of continious 1's from right to left
-- from the start bit i to the end bit j
function make_mask(i, j)
	if j == nil then j = i end
	local mask = 0
	for index=i, j do
		mask += 1 << index
	end
	return mask
end


function get_from_number( number, i, j )
	return number & make_mask(i, j)
end


function get_from_numbers( bytes, i, j )
	local start_index = (i \ BYTE_SIZE) + 1
	local end_index = (j \ BYTE_SIZE) + 1
	local res = 0
	local shift_val = - (i % BYTE_SIZE)
	for index = start_index, end_index do
		local byte = bytes[index]
		local bit_pos = ( index - 1 ) * BYTE_SIZE
		res += get_from_number(
			byte,
			mid(0, i - bit_pos, BYTE_SIZE - 1),
			mid(0, j - bit_pos, BYTE_SIZE - 1)
		) << shift_val
		shift_val += BYTE_SIZE
	end
	return res
end

-- Takes a string and and array of how much bits were used to serialize
-- Returns an array of numbers with the decoded values.
function deserialize(string, keys)
	local numbers = string_to_numbers(string)
	local res = {}
	local acc = 0
	for _, key in pairs(keys) do
		add( res, get_from_numbers(numbers, acc, acc + key - 1))
		acc += key
	end

	return res
end


-- Takes an array of numbers and and array of how much bits do we use to serialize
-- Returns a string with the encoded values.
function serialize( array, keys )
	local arr_index = 1
	local acc = 0
	local byte_num = 0
	local res = ""
	for _, k in pairs(keys) do
		arr_val = array[arr_index]

		for i=1,k do
			acc += get_bit(arr_val, i-1) << byte_num
			byte_num += 1

			if byte_num == BYTE_SIZE then
				res ..= chr( START_STR + acc )
				acc = 0
				byte_num = 0
			end
		end
		arr_index += 1
	end

	if byte_num > 0 then
		res ..= chr( START_STR + acc )
	end
	return res
end