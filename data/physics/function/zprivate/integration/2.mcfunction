# Update visuals / NBT
execute store result storage physics:temp data.Integration.Pos[0] double 0.001 run scoreboard players get @s Physics.Object.Pos.x
execute store result storage physics:temp data.Integration.Pos[1] double 0.001 run scoreboard players get @s Physics.Object.Pos.y
execute store result storage physics:temp data.Integration.Pos[2] double 0.001 run scoreboard players get @s Physics.Object.Pos.z
execute store result storage physics:temp data.Integration.transformation.left_rotation[0] float 0.001 run scoreboard players get @s Physics.Object.Orientation.x
execute store result storage physics:temp data.Integration.transformation.left_rotation[1] float 0.001 run scoreboard players get @s Physics.Object.Orientation.y
execute store result storage physics:temp data.Integration.transformation.left_rotation[2] float 0.001 run scoreboard players get @s Physics.Object.Orientation.z
execute store result storage physics:temp data.Integration.transformation.left_rotation[3] float 0.001 run scoreboard players get @s Physics.Object.Orientation.a
data modify entity @s {} merge from storage physics:temp data.Integration
