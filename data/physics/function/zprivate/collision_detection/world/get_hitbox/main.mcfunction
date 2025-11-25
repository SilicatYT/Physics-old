# Get the hitbox of the block at ~ ~ ~ and store it in the '#Physics.Projection.Block.WorldAxis.<AXIS>.Min/Max Physics' scores (Absolute coordinates, not relative to the block position). Then get the HitboxType and run the SAT for each part of the hitbox.
# (Important): This version is used during the SAT and doesn't include "ignored" tag checks, because that's already been done by this point.
# (Important): Despite the above, it can still return "HitboxType = 0", for example if it's an open fence gate.
scoreboard players set #Physics.Touching Physics 0

execute store result score #Physics.Projection.Block.WorldAxis.x.Max Physics store result score #Physics.BlockCenterPos.x Physics run scoreboard players operation #Physics.Projection.Block.WorldAxis.x.Min Physics = #Physics.BlockPos.x Physics
execute store result score #Physics.Projection.Block.WorldAxis.y.Max Physics store result score #Physics.BlockCenterPos.y Physics run scoreboard players operation #Physics.Projection.Block.WorldAxis.y.Min Physics = #Physics.BlockPos.y Physics
execute store result score #Physics.Projection.Block.WorldAxis.z.Max Physics store result score #Physics.BlockCenterPos.z Physics run scoreboard players operation #Physics.Projection.Block.WorldAxis.z.Min Physics = #Physics.BlockPos.z Physics

# Check blocks
execute if block ~ ~ ~ minecraft:water run return run function physics:zprivate/collision_detection/world/get_hitbox/temporary/water
execute if block ~ ~ ~ minecraft:oak_slab run return run function physics:zprivate/collision_detection/world/get_hitbox/temporary/oak_slab
function physics:zprivate/collision_detection/world/get_hitbox/temporary/full_block

# W.I.P.
# NOTE: You could make it so the max/min/center commands do not run when it's a block that has no hitbox because of its blockstate. But it probably wouldn't be worth it: Tons of duplicated commands for a performance gain when inside blocks that don't cause much lag anyway
