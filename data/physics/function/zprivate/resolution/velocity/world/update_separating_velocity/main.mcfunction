# Iterate over every block (except the block that contains the current iteration's resolved contact) to update the respective hitboxes
# (Important): If a block's data is present, it has at least 1 hitbox with at least 1 contact. So I COULD update that here directly to avoid 2 function calls. But it would get messy.

# Block 1
function physics:zprivate/resolution/velocity/world/update_separating_velocity/update_block
data modify storage physics:resolution Object.Objects[0].Blocks append from storage physics:temp data.UpdateBlocks[-1]
execute if score #Physics.BlockCount Physics matches 1 run return 0

# Block 2
data remove storage physics:temp data.UpdateBlocks[-1]
function physics:zprivate/resolution/velocity/world/update_separating_velocity/update_block
data modify storage physics:resolution Object.Objects[0].Blocks append from storage physics:temp data.UpdateBlocks[-1]
execute if score #Physics.BlockCount Physics matches 2 run return 0

# Block 3
data remove storage physics:temp data.UpdateBlocks[-1]
function physics:zprivate/resolution/velocity/world/update_separating_velocity/update_block
data modify storage physics:resolution Object.Objects[0].Blocks append from storage physics:temp data.UpdateBlocks[-1]
execute if score #Physics.BlockCount Physics matches 3 run return 0

# Block 4
data remove storage physics:temp data.UpdateBlocks[-1]
function physics:zprivate/resolution/velocity/world/update_separating_velocity/update_block
data modify storage physics:resolution Object.Objects[0].Blocks append from storage physics:temp data.UpdateBlocks[-1]
execute if score #Physics.BlockCount Physics matches 4 run return 0

# Block 5
data remove storage physics:temp data.UpdateBlocks[-1]
function physics:zprivate/resolution/velocity/world/update_separating_velocity/update_block
data modify storage physics:resolution Object.Objects[0].Blocks append from storage physics:temp data.UpdateBlocks[-1]
execute if score #Physics.BlockCount Physics matches 5 run return 0

# Block 6
data remove storage physics:temp data.UpdateBlocks[-1]
function physics:zprivate/resolution/velocity/world/update_separating_velocity/update_block
data modify storage physics:resolution Object.Objects[0].Blocks append from storage physics:temp data.UpdateBlocks[-1]
execute if score #Physics.BlockCount Physics matches 6 run return 0

# Block 7
data remove storage physics:temp data.UpdateBlocks[-1]
function physics:zprivate/resolution/velocity/world/update_separating_velocity/update_block
data modify storage physics:resolution Object.Objects[0].Blocks append from storage physics:temp data.UpdateBlocks[-1]
execute if score #Physics.BlockCount Physics matches 7 run return 0

# Block 8
data remove storage physics:temp data.UpdateBlocks[-1]
function physics:zprivate/resolution/velocity/world/update_separating_velocity/update_block
data modify storage physics:resolution Object.Objects[0].Blocks append from storage physics:temp data.UpdateBlocks[-1]
execute if score #Physics.BlockCount Physics matches 8 run return 0

# Block 9
data remove storage physics:temp data.UpdateBlocks[-1]
function physics:zprivate/resolution/velocity/world/update_separating_velocity/update_block
data modify storage physics:resolution Object.Objects[0].Blocks append from storage physics:temp data.UpdateBlocks[-1]
execute if score #Physics.BlockCount Physics matches 9 run return 0

# Block 10
data remove storage physics:temp data.UpdateBlocks[-1]
function physics:zprivate/resolution/velocity/world/update_separating_velocity/update_block
data modify storage physics:resolution Object.Objects[0].Blocks append from storage physics:temp data.UpdateBlocks[-1]
execute if score #Physics.BlockCount Physics matches 10 run return 0

# Next loop
data remove storage physics:temp data.UpdateBlocks[-1]
scoreboard players remove #Physics.BlockCount Physics 10
function physics:zprivate/resolution/velocity/world/update_separating_velocity/main
