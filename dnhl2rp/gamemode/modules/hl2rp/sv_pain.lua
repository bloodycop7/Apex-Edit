local cds = {
    Sound("npc/metropolice/die1.wav"),
	Sound("npc/metropolice/die2.wav"),
	Sound("npc/metropolice/die3.wav")
}

local cfs = {
    Sound("npc/metropolice/fire_scream1.wav "),
	Sound("npc/metropolice/fire_scream2.wav "),
	Sound("npc/metropolice/fire_scream3.wav ")
}

local chs = {
    Sound("npc/metropolice/pain1.wav"),
	Sound("npc/metropolice/pain2.wav"),
	Sound("npc/metropolice/pain3.wav")
}

local vhs = {
    Sound("vo/npc/vortigaunt/vortigese07.wav"),
	Sound("vo/npc/vortigaunt/vortigese04.wav"),
	Sound("vo/npc/vortigaunt/vortigese03.wav")
}

local cps = {
    Sound("vo/npc/male01/pain01.wav"),
	Sound("vo/npc/male01/pain02.wav"),
	Sound("vo/npc/male01/pain03.wav"),
	Sound("vo/npc/male01/pain04.wav"),
	Sound("vo/npc/male01/pain05.wav"),
	Sound("vo/npc/male01/pain06.wav"),
	Sound("vo/npc/male01/pain07.wav"),
	Sound("vo/npc/male01/pain08.wav"),
	Sound("vo/npc/male01/pain09.wav")
}

local cpmodels = {
	Model("models/dpfilms/metropolice/hdpolice.mdl"),
	Model("models/dpfilms/metropolice/elite_police.mdl"),
	Model("models/dpfilms/metropolice/blacop.mdl")
}

function sounddeath(client,inflictor,attacker)
    if client:IsCP() and attacker:GetClass():find("env_fire") then
        client:EmitSound(table.Random(cfs))
    end

    if client:IsCP() and attacker:GetClass():find("entityFlame") then
        client:EmitSound(table.Random(cfs))
    end

    if client:IsCP() and cpmodels[client:GetModel()] then
		client:EmitSound(table.Random(cds))
	end
end

hook.Add("PlayerDeath", "damn", sounddeath)

function pain(client,attacker,health,damage)
    if client:IsCP() and damage > 3 then
        client:EmitSound(table.Random(chs))
    end
    if client:Team() == TEAM_VORT and damage > 3 then
        client:EmitSound(table.Random(vhs))
	end
    if client:Team() == TEAM_CITIZEN or client:Team() == TEAM_CWU and damage > 3 then
        client:EmitSound(table.Random(cps))
    end
end

hook.Add("PlayerHurt", "dead2", pain)
