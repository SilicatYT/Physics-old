# Calculate movement along the contact normal
# (Important): Movement * ContactNormal
$execute store result score #Physics.PenetrationDepthDifference Physics run data get storage physics:temp data.UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[3].ContactNormal[0]
$execute store result score #Physics.Maths.Value1 Physics run data get storage physics:temp data.UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[3].ContactNormal[1]
$execute store result score #Physics.Maths.Value2 Physics run data get storage physics:temp data.UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[3].ContactNormal[2]

scoreboard players operation #Physics.PenetrationDepthDifference Physics *= #Physics.Movement.x Physics
scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.Movement.y Physics
scoreboard players operation #Physics.Maths.Value2 Physics *= #Physics.Movement.z Physics

scoreboard players operation #Physics.PenetrationDepthDifference Physics += #Physics.Maths.Value1 Physics
scoreboard players operation #Physics.PenetrationDepthDifference Physics += #Physics.Maths.Value2 Physics
scoreboard players operation #Physics.PenetrationDepthDifference Physics /= #Physics.Constants.1000 Physics

# Update the PenetrationDepth
$execute store result score #Physics.PenetrationDepth Physics run data get storage physics:temp data.UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[3].PenetrationDepth
$execute store result storage physics:temp data.UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[3].PenetrationDepth short 1 run scoreboard players operation #Physics.PenetrationDepth Physics -= #Physics.PenetrationDepthDifference Physics

# Update the MaxPenetrationDepth
execute if score #Physics.PenetrationDepth Physics <= @s Physics.Object.MaxPenetrationDepth run return 0
data remove storage physics:temp data.UpdateBlocks[-1].Hitboxes[].Contacts[].HasMaxPenetrationDepth
$execute store result storage physics:temp data.UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[3].HasMaxPenetrationDepth byte 0 run data remove storage physics:resolution Object.Objects[0].Blocks[].Hitboxes[].Contacts[].HasMaxPenetrationDepth
scoreboard players operation @s Physics.Object.MaxPenetrationDepth = #Physics.PenetrationDepth Physics
