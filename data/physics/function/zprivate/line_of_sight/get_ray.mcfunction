# Get ray position & direction
scoreboard players set #Physics.GotRayPos Physics 1
tp 0-0-0-0-0 ~ ~ ~
data modify storage physics:temp data.Ray.Pos set from entity 0-0-0-0-0 Pos
execute in minecraft:overworld positioned 0.0 0.0 0.0 run tp 0-0-0-0-0 ^ ^ ^1
data modify storage physics:temp data.Ray.Direction set from entity 0-0-0-0-0 Pos

execute store result score #Physics.RayPosOriginal.x Physics run data get storage physics:temp data.Ray.Pos[0] 1000
execute store result score #Physics.RayPosOriginal.y Physics run data get storage physics:temp data.Ray.Pos[1] 1000
execute store result score #Physics.RayPosOriginal.z Physics run data get storage physics:temp data.Ray.Pos[2] 1000
execute store result score #Physics.RayDirectionOriginal.x Physics run data get storage physics:temp data.Ray.Direction[0] 1000
execute store result score #Physics.RayDirectionOriginal.y Physics run data get storage physics:temp data.Ray.Direction[1] 1000
execute store result score #Physics.RayDirectionOriginal.z Physics run data get storage physics:temp data.Ray.Direction[2] 1000
