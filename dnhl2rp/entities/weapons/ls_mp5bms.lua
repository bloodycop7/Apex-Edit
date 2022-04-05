AddCSLuaFile()

SWEP.Base = "ls_base"

SWEP.PrintName = "Mp5"
SWEP.Category = "Black Mesa Longsword"
SWEP.IconOverride = "materials/entities/weapon_smg1.png"
SWEP.Spawnable = true
SWEP.AdminOnly = true

SWEP.HoldType = "smg"

SWEP.WorldModel = Model("models/weapons/tfa_ins2/w_mp5k.mdl")
SWEP.ViewModel = Model("models/weapons/tfa_ins2/c_mp5k.mdl")
SWEP.ViewModelFOV = 55

SWEP.Slot = 2
SWEP.SlotPos = 1

SWEP.CSMuzzleFlashes = false

SWEP.ReloadSound = Sound("Weapon_SMG1.Reload")
SWEP.EmptySound = Sound("Weapon_MP5.Empty")

SWEP.Primary.Sound = Sound("Weapon_SMG1.Single")
SWEP.Primary.Recoil = 0.18 -- base recoil value, SWEP.Spread mods can change this
SWEP.Primary.Damage = 9.5
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
SWEP.Spread.Max = 5
SWEP.Spread.IronsightsMod = 0.97 -- multiply
SWEP.Spread.CrouchMod = 0.95 -- crouch effect (multiply)
SWEP.Spread.AirMod = 1.2 -- how does if the player is in the air effect spread (multiply)
SWEP.Spread.RecoilMod = 0 -- how does the recoil effect the spread (sustained fire) (additional)
SWEP.Spread.VelocityMod = 0.1 -- movement speed effect on spread (additonal)

SWEP.IronsightsPos = Vector(-2.990, -2.221, 0.829)
SWEP.IronsightsAng = Angle(0, 0, 0)
SWEP.IronsightsFOV = 0.75
SWEP.IronsightsSensitivity = 0.8
SWEP.IronsightsCrosshair = false
SWEP.IronsightsRecoilVisualMultiplier = 4