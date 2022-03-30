
if (SERVER) then
    local aw = {
        ["pocket"] = true,
        ["keys"] = true,
        ["gmod_tool"] = true,
        ["weapon_physgun"] = true
    }

    local combineNPCs = {
        ["npc_metropolice"] = true,
        ["npc_combine_s"] = true,
        ["CombinePrison"] = true,
        ["npc_cscanner"] = true,
        ["npc_manhack"] = true,
        ["PrisonShotgunner"] = true,
        ["ShotgunSoldier"] = true,
        ["npc_turret_floor"] = true,
        ["npc_clawscanner"] = true,
        ["npc_rollermine"] = true,
        ["npc_combine_camera"] = true,
        ["npc_combinegunship"] = true,
        ["npc_hunter"] = true,
        ["npc_apc_dropship"] = true,
        ["npc_elite_overwatch_dropship"] = true,
        ["npc_civil_protection_tier1_dropship"] = true,
        ["npc_civil_protection_tier2_dropship"] = true,
        ["npc_shotgunner_dropship"] = true,
        ["npc_overwatch_squad_tier1_dropship"] = true,
        ["npc_overwatch_squad_tier2_dropship"] = true,
        ["npc_overwatch_squad_tier3_dropship"] = true,
        ["npc_random_combine_dropship"] = true,
        ["npc_strider_dropship"] = true,
        ["npc_strider"] = true,
        ["combine_mine"] = true,
        ["npc_rollermine"] = true,
        ["npc_turret_ceiling"] = true,
        ["npc_turret_ground"] = true,
        ["npc_sniper"] = true,
        ["npc_helicopter"] = true,
        ["combine_mine"] = true,
        ["npc_clawscanner"] = true,
        ["npc_stalker"] = true,
        ["npc_combinedropship"] = true,
        ["npc_vj_hlvr_suppressor"] = true,
        ["npc_vj_hlvr_police"] = true,
        ["npc_vj_hlvr_heavy"] = true,
        ["npc_vj_hlvr_grunt"] = true,
        ["npc_vj_hlvr_grunt_police"] = true,
        ["npc_vj_hlvr_captain"] = true,
        ["npc_vj_hlvr_soldier_sg"] = true,
        ["npc_vj_hlvr_soldier"] = true,
        ["npc_vj_hlvr_soldier_elite"] = true,
        ["npc_vj_hlvr_suppressor"] = true,
        ["npc_hla_metropolice"] = true,
        ["npc_vj_hlvr_heavy"] = true
    }

    local rebelNPCs = {
        ["npc_alyx"] = true,
        ["npc_alyx_ep2"] = true,
        ["npc_barney"] = true,
        ["npc_barney_ep1"] = true,
        ["npc_citizen"] = true,
        ["npc_dog"] = true,
        ["npc_magnusson"] = true,
        ["npc_kleiner"] = true,
        ["npc_mossman"] = true,
        ["Medic"] = true,
        ["npc_odessa"] = true,
        ["Rebel"] = true,
        ["Refugee"] = true,
        ["npc_turret_floor_rebel"] = true,
        ["VortigauntUriah"] = true,
        ["npc_vortigaunt"] = true,
        ["npc_vortigaunt_2004"] = true,
        ["VortigauntSlave"] = true,
        ["npc_vortigaunt_slave_2004"] = true,
        ["npc_turret_floor_rebel"] = true,
        ["npc_resturret01"] = true,
        ["npc_resturret02"] = true,
        ["npc_resturret03"] = true,
        ["rebel_mine"] = true
    }

    hook.Add("OnEntityCreated", "help", function(entity)
    
        if (entity:IsNPC()) then
            for _, client in pairs(player.GetAll()) do

                if combineNPCs[entity:GetClass()] or aw[client:GetActiveWeapon():GetClass()] then
                    entity:AddEntityRelationship(client, client:IsCP() and D_LI or D_HT, 99)
                    combine_npcs = combine_npcs or {}
                    combine_npcs[entity] = true
                end

                if rebelNPCs[entity:GetClass()] then

                    entity:AddEntityRelationship(client, client:IsCP() and D_HT or D_LI, 99)
                    rebel_npcs = rebel_npcs or {}
                    rebel_npcs[entity] = true
                end
            end
        end
    end)

    hook.Add("EntityRemoved", "help2", function(entity)
        if (entity:IsNPC()) then
            combine_npcs = combine_npcs or {}
            combine_npcs[entity] = nil
        end
    end)

    hook.Add("PlayerSpawn", "help3", function(ply)
        if (ply and combine_npcs) then
            if (ply:IsCP()) then
                for ent, v in pairs(combine_npcs) do
                    if combineNPCs[ent:GetClass()] then
                        ent:AddEntityRelationship(client, D_LI, 99)
                    end
                end
            else
                for ent, v in pairs(combine_npcs) do
                    if (combineNPCs[ent:GetClass()] and rebelNPCs[ent:GetClass()]) then
                        ent:AddEntityRelationship(ply, D_HT, 99)
                    end
                end
            end
        end
    end)
end
