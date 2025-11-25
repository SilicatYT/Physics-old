# Get the corner point
$execute store result storage physics:temp data.NewContact.FeatureA byte 1 store result storage physics:temp data.FeatureA byte 1 run scoreboard players set #Physics.FeatureA Physics $(Corner)

# Copy the coordinates (For getting the Contact Point later)
$execute store result storage physics:temp data.NewContact.ContactPoint[0] int 1 run scoreboard players operation #Physics.ContactPoint.x Physics = #Physics.ThisObject Physics.Object.CornerPosGlobal.$(Corner).x
$execute store result storage physics:temp data.NewContact.ContactPoint[1] int 1 run scoreboard players operation #Physics.ContactPoint.y Physics = #Physics.ThisObject Physics.Object.CornerPosGlobal.$(Corner).y

# Calculate penetration depth (& copy the remaining contact point coordinates)
# (Important): The penetration depth depends on the contact normal, so if that one needs to be inverted, so does the penetration depth.
execute if score #Physics.InvertValues Physics matches 0 store result storage physics:temp data.NewContact.ContactPoint[2] int 1 store result score #Physics.ContactPoint.z Physics run scoreboard players operation #Physics.PenetrationDepth Physics = #Physics.Projection.Block.WorldAxis.z.Max Physics
$execute if score #Physics.InvertValues Physics matches 0 store result storage physics:temp data.NewContact.PenetrationDepth short 1 run return run scoreboard players operation #Physics.PenetrationDepth Physics -= #Physics.ThisObject Physics.Object.CornerPosGlobal.$(Corner).z

execute store result storage physics:temp data.NewContact.ContactPoint[2] int 1 store result score #Physics.ContactPoint.z Physics run scoreboard players get #Physics.Projection.Block.WorldAxis.z.Min Physics
$scoreboard players operation #Physics.PenetrationDepth Physics = #Physics.ThisObject Physics.Object.CornerPosGlobal.$(Corner).z
execute store result storage physics:temp data.NewContact.PenetrationDepth short 1 run scoreboard players operation #Physics.PenetrationDepth Physics -= #Physics.Projection.Block.WorldAxis.z.Min Physics
data modify storage physics:temp data.NewContact.ContactNormal set value [I;0,0,-1000]
scoreboard players set #Physics.ContactNormal.z Physics -1000
