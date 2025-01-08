--[[pod_format="raw",created="2024-03-22 02:07:30",modified="2024-03-22 02:08:17",revision=8]]
-- tree is part of Picotron Utilities
-- https://github.com/Rayquaza01/picotron-utilities

cd(env().path)

if (env().argv[1] == "--help") then
	print("Usage: tree [dir]")
	print("Prints a tree of the directory structure.")
	exit(0)
end

local start_path = env().argv[1] or "."

start_path = fullpath(start_path)

-- there seems to be a limitation that makes the earlier output get cut off
-- if there are too many lines printed
-- so i put all of the lines in a variable and print it all at once to get around that
local output = {}

--printh("ls ["..path.."]")

function indent(str, length)
	return string.format("\*%d\t%s", length, str)
end

function print_folder(path, depth)
	local res = ls(path)

	if (not res) then
		print("could not open path "..tostr(path))
		exit(0)
	end

	for file in all(res) do
		-- workaround picotron bug - sometimes ls returns nil in some /system folders
		if file ~= nil then
			local col = "6" -- default color grey

			local ftype, _, origin = fstat(path .. "/" .. file)

			if (ftype == "folder") then
				if not file:find("%.p64$") and not file:find("%.p64%.png$") and not file:find("%.p64%.rom$") then
					col = "e" -- pink, if folder (not p64)
					if origin then
						col = "b" -- green, if virtual folder like /system and /ram
					end
				end

				local filename = string.format("\f%s%s/\f7", col, file)

				add(output, indent(filename, depth))
				print_folder(path .. "/" .. file, depth + 1)
			else
				if file:find("%.lua$") then
					col = "c" -- blue
				elseif file:find("%.txt$") then
					col = "a" -- yellow
				elseif file:find("%.pod$") then
					col = "9" -- orange
				end

				local filename = string.format("\f%s%s\f7", col, file)

				add(output, indent(filename, depth))
			end
			--print(file)
		end
	end
end

print_folder(start_path, 0)
print(table.concat(output, "\n"))
