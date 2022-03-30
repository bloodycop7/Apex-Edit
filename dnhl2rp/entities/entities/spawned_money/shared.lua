ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Spawned Money"
ENT.Author = "FPtje"
ENT.Spawnable = true
ENT.Category = "HL2RP - Entities"
ENT.AdminSpawnable = false

function ENT:SetupDataTables()
	self:NetworkVar("Int",0,"amount")
end

local ENTITY = FindMetaTable("Entity")
function ENTITY:IsMoneyBag()
	return self:GetClass() == "spawned_money"
end