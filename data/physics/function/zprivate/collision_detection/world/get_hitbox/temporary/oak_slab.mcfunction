scoreboard players set #Physics.BlockDiagonalLength Physics 1500
execute if block ~ ~ ~ minecraft:oak_slab[type=double] run scoreboard players set #Physics.BlockDiagonalLength Physics 1732

# Hitbox 1 (Solid)
scoreboard players set #Physics.Touching Physics 0

    # Block Hitbox
    scoreboard players remove #Physics.Projection.Block.WorldAxis.x.Min Physics 500
    scoreboard players add #Physics.Projection.Block.WorldAxis.x.Max Physics 500
    execute unless block ~ ~ ~ minecraft:oak_slab[type=top] run scoreboard players remove #Physics.Projection.Block.WorldAxis.y.Min Physics 500
    execute if block ~ ~ ~ minecraft:oak_slab[type=bottom] run scoreboard players remove #Physics.BlockCenterPos.y Physics 250
    execute unless block ~ ~ ~ minecraft:oak_slab[type=bottom] run scoreboard players add #Physics.Projection.Block.WorldAxis.y.Max Physics 500
    execute if block ~ ~ ~ minecraft:oak_slab[type=top] run scoreboard players add #Physics.BlockCenterPos.y Physics 250
    scoreboard players remove #Physics.Projection.Block.WorldAxis.z.Min Physics 500
    scoreboard players add #Physics.Projection.Block.WorldAxis.z.Max Physics 500

    # Run SAT
    function physics:zprivate/collision_detection/world/sat

    # Update the previous tick's contacts with that hitbox
    # ??????

# Hitbox 2 (Fluid)
# (Important): Make sure that HitboxID and HitboxType are correct if you return early (Type can be accomplished by always running the waterlogged blockstate last)
execute if block ~ ~ ~ minecraft:oak_slab[waterlogged=false] run return 0

    # Add the hitbox to the final storage (Not necessary because it's fluid)
    # scoreboard players set #Physics.HitboxID Physics 2

    # Reset Min, Max and CenterPos (Could be optimized, this is temporary)
    execute store result score #Physics.Projection.Block.WorldAxis.x.Max Physics store result score #Physics.BlockCenterPos.x Physics run scoreboard players operation #Physics.Projection.Block.WorldAxis.x.Min Physics = #Physics.BlockPos.x Physics
    execute store result score #Physics.Projection.Block.WorldAxis.y.Max Physics store result score #Physics.BlockCenterPos.y Physics run scoreboard players operation #Physics.Projection.Block.WorldAxis.y.Min Physics = #Physics.BlockPos.y Physics
    execute store result score #Physics.Projection.Block.WorldAxis.z.Max Physics store result score #Physics.BlockCenterPos.z Physics run scoreboard players operation #Physics.Projection.Block.WorldAxis.z.Min Physics = #Physics.BlockPos.z Physics

    # HitboxType
    execute store result storage physics:temp data.HitboxType byte 1 run scoreboard players set #Physics.HitboxType Physics 2

    # Block Hitbox
    scoreboard players remove #Physics.Projection.Block.WorldAxis.x.Min Physics 500
    scoreboard players add #Physics.Projection.Block.WorldAxis.x.Max Physics 500
    scoreboard players remove #Physics.Projection.Block.WorldAxis.z.Min Physics 500
    scoreboard players add #Physics.Projection.Block.WorldAxis.z.Max Physics 500

    execute if block ~ ~ ~ minecraft:oak_slab[type=bottom] run scoreboard players add #Physics.Projection.Block.WorldAxis.y.Max Physics 388
    execute if block ~ ~ ~ minecraft:oak_slab[type=top] run scoreboard players remove #Physics.Projection.Block.WorldAxis.y.Min Physics 500
    execute if block ~ ~ ~ minecraft:oak_slab[type=bottom] run scoreboard players add #Physics.BlockCenterPos.y Physics 445
    execute if block ~ ~ ~ minecraft:oak_slab[type=top] run scoreboard players remove #Physics.BlockCenterPos.y Physics 250
    execute if block ~ ~ ~ minecraft:oak_slab[type=top] run scoreboard players set #Physics.BlockDiagonalLength Physics 1500
    execute if block ~ ~ ~ minecraft:oak_slab[type=bottom] run scoreboard players set #Physics.BlockDiagonalLength Physics 1482

    # Run SAT
    function physics:zprivate/collision_detection/world/sat

# Reset HitboxType
# (Important): This is done after every non-1 HitboxType, so it doesn't have to set it to 1 constantly (Lowers the cost of solid hitboxes, which are already the most expensive type)
scoreboard players set #Physics.HitboxType Physics 1
#scoreboard players set #Physics.HitboxID Physics 1
# ^ because most blocks only have a single hitbox, so I just need to reset the HitboxID to 1 when it changed. But this command HAS TO run. I can't exit early.


# OVERSIGHT: The first hitbox that gets detected will always create the block entry in the storage, with the hitbox already included (ID:1b). But what if the 2nd hitbox is the first to be in contact, and ID:1b isn't in contact? Then it just adds 2 hitboxes, which is wrong.
