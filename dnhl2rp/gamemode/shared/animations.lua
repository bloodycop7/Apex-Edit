local Anims = {}
Anims[ACT_GMOD_GESTURE_BOW] = "Bow"
Anims[ACT_GMOD_TAUNT_MUSCLE] = "Dance"
Anims[ACT_GMOD_GESTURE_BECON] = "Follow me!"
Anims[ACT_GMOD_TAUNT_LAUGH] = "Laugh"
Anims[ACT_GMOD_TAUNT_PERSISTENCE] = "Lion Pose"
Anims[ACT_GMOD_GESTURE_DISAGREE] = "Non-verbal no"
Anims[ACT_GMOD_GESTURE_AGREE] = "Thumbs up"
Anims[ACT_GMOD_GESTURE_WAVE] = "Wave"


function GM:GrabEarAnimation( ply )
-- We hate that Ear Animation :3
end

hook.Add("CalcMainActivity", "darkrp_animations", function(ply, velocity) -- Using hook.Add and not GM:CalcMainActivity to prevent animation problems
	-- Dropping weapons/money!
	if ply.anim_DroppingItem then
		ply:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_ITEM_DROP, true)
		ply.anim_DroppingItem = nil
	end

	-- Giving items!
	if ply.anim_GivingItem then
		ply:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_ITEM_GIVE, true)
		ply.anim_GivingItem = nil
	end

	if CLIENT and ply.SaidHi then
		ply:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_SIGNAL_GROUP, true)
		ply.SaidHi = nil
	end

	if CLIENT and ply.ThrewPoop then
		ply:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_ITEM_THROW, true)
		ply.ThrewPoop = nil
	end

	if CLIENT and ply.knocking then
		ply:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_HL2MP_GESTURE_RANGE_ATTACK_FIST, true)
		ply.knocking = nil
	end

	if CLIENT and ply.usekeys then
		ply:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_ITEM_PLACE, true)
		ply.usekeys = nil
	end

	if not SERVER then return end

	-- Hobo throwing poop!
	local Weapon = ply:GetActiveWeapon()
	if RPExtraTeams[ply:Team()] and RPExtraTeams[ply:Team()].hobo and not ply.ThrewPoop and IsValid(Weapon) and Weapon:GetClass() == "weapon_bugbait" and ply:KeyDown(IN_ATTACK) then
		ply.ThrewPoop = true
		ply:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_ITEM_THROW, true)


		local RP = RecipientFilter()
		RP:AddAllPlayers()

		umsg.Start("anim_throwpoop", RP)
			umsg.Entity(ply)
		umsg.End()
	elseif ply.ThrewPoop and not ply:KeyDown(IN_ATTACK) then
		ply.ThrewPoop = nil
	end

	-- Saying hi/hello to a player
	if not ply.SaidHi and IsValid(Weapon) and Weapon:GetClass() == "weapon_physgun" and ply:KeyDown(IN_ATTACK) then
		local ent = ply:GetEyeTrace().Entity
		if IsValid(ent) and ent:IsPlayer() then
			ply.SaidHi = true
			ply:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_SIGNAL_GROUP, true)

			local RP = RecipientFilter()
			RP:AddAllPlayers()

			umsg.Start("anim_sayhi", RP)
				umsg.Entity(ply)
			umsg.End()
		end
	elseif ply.SaidHi and not ply:KeyDown(IN_ATTACK) then
		ply.SaidHi = nil
	end
end)

if SERVER then
	local function CustomAnim(ply, cmd, args)
		local Gesture = tonumber(args[1] or 0)
		if not Anims[Gesture] then return end

		local RP = RecipientFilter()
		RP:AddAllPlayers()

		umsg.Start("_DarkRP_CustomAnim", RP)
		umsg.Entity(ply)
		umsg.Short(Gesture)
		umsg.End()
	end
	concommand.Add("_DarkRP_DoAnimation", CustomAnim)

	local function DoCitizenPhrase(ply, cmd, args)

		local CitizenPhrase = (args[1] or 0)
		if not table.KeyFromValue(CitizenPhrases,CitizenPhrase) then return end
		local RP = RecipientFilter()
		RP:AddAllPlayers()

		if ply:Team() == TEAM_CITIZEN or ply:Team() == TEAM_CWU then
			ply:EmitSound(Sound(CitizenPhrase),80, 100)
		end
	end
	concommand.Add("HL2RP_DoCitizenPhrase", DoCitizenPhrase)

	local function DoCPPhrase(ply, cmd, args)

		local CPPhrase = (args[1] or 0)
		if not table.KeyFromValue(CPPhrases,CPPhrase) then return end
		local RP = RecipientFilter()
		RP:AddAllPlayers()

		if ply:Team() == TEAM_CP then
			ply:EmitSound(Sound(CPPhrase1),80, 100)
		end
	end
	concommand.Add("HL2RP_DoCPPhrase", DoCPPhrase)

	local function DoVORTPhrase(ply, cmd, args)

		local VORTPhrase = (args[1] or 0)
		if not table.KeyFromValue(VORTPhrases,VORTPhrase) then return end
		local RP = RecipientFilter()
		RP:AddAllPlayers()

		if ply:Team() == TEAM_VORT then
			ply:EmitSound(Sound(VORTPhrase),80, 100)
		end


	end
	concommand.Add("HL2RP_DoVORTPhrase", DoVORTPhrase)

	return
