--[[pod_format="raw",created="2024-03-22 02:07:19",modified="2024-03-22 02:08:17",revision=10]]
-- touch is part of Picotron Utilities
-- https://github.com/Rayquaza01/picotron-utilities

cd(env().path)
local argv = env().argv or {}

if (argv[1] == "--help") then
	print("Usage: touch FILE...")
	print("Update the modification time of each FILE to the current time (reads and rewrites the file)")
	print("A FILE argument that does not exist is created empty.")
	exit(0)
end

for i = 1, #argv, 1 do
	-- fetch content of file
	-- if content is nil, change content to blank
	-- otherwise keep it same
	local content = fetch(argv[i])
	if (content == nil) then
		content = ""
	end

	-- write content to file
	store(argv[i], content)
end

exit(0)
