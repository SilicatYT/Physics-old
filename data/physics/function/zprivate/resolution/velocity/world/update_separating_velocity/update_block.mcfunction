# Iterate over every hitbox of the current block to update its contacts
# (Important): Just like in accumulation, I decided that 8 hitboxes is the upper limit for keeping contacts, so I don't need recursion.

# Hitbox 1
function physics:zprivate/resolution/velocity/world/update_separating_velocity/update_hitbox {Index:0b}

# Hitbox 2
execute unless data storage physics:temp data.UpdateBlocks[-1].Hitboxes[1] run return 0
function physics:zprivate/resolution/velocity/world/update_separating_velocity/update_hitbox {Index:1b}

# Hitbox 3
execute unless data storage physics:temp data.UpdateBlocks[-1].Hitboxes[2] run return 0
function physics:zprivate/resolution/velocity/world/update_separating_velocity/update_hitbox {Index:2b}

# Hitbox 4
execute unless data storage physics:temp data.UpdateBlocks[-1].Hitboxes[3] run return 0
function physics:zprivate/resolution/velocity/world/update_separating_velocity/update_hitbox {Index:3b}

# Hitbox 5
execute unless data storage physics:temp data.UpdateBlocks[-1].Hitboxes[4] run return 0
function physics:zprivate/resolution/velocity/world/update_separating_velocity/update_hitbox {Index:4b}

# Hitbox 6
execute unless data storage physics:temp data.UpdateBlocks[-1].Hitboxes[5] run return 0
function physics:zprivate/resolution/velocity/world/update_separating_velocity/update_hitbox {Index:5b}

# Hitbox 7
execute unless data storage physics:temp data.UpdateBlocks[-1].Hitboxes[6] run return 0
function physics:zprivate/resolution/velocity/world/update_separating_velocity/update_hitbox {Index:6b}

# Hitbox 8
execute if data storage physics:temp data.UpdateBlocks[-1].Hitboxes[7] run function physics:zprivate/resolution/velocity/world/update_separating_velocity/update_hitbox {Index:7b}
