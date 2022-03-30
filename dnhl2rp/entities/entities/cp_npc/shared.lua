ENT.Base = "base_ai" -- This entity is based on "base_ai"
ENT.Type = "ai" -- What type of entity is it, in this case, it's an AI.
ENT.PrintName		= "CP NPC"
ENT.Author			= "Datamats ~ Re Evaluated By JamesDK"
ENT.Contact			= "N/A"
ENT.Purpose			= "ATM Banker"
ENT.Instructions	= "Press E"
ENT.Category 		= "HL2RP - Vendors"

ENT.Spawnable = true
ENT.AdminOnly = true

ENT.AutomaticFrameAdvance = true -- This entity will animate itself.


CPRanks = {}
CPDivisions = {}
CPRanks[1] = {
		id = 1,
		name = "RCT",
		description = [[Name: Recruit (RCT)
Description:
Recruits are little more than citizens in a uniform.
Most recruits are in the process of receiving basic training
and are kept within the bounds of the Nexus at all times,
unless partnered with another unit.

-- You CAN go rogue (With Staff Permission)! --]],
		xp = 35
}


CPRanks[2] = {
		id = 2,
		name = "i4",
		description = [[Name: Ground Unit 04 (04)
Description:
04’s are the last trainee ranks of the CP. They have almost
completed basic training, and have a good knowledge of
CP procedure.

-- You CAN go rogue (With Staff Permission)! --]],
		xp = 100
}

CPRanks[3] = {
		id = 3,
		name = "i3",
		description = [[Name: Ground Unit 03 (03)
Description:
03’s have completed CP basic training, and are ready to begin
their official duties. They are the first of the frontline CP
forces and work with other Ground Units to perform their duties.
They and all higher units are fitted with biosignals.

-- You CAN go rogue (With Staff Permission)! --]],
		xp = 200
}

CPRanks[4] = {
		id = 4,
		name = "i2",
		description = [[Name: Ground Unit 02 (02)
Description:
02’s have been promoted from 03 after proving their competence and
loyalty to their superiors. 02’s are frequently given training in
advanced techniques, such as breaching.
-- You CANNOT go rogue! --]],
		xp = 300
}

CPRanks[5] = {
		id = 5,
		name = "i1",
		description = [[Name: Ground Unit 01 (01)

Description:
01’s are Ground Units that have proven themselves completely loyal
to the Universal Union, and have undergone some basic memory
replacement, removing negative thoughts about the UU.
Many of them are promoted in order to prepare them for a
command position, and frequently undergo leadership training.

-- You CANNOT go rogue! --]],
		xp = 400
}

CPRanks[6] = {
		id = 6,
		name = "OfC",
		description = [[Name: Officer (OfC)
Description:
OfC’s are CP units that have been chosen to join the high command
of the CP. They have undergone leadership training and are often
tasked with commanding small squads of CP officers, and training
recruits and other low ranked units. They have undergone significant
memory modification,
removing almost all negative thoughts about the UU.

-- You CANNOT go rogue! --]],
		xp = 500
}

CPRanks[7] = {
		id = 7,
		name = "SqL",
		description = [[Name: Squad Leader (SqL)
Description:
Squad Leaders are responsible of commanding PT's and Units
And watching OfC's if they become to turn mentally unfit for their rank.

-- You CANNOT go rogue! --]],
		xp = 600
}

CPRanks[8] = {
		id = 8,
		name = "DvL",
		description = [[Name: Division Leader (DvL)
Description:
The DvL is an exceptional unit, chosen to become the leader
of a particular division. They are responsible for the activities
of all units assigned to their division. Often, they will select
an EpU to act as their second in command and will frequently
organise training sessions for their own division.

-- You CANNOT go rogue! --
Max: 1 Per Division]],
		xp = 800,
		max = 1
}

CPRanks[9] = {
	id = 9,
	name = "DcO",
	description = [[Name: District Control Officer (DcO)
Description:
The DcO is an exceptional unit, chosen to become the leader
of a particular division. They are responsible for the activities
of all units assigned to their division. Often, they will select
an EpU to act as their second in command and will frequently
organise training sessions for their own division.

-- You CANNOT go rogue! --
Max: 1 Per Division]],
	xp = 1000,
	max = 1
}

CPDivisions[1] = {
		id = 1,
		name = "UNION",
		model = "models/dpfilms/metropolice/hdpolice.mdl",
		weapons = {},
		description = [[Name: UNION
Description:
The UNION division is the most common within the CP. Their job
is to patrol the city and man checkpoints. They will often carry
out searches of the apartment complex and other buildings. They
are the frontline of the CP, and all other divisions are designed
to support them.
-- You CAN go rogue (With Staff Permission)! --
]],
		max = 64,
		xp = 35
}
CPDivisions[1].weapons[1] = {"ls_stunstick"}
CPDivisions[1].weapons[2] = {"ls_usp", "arrest_stick"}
CPDivisions[1].weapons[7] = {"ls_mp7"}
CPDivisions[1].weapons[10] = {"ls_357"}

CPDivisions[2] = {
		id = 2,
		name = "HELIX",
		model = "models/dpfilms/metropolice/civil_medic.mdl",
		weapons = {},
		description = [[Name: HELIX
Description:
The HELIX division is made up of medically trained units and are
responsible for the general health of the city and the CP. HELIX’s
often use CWU medics as assistants and frequently set up health centres
to treat the injured and unwell. HELIX units are able to provide
additional medical supplies to those that require them, in exchange for
tokens. Individual HELIX units often join up with other CP divisions and
squads in order to function as a field medic.


-- You CANNOT go rogue! --
Max Units: 10]],
		max = 10,
		xp = 60
}

