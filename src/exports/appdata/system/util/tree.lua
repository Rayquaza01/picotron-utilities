--[[pod_format="raw",created="2024-03-22 02:07:30",modified="2024-03-22 02:08:17",revision=8]]
-- tree is part of Picotron Utilities
-- https://github.com/Rayquaza01/picotron-utilities

cd(env().path)

if (env().argv[1] == "--help") then
	print("Usage: tree [dir]")
	print("Prints a tree of the directory structure.")
	exit(0)
end

local path = env().argv[1] or "."

path = fullpath(path)

-- there seems to be a limitation that makes the earlier output get cut off
-- if there are too many lines printed
-- so i put all of the lines in a variable and print it all at once to get around that
output = {}

--printh("ls ["..path.."]")

function indent(str, length)
	for i = 1, length, 1 do
		str = "	" .. str
	end
	
	return str
end

function print_folder(path, depth)
	local res = ls(path)

	if (not res) then
		print("could not open path "..tostr(path))
		exit(0)
	end
	
	for i = 1, #res, 1 do
		if (fstat(path.."/"..res[i]) == "folder") then
			filename = res[i].."/"
			
			add(output, indent(filename, depth))
			print_folder(path.."/"..res[i], depth + 1)
		else
			add(output, indent(res[i], depth))
		end
		--print(res[i])
	end
end

print_folder(path, 0)
print(table.concat(output, "\n"))
