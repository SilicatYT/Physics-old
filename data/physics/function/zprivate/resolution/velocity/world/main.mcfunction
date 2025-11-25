# Get the block data that contains the contact to be resolved & remove the original
data modify storage physics:resolution Block set from storage physics:resolution Object.Objects[0].Blocks[{Hitboxes:[{Contacts:[{HasMinSeparatingVelocity:0b}]}]}]
data remove storage physics:resolution Object.Objects[0].Blocks[{Hitboxes:[{Contacts:[{HasMinSeparatingVelocity:0b}]}]}]

# Repeat for the hitbox
data modify storage physics:resolution Hitbox set from storage physics:resolution Block.Hitboxes[{Contacts:[{HasMinSeparatingVelocity:0b}]}]
data remove storage physics:resolution Block.Hitboxes[{Contacts:[{HasMinSeparatingVelocity:0b}]}]

# Get the contact to be resolved & remove the original
data modify storage physics:resolution Contact set from storage physics:resolution Hitbox.Contacts[{HasMinSeparatingVelocity:0b}]
data remove storage physics:resolution Hitbox.Contacts[{HasMinSeparatingVelocity:0b}]

# Resolve the contact
execute store result score #Physics.FeatureB Physics run data get storage physics:resolution Contact.FeatureB
execute if score #Physics.FeatureB Physics matches 12..13 run return run function physics:zprivate/resolution/velocity/world/world_axis_y/main
execute if score #Physics.FeatureB Physics matches 10..11 run return run function physics:zprivate/resolution/velocity/world/world_axis_x/main
execute if score #Physics.FeatureB Physics matches 14..15 run return run function physics:zprivate/resolution/velocity/world/world_axis_z/main
execute store result score #Physics.FeatureA Physics run data get storage physics:resolution Contact.FeatureA
execute if score #Physics.FeatureA Physics matches 10..15 run return run function physics:zprivate/resolution/velocity/world/object_axis/main