end

local function DropItem(um)
	local ply = um:ReadEntity()
	if not IsValid(ply) then return end

	ply.anim_DroppingItem = true
end
usermessage.Hook("anim_dropitem", DropItem)

local function GiveItem(um)
	local ply = um:ReadEntity()
	if not IsValid(ply) then return end

	ply.anim_GivingItem = true
end
usermessage.Hook("anim_giveitem", GiveItem)

local function ThrowPoop(um)
	local ply = um:ReadEntity()
	if not IsValid(ply) then return end

	ply.ThrewPoop = true
end
usermessage.Hook("anim_throwpoop", ThrowPoop)

local function PhysgunHi(um)
	local ply = um:ReadEntity()
	if not IsValid(ply) then return end

	ply.SaidHi = true
end
usermessage.Hook("anim_sayhi", PhysgunHi)

local function KeysAnims(um)
	local ply = um:ReadEntity()
	if not IsValid(ply) then return end
	local Type = um:ReadString()
	ply[Type] = true
end
usermessage.Hook("anim_keys", KeysAnims)

local function manhackanim(um)
	local ply = um:ReadEntity()
	if not IsValid(ply) then return end
	local Type = um:ReadString()
	ply[Type] = true
end
usermessage.Hook("deployman", manhackanim)


local function CustomAnimation(um)
	local ply = um:ReadEntity()
	local act = um:ReadShort()

	if not IsValid(ply) then return end
	ply:AnimRestartGesture(GESTURE_SLOT_CUSTOM, act, true)
end
usermessage.Hook("_DarkRP_CustomAnim", CustomAnimation)

local AnimFrame
local function AnimationMenu()
	if AnimFrame then return end

	local Panel = vgui.Create("Panel")
	Panel:SetPos(0,0)
	Panel:SetSize(ScrW(), ScrH())
	function Panel:OnMousePressed()
		AnimFrame:Close()
	end

	AnimFrame = AnimFrame or vgui.Create("DFrame", Panel)
	local Height = table.Count(Anims) * 60
	AnimFrame:SetSize(130, Height)
	AnimFrame:SetPos(ScrW()/2 + ScrW() * 0.1, ScrH()/2 - (Height/2))
	AnimFrame:SetTitle("Act")
	AnimFrame:SetVisible(true)
	AnimFrame:MakePopup()

	function AnimFrame:Close()
		Panel:Remove()
		AnimFrame:Remove()
		AnimFrame = nil
	end

	local i = 0
	for k,v in SortedPairs(Anims) do
		i = i + 1
		local button = vgui.Create("DButton", AnimFrame)
		button:SetPos(10, (i-1)*55 + 30)
		button:SetSize(110, 50)
		button:SetText(v)
		button:SetTextColor(Color( 255, 255, 255 ))

		button.DoClick = function()
			RunConsoleCommand("_DarkRP_DoAnimation", k)
		end
	end
	AnimFrame:SetSkin(GAMEMODE.Config.DarkRPSkin)
end
concommand.Add("_DarkRP_AnimationMenu", AnimationMenu)



/*
===============
Citizen Phrases
===============
*/

local CitizenFrame
local function CitizenMenu()
	StopSpam = 0
	if CitizenFrame then return end

	local CitizenPanel = vgui.Create("Panel")
	CitizenPanel:SetPos(0,0)
	CitizenPanel:SetSize(ScrW(), ScrH())
	function CitizenPanel:OnMousePressed()
		CitizenFrame:Close()
	end

	CitizenFrame = CitizenFramee or vgui.Create("DFrame", CitizenPanel)
	local Height = table.Count(CitizenPhrases) * 20 + 40
	CitizenFrame:SetSize(150, Height)
	CitizenFrame:SetPos(ScrW()/2 + ScrW() * 0.1, ScrH()/2 - (Height/2))
	CitizenFrame:SetTitle("Voice")
	CitizenFrame:SetVisible(true)
	CitizenFrame:MakePopup()

	function CitizenFrame:Close()
		CitizenPanel:Remove()
		CitizenFrame:Remove()
		CitizenFrame = nil
	end

	local Citizeni = 0
	local StopSpam = 0
	for k,v in pairs(CitizenPhrases) do
		Citizeni = Citizeni + 1
		local CitizenPhraseButton = vgui.Create("DButton", CitizenFrame)
		CitizenPhraseButton:SetPos(20, (Citizeni-1)*20 + 30)
		CitizenPhraseButton:SetSize(110, 20)
		CitizenPhraseButton:SetText(k)
		CitizenPhraseButton:SetTextColor(Color( 255, 255, 255 ))
		CitizenPhraseButton.DoClick = function()
		if StopSpam == 0 then
		RunConsoleCommand("HL2RP_DoCitizenPhrase", v)
		StopSpam = 1
		end

		timer.Create( "VoiceSpam", 1, 4, function()
		StopSpam = 0
			--ply:EmitSound(Sound(v),80, 100)
			end)
		end
	end
	CitizenFrame:SetSkin(GAMEMODE.Config.DarkRPSkin)
