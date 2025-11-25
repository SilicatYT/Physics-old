# Get which object has the closest intersection point
# (Important): The distance selector is <entity_interaction_range in creative mode> + sqrt(3*<largest allowed side length>^2)/2
scoreboard players set #Physics.GotRayPos Physics 0
execute store result score #Physics.EntityInteractionRange Physics run attribute @s minecraft:entity_interaction_range get 1000
execute at @s anchored eyes positioned ^ ^ ^ as @e[type=minecraft:item_display,tag=Physics.Object,distance=..8.464,sort=nearest] run function physics:zprivate/line_of_sight/check_aabb_intersection

# Check if an intersection happened
execute if score #Physics.MinDistance Physics matches 2147483647 run return run execute if score @s Physics.Player.LookingAtID matches 1.. run function physics:zprivate/line_of_sight/kill_hitbox

# An intersection happened
    # Store the Ray Direction for later when punching
    scoreboard players operation @s Physics.Player.LookingAtDirection.x = #Physics.RayDirectionOriginal.x Physics
    scoreboard players operation @s Physics.Player.LookingAtDirection.y = #Physics.RayDirectionOriginal.y Physics
    scoreboard players operation @s Physics.Player.LookingAtDirection.z = #Physics.RayDirectionOriginal.z Physics

    # Calculate the targeted position
    scoreboard players operation #Physics.RayDirectionOriginal.x Physics *= #Physics.MinDistance Physics
    scoreboard players operation #Physics.RayDirectionOriginal.x Physics /= #Physics.Constants.1000 Physics
    execute store result storage physics:temp data.HitboxPos[0] double 0.001 store result score @s Physics.Player.LookingAtPos.x run scoreboard players operation #Physics.RayPosOriginal.x Physics += #Physics.RayDirectionOriginal.x Physics

    scoreboard players operation #Physics.RayDirectionOriginal.y Physics *= #Physics.MinDistance Physics
    scoreboard players operation #Physics.RayDirectionOriginal.y Physics /= #Physics.Constants.1000 Physics
    scoreboard players operation #Physics.RayPosOriginal.y Physics += #Physics.RayDirectionOriginal.y Physics
    execute store result storage physics:temp data.HitboxPos[1] double 0.001 store result score @s Physics.Player.LookingAtPos.y run scoreboard players remove #Physics.RayPosOriginal.y Physics 175

    scoreboard players operation #Physics.RayDirectionOriginal.z Physics *= #Physics.MinDistance Physics
    scoreboard players operation #Physics.RayDirectionOriginal.z Physics /= #Physics.Constants.1000 Physics
    execute store result storage physics:temp data.HitboxPos[2] double 0.001 store result score @s Physics.Player.LookingAtPos.z run scoreboard players operation #Physics.RayPosOriginal.z Physics += #Physics.RayDirectionOriginal.z Physics

    # Try to teleport the interaction entity
    execute if score @s Physics.Player.LookingAtID matches 1.. run scoreboard players set #Physics.MinDistance Physics -1
    scoreboard players operation @s Physics.Player.LookingAtID = #Physics.LookingAtID Physics
    execute if score #Physics.MinDistance Physics matches -1 if function physics:zprivate/line_of_sight/tp_hitbox at @s as @e[type=minecraft:interaction,predicate=physics:same_player_id,distance=..8.464,limit=1] if function physics:zprivate/line_of_sight/tp_hitbox run return run scoreboard players set #Physics.MinDistance Physics 2147483647
    scoreboard players set #Physics.MinDistance Physics 2147483647

    # Summon a new interaction entity
    scoreboard players operation #Physics.NewHitbox Physics.Player.ID = @s Physics.Player.ID
    execute summon minecraft:interaction run function physics:zprivate/line_of_sight/summon_hitbox