CPDivisions[2].weapons[1] = {"ls_stunstick"}
CPDivisions[2].weapons[2] = {"ls_usp", "arrest_stick","ls_firstaid"}
CPDivisions[2].weapons[10] = {"ls_357"}


CPDivisions[3] = {
		id = 3,
		name = "GRID",
		model = "models/dpfilms/metropolice/hl2concept.mdl",
		weapons = {"ls_usp"},
		description = [[Name: GRID
Description:
The GRID division are mechanics, responsible for the maintenance of the
Universal Union’s technology, vehicles and weaponry. GRID units
also operate scanner drones, which patrol throughout the city and are
often used for reconnaissance.OCPsionally GRID units will carry out
vehicular patrols in APCs. The main role of GRID units is to provide
mechanical and technological support of other divisions.

-- You CANNOT go rogue! --
Max Units: 6]],
		max = 6,
		xp = 100
}

CPDivisions[3].weapons[1] = {"ls_stunstick", "arrest_stick"}
CPDivisions[3].weapons[7] = {"ls_mp7","door_ram"}
CPDivisions[3].weapons[9] = {"ls_357"}

CPDivisions[4] = {
		id = 4,
		name = "JURY",
		model = "models/dpfilms/metropolice/policetrench.mdl",
		weapons = {},
		description = [[Name: JURY
Description:
The JURY division manages the Nexus prison, and is trained to interrogate
captives. Their uniforms are often covered in the blood and viscera of
their victims and not even their CP comrades are entirely comfortable
being around them. Every officer is familiar with the screams that come
from the interrogation rooms, and the cold, brutal efficiency the JURY’s
operate with.
One shudders to imagine what inhuman thoughts lurk behind that mask…

-- You CANNOT go rogue! --
Max Units: 4]],
		max = 4,
		xp = 200
}

CPDivisions[4].weapons[1] = {"ls_stunstick"}
CPDivisions[4].weapons[2] = {"ls_usp", "arrest_stick"}
CPDivisions[4].weapons[9] = {"ls_spas12", "ls_357"}


CPDivisions[5] = {
		id = 5,
		name = "SPEAR",
		model = "models/dpfilms/metropolice/elite_police.mdl",
		weapons = {},
		description = [[Name: SPEAR
Description:
The SPEAR division is an elite division, tasked with patrolling 404 zones
in small squads and locating rogue units.Members of SPEAR are highly
trained and hardened by the harsh conditions in the 404 zones they
patrol and as such are almost entirely fearless, and highly loyal.

-- You CANNOT go rogue! --
Max Units: 2]],
		max = 2,
		xp = 1500
}

CPDivisions[5].weapons[1] = {"ls_stunstick", "ls_spas12"}

CPDivisions[6] = {
		id = 6,
		name = "VICE",
		model = "models/dpfilms/metropolice/blacop.mdl",
		weapons = {"ls_stunstick", "ls_mp7", "arrest_stick"},
		description = [[Name: VICE
Description:
VICE Is an elite division tasked to protect all High Priority Units.
They are Responsible with guarding them at ALL Cost.
They are equipped with SMG, Stunstick and a Pistol.

-- You CANNOT go rogue! --
Max: 1
]],
	xp = 500,
	max = 3
}

CPDivisions[6].weapons[1] = {"ls_stunstick", "ls_mp7", "arrest_stick", "ls_usp"}
CPDivisions[6].weapons[2] = {"ls_stunstick", "ls_mp7", "arrest_stick", "ls_usp"}
CPDivisions[6].weapons[3] = {"ls_stunstick", "ls_mp7", "arrest_stick", "ls_usp"}
CPDivisions[6].weapons[4] = {"ls_stunstick", "ls_mp7", "arrest_stick", "ls_usp"}
CPDivisions[6].weapons[5] = {"ls_stunstick", "ls_mp7", "arrest_stick", "ls_usp"}
CPDivisions[6].weapons[6] = {"ls_stunstick", "ls_mp7", "arrest_stick", "ls_usp"}
CPDivisions[6].weapons[7] = {"ls_stunstick", "ls_mp7", "arrest_stick", "ls_usp"}
CPDivisions[6].weapons[8] = {"ls_stunstick", "ls_mp7", "arrest_stick", "ls_usp"}
CPDivisions[6].weapons[9] = {"ls_stunstick", "ls_mp7", "arrest_stick", "ls_357"}

CPDivisions[7] = {
		id = 7,
		name = "CmD",
		model = "models/dpfilms/metropolice/elite_police.mdl",
		weapons = {"ls_stunstick", "ls_mp7", "arrest_stick", "ls_357"},
		description = [[Name: COMMANDER
Description:
The CmD or Commander is the commander of the Civil Protection
His job is to maintain the Units and Direct them to victory
He is equiped with .357, SMG and Stunstick

-- You CANNOT go rogue! --
Max: 1
]],
		xp = 1200,
		max = 1
}

function ENT:SetAutomaticFrameAdvance( bUsingAnim ) -- This is called by the game to tell the entity if it should animate itself.
	self.AutomaticFrameAdvance = bUsingAnim
end

-- Since this file is ran by both the client and the server, both will share this information.
