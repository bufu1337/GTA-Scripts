-- See Copyright Notice in core\LICENSE.txt
require("lfs") 

function file_get_contents(name) 
	local file = io.open(name, "r")
	if (file) then
		local data = file:read("*a")
		file:close()
		return data
	end
	return nil
end

function file_put_contents(name,content)
	local file = io.open(name,"w+")
	if (file) then
		file:write(content)
		file:close()
		return true
	end
	return false
end

function print_r (t, indent, done)
  done = done or {}
  indent = indent or ''
  local nextIndent -- Storage for next indentation value
  for key, value in pairs (t) do
    if type (value) == "table" and not done [value] then
      nextIndent = nextIndent or
          (indent .. string.rep(' ',string.len(tostring (key))+2))
          -- Shortcut conditional allocation
      done [value] = true
      print (indent .. "[" .. tostring (key) .. "] => Table {");
      print  (nextIndent .. "{");
      print_r (value, nextIndent .. string.rep(' ',2), done)
      print  (nextIndent .. "}");
    else
      print  (indent .. "[" .. tostring (key) .. "] => " .. tostring (value).."")
    end
  end
end

function explode(div,str) -- abuse to: http://richard.warburton.it
	if (str==nil) then return {} end
	local pos,arr = 0,{}
	for st,sp in function() return string.find(str,div,pos,true) end do -- for each divider found
		table.insert(arr,string.sub(str,pos,st-1)) -- Attach chars left of current divider
		pos = sp + 1 -- Jump past current divider
	end
	table.insert(arr,string.sub(str,pos)) -- Attach chars right of last divider
	return arr
end

function trim(s)
	return (string.gsub(s, "^%s*(.-)%s*$", "%1"))
end

function str_replace(old,new,str)
	return table.concat(explode(old,str),new)
end

function readCfgFile(filename) 
	local cfg={}
	for pos,line in pairs(explode("\n",file_get_contents(filename))) do 
		local iscomment=string.match(line,"^%s*(#).*")
		line=trim(line)
		if (line=="") then
			-- empty line, ignore it for now.
		elseif (not iscomment) then
			varia,value=string.match(line,"(.*)=(.*)")
			if (varia) then 
				cfg[varia]=value
			else
				print("")
				print("           (read) BROKEN cfg-Line in file "..filename..":"..pos)
				print("")
			end
		end
	end
	return cfg
end

function setCfgFileLine(filename,linename,newval)
	local newlines = {}
	local wasset = false
	for pos,line in pairs(explode("\n",file_get_contents(filename))) do 
		local iscomment=string.match(line,"^%s*(#).*")
		line=trim(line)
		if (line=="") then
			table.insert(newlines,"")
			-- empty line, ignore it for now.
		elseif (not iscomment) then
			varia,value=string.match(line,"(.*)=(.*)")
			if (varia) then 
				if (varia==linename) then
					table.insert(newlines,linename.."="..newval)
					wasset = true
				else
					table.insert(newlines,line)
				end
			else
				-- ok broken line, we'll ignore it
				table.insert(newlines,line)
			end
		else
			-- ok comment, lets add it:
			table.insert(newlines,line)
		end
	end
	if (not wasset) then
		table.insert(newlines,linename.."="..newval)
	end
	file_put_contents(filename,table.concat(newlines,"\n"))
end

function unsetCfgFileLine(filename,linename)
	local newlines = {}
	for pos,line in pairs(explode("\n",file_get_contents(filename))) do 
		local iscomment=string.match(line,"^%s*(#).*")
		line=trim(line)
		if (line=="") then
			table.insert(newlines,"")
			-- empty line, ignore it for now.
		elseif (not iscomment) then
			varia,value=string.match(line,"(.*)=(.*)")
			if (varia) then 
				if (varia==linename) then
					-- ignore that line, since its the one we want to unset
				else
					table.insert(newlines,line)
				end
			else
				-- ok broken line, we'll ignore it
				table.insert(newlines,line)
			end
		else
			-- ok comment, lets add it:
			table.insert(newlines,line)
		end
	end
	file_put_contents(filename,table.concat(newlines,"\n"))
end

function onError(dreason,file,line)
	onProblem(1,dreason,file,line)
end

function onWarning(dreason,file,line)
	onProblem(2,dreason,file,line)
end

function onProblem(dtyp,dreason,file,line)
	table.insert(project.problems,{typ=dtyp,reason=dreason,file=file,line=line})
	if (dtyp == 2) then
		print("  Warning: "..dreason)
		print("  	"..line..":"..file)
		print("")
	end
	if (dtyp == 1) then
		print("  Error: Can't build '"..project.name.."' because:")
		print("")
		print("  	"..dreason)
		print("")
		print("  	file: "..file)
		print("  	line: "..line)
		print("")
		print("")
		file_put_contents("..\\..\\projects\\"..project.name.."\\build.error.log",dreason)
		os.exit()
	end
end

project={}
project.name=arg[1]
project.problems={}

