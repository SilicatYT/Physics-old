# Check if the block is ignored
execute if block ~ ~ ~ #physics:ignored run return 0

# Get the hitbox of the block at ~ ~ ~ and store it in the '#Physics.Projection.Block.WorldAxis.<AXIS>.Min/Max Physics' scores (Absolute coordinates, not relative to the block position). Then update the contacts for each hitbox.
execute if block ~ ~ ~ minecraft:water run return run function physics:zprivate/contact_generation/accumulate/world/not_touching/get_hitbox/temporary/water
execute if block ~ ~ ~ minecraft:oak_slab run return run function physics:zprivate/contact_generation/accumulate/world/not_touching/get_hitbox/temporary/oak_slab
function physics:zprivate/contact_generation/accumulate/world/not_touching/get_hitbox/temporary/full_block

# W.I.P.
