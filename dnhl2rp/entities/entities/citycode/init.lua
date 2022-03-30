AddCSLuaFile( "cl_init.lua" ) -- Make sure clientside
AddCSLuaFile( "shared.lua" )  -- and shared scripts are sent.
include('shared.lua')


function ENT:Initialize()
	self:SetModel("models/hunter/blocks/cube2x3x025.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self:SetMaterial("models/props_combine/stasisshield_sheet")
	
	local physObj = self:GetPhysicsObject()

	if (IsValid(physObj)) then
		physObj:Sleep()
	end

end


