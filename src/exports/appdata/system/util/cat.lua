--[[pod_format="raw",created="2024-03-22 02:06:02",modified="2025-07-21 04:19:45",revision=21,xstickers={}]]
-- cat is part of Picotron Utilities
-- https://github.com/Rayquaza01/picotron-utilities

cd(env().path)
local argv = env().argv or {}

if (argv[1] == "--help") then
	print("Usage: cat [FILE]...")
	print("Concatenate FILE(s) to standard output")
	exit(0)
end

for i = 1, #argv, 1 do
	content = fetch(argv[i])
	if content then
		if type(content) == "string" then
			print(content)
		else
			print(pod(content))
		end
	end
end

exit(0)
