# Get the object face
execute if score #Physics.InvertValues Physics matches 1 store result storage physics:temp data.NewContact.FeatureB byte 1 store result storage physics:temp data.FeatureB byte 1 run scoreboard players set #Physics.FeatureB Physics 12
execute if score #Physics.InvertValues Physics matches 0 store result storage physics:temp data.NewContact.FeatureB byte 1 store result storage physics:temp data.FeatureB byte 1 run scoreboard players set #Physics.FeatureB Physics 13

# Get the corner point for when ObjectB's axis is y
$execute store result storage physics:temp data.NewContact.FeatureA byte 1 store result storage physics:temp data.FeatureA byte 1 run scoreboard players set #Physics.FeatureA Physics $(Corner)

# Copy the coordinates (For getting the Contact Point later)
$scoreboard players operation #Physics.ContactPoint.x Physics = #Physics.ThisObject Physics.Object.CornerPosGlobal.$(Corner).x
$scoreboard players operation #Physics.ContactPoint.y Physics = #Physics.ThisObject Physics.Object.CornerPosGlobal.$(Corner).y
$scoreboard players operation #Physics.ContactPoint.z Physics = #Physics.ThisObject Physics.Object.CornerPosGlobal.$(Corner).z

# Calculate penetration depth & get contact normal
# (Important): The contact normal scores are set for accumulation later.
$scoreboard players operation #Physics.PenetrationDepth Physics = #Physics.Projection.ObjectCorner$(Corner).OtherObjectAxis.y Physics
scoreboard players operation #Physics.PenetrationDepth Physics += #Physics.Projection.ObjectCenter.OtherObjectAxis.y Physics
execute if score #Physics.InvertValues Physics matches 0 store result storage physics:temp data.NewContact.ContactNormal[0] int 1 store result score #Physics.ContactNormal.x Physics run scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.Axis.y.x
execute if score #Physics.InvertValues Physics matches 0 store result storage physics:temp data.NewContact.ContactNormal[1] int 1 store result score #Physics.ContactNormal.y Physics run scoreboard players operation #Physics.Maths.Value2 Physics = @s Physics.Object.Axis.y.y
execute if score #Physics.InvertValues Physics matches 0 store result storage physics:temp data.NewContact.ContactNormal[2] int 1 store result score #Physics.ContactNormal.z Physics run scoreboard players operation #Physics.Maths.Value3 Physics = @s Physics.Object.Axis.y.z
execute if score #Physics.InvertValues Physics matches 0 run scoreboard players operation #Physics.PenetrationDepth Physics -= @s Physics.Object.ProjectionOwnAxis.y.Max
execute if score #Physics.InvertValues Physics matches 0 store result storage physics:temp data.NewContact.PenetrationDepth short 1 store result storage physics:zprivate ContactGroups[-1].Objects[-1].MaxPenetrationDepth short 1 run return run scoreboard players operation #Physics.PenetrationDepth Physics *= #Physics.Constants.-1 Physics

execute store result storage physics:temp data.NewContact.PenetrationDepth short 1 store result storage physics:zprivate ContactGroups[-1].Objects[-1].MaxPenetrationDepth short 1 run scoreboard players operation #Physics.PenetrationDepth Physics -= @s Physics.Object.ProjectionOwnAxis.y.Min
scoreboard players operation #Physics.ContactNormal.x Physics = @s Physics.Object.Axis.y.x
scoreboard players operation #Physics.ContactNormal.y Physics = @s Physics.Object.Axis.y.y
scoreboard players operation #Physics.ContactNormal.z Physics = @s Physics.Object.Axis.y.z
execute store result storage physics:temp data.NewContact.ContactNormal[0] int 1 store result score #Physics.Maths.Value1 Physics run scoreboard players operation #Physics.ContactNormal.x Physics *= #Physics.Constants.-1 Physics
execute store result storage physics:temp data.NewContact.ContactNormal[1] int 1 store result score #Physics.Maths.Value2 Physics run scoreboard players operation #Physics.ContactNormal.y Physics *= #Physics.Constants.-1 Physics
execute store result storage physics:temp data.NewContact.ContactNormal[2] int 1 store result score #Physics.Maths.Value3 Physics run scoreboard players operation #Physics.ContactNormal.z Physics *= #Physics.Constants.-1 Physics
