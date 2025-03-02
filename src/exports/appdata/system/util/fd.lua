--[[pod_format="raw",created="2024-11-03 14:42:26",modified="2024-11-03 14:42:26",revision=0]]
-- fd is part of Picotron Utilities
-- https://github.com/Rayquaza01/picotron-utilities
cd(env().path)
local argv = env().argv or {}

local pattern = argv[1]
local search_path = argv[2] or "."

search_path = search_path:gsub("/$", "")

output = {}

if (argv[1] == "--help" or #argv < 1) then
	print("Usage: fd [pattern] [folder]")
	print("Searches for files with a name matching a pattern in the specified folder")
	print("Uses lua patterns, not regular expressions. See: https://www.lua.org/pil/20.2.html")
	exit(0)
end

function search_folder(term, path)
	local res = ls(path)

	if (not res) then
		print("could not open path "..tostr(path))
		exit(0)
	end

	for i = 1, #res, 1 do
		-- search in only last part of file
		local pstart, pend = res[i]:find(term)
		if pstart then
			add(output, string.format(
				"%s/%s\fb%s\f7%s",
				path,
				res[i]:sub(0, pstart - 1),
				res[i]:sub(pstart, pend),
				res[i]:sub(pend + 1, #res[i])
			))
		end

		local fullpath = path.."/"..res[i]
		if fstat(fullpath) == "folder" then
			fullpath = fullpath.."/"
		end

		if (fstat(fullpath) == "folder") then
			search_folder(term, path.."/"..res[i])
		end
		--print(res[i])
	end
end

search_folder(pattern, search_path)
print(table.concat(output, "\n"))
