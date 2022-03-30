AddCSLuaFile( "shared.lua" )  -- and shared scripts are sent. 
include('shared.lua')
 

function ENT:Initialize()
 
	self:SetModel( "models/weapons/w_packatm.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )      -- Make us work with physics,
	self:SetMoveType(SOLID_VPHYSICS)   -- after all, gmod is a physics
	self:SetSolid( SOLID_VPHYSICS )         -- Toolbox
	self:SetUseType( SIMPLE_USE )

	timer.Simple( 120, function() if self:IsValid() then
	self:Remove() end end )
        local phys = self:GetPhysicsObject()
		if (phys:IsValid()) then
			timer.Simple(1.4,function() phys:Wake() end)
		end
end

function ENT:Use(activator, caller)


	if caller:IsCP() then
		if caller:SteamID() == activator:SteamID() then

			caller:SetSelfDarkRPVar("Energy", math.Clamp((caller:getDarkRPVar("Energy") or 100) + (80), 0, 100))
			caller:AddMoney(500)
			caller:notify("Because you are a CP you recived your hourly paycheck (500) for this ration.")
			caller:notify("You may come back in one hour to recive your next ration.")


		umsg.Start("AteFoodIcon", caller)
		umsg.End()

		caller:EmitSound("Eat.mp3", 100, 100)
		self:Remove()
		end
	end
end