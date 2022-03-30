AddCSLuaFile( "cl_init.lua" ) -- Make sure clientside
AddCSLuaFile( "shared.lua" )  -- and shared scripts are sent.
include('shared.lua')

util.AddNetworkString("vguiterminal")

function ENT:Initialize()
	self:SetModel("models/props_combine/combine_interface001.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)

end


function ENT:AcceptInput(Name, Activator, Caller)
	local find = Caller:Name()
	if (Caller:Team() == TEAM_CP and find:find("CmD") or Caller:Team() == TEAM_CP and find:find("DcO") or Caller:Team() == TEAM_CP and find:find("DvL") or Caller:Team() == TEAM_CP and find:find("OfC") or Caller:Team() == TEAM_CP and find:find("SqL") or Caller:IsSuperAdmin() or Caller:GetUserGroup():find("developer") or  Caller:Team() == TEAM_OVERWATCH and find:find("LDR") or Caller:Team() == TEAM_OVERWATCH and find:find("OWC")) then
		net.Start("vguiterminal")
		net.Send(Caller)
		print("caller opened") -- We don't need any content in the usermessage so we're sending it empty now.
	else
		Caller:notify("You cannot do that." )
	end
end
