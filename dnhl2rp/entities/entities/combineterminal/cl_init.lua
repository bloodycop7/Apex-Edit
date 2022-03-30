include('shared.lua')


function ENT:Draw()
	self:DrawModel()
	if LocalPlayer():GetEyeTrace().Entity == self and EyePos():Distance( self:GetPos() ) < 512 then
		hook.Add("PreDrawHalos", "Halo", function()
			local client = LocalPlayer()
			local team = client:Team()
			if team == TEAM_CP or team == TEAM_OVERWATCH then
				halo.Add({ self }, Color(255, 0, 0), 0, 0, 10)
			end
		end)
	end
end

net.Receive("vguiterminal", function()
	local client = LocalPlayer()
	local mainbox = vgui.Create("DFrame")
	mainbox:SetSize(500,580)
	mainbox:Center()
	mainbox:ShowCloseButton(true)
	mainbox:MakePopup()
	mainbox:SetTitle("Combine Terminal")
	mainbox.Paint = function(self, w, h)
		draw.RoundedBox(2,0,0,w,h,Color(54,73,112))
	end
	local civilbut = vgui.Create("DButton", mainbox)
	civilbut:SetTextColor(Color(0,255,64))
	civilbut:SetFont("BudgetLabel")
	civilbut:SetText("Civil Code")
	civilbut:SetPos(70,30)
	civilbut:SetSize(350,100)
	civilbut.Paint = function(self,w,h)
		draw.RoundedBox(2,0,0,w,h,Color(36,76,209))
	end
	civilbut.DoClick = function()
		if ((cooldown or 0) < CurTime()) then
			local client = LocalPlayer()	
			SetGlobalBool("jw", false)			// A custom function run when clicked ( note the . instead of : )
			SetGlobalBool("civil", true)
			SetGlobalBool("cu", false)
			cooldown = CurTime() + 2
		end			// Run the console command "say hi" when you click it ( command, args )
	end

	local jw = vgui.Create("DButton", mainbox)
	jw:SetTextColor(Color(255,0,0))
	jw:SetFont("BudgetLabel")
	jw:SetText("Activate Judgment Waiver")
	jw:SetPos(70,240)
	jw:SetSize(350,100)
	jw.Paint = function(self,w,h)
		draw.RoundedBox(2,0,0,w,h,Color(36,76,209))
	end
	jw.DoClick = function()	
		local client = LocalPlayer()
		if ((cooldown or 0) < CurTime()) then
			SetGlobalBool("jw", true)
			SetGlobalBool("civil", false)			// A custom function run when clicked ( note the . instead of : )
			SetGlobalBool("cu", false)
			timer.Simple(0, function()
				client:ConCommand("play ambient/machines/wall_move4.wav")	
			end)
			timer.Simple(3, function()
				client:ConCommand("play npc/overwatch/cityvoice/f_protectionresponse_5_spkr.wav")	
			end)
			timer.Simple(15, function()
				client:ConCommand("play exposing.mp3")	
			end)
			cooldown = CurTime() + 2
		end			// Run the console command "say hi" when you click it ( command, args )
	end

	local cu = vgui.Create("DButton", mainbox)
	cu:SetTextColor(Color(255,157,0))
	cu:SetFont("BudgetLabel")
	cu:SetText("Activate Civil Unrest")
	cu:SetPos(70,460)
	cu:SetSize(350,100)
	cu.Paint = function(self,w,h)
		draw.RoundedBox(2,0,0,w,h,Color(36,76,209))
	end
	cu.DoClick = function()
		local client = LocalPlayer()
		if ((cooldown or 0) < CurTime()) then
			SetGlobalBool("civil", false)			// A custom function run when clicked ( note the . instead of : )
			SetGlobalBool("jw", false)
			SetGlobalBool("cu", true)
			timer.Simple(0, function()
				client:ConCommand("play npc/overwatch/cityvoice/f_unrestprocedure1_spkr.wav")
			end)
			cooldown = CurTime() + 2
		end
	end
	print("opened from caller")
end)




