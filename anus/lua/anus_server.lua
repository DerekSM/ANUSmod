include("anus_sql.lua")
include("anus_util.lua")
include("anus_groups.lua")
include("anus_plugins.lua")

AddCSLuaFile("anus_client.lua")
AddCSLuaFile("anus_groups.lua")
AddCSLuaFile("anus_plugins.lua")

hook.Add("Initialize", "anus_DoMyshit", function()
	
	sql.Query("CREATE TABLE IF NOT EXISTS anus_groups( groupname char(13) NOT NULL, grouprank char(3) NOT NULL, PRIMARY KEY(groupname) );")
	sql.Query("CREATE TABLE IF NOT EXISTS anus_players( steamid char(21) NOT NULL, groupname char(13) NOT NULL, PRIMARY KEY(steamid) );")
	sql.Query("CREATE TABLE IF NOT EXISTS anus_plugins( pluginname char(15) NOT NULL, disabled char(5) NOT NULL, PRIMARY KEY(pluginname) );")
		
	anus.Plugins.Load()

end)
	