function spawn(ply)
    if ply:IsAdmin() then

        local entitiesforspawn = {
            "gunpowder",
            "iron",
            "wood"
        }

        local poses = {
            Vector(3750.454590, 6243.376953, -67.631577),
            Vector(4675.001465, 8030.603516, 351.681244),
            Vector(5919.695313, 4014.336182, 3.856246)
        }
        timer.Create("loote", math.random(80, 500), 0, function()
            local e = ents.Create(entitiesforspawn[math.random(1, #entitiesforspawn)])
            e:Spawn()
            e:Activate()
            e:SetPos(poses[math.random(1, #poses)])
            print("itemspawned")
        end)
    end
end

concommand.Add("spawnbegin", spawn)

function randompos(ply)
    local poses = {
        Vector(3742.987549, 6255.968750, -105.623749),
        Vector(4675.001465, 8030.603516, 351.681244),
        Vector(5919.695313, 4014.336182, 3.856246)
    }
    if ply:IsAdmin() then
        ply:SetPos(poses[math.random(1, #poses)])
    end
end

concommand.Add("posset", randompos)

function died(ply)
    local chance = math.random(0,100)
    if ply:Team() == TEAM_CP then
        if chance <= 25 then 
            local e = ents.Create( "bio" )
            e:Spawn()
            e:Activate()
            e:SetPos( ply:GetPos() + Vector( 0, 0, 100) )
        elseif chance >= 25 and chance <= 50 then
            local e = ents.Create( "ls_usp" )
            e:Spawn()
            e:Activate()
            e:SetPos( ply:GetPos() + Vector( 0, 0, 100) )
        elseif chance >= 50 and chance <= 75 then
            local e = ents.Create( "item_ammo_smg1" )
            e:Spawn()
            e:Activate()
            e:SetPos( ply:GetPos() + Vector( 0, 0, 100) )
        elseif chance >=75 and chance <= 100 then
            local e = ents.Create( "ls_mp7" )
            e:Spawn()
            e:Activate()
            e:SetPos( ply:GetPos() + Vector( 0, 0, 100) )
        end
    end
end

hook.Add("PlayerDeath", "days", died)

function cuon(ply)
    if ply:IsAdmin() then
        SetGlobalBool("cu", true)
        SetGlobalBool("civil", false)
        SetGlobalBool("jw", false)
        ply:notify("You have Turned Civil Unrest On.")
        timer.Simple(0, function()
            ply:ConCommand("play npc/overwatch/cityvoice/f_unrestprocedure1_spkr.wav")
        end)
    else
        ply:notify("You are not part of the Moderation Team to do this!")
    end
end

function cuoff(ply)
    if ply:IsAdmin() then
        SetGlobalBool("jw", false)
        SetGlobalBool("cu", false)
        SetGlobalBool("civil", true)
        ply:notify("You have Turned Civil Unrest Off.")
    else
        ply:notify("You are not part of the Moderation Team to do this!")
    end
end

function jwon(ply)
    if ply:IsAdmin() then
        SetGlobalBool("cu", false)
        SetGlobalBool("civil", false)
        SetGlobalBool("jw", true)
        ply:notify("You have Turned JW On.")
        timer.Simple(0, function()
            ply:ConCommand("play ambient/machines/wall_move4.wav")	
        end)
        timer.Simple(3, function()
            ply:ConCommand("play npc/overwatch/cityvoice/f_protectionresponse_5_spkr.wav")	
        end)
        timer.Simple(15, function()
            ply:ConCommand("play exposing.mp3")	
        end)
    else
        ply:notify("You are not part of the Moderation Team to do this!")
    end
end

function jwoff(ply)
    if ply:IsAdmin() then
        SetGlobalBool("cu", false)
        SetGlobalBool("civil", true)
        SetGlobalBool("jw", false)
        ply:notify("You have Turned JW Off.")
    else
        ply:notify("You are not part of the Moderation Team to do this!")
    end
end

AddChatCommand("/jwon", jwon)
AddChatCommand("/jwoff", jwoff)
AddChatCommand("/cuon", cuon)
AddChatCommand("/cuoff", cuoff)
AddChatCommand("/civil", civil)

function civil(ply)
    if ply:IsAdmin() then
        SetGlobalBool("cu", false)
        SetGlobalBool("civil", true)
        SetGlobalBool("jw", false)
        ply:notify("You have Turned Civil On.")
    else
        ply:notify("You are not part of the Moderation Team to do this!")
    end
end

hook.Add("PlayerDeath", "resetsubmat", function(ply)
    ply:SetSubMaterial(0, "")
end)

hook.Add("OnPlayerChangedTeam", "resetsub2", function(ply)
    ply:SetSubMaterial(0, "")
end)

util.AddNetworkString("bro please for ffs")

function mainpage(ply)
    if not IsValid(ply) then return end
    net.Start("bro please for ffs")
    net.Send(ply)
end

AddChatCommand("/page", mainpage)

function spawnmanhack(p)
    local name = p:Name()
    if p:Team() == TEAM_CP and p:Name():find("GRID") or p:Name():match("SPEAR") or name:match("CmD") then
        p:forceSequence("deploy")
        timer.Simple(0.9, function()
            local manhack = ents.Create("npc_manhack")
            manhack:SetPos( p:GetPos() + Vector(0,0, 120) )
            manhack:Spawn()
            manhack:Activate()
        end)

    else
        p:notify("You cannot do that!")
    end
end

AddChatCommand("/deploy", spawnmanhack)


function jwcheck(ply)
    if GetGlobalBool("jw", false) == true then
        timer.Simple(0, function()
            ply:ConCommand("play ambient/machines/wall_move4.wav")	
        end)
        timer.Simple(3, function()
            ply:ConCommand("play npc/overwatch/cityvoice/f_protectionresponse_5_spkr.wav")	
        end)
        timer.Simple(15, function()
            ply:ConCommand("play exposing.mp3")	
        end)
    end
end