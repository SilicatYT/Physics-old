#tellraw @p ["",{nbt:"ContactGroups",storage:"physics:zprivate"}]

# Get MaxPenetrationDepth of all objects combined & select that as the entity to be resolved
scoreboard players set #Physics.MaxPenetrationDepthTotal Physics -2147483648
scoreboard players operation #Physics.MaxPenetrationDepthTotal Physics > @e[type=minecraft:item_display,tag=Physics.Object] Physics.Object.MaxPenetrationDepth
execute if score #Physics.MaxPenetrationDepthTotal Physics <= #Physics.Settings.Resolution.MinPenetrationDepth Physics run return 0
execute as @e[type=minecraft:item_display,tag=Physics.Object,predicate=physics:same_max_penetration_depth,limit=1] run function physics:zprivate/resolution/penetration/found_object_a

execute if score #Physics.RemainingIterations Physics matches 1 run return 0

# Get MaxPenetrationDepth of all objects combined & select that as the entity to be resolved
scoreboard players set #Physics.MaxPenetrationDepthTotal Physics -2147483648
scoreboard players operation #Physics.MaxPenetrationDepthTotal Physics > @e[type=minecraft:item_display,tag=Physics.Object] Physics.Object.MaxPenetrationDepth
execute if score #Physics.MaxPenetrationDepthTotal Physics <= #Physics.Settings.Resolution.MinPenetrationDepth Physics run return 0
execute as @e[type=minecraft:item_display,tag=Physics.Object,predicate=physics:same_max_penetration_depth,limit=1] run function physics:zprivate/resolution/penetration/found_object_a

execute if score #Physics.RemainingIterations Physics matches 2 run return 0

# Get MaxPenetrationDepth of all objects combined & select that as the entity to be resolved
scoreboard players set #Physics.MaxPenetrationDepthTotal Physics -2147483648
scoreboard players operation #Physics.MaxPenetrationDepthTotal Physics > @e[type=minecraft:item_display,tag=Physics.Object] Physics.Object.MaxPenetrationDepth
execute if score #Physics.MaxPenetrationDepthTotal Physics <= #Physics.Settings.Resolution.MinPenetrationDepth Physics run return 0
execute as @e[type=minecraft:item_display,tag=Physics.Object,predicate=physics:same_max_penetration_depth,limit=1] run function physics:zprivate/resolution/penetration/found_object_a

execute if score #Physics.RemainingIterations Physics matches 3 run return 0

# Get MaxPenetrationDepth of all objects combined & select that as the entity to be resolved
scoreboard players set #Physics.MaxPenetrationDepthTotal Physics -2147483648
scoreboard players operation #Physics.MaxPenetrationDepthTotal Physics > @e[type=minecraft:item_display,tag=Physics.Object] Physics.Object.MaxPenetrationDepth
execute if score #Physics.MaxPenetrationDepthTotal Physics <= #Physics.Settings.Resolution.MinPenetrationDepth Physics run return 0
execute as @e[type=minecraft:item_display,tag=Physics.Object,predicate=physics:same_max_penetration_depth,limit=1] run function physics:zprivate/resolution/penetration/found_object_a

execute if score #Physics.RemainingIterations Physics matches 4 run return 0

# Get MaxPenetrationDepth of all objects combined & select that as the entity to be resolved
scoreboard players set #Physics.MaxPenetrationDepthTotal Physics -2147483648
scoreboard players operation #Physics.MaxPenetrationDepthTotal Physics > @e[type=minecraft:item_display,tag=Physics.Object] Physics.Object.MaxPenetrationDepth
execute if score #Physics.MaxPenetrationDepthTotal Physics <= #Physics.Settings.Resolution.MinPenetrationDepth Physics run return 0
execute as @e[type=minecraft:item_display,tag=Physics.Object,predicate=physics:same_max_penetration_depth,limit=1] run function physics:zprivate/resolution/penetration/found_object_a

execute if score #Physics.RemainingIterations Physics matches 5 run return 0

