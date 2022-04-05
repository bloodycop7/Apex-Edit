AddCSLuaFile()

SWEP.Base = "ls_base"

SWEP.PrintName = "M4A1"
SWEP.Category = "impulse HL2RP Weapons"
SWEP.Spawnable = true
SWEP.AdminOnly = true

SWEP.HoldType = "smg"

SWEP.WorldModel = Model("models/weapons/w_dm4a1.mdl")
SWEP.ViewModel = Model("models/weapons/v_dm4a1.mdl")
SWEP.ViewModelFOV = 55

SWEP.Slot = 2
SWEP.SlotPos = 1

SWEP.CSMuzzleFlashes = false

SWEP.ReloadSound = Sound("Weapon_SMG1.Reload")
SWEP.EmptySound = Sound("Weapon_Pistol.Empty")

SWEP.Primary.Sound = Sound("Weapon_SMG1.Single")
SWEP.Primary.Recoil = 0.18 -- base recoil value, SWEP.Spread mods can change this
SWEP.Primary.Damage = 23
SWEP.Primary.NumShots = 1
SWEP.Primary.Cone = 0.025
SWEP.Primary.Delay = RPM(1000)

SWEP.Primary.Ammo = "Rifle"
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 30
SWEP.Primary.DefaultClip = 150

SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Automatic = false
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1

SWEP.Spread = {}
SWEP.Spread.Min = 0
SWEP.Spread.Max = 3
SWEP.Spread.IronsightsMod = 0.97 -- multiply
SWEP.Spread.CrouchMod = 0.95 -- crouch effect (multiply)
SWEP.Spread.AirMod = 1.2 -- how does if the player is in the air effect spread (multiply)
SWEP.Spread.RecoilMod = 0 -- how does the recoil effect the spread (sustained fire) (additional)
SWEP.Spread.VelocityMod = 0.1 -- movement speed effect on spread (additonal)

SWEP.IronsightsPos = Vector(-2.951, 0.221, 1.529)
SWEP.IronsightsAng = Angle(0, 0, 0)
SWEP.IronsightsFOV = 0.75
SWEP.IronsightsSensitivity = 0.8
SWEP.IronsightsCrosshair = false
SWEP.IronsightsRecoilVisualMultiplier = 4
