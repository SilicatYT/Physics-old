# Copy the previous tick's contacts for that block to a temporary storage & remove the entry that is copied over
# (Important): Because this function can also be run if there is no data for that block, the "data.Block" storage would keep the previous data, leading to bugs. So it's cleared after it's done being used in "get_hitbox".
# (Important): I tag the block data I want to copy & delete so I only need 1 macro instead of 2.
$data modify storage physics:temp data.Blocks[{Pos:$(Pos)}].R set value 1b
data modify storage physics:temp data.Block set from storage physics:temp data.Blocks[{R:1b}]
data remove storage physics:temp data.Blocks[{R:1b}]
