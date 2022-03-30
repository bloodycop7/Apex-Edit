ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Spawned Weapon"
ENT.Author = "Rickster"
ENT.Spawnable = true
ENT.AdminSpawnable = false
ENT.Category = "HL2RP - Entities"

function ENT:SetupDataTables()
	self:NetworkVar("Entity",1,"owning_ent")
end