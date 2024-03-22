--[[pod_format="raw",created="2024-03-22 02:07:42",modified="2024-03-22 02:08:17",revision=5]]
-- wget is part of Picotron Utilities
-- https://github.com/Rayquaza01/picotron-utilities

cd(env().path)
local argv = env().argv

if (argv[1] == "--help" or #argv < 2) then
	print("Usage: wget [src url or file] [file]")
	print("GETs a url or reads a file and saves it to a file.")
	exit(0)
end

local res = fetch(argv[1])
if not res then
	print("Failed to get file or url")
	exit(0)
end

store(argv[2], res)
