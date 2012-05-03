anus.Plugins = {}
anus.Plugins.List = {}


function anus.Plugins.Register( str_PName, tbl_Plugin )
	if ( not str_PName or not tbl_Plugin ) then return end
		
	anus.Plugins.List[ str_PName ] = tbl_Plugin
	Msg(anus.Prefix.CMsg .. " Registered plugin  --- " .. str_PName .. " ---\n")
	
	if (SERVER) then
		if anus.SQL.PluginEnabled( str_PName ) then
			tbl_Plugin:Enabled()
			// If the above doesn't work then try the below :D
			-- anus.Plugins.List[ str_PName ]:Enabled()
		end
	end
end
	
function anus.Plugins.Load()
	
	local plugindir = file.FindInLua("anus_plugins/*.lua")
		
	for _,pluginfile in pairs(plugindir) do
		// We don't need the below anymore since we're changing the system.
		--if ( dir != "." and dir != ".." and file.IsDir("../lua/plugins/" .. dir) ) then
				
		anus.PLUGIN_NAME = "anus_plugins/" .. pluginfile
		
		// Not anymore, sir!
		--include("plugins/" .. pluginfile .. "/plugin.lua")
		include(anus.PLUGIN_NAME)
		
		if (SERVER) then
			AddCSLuaFile(anus.PLUGIN_NAME)
		end
		
		Msg(anus.Prefix.CMsg .. " Loaded plugin  --- " .. pluginfile .. " ---\n")
				
		--end
	end
	
end
	
function anus.Plugins.PluginExists( plugin )
	if ( not plugin ) then return false end
	if ( not anus.Plugins.List[ plugin ] ) then return false end
		
	return true
end

if (SERVER) then

	function anus.Plugins.Toggleable( pl, cmd, arg )
		if (pl.UserGroup != 999) then pl:ChatPrint("YOU CANNOT RUN THIS... HOLY SHIIIIIIIITTT") return end
		if (not arg[1] or not anus.Plugins.PluginExists( arg[1] )) then pl:ChatPrint("wut") return end
		
		if anus.SQL.PluginEnabled( arg[1] ) then
			anus.SQL.Query("REPLACE INTO anus_plugins VALUES(" .. sql.SQLStr(tostring(arg[1])) .. ", " .. sql.SQLStr("true") .. ");", function(data)
				if ( not data ) then print("My little problem", sql.LastError(tostring(data))) end
			end)
			pl:ChatPrint("Toggled plugin - disabled")
		else
			anus.SQL.Query("REPLACE INTO anus_plugins VALUES(" .. sql.SQLStr(arg[1]) .. ", false);")
			pl:ChatPrint("Toggled plugin - enabled")
		end
	end
	concommand.Add("anus_toggleplugin", anus.Plugins.Toggleable)
	
end

