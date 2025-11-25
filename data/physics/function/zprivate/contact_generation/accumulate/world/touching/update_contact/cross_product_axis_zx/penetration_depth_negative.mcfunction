# Store contact
$data modify storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts append value {FeatureB:$(Edge)b,ContactNormal:[I;0,0,0]}
execute store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].FeatureA byte 1 run scoreboard players get #Physics.Contact.FeatureA Physics
execute store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].PenetrationDepth short 1 run scoreboard players get #Physics.PenetrationDepth Physics

execute if score #Physics.InvertValues Physics matches 0 store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].ContactNormal[0] int 1 run scoreboard players get #Physics.CrossProductAxis.zx.x Physics
execute if score #Physics.InvertValues Physics matches 0 store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].ContactNormal[1] int 1 run return run scoreboard players get #Physics.CrossProductAxis.zx.y Physics
execute store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].ContactNormal[0] int -1 run scoreboard players get #Physics.CrossProductAxis.zx.x Physics
execute store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].ContactNormal[1] int -1 run scoreboard players get #Physics.CrossProductAxis.zx.y Physics
