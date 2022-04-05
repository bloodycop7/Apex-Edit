AddCSLuaFile()

SWEP.Base = "ls_base"

SWEP.PrintName = "MP5"
SWEP.Category = "Custom Longsword Weapons"
SWEP.IconOverride = "materials/spawnicons/models/weapons/w_jmod_mp5.png"
SWEP.Spawnable = true
SWEP.AdminOnly = true

SWEP.HoldType = "smg"

SWEP.WorldModel = Model("models/weapons/w_smg_mp5.mdl")
SWEP.ViewModel = Model("models/weapons/cstrike/c_smg_mp5.mdl")
SWEP.ViewModelFOV = 55

SWEP.Slot = 2
SWEP.SlotPos = 1

SWEP.CSMuzzleFlashes = false

SWEP.ReloadSound = Sound("Weapon_SMG1.Reload")
SWEP.EmptySound = Sound("Weapon_Pistol.Empty")

SWEP.Primary.Sound = Sound("Weapon_MP5Navy.Single")
SWEP.Primary.Recoil = 0.18 -- base recoil value, SWEP.Spread mods can change this
SWEP.Primary.Damage = 9.4
SWEP.Primary.NumShots = 1
SWEP.Primary.Cone = 0.038
SWEP.Primary.Delay = RPM(857)

SWEP.Primary.Ammo = "smg1"
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 45
SWEP.Primary.DefaultClip = 45

SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Automatic = false
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1

SWEP.Spread = {}
SWEP.Spread.Min = 0
SWEP.Spread.Max = 10
SWEP.Spread.IronsightsMod = 0.97 -- multiply
SWEP.Spread.CrouchMod = 0.95 -- crouch effect (multiply)
SWEP.Spread.AirMod = 1.2 -- how does if the player is in the air effect spread (multiply)
SWEP.Spread.RecoilMod = 5 -- how does the recoil effect the spread (sustained fire) (additional)
SWEP.Spread.VelocityMod = 0.1 -- movement speed effect on spread (additonal)

SWEP.IronsightsPos = Vector(-5.350, 0, 2.050)
SWEP.IronsightsAng = Angle(0, 0, 0)
SWEP.IronsightsFOV = 0.65
SWEP.IronsightsSensitivity = 0.8
SWEP.IronsightsCrosshair = false
SWEP.IronsightsRecoilVisualMultiplier = 4