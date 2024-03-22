--[[pod_format="raw",created="2024-03-15 13:58:36",modified="2024-03-22 02:08:17",revision=414]]
-- Picotron Utilities v1.0
-- https://github.com/Rayquaza01/picotron-utilities
-- by Arnaught

function includes(tbl, val)
	for i = 1, #tbl, 1 do
		if tbl[i] == val then
			return true
		end
	end
	
	return false
end

cd(env().path)
argv = env().argv
pkg = env().prog_name

commands_path = pkg .. "/exports/appdata/system/util"

-- error message if try to run cart with ctrl+r
if not pkg:find("%.p64$") then
	print("This cart can't be run directly!")
	print("Please run this from the commandline.")
	
	print("")
	
	print("To install as a bundle command, save this cart to your util path")
	print("\tsave /appdata/system/util/busybox")
	print("Then, you can run a bundled command by passing that command as an argument")
	print("\tbusybox tree")
	
	print("")
	
	print("To install individual commands, install this cart with yotta")
	print("\tyotta util install #picotron_utilities")

	print("")	

	print("You can also manually copy the files from /exports inside this cart")
	print("\tcp /ram/cart/exports/appdata/system/util/grep.lua /appdata/system/util")
	
	print("")
else
	exports = ls(commands_path)
	commands = {}
	for file in all(exports) do
		if fstat(commands_path .. "/" .. file) == "file" and file:find("%.lua$") then
			add(commands, sub(file, 1, -5))
		end
	end

	if argv[1] == "--help" or #argv < 1 then
		print("This cart is a bundle of the following commands:")
		print(table.concat(commands, ", "))
		print(string.format("To run a command, run %s [command name] [arguments]", pkg))
	end

	if includes(commands, argv[1]) then
		-- copy argv to new table, excluding first argument (which is the command name)
		new_argv = {}
		for i = 2, #argv, 1 do
			add(new_argv, argv[i])
		end
	
		-- copy this env to new process
		local new_env = env()
		-- replace argv
		new_env.argv = new_argv

		create_process(commands_path .. "/" .. argv[1] .. ".lua", new_env)
	end
end