# Get MaxPenetrationDepth of all objects combined & select that as the entity to be resolved
scoreboard players set #Physics.MaxPenetrationDepthTotal Physics -2147483648
scoreboard players operation #Physics.MaxPenetrationDepthTotal Physics > @e[type=minecraft:item_display,tag=Physics.Object] Physics.Object.MaxPenetrationDepth
execute if score #Physics.MaxPenetrationDepthTotal Physics <= #Physics.Settings.Resolution.MinPenetrationDepth Physics run return 0
execute as @e[type=minecraft:item_display,tag=Physics.Object,predicate=physics:same_max_penetration_depth,limit=1] run function physics:zprivate/resolution/penetration/found_object_a

execute if score #Physics.RemainingIterations Physics matches 6 run return 0

# Get MaxPenetrationDepth of all objects combined & select that as the entity to be resolved
scoreboard players set #Physics.MaxPenetrationDepthTotal Physics -2147483648
scoreboard players operation #Physics.MaxPenetrationDepthTotal Physics > @e[type=minecraft:item_display,tag=Physics.Object] Physics.Object.MaxPenetrationDepth
execute if score #Physics.MaxPenetrationDepthTotal Physics <= #Physics.Settings.Resolution.MinPenetrationDepth Physics run return 0
execute as @e[type=minecraft:item_display,tag=Physics.Object,predicate=physics:same_max_penetration_depth,limit=1] run function physics:zprivate/resolution/penetration/found_object_a

execute if score #Physics.RemainingIterations Physics matches 7 run return 0

# Get MaxPenetrationDepth of all objects combined & select that as the entity to be resolved
scoreboard players set #Physics.MaxPenetrationDepthTotal Physics -2147483648
scoreboard players operation #Physics.MaxPenetrationDepthTotal Physics > @e[type=minecraft:item_display,tag=Physics.Object] Physics.Object.MaxPenetrationDepth
execute if score #Physics.MaxPenetrationDepthTotal Physics <= #Physics.Settings.Resolution.MinPenetrationDepth Physics run return 0
execute as @e[type=minecraft:item_display,tag=Physics.Object,predicate=physics:same_max_penetration_depth,limit=1] run function physics:zprivate/resolution/penetration/found_object_a

execute if score #Physics.RemainingIterations Physics matches 8 run return 0

# Get MaxPenetrationDepth of all objects combined & select that as the entity to be resolved
scoreboard players set #Physics.MaxPenetrationDepthTotal Physics -2147483648
scoreboard players operation #Physics.MaxPenetrationDepthTotal Physics > @e[type=minecraft:item_display,tag=Physics.Object] Physics.Object.MaxPenetrationDepth
execute if score #Physics.MaxPenetrationDepthTotal Physics <= #Physics.Settings.Resolution.MinPenetrationDepth Physics run return 0
execute as @e[type=minecraft:item_display,tag=Physics.Object,predicate=physics:same_max_penetration_depth,limit=1] run function physics:zprivate/resolution/penetration/found_object_a

execute if score #Physics.RemainingIterations Physics matches 9 run return 0

# Get MaxPenetrationDepth of all objects combined & select that as the entity to be resolved
scoreboard players set #Physics.MaxPenetrationDepthTotal Physics -2147483648
scoreboard players operation #Physics.MaxPenetrationDepthTotal Physics > @e[type=minecraft:item_display,tag=Physics.Object] Physics.Object.MaxPenetrationDepth
execute if score #Physics.MaxPenetrationDepthTotal Physics <= #Physics.Settings.Resolution.MinPenetrationDepth Physics run return 0
execute as @e[type=minecraft:item_display,tag=Physics.Object,predicate=physics:same_max_penetration_depth,limit=1] run function physics:zprivate/resolution/penetration/found_object_a

# Start next resolution iteration
execute if score #Physics.RemainingIterations Physics matches 10 run return 0
scoreboard players remove #Physics.RemainingIterations Physics 10
function physics:zprivate/resolution/penetration/main
