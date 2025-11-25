# Calculate Penetration Depth
$scoreboard players operation #Physics.PenetrationDepth Physics -= #Physics.Projection.BlockCornerBase$(StartCorner).CrossProductAxis.yx Physics
scoreboard players operation #Physics.PenetrationDepth Physics -= #Physics.Projection.BlockCenter.CrossProductAxis.yx Physics
execute if score #Physics.InvertValues Physics matches 1 run scoreboard players operation #Physics.PenetrationDepth Physics *= #Physics.Constants.-1 Physics

# Check if the Penetration Depth is within the threshold (Can be slightly negative)
execute if score #Physics.PenetrationDepth Physics < #Physics.Settings.Accumulation.MinPenetrationDepth Physics run return 0

# Append the contact
$data modify storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts append value {FeatureB:$(Edge)b,ContactNormal:[I;0,0,0]}
execute store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].FeatureA byte 1 run scoreboard players get #Physics.Contact.FeatureA Physics

execute store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].PenetrationDepth short 1 run scoreboard players get #Physics.PenetrationDepth Physics

# Contact Normal
execute if score #Physics.InvertValues Physics matches 0 store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].ContactNormal[0] int 1 run scoreboard players get #Physics.CrossProductAxis.yx.x Physics
execute if score #Physics.InvertValues Physics matches 0 store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].ContactNormal[2] int 1 run return run scoreboard players get #Physics.CrossProductAxis.yx.z Physics
execute store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].ContactNormal[0] int -1 run scoreboard players get #Physics.CrossProductAxis.yx.x Physics
execute store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].ContactNormal[2] int -1 run scoreboard players get #Physics.CrossProductAxis.yx.z Physics
