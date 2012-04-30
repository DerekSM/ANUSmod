anus = {}
anus.Info = {}
anus.Info.Name = "anus"
anus.Info.Version = 1.0
anus.Info.Description = "A simple unworthy admin mod in beta state: A Non Ugly Serverside mod"
anus.Info.Author = "Derek_SM"

anus.Prefix = {}
anus.Prefix.CMsg = "anus ||"

if (SERVER) then
	print('"' .. anus.Info.Name .. '" initialized: Running version ' .. anus.Info.Version .. '; Made by ' .. anus.Info.Author .. ';\n ' .. anus.Info.Description .. '\n')
	include("anus_server.lua")
end