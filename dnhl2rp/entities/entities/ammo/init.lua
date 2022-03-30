AddCSLuaFile( "cl_init.lua" ) -- This means the client will download these files
AddCSLuaFile( "shared.lua" )

include('shared.lua') -- At this point the contents of shared.lua are ran on the server only.


function ENT:Initialize( ) --This function is run when the entity is created so it's a good place to setup our entity.

	self:SetModel( "models/Items/ammocrate_ar2.mdl" ) -- Sets the model of the NPC.
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
        local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
		phys:EnableMotion(false)
	end
end

function ENT:OnTakeDamage()
	return false
end

function ENT:AcceptInput( Name, Activator, Caller )
weaponAmmo = {}
weaponAmmo["Pistol"] = 94
weaponAmmo["357"] = 50
weaponAmmo["SMG1"] = 500
weaponAmmo["slam"] = 3
weaponAmmo["Grenade"] = 1
weaponAmmo["Rifle"] = 300
weaponAmmo["SniperPenetratedRound"] = 100
if Activator:HasWeapon("weapon_csniper") then
	weaponAmmo["SniperRound"] = 30
else
	weaponAmmo["AR2"] = 300
end
weaponAmmo["Buckshot"] = 52
weaponAmmo["XBowBolt"] = 45
weaponAmmo["controllable_manhack"] = 3

	if Name == "Use" and Caller:IsPlayer() then
	local Wpn = ""
	local Count = 0
    	for k , v in ipairs(Caller:GetWeapons()) do
			local AmmoName = game.GetAmmoName(v:GetPrimaryAmmoType())
			print(AmmoName)
			if weaponAmmo[AmmoName] and Caller:GetAmmoCount(AmmoName) and Caller:GetAmmoCount(AmmoName) < weaponAmmo[AmmoName] then

				local giveAmmo =  weaponAmmo[AmmoName] - Caller:GetAmmoCount(AmmoName)
					local AmmoName = weaponAmmo[AmmoName]
					Caller:GiveAmmo( giveAmmo, v:GetPrimaryAmmoType(), true )
			end
    	end
    	Caller:notify("Your ammo has been restocked.")
		self:EmitSound("items/ammocrate_open.wav")
	end

end
