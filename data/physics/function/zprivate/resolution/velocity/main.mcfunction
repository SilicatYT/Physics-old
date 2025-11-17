execute store result score #Physics.HowMany Physics if data storage physics:resolution Object.Objects[0].Blocks[]
#execute if score #Physics.HowMany Physics matches 0 run tellraw @p ["Main: ",{score:{name:"#Physics.HowMany",objective:"Physics"}}]

# Get MinSeparatingVelocity of all objects combined & select that as the entity to be resolved
scoreboard players set #Physics.MinSeparatingVelocityTotal Physics 2147483647
scoreboard players operation #Physics.MinSeparatingVelocityTotal Physics < @e[type=minecraft:item_display,tag=Physics.Object] Physics.Object.MinSeparatingVelocity
execute if score #Physics.MinSeparatingVelocityTotal Physics >= #Physics.Settings.Resolution.MaxSeparatingVelocity Physics run return 0
execute as @e[type=minecraft:item_display,tag=Physics.Object,predicate=physics:same_min_separating_velocity,limit=1] run function physics:zprivate/resolution/velocity/found_object_a

execute if score #Physics.RemainingIterations Physics matches 1 run return 0

# Get MinSeparatingVelocity of all objects combined & select that as the entity to be resolved
scoreboard players set #Physics.MinSeparatingVelocityTotal Physics 2147483647
scoreboard players operation #Physics.MinSeparatingVelocityTotal Physics < @e[type=minecraft:item_display,tag=Physics.Object] Physics.Object.MinSeparatingVelocity
execute if score #Physics.MinSeparatingVelocityTotal Physics >= #Physics.Settings.Resolution.MaxSeparatingVelocity Physics run return 0
execute as @e[type=minecraft:item_display,tag=Physics.Object,predicate=physics:same_min_separating_velocity,limit=1] run function physics:zprivate/resolution/velocity/found_object_a

execute if score #Physics.RemainingIterations Physics matches 2 run return 0

# Get MinSeparatingVelocity of all objects combined & select that as the entity to be resolved
scoreboard players set #Physics.MinSeparatingVelocityTotal Physics 2147483647
scoreboard players operation #Physics.MinSeparatingVelocityTotal Physics < @e[type=minecraft:item_display,tag=Physics.Object] Physics.Object.MinSeparatingVelocity
execute if score #Physics.MinSeparatingVelocityTotal Physics >= #Physics.Settings.Resolution.MaxSeparatingVelocity Physics run return 0
execute as @e[type=minecraft:item_display,tag=Physics.Object,predicate=physics:same_min_separating_velocity,limit=1] run function physics:zprivate/resolution/velocity/found_object_a

execute if score #Physics.RemainingIterations Physics matches 3 run return 0

# Get MinSeparatingVelocity of all objects combined & select that as the entity to be resolved
scoreboard players set #Physics.MinSeparatingVelocityTotal Physics 2147483647
scoreboard players operation #Physics.MinSeparatingVelocityTotal Physics < @e[type=minecraft:item_display,tag=Physics.Object] Physics.Object.MinSeparatingVelocity
execute if score #Physics.MinSeparatingVelocityTotal Physics >= #Physics.Settings.Resolution.MaxSeparatingVelocity Physics run return 0
execute as @e[type=minecraft:item_display,tag=Physics.Object,predicate=physics:same_min_separating_velocity,limit=1] run function physics:zprivate/resolution/velocity/found_object_a

execute if score #Physics.RemainingIterations Physics matches 4 run return 0

# Get MinSeparatingVelocity of all objects combined & select that as the entity to be resolved
scoreboard players set #Physics.MinSeparatingVelocityTotal Physics 2147483647
scoreboard players operation #Physics.MinSeparatingVelocityTotal Physics < @e[type=minecraft:item_display,tag=Physics.Object] Physics.Object.MinSeparatingVelocity
execute if score #Physics.MinSeparatingVelocityTotal Physics >= #Physics.Settings.Resolution.MaxSeparatingVelocity Physics run return 0
execute as @e[type=minecraft:item_display,tag=Physics.Object,predicate=physics:same_min_separating_velocity,limit=1] run function physics:zprivate/resolution/velocity/found_object_a

