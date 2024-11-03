--[[pod_format="raw",created="2024-11-03 16:08:38",modified="2024-11-03 16:18:31",revision=1]]
-- stat is part of Picotron Utilities
-- https://github.com/Rayquaza01/picotron-utilities

--- https://github.com/Rayquaza01/enchanted-gemstones/blob/f47d430a438f28000076c1facb836fd4194bf083/enchanted-gemstones/3.p8.lua#L24
--- @param tbl table
--- @param v any
function set_add(tbl, v)
	-- default pos at end of list
	local pos = #tbl + 1
	-- for each item in list
	for i = #tbl, 1, -1 do
		-- if item already in list, return early
		-- each item can only be in list once
		if (tbl[i] == v) then
			return
		end
		-- insert position is sorted
		if (v < tbl[i]) then
			pos = i
		end
		-- break if passed correct position
		if (v > tbl[i]) then
			break
		end
	end
	add(tbl, v, pos)
end

cd(env().path)
local argv = env().argv or {}

if #argv < 1 or argv[1] == "--help" then
	print("Usage: stat [OPTIONS]... [FILE]")
	print("Display file status and metadata")
	print("\nOptions:")
	print("-b, --binary - Use binary prefixes for file sizes")
	print("-s, --metric - use SI (metric) prefixes for file sizes")
	print("-B, --bytes - don't use prefixes for file sizes")
	exit(0)
end

-- set what prefix type to use by default
local prefix = "bi"
local file = ""
local metadata = {}

local conversions = {
	si = {
		prefixes = {"KB", "MB", "GB"},
		K = 1000,
		M = 1000000, -- 1000^2
		G = 1000000000 -- 1000^3
	},
	bi = {
		prefixes = {"KiB", "MiB", "GiB"},
		K = 1024,
		M = 1048576, -- 1024^2
		G = 1073741824 -- 1024^3
	}
}

--- Converts a number of bytes to a readable size
--- @param sz number
--- @return string
function sizeToReadable(sz)
	if prefix == "" then
		return tostr(sz)
	end

	local ctable = prefix == "bi" and conversions.bi or conversions.si

	if sz > ctable.G then
		return string.format("%.2f%s", sz / ctable.G, ctable.prefixes[3])
	elseif sz > ctable.M then
		return string.format("%.2f%s", sz / ctable.M, ctable.prefixes[2])
	elseif sz > ctable.K then
		return string.format("%.2f%s", sz / ctable.K, ctable.prefixes[1])
	end

	return tostr(sz)
end

for arg in all(argv) do
	if arg == "-b" or arg == "--binary" then
		prefix = "bi"
	elseif arg == "-B" or arg == "--bytes" then
		prefix = ""
	elseif arg == "-s" or arg == "--metric" then
		prefix = "si"
	else
		file = arg
	end
end

ftype, size, origin = fstat(argv[1])
if ftype == nil then
	print("Failed to stat file")
	exit(1)
end

print("\feFile\f7: " .. file)
print("\feType\f7: " .. ftype)
if size != nil then
	print("\feSize\f7: " .. sizeToReadable(size))
end
if origin != nil then
	print("\feOrigin\f7: " .. origin)
end

md = fetch_metadata(file)
if md != nil then
	for k, v in pairs(md) do
		set_add(metadata, string.format("\f9%s\f7: %s", k, v))
	end

	print(table.concat(metadata, "\n"))
end
