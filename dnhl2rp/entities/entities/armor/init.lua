AddCSLuaFile( "cl_init.lua" ) -- This means the client will download these files
AddCSLuaFile( "shared.lua" )

include('shared.lua') -- At this point the contents of shared.lua are ran on the server only.

function ENT:Initialize()
    if (SERVER) then
        self:SetModel("models/props_combine/suit_charger001.mdl")
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)
        self:SetMoveType(MOVETYPE_VPHYSICS)
        self:SetUseType(SIMPLE_USE)
        self.canUse = true

        local physObj = self:GetPhysicsObject()

        if (IsValid(physObj)) then
            physObj:EnableMotion(false)
            physObj:Sleep()
        end
    end
end

function ENT:Use(act)
    if act.NextUse and act.NextUse > CurTime() then
        self:EmitSound("items/suitchargeno1.wav")
        return
    end
    local team = act:Team()
    local name = act:Name()
    
    if act:Team() == TEAM_CP then
        act:SetArmor(50)
    elseif act:Team() == TEAM_CP and act:Name():find("DvL") then
        act:SetArmor(80)
    elseif act:Team() == TEAM_OVERWATCH and !act:Name():find("MACE") then
        act:SetArmor(100)
    elseif act:Name():find("MACE") then
        act:SetArmor(150)
    end

    self:EmitSound("items/suitchargeno1.wav")
    act:notify("You have recharged your armor")
    act.NextUse = CurTime() + 0.5
end
