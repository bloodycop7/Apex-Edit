ENT.Base = "base_ai" -- This entity is based on "base_ai"
ENT.Type = "anim" -- What type of entity is it, in this case, it's an AI.
ENT.PrintName		= "Health Charger"
ENT.Author			= "Hardway245"
ENT.Contact			= "N/A"
ENT.Purpose			= "Heal"
ENT.Instructions	= "Press E"
ENT.Category 		= "HL2RP - Entities"

ENT.AutomaticFrameAdvance = true
ENT.Spawnable = true
ENT.AdminOnly = true

ENT.AutomaticFrameAdvance = true -- This entity will animate itself.



function ENT:SetAutomaticFrameAdvance( bUsingAnim ) -- This is called by the game to tell the entity if it should animate itself.
--	self.AutomaticFrameAdvance = bUsingAnim

end

function ENT:Initialize( )

end

-- Since this file is ran by both the client and the server, both will share this information.
