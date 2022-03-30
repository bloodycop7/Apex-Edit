
function DoorKick(ply)
    local trace = ply:GetEyeTraceNoCursor()
    if trace.Entity:GetClass() =="prop_door_rotating" then
        if ply:IsCP() then
            local injectsound = Sound("npc/metropolice/vo/inject.wav")
            ply:EmitSound(injectsound)
            timer.Simple( SoundDuration(injectsound), function() 
                ply:forceSequence("kickdoorbaton")
                timer.Simple(1.1, function()
                    trace.Entity:Fire("Unlock")
                    trace.Entity:EmitSound("physics/wood/wood_plank_break1.wav", 100, 90)
                    trace.Entity:Fire("Open")
                    ply:notify("You kicked down this door!")
                end)
            end)
        else
            ply:notify("You must be part of the Civil Protection to preform this action!")
            return 
        end
    end
end


AddChatCommand("/doorkick", DoorKick)
AddChatCommand("/kickdoor", DoorKick)

function map(ply)
    if game.GetMap() == "rp_apex_industrial17_b10" then
        if (ply:GetPos() - Vector(1858.6030273438, 3585.53125, 125.53125)):LengthSqr() <= (800 ^ 2) then
			for v,k in pairs(ents.FindByName("nexus_tunnel_elevator1")) do
				k:Fire("Open")
			end

			ply:notify("You have called the Plaza elevator.")
		else
			ply:notify("You are not near the Plaza elevator.")
		end
    end
end

AddChatCommand("/elevator", map)

function kickmenu()
    if input.IsKeyDown( KEY_F2 ) then
        local mainbox = vgui.Create("DFrame")
        mainbox:Center()
        mainbox:SetSize(200,300)
        mainbox:ShowCloseButton(true)
        mainbox:MakePopup()
    end
end

