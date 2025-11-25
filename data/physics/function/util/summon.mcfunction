# Summon a rigid-body physics object
summon minecraft:item_display ~ ~ ~ {interpolation_duration:1,teleport_duration:1,Tags:["Physics.Object","Physics.New"],transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[1f,1f,1f]},item:{id:"minecraft:grass_block",count:1}}

# Set default attributes
execute as @e[type=minecraft:item_display,tag=Physics.New,distance=..0.1,limit=1] run function physics:zprivate/new_object
