-- See Copyright Notice in core\LICENSE.txt
require ("utils")
project.cfg=readCfgFile("..\\..\\projects\\"..project.name.."\\settings.cfg")

if (project.cfg["documentation"]=="full") then
	local xml_file = file_get_contents("..\\..\\projects\\"..project.name.."\\compile.info.log")
	
	if (xml_file~=nil) then
		
	    function parseargs(s)
	      local arg = {}
	      string.gsub(s, "(%w+)=([\"'])(.-)%2", function (w, _, a)
	        arg[w] = a
	      end)
	      return arg
	    end
	        
	    function collect(s)
	      local stack = {}
	      local top = {}
	      table.insert(stack, top)
	      local ni,c,label,xarg, empty
	      local i, j = 1, 1
	      while true do
	        ni,j,c,label,xarg, empty = string.find(s, "<(%/?)(%w+)(.-)(%/?)>", j)
	        if not ni then break end
	        local text = string.sub(s, i, ni-1)
	        if not string.find(text, "^%s*$") then
	          table.insert(top, text)
	        end
	        if empty == "/" then  -- empty element tag
	          table.insert(top, {label=label, xarg=parseargs(xarg), empty=1})
	        elseif c == "" then   -- start tag
	          top = {label=label, xarg=parseargs(xarg)}
	          table.insert(stack, top)   -- new level
	        else  -- end tag
	          local toclose = table.remove(stack)  -- remove top
	          top = stack[#stack]
	          if #stack < 1 then
	            error("nothing to close with "..label)
	          end
	          if toclose.label ~= label then
	            error("trying to close "..toclose.label.." with "..label)
	          end
	          table.insert(top, toclose)
	        end
	        i = j+1
	      end
	      local text = string.sub(s, i)
	      if not string.find(text, "^%s*$") then
	        table.insert(stack[stack.n], text)
	      end
	      if #stack > 1 then
	        error("unclosed "..stack[stack.n].label)
	      end
	      return stack[1]
	    end
		collected = collect(xml_file)
		events = {}
		groups = {}
		
		groups.core={}
		groups.environment={}
		groups.player={}
		groups.object={}
		groups.vehicle={}
		
		nogroup={}
		
		wiki_txt = {}
		
		for _,item in pairs(collected[2][2]) do
			if (type(item)=="table") then
				local curitem = {}
					curitem.description=""
				for key,val in pairs(item) do
					if (type(val)=="string" and val~="member") then
						-- we are at the description tag, nice!
						curitem.description = trim(val)
					end
					if (key=="xarg") then
						curitem.name = val.name
						curitem.syntax = val.syntax
					end
				end
				-- now lets find out, if and why that is a function we should document
				if (curitem.name~=nil and string.find(curitem.name,"M:")==1) then
					-- Only Functions!
					local needstobedocumented = true
					if (string.find(curitem.name,"M:_")==1) then
						events[str_replace("M:","",curitem.name)]=str_replace("M:","",curitem.name)
						needstobedocumented = false
					end
					if (string.find(curitem.name,"M:operator")==1) then
						needstobedocumented = false
					end
					if (needstobedocumented) then
						for _,e in pairs(events) do
							if (string.find(curitem.name,e)) then
								needstobedocumented = false
							end
						end
					end
					
					if (needstobedocumented) then
						local param_descr={}
						local param_type={}
						curitem.name = str_replace("M:","",curitem.name)
						local parts = explode("(",curitem.syntax);
						parts[2] = explode(")",parts[2])[1];
						local func_name = parts[1]
						local params_def = str_replace("&amp;","&",parts[2])
						local raw_params = str_replace("[]","",params_def)
						local raw_params = str_replace("&","",raw_params)
						raw_params = explode(",",raw_params)
						local params={}
						for _,p in pairs(raw_params) do
							p=explode(":",p)
							if (p[2]==nil) then
								if (trim(p[1])~="") then
									table.insert(params,trim(p[1]));
									param_descr[trim(p[1])]=""
									param_type[trim(p[1])]=""
								end
							else
								table.insert(params,trim(p[2]));
								param_descr[trim(p[2])]=""
								param_type[trim(p[2])]=""
							end
						end
						curitem.params_table=params
						curitem.params_def=params_def
						curitem.params=table.concat(params,",")
						curitem.groups={}
						curitem.return_type=""
						
						description_parts = explode("@",curitem.description)
						if (description_parts[2]~=nil) then
							curitem.description=trim(description_parts[1])
							description_parts[1]=nil
							for _,part in pairs(description_parts) do
								part=trim(part)
								if (string.find(part,"return ")) then
									-- TODO: Check if not empty 
									parts = str_replace("return ","",part)
									parts = explode(" ",parts)
									if (parts[2]==nil) then
										parts[2]=""
									end
									curitem.return_type=parts[1]
									parts[1]=nil
									curitem.return_description=""
									for _,p in pairs(parts) do
										if (curitem.return_description~="") then
											curitem.return_description = curitem.return_description .. " " .. p
										else
											curitem.return_description = p
										end
									end
								end
								if (string.find(part,"ingroup ")) then
									-- TODO: Check if not empty
									-- TODO: Multiple groups in one line
									table.insert(curitem.groups,str_replace("ingroup ","",part))
								end
								if (string.find(part,"param ")) then
									-- TODO: If inufficient information
									-- TODO: If parameter does not exist
									parts=explode(" ",part)
									if (parts[3]==nil) then
										parts[3]=""
									end
									if (parts[2]==nil) then
										-- TODO: warning, seomthing broken .. @param ohne parameter ...
										parts[2]=""
									end
									param_name=parts[3]
									param_type[param_name]=parts[2]
									if (param_descr[param_name]==nil) then
										-- TODO: warning, that we document a variable, which does not exist ...
									else
										parts[1]=nil
										parts[2]=nil
										parts[3]=nil
										for _,p in pairs(parts) do
											if (param_descr[param_name]~="") then
												param_descr[param_name] = param_descr[param_name] .. " " .. p
											else
												param_descr[param_name] = p
											end
										end
									end
								end
							end
						end
						curitem.param_descr=param_descr
						curitem.param_type=param_type
						if (curitem.name~="DmoduleInitLang" and curitem.name~="DmoduleInitLangItem" ) then
							if (table.getn(curitem.groups)==0) then
								nogroup[string.lower(curitem.name)]=curitem
							else
								for _,group in pairs(curitem.groups) do
									-- TODO: add check if group is not allowed?
									if (groups[group]==nil) then
										groups[group]={}
									end
									groups[group][string.lower(curitem.name)]=curitem
								end
							end
						end
					end
				end
			end
		end
		
		for group,items in pairs(groups) do
			table.insert(wiki_txt,"=="..string.upper(string.sub(group,1,1))..string.sub(group,2).."==")
			table.insert(wiki_txt,"")
			for _,curitem in pairs(items) do
				if (curitem.return_type=="") then
					table.insert(wiki_txt,"{{PWNProcedureName|"..curitem.name.."|"..curitem.params_def.."}}")
				else
					table.insert(wiki_txt,"{{PWNFunctionName|"..curitem.name.."|"..curitem.params_def.."|"..curitem.return_type.."}}")
				end
				for _,param in pairs(curitem.params_table) do
					table.insert(wiki_txt,"{{PWNParameter|"..param.."|"..curitem.param_descr[param].."|"..curitem.param_type[param].."}}")
				end
				table.insert(wiki_txt,"{{PWNDescription|"..curitem.description.."}}")
				table.insert(wiki_txt,"")
				table.insert(wiki_txt,"")
			end
		end
		
		table.insert(wiki_txt,"== Other ==")
		table.insert(wiki_txt,"")
		for _,curitem in pairs(nogroup) do
			if (curitem.return_type=="") then
				table.insert(wiki_txt,"{{PWNProcedureName|"..curitem.name.."|"..curitem.params_def.."}}")
			else
				table.insert(wiki_txt,"{{PWNFunctionName|"..curitem.name.."|"..curitem.params_def.."|"..curitem.return_type.."}}")
			end
			for _,param in pairs(curitem.params_table) do
				table.insert(wiki_txt,"{{PWNParameter|"..param.."|"..curitem.param_descr[param].."|"..curitem.param_type[param].."}}")
			end
			table.insert(wiki_txt,"{{PWNDescription|"..curitem.description.."}}")
			table.insert(wiki_txt,"")
			table.insert(wiki_txt,"")
		end
		file_put_contents("..\\..\\projects\\"..project.name.."\\docs.wiki.txt",table.concat(wiki_txt,"\n"))
	end
end
