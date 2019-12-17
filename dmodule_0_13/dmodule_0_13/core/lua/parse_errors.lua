-- See Copyright Notice in core\LICENSE.txt
require("utils")

local file = io.open("..\\..\\projects\\"..project.name.."\\compile.error.log", "r")
if (not file) then
	os.exit()
end

local problems={}
problems.errors={}
problems.warnings={}

local error_data = file:read("*a")
file:close()

error_data=explode("\n",error_data)

for line,errorline in pairs(error_data) do
	-- D:\svn.db.net\trunk\pwn\core\pawno\include\dutils.inc(37) : warning 219: local variable "i" shadows a variable at a preceding level
	etype = "warning"
	efilename, eline, eid, emsg = string.match(errorline, [[^([%w%\: %_%.]+)%((%d+)%) : warning (%d+): (.*)$]])
	if (efilename==nil) then
		etype = "error"
		efilename, eline, eid, emsg = string.match(errorline, [[^([%w%\: %_%.]+)%((%d+)%) : fatal error (%d+): (.*)]])
		if (efilename==nil) then
			efilename, eline, eid, emsg = string.match(errorline, [[^([%w%\: %_%.]+)%((%d+)%) : error (%d+): (.*)]])
		end
	end
	if (efilename) then
		local current={}
		current.filename=str_replace("..\\..\\..\\..\\","",efilename)
		current.line=eline
		current.id=eid
		current.msg=emsg
		
		if (string.find(" symbol is never used: \"DmoduleInitLang\"",current.msg)) then
			onError("DmoduleInitLang() is not called by OnGameModeInit in sampcore module.",current.filename,current.line)
		end
		if (string.find(current.msg,"undefined symbol \"_")) then
			-- Callback is not definied in exports.txt, but called in the module
			local parts = explode("undefined symbol \"_",current.msg)
			onError("The event "..str_replace("\"","",parts[2]).." is fired, but not defined as export.",str_replace(".dmodule.inc",".exports.txt",current.filename),"-")
		end
		if (string.find(current.msg,"undefined symbol \"T_")) then
			-- Callback is not definied in exports.txt, but called in the module
			local parts = explode("undefined symbol \"T_",current.msg)
			onError("gettext: Using undefined translation key "..str_replace("\"","",parts[2])..".",current.filename,current.line)
		end
		if (not string.find(current.msg,"symbol is never used: \"_")) then
			if ((string.find(current.msg,"symbol is never used: \"") and (string.find(current.msg,"_Read") or string.find(current.msg,"_Write")))) then
				-- Ok a _ReadValues event isn't readed, because it isn't set - we ignore that.
			else
				if (etype=="warning") then
					table.insert(problems.warnings,current)
				else
					table.insert(problems.errors,current)
				end
			end
		end
	end
end
if (table.getn(problems.errors)==0 and table.getn(problems.warnings)==0 ) then
	os.execute("del ..\\..\\projects\\"..project.name.."\\compile.error.log",true)
	os.exit()
end

print("")
print("  Compiling issues:")
print("")
local showitems={}
if (table.getn(problems.errors)>0) then
	print("  Warnings: "..table.getn(problems.warnings).." (hidden until errors are solved)")
	print("  Errors: "..table.getn(problems.errors).." (fix first error first and recompile)")
	showitems=problems.errors
else
	if (table.getn(problems.warnings)>0) then
		print("  Warnings: "..table.getn(problems.warnings).." (fix first warning first and recompile)")
		showitems=problems.warnings
	end
end
for no, item in pairs(showitems) do
	local fileinfo=explode("\\",item.filename)
	print("   "..fileinfo[table.getn(fileinfo)]..":"..item.line.." "..item.msg)
	if (fileinfo[table.getn(fileinfo)]~=item.filename) then
		fileinfo[table.getn(fileinfo)]=nil
		print("   ("..str_replace(arg[1].."\\build\\gamemodes\\..\\..\\..\\..\\","",table.concat(fileinfo,"\\"))..")")
	end
end
