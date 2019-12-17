-- See Copyright Notice in core\LICENSE.txt
function project_detectcommand(param1,param2)
	local lcommand = trim(string.lower(param1))
	if (lcommand == "help" and param2==nil) then return "help" end
	if (lcommand == "?" and param2==nil) then return "help" end
	if (lcommand == "/?" and param2==nil) then return "help" end
	if (lcommand == "list" and param2==nil) then return "list" end
	if (lcommand == "l" and param2==nil) then return "list" end
	if (lcommand == "modules" or lcommand == "m") then
		if (param2 == nil) then
			cmdError("Project missing","Correct usage: dmodule project modules [project] [help|add|list|del|clear]")
		end
		return "modules"
	end
	if (lcommand == "name" or lcommand == "n") then
		if (param2 == nil) then
			cmdError("Project missing","Correct usage: dmodule project name [project] \"New Name\"")
		end
		return "name"
	end
	if (lcommand == "create") then
		if (param2 == nil) then
			cmdError("Project missing","Correct usage: dmodule project create [project] [rcon_password]")
		end
		return "create"
	end
	if (lcommand == "var" or lcommand == "v") then
		if (param2 == nil) then
			cmdError("Project missing","Correct usage: dmodule project var [project]")
		end
		return "var"
	end
	cmdError("Unknown task","Use 'dmodule project help' to figure out how to use the project functions")
end

function cmdline_project(params)
	command=project_detectcommand(params[1],params[2])
	local p={}
	params[1]=nil
	for _,param in pairs(params) do
		table.insert(p,param)
	end
	if (command ~= "help" and command ~= "create") then
		-- we'll need to check if that project exists
		if (lfs.attributes("..\\..\\projects\\"..p[1]) == nil) then
			-- means, the folder doesn't even exist
			cmdError("Project does not exist","Create with 'dmodule project create '"..p[1].."'.")
			
		end
	end
	_G["cmdline_project_"..command](p)
	
end

function cmdline_project_help(params)
	print("   Dmodule-Commandline Help ")
	print(" ")
	print("    project")
	print(" ")
	print(" Usage: dmodule project [projectname] [context] [task]")
	print(" ")
	print(" Contexts:")
	print("   help    - displaying this help (short: ?)")
	print("   modules - working on the modules (short: m)")
	print("   name \"New Name\" - sets the name of the project (short: n)")
	print("   var - lists all specified server variables (short: v)")
	print("   var varname \"newvalue\" - sets the varname to new value (short: v)")
	print(" ")
	print(" For detailed information about a modules command use")
	print("   dmodule project projectname modules help")
end

function cmdline_project_name(params)
	project={}
	project.name = params[1]
	if (params[2]==nil) then
		cmdError("Parameter missing","Use 'dmodule project name "..project.name.." \"New Name\"'")
	end
	print(" Updated project name for '"..project.name.."' to:")
	print("   "..params[2])
	setCfgFileLine("..\\..\\projects\\"..project.name.."\\settings.cfg","name",params[2])
end

function cmdline_project_create(params)
	project={}
	project.name = params[1]
	if (lfs.attributes("..\\..\\projects\\"..project.name) ~= nil) then
		cmdError("Project already exists","You can use that project already!")
	end
	
	if (params[2]==nil) then
		cmdError("Parameter missing","Use 'dmodule project create "..project.name.." \"your rconpass\"'")
	end
	os.execute("mkdir ".."..\\..\\projects\\"..project.name);
	if (lfs.attributes("..\\..\\projects\\"..project.name) == nil) then
		cmdError("Creation problem","Can't create the project folder.")
	end
	print(" Created project '"..project.name.."'")
	print("   name     : "..project.name)
	print("   rconpass : "..params[2])
	file_put_contents("..\\..\\projects\\"..project.name.."\\settings.cfg","name="..project.name)
	setCfgFileLine("..\\..\\projects\\"..project.name.."\\settings.cfg","server.rcon_password",params[2])
end

