AddCSLuaFile()

SWEP.Base = "ls_base_projectile"

SWEP.PrintName = "Explosive Can Thrower"
SWEP.Category = "Custom Longsword Weapons"
SWEP.IconOverride = "materials/icons/canthrower.jpg"

SWEP.Spawnable = true
SWEP.AdminOnly = true

SWEP.HoldType = "rpg"

SWEP.WorldModel = Model("models/weapons/w_pistol.mdl")
SWEP.ViewModel = Model("models/weapons/c_pistol.mdl")
SWEP.ViewModelFOV = 45

SWEP.Slot = 4
SWEP.SlotPos = 2

SWEP.DoFireAnim = true

SWEP.Primary.Sound = Sound("npc/metropolice/vo/pickupthecan1.wav")
SWEP.Primary.Recoil = 0 -- base recoil value, SWEP.Spread mods can change this
SWEP.Primary.Automatic = true
SWEP.Primary.Delay = RPM(600)
SWEP.Primary.HitDelay = 0.1

SWEP.Primary.Ammo = "can"
SWEP.Primary.ClipSize = 1000
SWEP.Primary.DefaultClip = 1000

SWEP.Projectile = {}
SWEP.Projectile.Model = Model("models/props_junk/PopCan01a.mdl")
SWEP.Projectile.Touch = true
SWEP.Projectile.FireSound = Sound("BaseGrenade.Explode")
SWEP.Projectile.ForceMod = 4

function SWEP:ProjectileFire(owner, hit)
	local explodeEnt = ents.Create("env_fire")
    explodeEnt:SetPos(self:GetPos())
    explodeEnt:Spawn()
    explodeEnt:SetKeyValue("iMagnitude", 100)
    explodeEnt:Fire("explode", "", 0)
end