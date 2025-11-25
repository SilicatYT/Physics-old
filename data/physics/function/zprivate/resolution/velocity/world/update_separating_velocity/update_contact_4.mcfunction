# Setup
$execute store result score #Physics.Maths.RelativeContactPos.x Physics run data get storage physics:temp data.UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[4].ContactPoint[0]
$execute store result score #Physics.ContactVelocityChange.z Physics run data get storage physics:temp data.UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[4].ContactPoint[1]
$execute store result score #Physics.Maths.RelativeContactPos.z Physics run data get storage physics:temp data.UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[4].ContactPoint[2]

scoreboard players operation #Physics.Maths.RelativeContactPos.x Physics -= @s Physics.Object.Pos.x
scoreboard players operation #Physics.ContactVelocityChange.z Physics -= @s Physics.Object.Pos.y
scoreboard players operation #Physics.Maths.RelativeContactPos.z Physics -= @s Physics.Object.Pos.z

scoreboard players operation #Physics.ContactVelocityChange.x Physics = #Physics.AngularVelocityChange.y Physics
execute store result score #Physics.Maths.Value1 Physics run scoreboard players operation #Physics.ContactVelocityChange.y Physics = #Physics.AngularVelocityChange.z Physics

# Cross product
scoreboard players operation #Physics.ContactVelocityChange.x Physics *= #Physics.Maths.RelativeContactPos.z Physics
scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.ContactVelocityChange.z Physics
scoreboard players operation #Physics.ContactVelocityChange.x Physics -= #Physics.Maths.Value1 Physics
scoreboard players operation #Physics.ContactVelocityChange.x Physics /= #Physics.Constants.1000 Physics

scoreboard players operation #Physics.ContactVelocityChange.y Physics *= #Physics.Maths.RelativeContactPos.x Physics
scoreboard players operation #Physics.Maths.RelativeContactPos.z Physics *= #Physics.AngularVelocityChange.x Physics
scoreboard players operation #Physics.ContactVelocityChange.y Physics -= #Physics.Maths.RelativeContactPos.z Physics
scoreboard players operation #Physics.ContactVelocityChange.y Physics /= #Physics.Constants.1000 Physics

scoreboard players operation #Physics.ContactVelocityChange.z Physics *= #Physics.AngularVelocityChange.x Physics
scoreboard players operation #Physics.Maths.RelativeContactPos.x Physics *= #Physics.AngularVelocityChange.y Physics
scoreboard players operation #Physics.ContactVelocityChange.z Physics -= #Physics.Maths.RelativeContactPos.x Physics
scoreboard players operation #Physics.ContactVelocityChange.z Physics /= #Physics.Constants.1000 Physics

# Update ContactVelocity
scoreboard players operation #Physics.ContactVelocityChange.x Physics += #Physics.LinearVelocityChange.x Physics
scoreboard players operation #Physics.ContactVelocityChange.y Physics += #Physics.LinearVelocityChange.y Physics
scoreboard players operation #Physics.ContactVelocityChange.z Physics += #Physics.LinearVelocityChange.z Physics

$execute store result score #Physics.ContactVelocity.x Physics run data get storage physics:temp data.UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[4].ContactVelocity[0]
$execute store result score #Physics.ContactVelocity.y Physics run data get storage physics:temp data.UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[4].ContactVelocity[1]
$execute store result score #Physics.ContactVelocity.z Physics run data get storage physics:temp data.UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[4].ContactVelocity[2]
$execute store result storage physics:temp data.UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[4].ContactVelocity[0] int 1 run scoreboard players operation #Physics.ContactVelocity.x Physics += #Physics.ContactVelocityChange.x Physics
$execute store result storage physics:temp data.UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[4].ContactVelocity[1] int 1 run scoreboard players operation #Physics.ContactVelocity.y Physics += #Physics.ContactVelocityChange.y Physics
$execute store result storage physics:temp data.UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[4].ContactVelocity[2] int 1 run scoreboard players operation #Physics.ContactVelocity.z Physics += #Physics.ContactVelocityChange.z Physics

# Update SeparatingVelocity
$execute store result score #Physics.ContactNormal.x Physics run data get storage physics:temp data.UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[4].ContactNormal[0]
$execute store result score #Physics.ContactNormal.y Physics run data get storage physics:temp data.UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[4].ContactNormal[1]
$execute store result score #Physics.ContactNormal.z Physics run data get storage physics:temp data.UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[4].ContactNormal[2]

scoreboard players operation #Physics.ContactNormal.x Physics *= #Physics.ContactVelocity.x Physics
scoreboard players operation #Physics.ContactNormal.y Physics *= #Physics.ContactVelocity.y Physics
scoreboard players operation #Physics.ContactNormal.z Physics *= #Physics.ContactVelocity.z Physics
scoreboard players operation #Physics.ContactNormal.x Physics += #Physics.ContactNormal.y Physics
scoreboard players operation #Physics.ContactNormal.x Physics += #Physics.ContactNormal.z Physics
$execute store result storage physics:temp data.UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[4].SeparatingVelocity short 1 run scoreboard players operation #Physics.ContactNormal.x Physics /= #Physics.Constants.1000 Physics

execute if score @s Physics.Object.MinSeparatingVelocity <= #Physics.ContactNormal.x Physics run return 0
data remove storage physics:temp data.UpdateBlocks[-1].Hitboxes[].Contacts[].HasMinSeparatingVelocity
$execute store result storage physics:temp data.UpdateBlocks[-1].Hitboxes[$(Index)].Contacts[4].HasMinSeparatingVelocity byte 0 run data remove storage physics:resolution Object.Objects[0].Blocks[].Hitboxes[].Contacts[].HasMinSeparatingVelocity
scoreboard players operation @s Physics.Object.MinSeparatingVelocity = #Physics.ContactNormal.x Physics
