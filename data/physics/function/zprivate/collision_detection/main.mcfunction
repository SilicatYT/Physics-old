# Setup (Precalculations)
scoreboard players set #Physics.SetupDone Physics 0

scoreboard players set @s Physics.Object.MinSeparatingVelocity 2147483647
scoreboard players set @s Physics.Object.MaxPenetrationDepth -2147483648

# Prepare the contacts storage & copy over this object's stored contacts from the previous tick (If there are any)
# (Important): The ID in the data storage is also used when generating the new contact
# (Important): I use a placeholder "MinSeparatingVelocity" so it doesn't get selected during resolution and is immediately replaced when a contact is found / updated.
# (Important): With at least 2 contacts that refresh the MinSeparatingVelocity for the current object, only refreshing the score and then at the very end copying it into the storage once is faster than always refreshing the storage. Thanks to accumulation, this will basically be guaranteed.
data modify storage physics:temp data.Blocks set value []
data modify storage physics:zprivate ContactGroups append value {Objects:[{Blocks:[]}]}
execute store result storage physics:temp data.A int 1 store result storage physics:zprivate ContactGroups[-1].A int 1 run scoreboard players operation #Physics.ThisObject Physics.Object.ID = @s Physics.Object.ID
execute if entity @s[tag=Physics.HasContacts] run function physics:zprivate/contact_generation/accumulate/get_previous_contacts with storage physics:temp data

# Iterate over every minecraft block that intersects with the interaction entity's hitbox (AABB), so I can then perform the Separating Axes Theorem (SAT) to check for fine collisions
# (Important): I only have the global coords for the bounding box, so instead of using a few scoreboard commands, I just don't use relative coordinates here. If I do need the relative coordinates later, I will change that.
execute store result storage physics:temp data.StartX double 0.001 run scoreboard players get @s Physics.Object.BoundingBoxGlobalMin.x
execute store result storage physics:temp data.StartY double 0.001 run scoreboard players get @s Physics.Object.BoundingBoxGlobalMin.y
execute store result storage physics:temp data.StartZ double 0.001 run scoreboard players get @s Physics.Object.BoundingBoxGlobalMin.z

execute store result storage physics:temp data.StepCountX byte 1 run scoreboard players get @s Physics.Object.BoundingBoxStepCount.x
execute store result storage physics:temp data.StepCountY byte 1 run scoreboard players get @s Physics.Object.BoundingBoxStepCount.y
execute store result storage physics:temp data.StepCountZ byte 1 run scoreboard players get @s Physics.Object.BoundingBoxStepCount.z

execute at @s run function physics:zprivate/collision_detection/world/main with storage physics:temp data

# Update or discard contacts (World)
# (Important): Contacts for blocks that are in contact are already updated directly after their respective SAT, so this only updates contacts for blocks that had contacts in the previous tick but aren't in contact now.
# (Important): The "Blocks" object entry will be removed if no contacts were found or carried over.
# (Important): Until now, the remaining unupdated contacts are stored in physics:temp data.Blocks. Here, the contacts get updated (if necessary) and added to the actual final storage.
execute store result score #Physics.BlockCount Physics if data storage physics:temp data.Blocks[]
execute if score #Physics.BlockCount Physics matches 1.. run function physics:zprivate/contact_generation/accumulate/world/not_touching/main
#say Accumulation:
#tellraw @p ["",{nbt:"ContactGroups",storage:"physics:zprivate"}]

# Delete the "Blocks" entry in the object's contacts if no world collision was found or carried over from the last tick
execute unless data storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[0] run data remove storage physics:zprivate ContactGroups[-1].Objects[0]

# Set the MinSeparatingVelocity & MaxPenetrationDepth for all world contacts combined
scoreboard players operation #Physics.ThisObject Physics.Object.MinSeparatingVelocity.World = #Physics.ThisObject Physics.Object.MinSeparatingVelocity
scoreboard players operation #Physics.ThisObject Physics.Object.MaxPenetrationDepth.World = #Physics.ThisObject Physics.Object.MaxPenetrationDepth

# Check for coarse collisions with other dynamic objects, so I can then perform the SAT to check for fine collisions
# (Important): Only checks objects in a range of 6.929 blocks, which is the sum of both objects' maximum supported bounding box divided by 2 (so from the center of both entities), assuming I cap the dimensions at 4 blocks. The reasoning is explained in the set_attributes/dimension function.
# (Important): A Physics.Checked tag could remain for the object if the contact resolution moved it into an unloaded chunk, which could cause resolution issues for 1 tick upon getting loaded again (very minor and rare issues). This alone wouldn't warrant a change, but using a timestamp score I can also get rid of the "tag @e[...] remove ...". The performance difference is negligible, but with a lot of item displays, a timestamp is faster ontop of being more stable, especially given that inactive physics objects would've still counted toward the entity cap and made the @e call slower.
# (Important): The mini setup is run because I need to have *some* #Physics.ThisObject scores so I can do the AABB checks. I could maybe make it so it's only run if an entity is nearby, or use a predicate. Not sure what would be faster.
scoreboard players operation @s Physics.Object.Gametime = #Physics.Gametime Physics
execute if score #Physics.SetupDone Physics matches 0 run function physics:zprivate/collision_detection/object/mini_setup
#execute at @s as @e[type=minecraft:item_display,tag=Physics.Object,distance=..6.929] unless score @s Physics.Object.Gametime = #Physics.Gametime Physics if score @s Physics.Object.BoundingBoxGlobalMin.x <= #Physics.ThisObject Physics.Object.BoundingBoxGlobalMax.x if score #Physics.ThisObject Physics.Object.BoundingBoxGlobalMin.x <= @s Physics.Object.BoundingBoxGlobalMax.x if score @s Physics.Object.BoundingBoxGlobalMin.z <= #Physics.ThisObject Physics.Object.BoundingBoxGlobalMax.z if score #Physics.ThisObject Physics.Object.BoundingBoxGlobalMin.z <= @s Physics.Object.BoundingBoxGlobalMax.z if score @s Physics.Object.BoundingBoxGlobalMin.y <= #Physics.ThisObject Physics.Object.BoundingBoxGlobalMax.y if score #Physics.ThisObject Physics.Object.BoundingBoxGlobalMin.y <= @s Physics.Object.BoundingBoxGlobalMax.y run function physics:zprivate/collision_detection/object/sat

# Update or discard contacts (Object)
# (Important): Contacts for objects that are in contact are already updated directly after their respective SAT, so this only updates contacts for objects that were in contact last tick but aren't anymore.
#execute if data storage physics:temp data.ContactsPrevious[0] run function physics:zprivate/contact_generation/accumulate/update/object/not_touching/main

# Update the "HasContacts" tag
tag @s remove Physics.HasContacts
execute unless data storage physics:zprivate ContactGroups[-1].Objects[0] run return run data remove storage physics:zprivate ContactGroups[-1]
tag @s add Physics.HasContacts

# Update scores
execute if score #Physics.SetupDone Physics matches 0 run return 0
scoreboard players operation @s Physics.Object.MaxPenetrationDepth = #Physics.ThisObject Physics.Object.MaxPenetrationDepth
scoreboard players operation @s Physics.Object.MinSeparatingVelocity = #Physics.ThisObject Physics.Object.MinSeparatingVelocity
scoreboard players operation @s Physics.Object.MaxPenetrationDepth.World = #Physics.ThisObject Physics.Object.MaxPenetrationDepth.World
scoreboard players operation @s Physics.Object.MinSeparatingVelocity.World = #Physics.ThisObject Physics.Object.MinSeparatingVelocity.World
