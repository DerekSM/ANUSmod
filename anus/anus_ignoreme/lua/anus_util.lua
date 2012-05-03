function anus.FindPlayerByName( targPLAYER )
	if not targPLAYER then return end
	
	for k,v in pairs(player.GetAll()) do
	
		if string.lower(targPLAYER):find( string.lower(v:Nick()) ) then
			
			return v
			
		end
	
	end
end