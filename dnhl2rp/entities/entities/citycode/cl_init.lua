include('shared.lua')


function ENT:Draw()
	self:DrawModel()
	if LocalPlayer():GetEyeTrace().Entity == self and EyePos():Distance( self:GetPos() ) < 512 then
		hook.Add("PreDrawHalos", "Halo", function()
			local client = LocalPlayer()
			local team = client:Team()
			if (!client:IsCP() and GetGlobalBool("civil", true) == true) then
				halo.Add({ self }, Color(0, 255, 0), 0, 0, 10)
			elseif (!client:IsCP() and GetGlobalBool("cu", false) == true) then
				halo.Add({ self }, Color(255, 157, 0), 0, 0, 10)
			elseif (!client:IsCP() and GetGlobalBool("jw", false) == true) then
				halo.Add({ self }, Color(255, 0, 0), 0, 0, 10)
			end
		end)
	end
	local entPos = self:GetPos()
	local entAng = self:GetAngles()
	local pos = self:GetPos()
	local ang = self:GetAngles()

	pos = pos + (ang:Up() * 10.1)
	pos = pos + (ang:Forward() * -24.36)
	pos = pos + (ang:Right() * 50)

	ang:RotateAroundAxis(entAng:Up(), 90)
	ang:RotateAroundAxis(entAng:Right(), -2)

	cam.Start3D2D(pos, ang, 0.07)
		surface.SetDrawColor(20,20,0,190)
		surface.DrawRect(450,0,700, 250)
		draw.DrawText("City Code: ", "orbi-160", 450,0,nil)
		if GetGlobalBool("civil", true)== true then
			draw.DrawText("Civil", "orbi-160", 650,300,Color(0,255,0))
			surface.DrawRect(650,300,300, 250)
		elseif GetGlobalBool("cu", false) == true then
			draw.DrawText("Civil Unrest", "orbi-160", 350,300,Color(209,114,26))
			surface.DrawRect(350,300,850, 250)
		elseif GetGlobalBool("jw", false) == true then
			draw.DrawText("Judgment Waiver", "orbi-160", 150,300,Color(255,0,0))
			surface.DrawRect(150,300,1300, 250)
		end
	cam.End3D2D()
end


	


	

