--~ function ApexReceiveMsg()
--~ return net.ReadString()

--~ end
--~ net.Receive("apexmessage", ApexReceiveMsg)


--~ function ApexReceiveTeam()
--~ return net.ReadColor()
--~ print(net.ReadColor())

--~ end
--~ net.Receive("apexchatdata_team", ApexReceiveTeam)

--~ function ApexReceiveName()
--~ return net.ReadString()

--~ end
--~ net.Receive("apexchatdata_name", ApexReceiveName)



function ApexChatBuild()
local oocTags = {
	["superadmin"]	= "Super Admin",
	["admin"]		= "Admin",
	["gamemaster"]	= "Game Master",	
	["moderator"]	= "Mod",
	["vip"]			= "VIP"
}

local ooccolour = {
	["superadmin"]	= Color(0,153,255),
	["admin"]		= Color(255,0,170),
	["gamemaster"]	= Color(0,0,0),
	["moderator"]	= Color(0,37,124),
	["vip"]			= Color(204,184,58),
	["user"]        = Color(255,255,255)
}


data = net.ReadString()
message = net.ReadString()
ply = net.ReadEntity()
plyNAME = ply:Nick()
teamCOL = team.GetColor(ply:Team())
steamNAME = ply:SteamName()
usergroup = ply:GetUserGroup()
steamID = ply:SteamID()

if (oocTags[usergroup]) then
prefix = "["..oocTags[usergroup].."]"
else
prefix = ""
end

if (ooccolour[usergroup]) then
prefixc = ooccolour[usergroup]
else
prefixc = ""
end


local data1 = "chat.AddText("..data..")"
local data2 = CompileString(data1, "ChatColourPrint")

data2()

end
net.Receive("apexchatdata", ApexChatBuild)