# Get ObjectA's edge
# (Important): There are 4 possible edges, so everything is cached.
$execute store result storage physics:temp data.NewContact.FeatureA byte 1 store result storage physics:temp data.FeatureA byte 1 run scoreboard players set #Physics.FeatureA Physics $(Edge)

$execute store result score #Physics.ObjectA.EdgeStart.x Physics run scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosGlobal.$(StartCorner).x
$execute store result score #Physics.ObjectA.EdgeStart.y Physics run scoreboard players operation #Physics.Maths.Value2 Physics = #Physics.ThisObject Physics.Object.CornerPosGlobal.$(StartCorner).y
$execute store result score #Physics.ObjectA.EdgeStart.z Physics run scoreboard players operation #Physics.Maths.Value3 Physics = #Physics.ThisObject Physics.Object.CornerPosGlobal.$(StartCorner).z

# Get the edge's projection (For calculating the penetration depth)
$scoreboard players operation #Physics.PenetrationDepth Physics = #Physics.Projection.ObjectCorner$(StartCorner).CrossProductAxis.yx Physics
scoreboard players operation #Physics.PenetrationDepth Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.yx Physics
