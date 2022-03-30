if not maphl2config  then maphl2config = {} end

maphl2config["rp_nc_d47_v2"] = {

Spawn1=Vector(-367.995514, -1056.031250, -63.983234),

Spawn2=Vector(246.571075, -1312.423340, 41.109695),

JailExit=Vector(-367.995514, -1056.031250, -63.983234),

JailExitAngle= Angle(-362.006317, -1292.195313, -63.968750),

Broadcast=Vector(67.659470, -1669.206177, 1284.031250),

RationPos=Vector(),

RemoveArmor=true,

RemovePhysProps=false,

RationDispPos = Vector(12.031251, -1663.135010, 424.031250),

RationCPDispPos = Vector(-647.493408, -2032.031250, 384.031250),

RemoveObjByPos={

Vector(-410, -2241, 821),

Vector(-352, -2242, 821)

},

ButtonTable =  {

{
id = 4599,
check = function(p)
	if p:IsCP() or p:IsAdmin() then

		if string.match( p:Name(), "DcO" ) or string.match( p:Name(), "CmD" ) or string.match( p:Name(), "OWC" ) or p:Team() == TEAM_ADMINISTRATOR or p:IsAdmin() then

		p:notify("Access granted to Broadcast System")

		return true

		else

		p:notify("Access denied to Broadcast Station")

		return false

		end

	end

end
},


-- Nexus Prison



{

id = 4964,

check = function(p)

	if p:IsCP() or p:IsAdmin() then



		if string.match( p:Name(), "DcO" ) or string.match( p:Name(), "CmD" ) or string.match( p:Name(), "OWC" ) or string.match( p:Name(), "JURY" ) or p:IsAdmin() then

		p:notify("Access granted to Nova Prospekt")



		return true

		else



		p:notify("Access denied to Nova Prospekt")



		return false





		end

	end



end

},


id = 4916,
check = function(p)
	if p:IsCP() or p:IsAdmin() then

		if string.match( p:Name(), "DcO" ) or string.match( p:Name(), "CmD" ) or string.match( p:Name(), "OWC" ) or string.match( p:Name(), "JURY" ) or p:IsAdmin() then

		p:notify("Access granted to Execution Beam")

		return true

		else

		p:notify("Access denied to Execution Beam")

		return false

		end

	end

end
},


BioZones={
["Plaza"]={Vector(591.584961, -1321.669434, 915.215271),Vector(-872.477356, -13.777627, 894.975525)},
["Sector 2"]={Vector(-510.002472, 1068.671021, 761.545105),Vector(3518.741943, 767.158813, 556.49328)},
["Sector 3"]={Vector(2049.855713, -1145.680664, 706.505920),Vector(4103.240234, 230.108383, 652.63275)},
["Nexus"]={Vector(-63.032787, -3136.750977, 1548.722656),Vector(-580.853882, -2020.726929, 712.620972)},
["Nexus Cortyard"]={Vector(-1149.659668, -1360.639771, 535.260803),Vector(-108.836693, -1649.652344, 579.590942)}
},

CitadelPortal=Vector(-8967.436523, 7202.105957, 2411.097900),

AptData={
Vector(1791,2898,987),
Vector(1911,2898,987),
Vector(2717,2898,987),
Vector(2837,2898,987),
Vector(2837,2898,830),
Vector(2717,2898,830),
Vector(1911,2898,830),
Vector(1791,2898,830),
Vector(1791,2898,673),
Vector(1911,2898,673),
Vector(2717,2898,673),
Vector(2837,2898,673)

}

}