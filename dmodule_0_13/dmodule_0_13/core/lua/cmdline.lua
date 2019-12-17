-- See Copyright Notice in core\LICENSE.txt
require("utils")

function cmdError(title,description)
	print("")
	print(" Problem: "..title)
	print("   "..description)
	print("")
	os.exit()
end
-- first lets figure out, what we are working on

if (arg[1]==nil) then
	print("")
	print(" Error: You can't launch dmodule-command line interface without any parameter.")
	print("")
	print(" Try 'dmodule help' instead")
	print("")
	os.execute("pause")
	os.exit()
end

--[[
	detects the context we want to work on
	@return string
]]
function detect_context(command)
	local lcommand = trim(string.lower(command))
	if (lcommand == "module") then return "module" end
	if (lcommand == "m") then return "module" end
	if (lcommand == "mod") then return "mod" end
	if (lcommand == "project") then return "project" end
	if (lcommand == "p") then return "project" end
	if (lcommand == "help") then return "help" end
	if (lcommand == "/?") then return "help" end
	if (lcommand == "?") then return "help" end
	if (lcommand == "--help") then return "help" end
	cmdError("Unknown command","Use 'dmodule help' to figure out how to use that tool.")
end

context = detect_context(arg[1])

params={}
for id,item in pairs(arg) do
	if (id>1) then
		table.insert(params,trim(item))
	end
end

-- Now lets load the handler for the context
require("cmdline_"..context)
print("")
_G["cmdline_"..context](params)

	--[[
	for filename in (lfs.dir(lfs.currentdir().."\\..\\..")) do
		print(filename)
	end
	os.exit()
	]]


--print_r(arg)