function cmdline_project_var(params)
	project={}
	project.name = params[1]
	if (params[2]==nil) then
		-- we want to see what variables are set
		print(" Server variables for '"..project.name.."'")
		cfg = readCfgFile("..\\..\\projects\\"..project.name.."\\settings.cfg")
		for k,v in pairs(cfg) do
			if (string.find(k,"server.")) then
				local parts = explode("server.",k)
				print("   "..parts[2].." = "..v)
			end
		end
	else
		-- we shall update a variable, so lets see if we have a second one to view
		local allowedvars={}
		allowedvars["hostname"]="hostname"
		allowedvars["lanmode"]="lanmode"
		allowedvars["anticheat"]="anticheat"
		allowedvars["maxplayers"]="maxplayers"
		allowedvars["port"]="port"
		allowedvars["weburl"]="weburl"
		allowedvars["rcon_password"]="rcon_password"
		allowedvars["password"]="password"
		allowedvars["mapname"]="mapname"
		
		if (params[2]=="plugins") then
			-- extra information for plugins line, since we generate it
			cmdError("Not allowed Servervariable","You can not set \"plugins\", since DModule autogenerates it!")
		end
		if (allowedvars[params[2]]==nil) then
			cmdError("Unknown Servervariable","Can't set \""..params[2].."\", its not a correct server variable.")
		end

		print(" Updated server variable for '"..project.name.."'")
		if (params[3]==nil) then
			-- if we have no 3rd parameter, it means we want to unset the variable
			unsetCfgFileLine("..\\..\\projects\\"..project.name.."\\settings.cfg","server."..params[2])
			print("   Unsetted '"..params[2].."'")
		else
			-- if we have a 3rd parameter, it means we want to set the variable
			setCfgFileLine("..\\..\\projects\\"..project.name.."\\settings.cfg","server."..params[2],params[3])
			print("   "..params[2].." = "..params[3])
		end
	end
end

