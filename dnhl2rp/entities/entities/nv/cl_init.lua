include('shared.lua')


function ENT:Draw()
	self:DrawModel()
	if LocalPlayer():GetEyeTrace().Entity == self and EyePos():Distance( self:GetPos() ) < 512 then
		hook.Add("PreDrawHalos", "Halo", function()
			local client = LocalPlayer()
			local team = client:Team()
			if team == TEAM_CITIZEN then
				halo.Add({ self }, Color(255, 0, 0), 0, 0, 10)
			end
		end)
	end
end