end
concommand.Add("CitizenPhrases", CitizenMenu)

/*
================
CP Phrases
================
*/

local CPFrame
local function CPMenu()
	StopSpam = 0
	if CPFrame then return end

	local CPPanel = vgui.Create("Panel")
	CPPanel:SetPos(0,0)
	CPPanel:SetSize(ScrW(), ScrH())
	function CPPanel:OnMousePressed()
		CPFrame:Close()
	end

	CPFrame = CPFramee or vgui.Create("DFrame", CPPanel)
	local Height2 = table.Count(CPPhrases) * 20 + 40
	CPFrame:SetSize(150, Height2)
	CPFrame:SetPos(ScrW()/2 + ScrW() * 0.1, ScrH()/2 - (Height2/2))
	CPFrame:SetTitle("Voice")
	CPFrame:SetVisible(true)
	CPFrame:MakePopup()

	function CPFrame:Close()
		CPPanel:Remove()
		CPFrame:Remove()
		CPFrame = nil
	end

	local CPi = 0
	local StopSpam = 0
	for k,v in SortedPairs(CPPhrases) do
		CPi = CPi + 1
		local CPPhraseButton = vgui.Create("DButton", CPFrame)
		CPPhraseButton:SetPos(20, (CPi-1)*20 + 30)
		CPPhraseButton:SetSize(110, 20)
		CPPhraseButton:SetText(k)
		CPPhraseButton:SetTextColor(Color( 255, 255, 255 ))
		CPPhraseButton.DoClick = function()
		if StopSpam == 0 then
		RunConsoleCommand("HL2RP_DoCPPhrase", v)
		StopSpam = 1
		end

		timer.Create( "VoiceSpam", 1, 1, function()
		StopSpam = 0
			--ply:EmitSound(Sound(v),80, 100)
			end)
		end
	end
	CPFrame:SetSkin(GAMEMODE.Config.DarkRPSkin)
end
concommand.Add("CPPhrases", CPMenu)

/*
================
VORT Phrases
================
*/

local VORTFrame
local function VORTMenu()
	StopSpam = 0
	if VORTFrame then return end

	local VORTPanel = vgui.Create("Panel")
	VORTPanel:SetPos(0,0)
	VORTPanel:SetSize(ScrW(), ScrH())
	function VORTPanel:OnMousePressed()
		VORTFrame:Close()
	end

	VORTFrame = VORTFramee or vgui.Create("DFrame", VORTPanel)
	local Height2 = table.Count(VORTPhrases) * 20 + 40
	VORTFrame:SetSize(150, Height2)
	VORTFrame:SetPos(ScrW()/2 + ScrW() * 0.1, ScrH()/2 - (Height2/2))
	VORTFrame:SetTitle("Voice")
	VORTFrame:SetVisible(true)
	VORTFrame:MakePopup()

	function VORTFrame:Close()
		VORTPanel:Remove()
		VORTFrame:Remove()
		VORTFrame = nil
	end

	local VORTi = 0
	local StopSpam = 0
	for k,v in SortedPairs(VORTPhrases) do
		VORTi = VORTi + 1
		local VORTPhraseButton = vgui.Create("DButton", VORTFrame)
		VORTPhraseButton:SetPos(20, (VORTi-1)*20 + 30)
		VORTPhraseButton:SetSize(110, 20)
		VORTPhraseButton:SetText(k)
		VORTPhraseButton:SetTextColor(Color( 255, 255, 255 ))
		VORTPhraseButton.DoClick = function()
		if StopSpam == 0 then
		RunConsoleCommand("HL2RP_DoVORTPhrase", v)
		StopSpam = 1
		end

		timer.Create( "VoiceSpam", 1, 1, function()
		StopSpam = 0
			--ply:EmitSound(Sound(v),80, 100)
			end)
		end
	end
	VORTFrame:SetSkin(GAMEMODE.Config.DarkRPSkin)
end
concommand.Add("VORTPhrases", VORTMenu)
