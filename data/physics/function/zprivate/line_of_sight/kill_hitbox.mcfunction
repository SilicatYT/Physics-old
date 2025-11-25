# Looked away from object
scoreboard players set @s Physics.Player.LookingAtID 0
scoreboard players operation #Physics.Search Physics.Player.ID = @s Physics.Player.ID

    # Kill the hitbox
    # (Important): If the hitbox is outside that range, which is unlikely, it gets killed via the other method. It's good for performance to specify a distance here.
    execute store success score #Physics.HitboxKillSuccess Physics run kill @e[type=minecraft:interaction,predicate=physics:same_player_id,distance=..8.464,limit=1]
    execute if score #Physics.HitboxKillSuccess Physics matches 1 run scoreboard players remove #Physics.InteractionCount Physics 1
