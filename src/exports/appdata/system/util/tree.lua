--[[pod_format="raw",created="2024-03-22 02:07:30",modified="2025-02-23 03:19:47",revision=19]]
-- tree is part of Picotron Utilities
-- https://github.com/Rayquaza01/picotron-utilities

cd(env().path)

-- set to false to disable file type icons
local ICONS = true

local icons = {
	LUA="\^:803c4e4e7e7e3c00",
	TXT="\^:3e5276425e427e00",
	IMAGE="\^:7e6252464a527e00",
	BINARY="\^:00466d4d4b4be600",
	FONT="\^:000205255755a500",
	AUDIO="\^:003c242424363600",
	PICOTRON="\^:3e7f5f70077d7f3e",
	FILE="\^:3e52724242427e00",
	FOLDER="\^:00307e7e7e7e7e00"
}

local function get_icon(ext)
	if ext == "lua" then
		return icons.LUA
	elseif ext == "txt" or ext == "md" then
		return icons.TXT
	elseif ext == "gfx" or ext == "png" or ext == "map" or ext == "qoi" then
		return icons.IMAGE
	elseif ext == "pod" then
		return icons.BINARY
	elseif ext == "sfx" then
		return icons.AUDIO
	elseif ext == "p64" or ext == "p64.png" or ext == "rom" then
		return icons.PICOTRON
	elseif ext == "font" then
		return icons.FONT
	end

	return icons.FILE
end

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
			local ico = ""

			if (ftype == "folder") then
				ico = icons.FOLDER
				if not file:find("%.p64$") and not file:find("%.p64%.png$") and not file:find("%.p64%.rom$") then
					col = "e" -- pink, if folder (not p64)
					if origin then
						col = "b" -- green, if virtual folder like /system and /ram
					end
				else
					ico = icons.PICOTRON
				end

				if not ICONS then
					ico = ""
				end
				local filename = string.format("\f%s%s%s/\f7", col, ico, file)

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

				if ICONS then
					ico = get_icon(file:ext())
				end

				local filename = string.format("\f%s%s%s\f7", col, ico, file)

				add(output, indent(filename, depth))
			end
			--print(file)
		end
	end
end

print_folder(start_path, 0)
print(table.concat(output, "\n"))
