AddCSLuaFile( "cl_init.lua" ) -- This means the client will download these files
AddCSLuaFile( "shared.lua" )

include('shared.lua') -- At this point the contents of shared.lua are ran on the server only.


function ENT:Initialize()
    if (SERVER) then
        self:SetModel("models/props_combine/health_charger001.mdl")
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

function ENT:OnTakeDamage()
    return false
end

function ENT:Use( Name, Activator, Caller )
    if Activator.NextUse and Activator.NextUse > CurTime() then
        self:EmitSound("items/medshotno1.wav")
        return
    end
    Activator:SetHealth( math.min( Activator:GetMaxHealth(), Activator:SetMaxHealth(100) ) )
    self:EmitSound("items/medshot4.wav")
    Activator:notify("You have recharged your health")
    Activator.NextUse = CurTime() + 0.5
end
