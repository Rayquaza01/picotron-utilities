--[[pod_format="raw",created="2024-03-22 00:45:03",modified="2024-08-21 16:47:38",revision=273]]
-- grep is part of Picotron Utilities
-- https://github.com/Rayquaza01/picotron-utilities

cd(env().path)
local argv = env().argv or {}

if (argv[1] == "--help" or #argv < 1) then
	print("Usage: grep [pattern] [file or folder]")
	print("Searches for pattern match in a file, and prints all matches")
	print("If a folder is provided, it will recursively search through the folder's contents")
	print("If no folder or file is provided, it will default to the current directory")
	print("Uses lua patterns, not regular expressions. See: https://www.lua.org/pil/20.2.html")
	exit(0)
end

function right_pad(str, len, pad)
	if not pad then pad = " " end
	while #str < len do
		str = str .. pad
	end

	return str
end

local pattern = argv[1]
local file = argv[2] or "."

output = {}

function search_file(pattern, file, print_fname)
	local filetype = fstat(file)

	if (filetype == "file") then
		local content = fetch(file)
		-- ignore blank or non text files
		if not content or type(content) != "string" then
			return
		end

		local lines = split(content, "\n", false)

		-- print("searching " .. file)

		line_number_length = #tostr(#lines) + 1

		for i = 1, #lines, 1 do
			-- if you want to make grep use exact matching instead of pattern matching
			-- add the plain=true arg to find
			-- https://www.lua.org/manual/5.4/manual.html#pdf-string.find
			local pstart, pend = lines[i]:find(pattern)
			if pstart then
				local l = lines[i]:gsub("\t", " ")
				l = string.format(
					"%s\fb%s\f7%s",
					l:sub(0, pstart - 1),
					l:sub(pstart, pend),
					l:sub(pend + 1, #l)
				)

				local line_no = right_pad(tostr(i), line_number_length)

				if print_fname then
					add(output, string.format("%s:%s%s", file, line_no, l))
				else
					add(output, string.format("%s%s", line_no, l))
				end
			end
		end
	elseif (filetype == "folder") then
		-- if folder, search recursively
		local dir = ls(file)
		for i = 1, #dir, 1 do
			-- workaround picotron bug - sometimes ls returns nil in some /system folders
			if dir[i] ~= nil then
				search_file(pattern, file.."/"..dir[i], true)
			end
		end
	end
end

search_file(pattern, file, false)
print(table.concat(output, "\n"))
