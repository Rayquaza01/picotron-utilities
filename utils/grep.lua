cd(env().path)
local argv = env().argv

if (argv[1] == "--help" or #argv < 1) then
	print("Usage: grep [pattern] [file or folder]")
	print("Searches for pattern match in a file, and prints all matches")
	print("If a folder is provided, it will recursively search through the folder's contents")
	print("If no folder or file is provided, it will default to the current directory")
	print("Uses lua patterns, not regular expressions. See: https://www.lua.org/pil/20.2.html")
	exit(0)
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

		for i = 1, #lines, 1 do
			if lines[i]:find(pattern) then
				if print_fname then
					add(output, string.format("%s:%d\t\t%s", file, i, lines[i]))
				else
					add(output, string.format("%d\t\t%s", i, lines[i]))
				end
			end


			-- exact match, not needed anymore
			-- for j = 1, #lines[i] - #pattern + 1, 1 do
			-- 	if (pattern == sub(lines[i], j, j + #pattern - 1)) then
			-- 		-- print file name if recursive
			-- 		-- otherwise, just line number
			-- 		if print_fname then
			-- 			output = output .. string.format("%s:%d		%s", file, i, lines[i]) .. "\n"
			-- 		else
			-- 			output = output .. string.format("%d		%s", i, lines[i]) .. "\n"
			-- 		end

			-- 		-- if line matched once, stop checking
			-- 		break
			-- 	end
			-- end
		end
	elseif (filetype == "folder") then
		-- if folder, search recursively
		local dir = ls(file)
		for i = 1, #dir, 1 do
			search_file(pattern, file.."/"..dir[i], true)
		end
	end
end

search_file(pattern, file, false)
print(table.concat(output, "\n"))
