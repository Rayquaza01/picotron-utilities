cd(env().path)
local argv = env().argv

if (argv[1] == "--help" or #argv < 1) then
	print("Usage: frange [FILE] [start] [length]")
	print("Prints a file range with line numbers.")
	print("If start and length are omitted, the entire file is printed")
	print("If start and length are provided, only that range of the file is printed")
	exit(0)
end

local file = argv[1]
local start = tonum(argv[2]) or 1
local length = tonum(argv[3]) or 0

local content = fetch(file)
if (not content or type(content) != "string") then
	exit(1)
end

output = ""

local lines = split(content, "\n", false)
if (length <= 0) then
	length = #lines
end

for i = start, min(start + length - 1, #lines), 1 do
	output = output .. string.format("%d		%s", i, lines[i]) .. "\n"
end

print(output)
exit(0)
