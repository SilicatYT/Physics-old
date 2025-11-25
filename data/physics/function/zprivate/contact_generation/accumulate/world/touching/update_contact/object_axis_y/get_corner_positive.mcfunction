# Get corner position
$execute store result score #Physics.ContactCorner.x Physics run scoreboard players operation #Physics.ContactPoint.x Physics = #Physics.Projection.Block.WorldAxis.x.$(x) Physics
$execute store result score #Physics.ContactCorner.y Physics run scoreboard players operation #Physics.ContactPoint.y Physics = #Physics.Projection.Block.WorldAxis.y.$(y) Physics
$execute store result score #Physics.ContactCorner.z Physics run scoreboard players operation #Physics.ContactPoint.z Physics = #Physics.Projection.Block.WorldAxis.z.$(z) Physics

# Update the contact normal (Invert if needed)
execute store result storage physics:temp data.NewContact.ContactNormal[0] int 1 run scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Axis.y.x
execute store result storage physics:temp data.NewContact.ContactNormal[1] int 1 run scoreboard players operation #Physics.Maths.Value2 Physics = #Physics.ThisObject Physics.Object.Axis.y.y
execute store result storage physics:temp data.NewContact.ContactNormal[2] int 1 run scoreboard players operation #Physics.Maths.Value3 Physics = #Physics.ThisObject Physics.Object.Axis.y.z

# Contact Point
# (Important): Instead of inverting the contact normal, I divide by -1000 instead of 1000 here if I need to invert.
scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.PenetrationDepth Physics
scoreboard players operation #Physics.Maths.Value1 Physics /= #Physics.Constants.1000 Physics
execute store result storage physics:temp data.NewContact.ContactPoint[0] int 1 run scoreboard players operation #Physics.ContactPoint.x Physics += #Physics.Maths.Value1 Physics

scoreboard players operation #Physics.Maths.Value2 Physics *= #Physics.PenetrationDepth Physics
scoreboard players operation #Physics.Maths.Value2 Physics /= #Physics.Constants.1000 Physics
execute store result storage physics:temp data.NewContact.ContactPoint[1] int 1 run scoreboard players operation #Physics.ContactPoint.y Physics += #Physics.Maths.Value2 Physics

scoreboard players operation #Physics.Maths.Value3 Physics *= #Physics.PenetrationDepth Physics
scoreboard players operation #Physics.Maths.Value3 Physics /= #Physics.Constants.1000 Physics
execute store result storage physics:temp data.NewContact.ContactPoint[2] int 1 run scoreboard players operation #Physics.ContactPoint.z Physics += #Physics.Maths.Value3 Physics
