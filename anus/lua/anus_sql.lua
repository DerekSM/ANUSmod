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

hook.Add("Initialize", "asdfg", function()
	sql.Query("CREATE TABLE IF NOT EXISTS anus_groups( groupname char(13) NOT NULL, groupgroup char(3) NOT NULL, PRIMARY KEY(groupname) );")
	sql.Query("CREATE TABLE IF NOT EXISTS anus_players( steamid char(21) NOT NULL, groupname char(13) NOT NULL, PRIMARY KEY(steamid) );")
end)

function anus.SQL.LoadPlayer( targPLAYER )
	if not targPLAYER:IsPlayer() then return end
	
	anus.SQL.QueryValue("SELECT * FROM anus_players WHERE steamid = " .. sql.SQLStr( targPLAYER:SteamID() ) .. ";", function(data)
		if not data then
			targPLAYER:ChatPrint("Creating new data for you!")
			anus.SQL.Query("REPLACE INTO anus_players VALUES(" .. sql.SQLStr(targPLAYER:SteamID()) .. ", " .. sql.SQLStr(anus.Groups[0]) .. ");")
		else
			targPLAYER.UserGroup = anus.GetGroupByName( data )
			targPLAYER:SetUserGroup( tostring(data) )
		end
	end)
end

