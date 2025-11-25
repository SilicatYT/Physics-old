# Get ObjectB's edge
# (Important): There are 4 possible edges, so everything is cached.
$execute store result storage physics:temp data.NewContact.FeatureB byte 1 store result storage physics:temp data.FeatureB byte 1 run scoreboard players set #Physics.FeatureB Physics $(Edge)

$scoreboard players operation #Physics.ObjectB.EdgeStart.x Physics = #Physics.ThisObject Physics.Object.CornerPosGlobal.$(StartCorner).x
$scoreboard players operation #Physics.ObjectB.EdgeStart.y Physics = #Physics.ThisObject Physics.Object.CornerPosGlobal.$(StartCorner).y
$scoreboard players operation #Physics.ObjectB.EdgeStart.z Physics = #Physics.ThisObject Physics.Object.CornerPosGlobal.$(StartCorner).z

# Subtract the start point from the other edge's start point for calculating (u - m)
scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.ObjectB.EdgeStart.x Physics
scoreboard players operation #Physics.Maths.Value2 Physics -= #Physics.ObjectB.EdgeStart.y Physics
scoreboard players operation #Physics.Maths.Value3 Physics -= #Physics.ObjectB.EdgeStart.z Physics

# Calculate the Penetration Depth
$scoreboard players operation #Physics.PenetrationDepth Physics -= #Physics.Projection.OtherObjectCorner$(StartCorner).CrossProductAxis.xz Physics
scoreboard players operation #Physics.PenetrationDepth Physics -= #Physics.Projection.OtherObjectCenter.CrossProductAxis.xz Physics

# Invert the contact normal and penetration depth if necessary
execute if score #Physics.InvertValues Physics matches 0 store result storage physics:temp data.NewContact.PenetrationDepth short 1 run return run scoreboard players get #Physics.PenetrationDepth Physics
execute store result storage physics:temp data.NewContact.PenetrationDepth short 1 run scoreboard players operation #Physics.PenetrationDepth Physics *= #Physics.Constants.-1 Physics
scoreboard players operation #Physics.ContactNormal.x Physics = #Physics.CrossProductAxis.xz.x Physics
scoreboard players operation #Physics.ContactNormal.y Physics = #Physics.CrossProductAxis.xz.y Physics
scoreboard players operation #Physics.ContactNormal.z Physics = #Physics.CrossProductAxis.xz.z Physics
execute store result storage physics:temp data.NewContact.ContactNormal[0] int 1 run scoreboard players operation #Physics.ContactNormal.x Physics *= #Physics.Constants.-1 Physics
execute store result storage physics:temp data.NewContact.ContactNormal[1] int 1 run scoreboard players operation #Physics.ContactNormal.y Physics *= #Physics.Constants.-1 Physics
execute store result storage physics:temp data.NewContact.ContactNormal[2] int 1 run scoreboard players operation #Physics.ContactNormal.z Physics *= #Physics.Constants.-1 Physics
