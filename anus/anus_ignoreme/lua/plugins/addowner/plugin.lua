// This is shared.
local PLUGIN = {} -- We store our local table here.
PLUGIN["Name"] = "AddOwner" -- This is our plugin's name that shows up.
PLUGIN["Author"] = "Jason (Derek_SM)" -- This is who made our plugin.
PLUGIN["CanDisable"] = true -- Can server owners disable this plugin on the fly?
PLUGIN["StartDisabled"] = false -- Does the plugin start off as disabled or not?

// This is serverside only.
if (SERVER) then
	
	-- When the plugin is activated what happens?
	function PLUGIN:OnActivate()
		
		-- Well, we add a console command named "anus_addowner"
		concommand.Add("anus_addowner", anus_AddOwner)
	end
	
	-- When the plugin is deactivated what happens?
	function PLUGIN:OnDeactivate()
		
		-- Well, we simply remove a console command named "anus_addowner"
		concommand.Remove("anus_addowner")
	end
	
	
	-- We add a console command named "anus_addowner"
	local function anus_AddOwner( pl, cmd, arg )
		-- We make sure that the person adding an owner isn't a player.
		if pl:IsPlayer() then pl:ChatPrint("Cannot add owners as a player!") return end
	
		-- We find our target by (partially) his name, with the below function.
		local target = anus.FindPlayerByName( arg[1] )
		
		-- Using the number helps ensure that if the Owner name changes, the player still becomes an owner.
		-- We set our target as Owner. Two ways; Integer method, String method.
		target:SetGroup( 999 )
	end
	
end

// This would be our clientsite only. But there's no use for it here!

// This is after everythings finished.
anus.Plugins.Register( PLUGIN_FILENAME, PLUGIN )