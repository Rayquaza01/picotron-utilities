--[[pod_format="raw",created="2024-03-22 02:06:24",modified="2024-03-22 02:08:17",revision=15]]
-- frange is part of Picotron Utilities
-- https://github.com/Rayquaza01/picotron-utilities

cd(env().path)
local argv = env().argv

if (argv[1] == "--help" or #argv < 1) then
	print("Usage: frange [FILE] [start] [length]")
	print("Prints a file range with line numbers.")
	print("If start and length are omitted, the entire file is printed")
	print("If start and length are provided, only that range of the file is printed")
	print("If start is negative, lines from the end of the file are printed")
	exit(0)
end

local file = argv[1]
local start = tonum(argv[2]) or 1
local length = tonum(argv[3]) or 0

local content = fetch(file)
if (not content or type(content) != "string") then
	exit(1)
end
local lines = split(content, "\n", false)

if start<0 then
	-- negative start = count from end
	start += #lines+1
end
start = mid(start, 1,#lines)

if (length <= 0) then
	length = #lines
end

--- output
local output = {}
for i = start, min(start + length - 1, #lines), 1 do
	add(output, string.format("%d\t\t%s", i, lines[i]))
end

print(table.concat(output,"\n"))
exit(0)
