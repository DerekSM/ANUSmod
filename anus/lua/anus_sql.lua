anus.SQL = {}

function anus.SQL.Query( query, callback )
	local results
	sql.Begin()
		results = sql.Query( query )
	sql.Commit()
	if callback then callback(results) end
	return results
end
function anus.SQL.QueryValue( query, callback )
	callback( sql.QueryValue( query ) )
end

function anus.SQL.LoadPlayer( targPLAYER )
	if not targPLAYER:IsPlayer() then return end
	
	anus.SQL.QueryValue("SELECT * FROM anus_players WHERE steamid = " .. sql.SQLStr( targPLAYER:SteamID() ) .. ";", function(data)
		if (not data) then
			targPLAYER:ChatPrint("Creating new data for you!")
			anus.SQL.Query("REPLACE INTO anus_players VALUES(" .. sql.SQLStr(targPLAYER:SteamID()) .. ", " .. sql.SQLStr(anus.Groups[0]) .. ");")
		end
		targPLAYER.UserGroup = anus.GetGroupByName( data )
		targPLAYER:SetUserGroup( tostring(data) )
	end)
end

function anus.SQL.PluginEnabled( str_PName )	
	anus.SQL.QueryValue("SELECT * FROM anus_plugins WHERE pluginname = " .. sql.SQLStr(str_PName) .. ";", function(data)
		if (not data) then return true end
		if tobool(data["disabled"]) then return false end
	end)
	
	return true
end
