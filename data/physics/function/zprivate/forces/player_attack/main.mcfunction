advancement revoke @s only physics:hit_hitbox

# Check if the player is looking at a physics object
execute if score @s Physics.Player.LookingAtID matches 0 run return 0

# Punch the physics object
execute if score @s Physics.Player.PunchStrength matches -2147483648.. run scoreboard players operation #Physics.PlayerPunchStrength Physics = @s Physics.Player.PunchStrength
execute unless score @s Physics.Player.PunchStrength matches -2147483648.. run scoreboard players operation #Physics.PlayerPunchStrength Physics = #Physics.Settings.DefaultPlayerStrength Physics

execute store result storage physics:temp data.HitboxPos[0] double 0.001 store result score #Physics.IntersectionPos.x Physics run scoreboard players get @s Physics.Player.LookingAtPos.x
execute store result storage physics:temp data.HitboxPos[1] double 0.001 store result score #Physics.IntersectionPos.y Physics run scoreboard players get @s Physics.Player.LookingAtPos.y
execute store result storage physics:temp data.HitboxPos[2] double 0.001 store result score #Physics.IntersectionPos.z Physics run scoreboard players get @s Physics.Player.LookingAtPos.z

scoreboard players operation #Physics.RayDirection.x Physics = @s Physics.Player.LookingAtDirection.x
scoreboard players operation #Physics.RayDirection.y Physics = @s Physics.Player.LookingAtDirection.y
scoreboard players operation #Physics.RayDirection.z Physics = @s Physics.Player.LookingAtDirection.z

scoreboard players operation #Physics.Search Physics.Object.ID = @s Physics.Player.LookingAtID
execute as @e[type=minecraft:item_display,predicate=physics:same_object_id,distance=..8.464,limit=1] run function physics:zprivate/forces/player_attack/apply
