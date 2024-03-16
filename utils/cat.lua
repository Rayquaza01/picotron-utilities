cd(env().path)
local argv = env().argv

if (argv[1] == "--help") then
	print("Usage: cat [FILE]...")
	print("Concatenate FILE(s) to standard output")
	exit(0)
end

for i = 1, #argv, 1 do
	content = fetch(argv[i])
	if content then
		print(content)
	end
end

exit(0)
