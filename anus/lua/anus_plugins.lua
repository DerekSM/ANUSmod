anus.Plugins = {}
anus.Plugins.List = {}

if (SERVER) then
	
	local anus.Plugins.trustme = {}
	function anus.Plugins.Load()
	
		local plugindirs = file.FindInLua("plugins/*")
		
		for _,dir in pairs(plugindirs) do
			if ( dir != "." and dir != ".." and file.IsDir("../lua/plugins/" .. dir) ) then
				
				include("plugins/" .. dir .. "/plugin.lua")
				AddCSLuaFile("plugins/" .. dir .. "/plugin.lua")
				
				Msg(anus.Prefix.CMsg .. " Just loaded  --- " .. dir .. " ---\n")
				
				PLUGIN_FILENAME = dir
				
			end
		end
	
	end
	hook.Add("Initialize", "anus_InitializePluginLoad", anus.Plugins.Load)

	function anus.Plugins.Register( str_PName, tbl_Plugin )
		if ( not str_PName or not tbl_Plugin ) then return end
		
		
	end

end