function cmdline_project_modules(params)
	local already_selected={}

	project={}
	project.name = params[1]
	project.settings_modules = {}
	project.cfg = readCfgFile("..\\..\\projects\\"..project.name.."\\settings.cfg")
	if (project.cfg["modules"]==nil) then
		project.cfg["modules"]=""
	end
	
	if (project.cfg.moduledirectories==nil) then
		project.moduledirectories={"modules.c","modules.d","modules"}
	else
		project.moduledirectories={}
		for _,k in pairs(explode(" ",project.cfg.moduledirectories)) do
			if (trim(k)~="") then
				table.insert(project.moduledirectories,k)
			end
		end
	end
	
	already_selected={}
	for _,k in pairs(explode(" ",project.cfg.modules)) do
		if (trim(k)~="") then
			-- since we want to select every item only one time
			if (already_selected[trim(k)]==nil) then
				already_selected[trim(k)]=trim(k)
				local nv = {}
				nv.name=trim(k)
				table.insert(project.settings_modules,nv)
			end
		end
	end	
	
	local modules_get_task = function(p,p2)
		if (p==nil) then return "list" end
		local lp=trim(string.lower(p))
		if (lp=="list") then return "list" end
		if (lp=="l") then return "list" end
		if (lp=="help") then return "help" end
		if (lp=="?") then return "help" end
		if (lp=="clear" and p2==nil) then return "clear" end
		if (lp=="add" or lp=="a" or lp=="del" or lp=="d") then
			if (p2==nil) then
				cmdError("Parameter missing","Use 'dmodule project modules "..project.name.." "..lp.." modulename' to "..lp.." a module")
			end
			if (lp=="add" or lp=="a") then return "add" end
			if (lp=="del" or lp=="d") then return "del" end
		end
		cmdError("Unknown task","Use >dmodule project modules "..project.name.." help< to figure out how to use the modules project functions")
	end

	task = modules_get_task(params[2],params[3])
	if (task == "list") then
		print(" Used modules in '"..project.name.."'")
		for _,module in pairs(project.settings_modules) do
			module.folder = nil
			for _,folder in pairs(project.moduledirectories) do
				if (nil ~= file_get_contents("..\\..\\"..folder.."\\"..module.name.."\\"..module.name..".dmodule.inc")) then
					module.folder=folder
				end
			end
			local thename = module.name
			if (string.len(thename)<10) then
				thename = thename .. string.rep(" ",10-string.len(thename))
			end
			if (module.folder==nil) then
				
				print("   [--] "..thename.."")
			else
				print("   [ok] "..thename.." ("..module.folder..")")
			end
		end
		return nil
	end
	if (task == "help") then
		print("   Dmodule-Commandline Help ")
		print(" ")
		print("    project [projectname] modules")
		print(" ")
		print(" Usage: dmodule project [projectname] modules [subtask]")
		print(" ")
		print(" Subtasks:")
		print("   add [modulename] - add a module to the project (short: a)")
		print("   del [modulename] - remove a module to the project (short: d)")
		print("   clear - remove all modules")
		print("   list - list all modules used")
		print("   help - display this help")
		return nil
	end
	
	if (task == "clear") then
		print(" Updated modules selected in '"..project.name.."'")
		setCfgFileLine("..\\..\\projects\\"..project.name.."\\settings.cfg","modules","")
		print("   -- none selected --")
		return nil
	end

	-- parse the string list of selected modules into an nice table
	string_selected_modules = params[3]
	raw_selected_modules=explode(" ",string_selected_modules)
	selected_modules={}
	local selected_for_subtask={}
	for _,k in pairs(raw_selected_modules) do
		if (trim(k)~="") then
			-- since we want to select every item only one time
			if (selected_for_subtask[trim(k)]==nil) then
				selected_for_subtask[trim(k)]=trim(k)
				local nv = {}
				nv.name=trim(k)
				table.insert(selected_modules,nv)
			end
		end
	end
	if (task=="add") then
		-- if we are adding, lets validate if the modules really exist somewhere
		for _,module in pairs(selected_modules) do
			module.folder = nil
			for _,folder in pairs(project.moduledirectories) do
				if (nil ~= file_get_contents("..\\..\\"..folder.."\\"..module.name.."\\"..module.name..".dmodule.inc")) then
					module.folder=folder
				end
			end
			if (module.folder == nil) then
				print(" Searching for module:")
				for _,folder in pairs(project.moduledirectories) do
					print("   - "..folder)
				end
				cmdError("Unknown Module","Can't find "..module.name.." in projects module folders.")
			end
		end
	end
	
	local new_module_line_items = {}
	if (task == "del") then
		for _,module in pairs(project.settings_modules) do
			if (selected_for_subtask[module.name]~=nil) then
				-- ok, that one was selected for delete, so remove it
			else
				-- wasn't selected for delete, so we'll add it
				table.insert(new_module_line_items,module.name)
			end
		end
	else
		if (task == "add") then
			local is_already_in_list = {}
			-- first lets add the normal ones, still in and already no duplicates
			for _,module in pairs(project.settings_modules) do
				is_already_in_list[module.name]=module.name
				table.insert(new_module_line_items,module.name)
			end
			-- now lets add those from the command
			for _,module in pairs(selected_modules) do
				-- only if not already selected
				if (is_already_in_list[module.name]==nil) then
					is_already_in_list[module.name]=module.name
					table.insert(new_module_line_items,module.name)
				end
			end
		end
	end
	print(" Updated modules selected in '"..project.name.."'")
	local total = 0
	for _,modname in pairs(new_module_line_items) do
		total = total + 1
		local module = {}
		module.name = modname
		module.folder = nil
		for _,folder in pairs(project.moduledirectories) do
			if (nil ~= file_get_contents("..\\..\\"..folder.."\\"..module.name.."\\"..module.name..".dmodule.inc")) then
				module.folder=folder
			end
		end
		local thename = module.name
		if (string.len(thename)<10) then
			thename = thename .. string.rep(" ",10-string.len(thename))
		end
		if (module.folder==nil) then
			
			print("   [--] "..thename.."")
		else
			print("   [ok] "..thename.." ("..module.folder..")")
		end
	end
	if (total == 0) then
		print("   -- none selected --")
	end
	if (table.concat(new_module_line_items," ") ~= project.cfg.modules) then
		-- set only if changed
		setCfgFileLine("..\\..\\projects\\"..project.name.."\\settings.cfg","modules",table.concat(new_module_line_items," "))
	end
end