execute if score #Physics.RemainingIterations Physics matches 5 run return 0

# Get MinSeparatingVelocity of all objects combined & select that as the entity to be resolved
scoreboard players set #Physics.MinSeparatingVelocityTotal Physics 2147483647
scoreboard players operation #Physics.MinSeparatingVelocityTotal Physics < @e[type=minecraft:item_display,tag=Physics.Object] Physics.Object.MinSeparatingVelocity
execute if score #Physics.MinSeparatingVelocityTotal Physics >= #Physics.Settings.Resolution.MaxSeparatingVelocity Physics run return 0
execute as @e[type=minecraft:item_display,tag=Physics.Object,predicate=physics:same_min_separating_velocity,limit=1] run function physics:zprivate/resolution/velocity/found_object_a

execute if score #Physics.RemainingIterations Physics matches 6 run return 0

# Get MinSeparatingVelocity of all objects combined & select that as the entity to be resolved
scoreboard players set #Physics.MinSeparatingVelocityTotal Physics 2147483647
scoreboard players operation #Physics.MinSeparatingVelocityTotal Physics < @e[type=minecraft:item_display,tag=Physics.Object] Physics.Object.MinSeparatingVelocity
execute if score #Physics.MinSeparatingVelocityTotal Physics >= #Physics.Settings.Resolution.MaxSeparatingVelocity Physics run return 0
execute as @e[type=minecraft:item_display,tag=Physics.Object,predicate=physics:same_min_separating_velocity,limit=1] run function physics:zprivate/resolution/velocity/found_object_a

execute if score #Physics.RemainingIterations Physics matches 7 run return 0

# Get MinSeparatingVelocity of all objects combined & select that as the entity to be resolved
scoreboard players set #Physics.MinSeparatingVelocityTotal Physics 2147483647
scoreboard players operation #Physics.MinSeparatingVelocityTotal Physics < @e[type=minecraft:item_display,tag=Physics.Object] Physics.Object.MinSeparatingVelocity
execute if score #Physics.MinSeparatingVelocityTotal Physics >= #Physics.Settings.Resolution.MaxSeparatingVelocity Physics run return 0
execute as @e[type=minecraft:item_display,tag=Physics.Object,predicate=physics:same_min_separating_velocity,limit=1] run function physics:zprivate/resolution/velocity/found_object_a

execute if score #Physics.RemainingIterations Physics matches 8 run return 0

# Get MinSeparatingVelocity of all objects combined & select that as the entity to be resolved
scoreboard players set #Physics.MinSeparatingVelocityTotal Physics 2147483647
scoreboard players operation #Physics.MinSeparatingVelocityTotal Physics < @e[type=minecraft:item_display,tag=Physics.Object] Physics.Object.MinSeparatingVelocity
execute if score #Physics.MinSeparatingVelocityTotal Physics >= #Physics.Settings.Resolution.MaxSeparatingVelocity Physics run return 0
execute as @e[type=minecraft:item_display,tag=Physics.Object,predicate=physics:same_min_separating_velocity,limit=1] run function physics:zprivate/resolution/velocity/found_object_a

execute if score #Physics.RemainingIterations Physics matches 9 run return 0

# Get MinSeparatingVelocity of all objects combined & select that as the entity to be resolved
scoreboard players set #Physics.MinSeparatingVelocityTotal Physics 2147483647
scoreboard players operation #Physics.MinSeparatingVelocityTotal Physics < @e[type=minecraft:item_display,tag=Physics.Object] Physics.Object.MinSeparatingVelocity
execute if score #Physics.MinSeparatingVelocityTotal Physics >= #Physics.Settings.Resolution.MaxSeparatingVelocity Physics run return 0
execute as @e[type=minecraft:item_display,tag=Physics.Object,predicate=physics:same_min_separating_velocity,limit=1] run function physics:zprivate/resolution/velocity/found_object_a

# Start next resolution iteration
execute if score #Physics.RemainingIterations Physics matches 10 run return 0
scoreboard players remove #Physics.RemainingIterations Physics 10
function physics:zprivate/resolution/velocity/main
