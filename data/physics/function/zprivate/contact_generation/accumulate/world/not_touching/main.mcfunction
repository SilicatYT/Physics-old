# Carry over contacts from the previous tick for blocks that aren't touching
# (Important): All the contacts will either be discarded or carried over as "invalid" contacts.
# (Important): The hitbox data also has to be updated if the setting 'ReactToBlockUpdates' is enabled.
    # Mark all remaining contacts as invalid
    data remove storage physics:temp data.Blocks[].Hitboxes[].Contacts[].ContactVelocity
    data remove storage physics:temp data.Blocks[].Hitboxes[].Contacts[].SeparatingVelocity
    data remove storage physics:temp data.Blocks[].Hitboxes[].Contacts[].PenetrationDepth
    data remove storage physics:temp data.Blocks[].Hitboxes[].Contacts[].ContactNormal
    data remove storage physics:temp data.Blocks[].Hitboxes[].Contacts[].ContactPoint

    # Update every block's hitbox (incl. hitbox data depending on the setting, and contacts)
    # (Important): 10 blocks are hardcoded to improve performance (less function calls, scoreboard and data operations).
    # (Important): BlockPos is stored as a float because otherwise it rounds down and gets the wrong block. I would need extra operations to fix this, or make the macro command longer by adding the offset of 1 manually.
        # Block 1
        data modify storage physics:zprivate ContactGroups[-1].Objects[0].Blocks append value {}
        data modify storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Pos set from storage physics:temp data.Blocks[-1].Pos
        execute if score #Physics.Settings.ReactToBlockUpdates Physics matches 1 store result storage physics:temp data.BlockPos.x float 0.001 store result score #Physics.Projection.Block.WorldAxis.x.Min Physics store result score #Physics.Projection.Block.WorldAxis.x.Max Physics store result score #Physics.BlockCenterPos.x Physics run data get storage physics:temp data.Blocks[-1].Pos[0]
        execute if score #Physics.Settings.ReactToBlockUpdates Physics matches 1 store result storage physics:temp data.BlockPos.y float 0.001 store result score #Physics.Projection.Block.WorldAxis.y.Min Physics store result score #Physics.Projection.Block.WorldAxis.y.Max Physics store result score #Physics.BlockCenterPos.y Physics run data get storage physics:temp data.Blocks[-1].Pos[1]
        execute if score #Physics.Settings.ReactToBlockUpdates Physics matches 1 store result storage physics:temp data.BlockPos.z float 0.001 store result score #Physics.Projection.Block.WorldAxis.z.Min Physics store result score #Physics.Projection.Block.WorldAxis.z.Max Physics store result score #Physics.BlockCenterPos.z Physics run data get storage physics:temp data.Blocks[-1].Pos[2]
        execute if score #Physics.Settings.ReactToBlockUpdates Physics matches 1 run function physics:zprivate/contact_generation/accumulate/world/not_touching/get_hitbox/set_position with storage physics:temp data.BlockPos
        execute if score #Physics.Settings.ReactToBlockUpdates Physics matches 0 run function physics:zprivate/contact_generation/accumulate/world/not_touching/main_no_block_updates
        execute unless data storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[0] run data remove storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1]

        # Block 2
        execute if score #Physics.BlockCount Physics matches 1 run return 0
        data remove storage physics:temp data.Blocks[-1]

        data modify storage physics:zprivate ContactGroups[-1].Objects[0].Blocks append value {}
        data modify storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Pos set from storage physics:temp data.Blocks[-1].Pos
        execute if score #Physics.Settings.ReactToBlockUpdates Physics matches 1 store result storage physics:temp data.BlockPos.x float 0.001 store result score #Physics.Projection.Block.WorldAxis.x.Min Physics store result score #Physics.Projection.Block.WorldAxis.x.Max Physics store result score #Physics.BlockCenterPos.x Physics run data get storage physics:temp data.Blocks[-1].Pos[0]
        execute if score #Physics.Settings.ReactToBlockUpdates Physics matches 1 store result storage physics:temp data.BlockPos.y float 0.001 store result score #Physics.Projection.Block.WorldAxis.y.Min Physics store result score #Physics.Projection.Block.WorldAxis.y.Max Physics store result score #Physics.BlockCenterPos.y Physics run data get storage physics:temp data.Blocks[-1].Pos[1]
        execute if score #Physics.Settings.ReactToBlockUpdates Physics matches 1 store result storage physics:temp data.BlockPos.z float 0.001 store result score #Physics.Projection.Block.WorldAxis.z.Min Physics store result score #Physics.Projection.Block.WorldAxis.z.Max Physics store result score #Physics.BlockCenterPos.z Physics run data get storage physics:temp data.Blocks[-1].Pos[2]
        execute if score #Physics.Settings.ReactToBlockUpdates Physics matches 1 run function physics:zprivate/contact_generation/accumulate/world/not_touching/get_hitbox/set_position with storage physics:temp data.BlockPos
        execute if score #Physics.Settings.ReactToBlockUpdates Physics matches 0 run function physics:zprivate/contact_generation/accumulate/world/not_touching/main_no_block_updates
        execute unless data storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[0] run data remove storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1]

        # Block 3
        execute if score #Physics.BlockCount Physics matches 2 run return 0
        data remove storage physics:temp data.Blocks[-1]

        data modify storage physics:zprivate ContactGroups[-1].Objects[0].Blocks append value {}
        data modify storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Pos set from storage physics:temp data.Blocks[-1].Pos
        execute if score #Physics.Settings.ReactToBlockUpdates Physics matches 1 store result storage physics:temp data.BlockPos.x float 0.001 store result score #Physics.Projection.Block.WorldAxis.x.Min Physics store result score #Physics.Projection.Block.WorldAxis.x.Max Physics store result score #Physics.BlockCenterPos.x Physics run data get storage physics:temp data.Blocks[-1].Pos[0]
        execute if score #Physics.Settings.ReactToBlockUpdates Physics matches 1 store result storage physics:temp data.BlockPos.y float 0.001 store result score #Physics.Projection.Block.WorldAxis.y.Min Physics store result score #Physics.Projection.Block.WorldAxis.y.Max Physics store result score #Physics.BlockCenterPos.y Physics run data get storage physics:temp data.Blocks[-1].Pos[1]
        execute if score #Physics.Settings.ReactToBlockUpdates Physics matches 1 store result storage physics:temp data.BlockPos.z float 0.001 store result score #Physics.Projection.Block.WorldAxis.z.Min Physics store result score #Physics.Projection.Block.WorldAxis.z.Max Physics store result score #Physics.BlockCenterPos.z Physics run data get storage physics:temp data.Blocks[-1].Pos[2]
        execute if score #Physics.Settings.ReactToBlockUpdates Physics matches 1 run function physics:zprivate/contact_generation/accumulate/world/not_touching/get_hitbox/set_position with storage physics:temp data.BlockPos
        execute if score #Physics.Settings.ReactToBlockUpdates Physics matches 0 run function physics:zprivate/contact_generation/accumulate/world/not_touching/main_no_block_updates
        execute unless data storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[0] run data remove storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1]

        # Block 4
        execute if score #Physics.BlockCount Physics matches 3 run return 0
        data remove storage physics:temp data.Blocks[-1]

        data modify storage physics:zprivate ContactGroups[-1].Objects[0].Blocks append value {}
        data modify storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Pos set from storage physics:temp data.Blocks[-1].Pos
        execute if score #Physics.Settings.ReactToBlockUpdates Physics matches 1 store result storage physics:temp data.BlockPos.x float 0.001 store result score #Physics.Projection.Block.WorldAxis.x.Min Physics store result score #Physics.Projection.Block.WorldAxis.x.Max Physics store result score #Physics.BlockCenterPos.x Physics run data get storage physics:temp data.Blocks[-1].Pos[0]
        execute if score #Physics.Settings.ReactToBlockUpdates Physics matches 1 store result storage physics:temp data.BlockPos.y float 0.001 store result score #Physics.Projection.Block.WorldAxis.y.Min Physics store result score #Physics.Projection.Block.WorldAxis.y.Max Physics store result score #Physics.BlockCenterPos.y Physics run data get storage physics:temp data.Blocks[-1].Pos[1]
        execute if score #Physics.Settings.ReactToBlockUpdates Physics matches 1 store result storage physics:temp data.BlockPos.z float 0.001 store result score #Physics.Projection.Block.WorldAxis.z.Min Physics store result score #Physics.Projection.Block.WorldAxis.z.Max Physics store result score #Physics.BlockCenterPos.z Physics run data get storage physics:temp data.Blocks[-1].Pos[2]
        execute if score #Physics.Settings.ReactToBlockUpdates Physics matches 1 run function physics:zprivate/contact_generation/accumulate/world/not_touching/get_hitbox/set_position with storage physics:temp data.BlockPos
        execute if score #Physics.Settings.ReactToBlockUpdates Physics matches 0 run function physics:zprivate/contact_generation/accumulate/world/not_touching/main_no_block_updates
        execute unless data storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[0] run data remove storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1]

        # Block 5
        execute if score #Physics.BlockCount Physics matches 4 run return 0
        data remove storage physics:temp data.Blocks[-1]

        data modify storage physics:zprivate ContactGroups[-1].Objects[0].Blocks append value {}
        data modify storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Pos set from storage physics:temp data.Blocks[-1].Pos
        execute if score #Physics.Settings.ReactToBlockUpdates Physics matches 1 store result storage physics:temp data.BlockPos.x float 0.001 store result score #Physics.Projection.Block.WorldAxis.x.Min Physics store result score #Physics.Projection.Block.WorldAxis.x.Max Physics store result score #Physics.BlockCenterPos.x Physics run data get storage physics:temp data.Blocks[-1].Pos[0]
        execute if score #Physics.Settings.ReactToBlockUpdates Physics matches 1 store result storage physics:temp data.BlockPos.y float 0.001 store result score #Physics.Projection.Block.WorldAxis.y.Min Physics store result score #Physics.Projection.Block.WorldAxis.y.Max Physics store result score #Physics.BlockCenterPos.y Physics run data get storage physics:temp data.Blocks[-1].Pos[1]
        execute if score #Physics.Settings.ReactToBlockUpdates Physics matches 1 store result storage physics:temp data.BlockPos.z float 0.001 store result score #Physics.Projection.Block.WorldAxis.z.Min Physics store result score #Physics.Projection.Block.WorldAxis.z.Max Physics store result score #Physics.BlockCenterPos.z Physics run data get storage physics:temp data.Blocks[-1].Pos[2]
        execute if score #Physics.Settings.ReactToBlockUpdates Physics matches 1 run function physics:zprivate/contact_generation/accumulate/world/not_touching/get_hitbox/set_position with storage physics:temp data.BlockPos
        execute if score #Physics.Settings.ReactToBlockUpdates Physics matches 0 run function physics:zprivate/contact_generation/accumulate/world/not_touching/main_no_block_updates
        execute unless data storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[0] run data remove storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1]

        # Block 6
        execute if score #Physics.BlockCount Physics matches 5 run return 0
        data remove storage physics:temp data.Blocks[-1]

        data modify storage physics:zprivate ContactGroups[-1].Objects[0].Blocks append value {}
        data modify storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Pos set from storage physics:temp data.Blocks[-1].Pos
        execute if score #Physics.Settings.ReactToBlockUpdates Physics matches 1 store result storage physics:temp data.BlockPos.x float 0.001 store result score #Physics.Projection.Block.WorldAxis.x.Min Physics store result score #Physics.Projection.Block.WorldAxis.x.Max Physics store result score #Physics.BlockCenterPos.x Physics run data get storage physics:temp data.Blocks[-1].Pos[0]
        execute if score #Physics.Settings.ReactToBlockUpdates Physics matches 1 store result storage physics:temp data.BlockPos.y float 0.001 store result score #Physics.Projection.Block.WorldAxis.y.Min Physics store result score #Physics.Projection.Block.WorldAxis.y.Max Physics store result score #Physics.BlockCenterPos.y Physics run data get storage physics:temp data.Blocks[-1].Pos[1]
        execute if score #Physics.Settings.ReactToBlockUpdates Physics matches 1 store result storage physics:temp data.BlockPos.z float 0.001 store result score #Physics.Projection.Block.WorldAxis.z.Min Physics store result score #Physics.Projection.Block.WorldAxis.z.Max Physics store result score #Physics.BlockCenterPos.z Physics run data get storage physics:temp data.Blocks[-1].Pos[2]
        execute if score #Physics.Settings.ReactToBlockUpdates Physics matches 1 run function physics:zprivate/contact_generation/accumulate/world/not_touching/get_hitbox/set_position with storage physics:temp data.BlockPos
        execute if score #Physics.Settings.ReactToBlockUpdates Physics matches 0 run function physics:zprivate/contact_generation/accumulate/world/not_touching/main_no_block_updates
        execute unless data storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[0] run data remove storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1]

        # Block 7
        execute if score #Physics.BlockCount Physics matches 6 run return 0
        data remove storage physics:temp data.Blocks[-1]

        data modify storage physics:zprivate ContactGroups[-1].Objects[0].Blocks append value {}
        data modify storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Pos set from storage physics:temp data.Blocks[-1].Pos
        execute if score #Physics.Settings.ReactToBlockUpdates Physics matches 1 store result storage physics:temp data.BlockPos.x float 0.001 store result score #Physics.Projection.Block.WorldAxis.x.Min Physics store result score #Physics.Projection.Block.WorldAxis.x.Max Physics store result score #Physics.BlockCenterPos.x Physics run data get storage physics:temp data.Blocks[-1].Pos[0]
        execute if score #Physics.Settings.ReactToBlockUpdates Physics matches 1 store result storage physics:temp data.BlockPos.y float 0.001 store result score #Physics.Projection.Block.WorldAxis.y.Min Physics store result score #Physics.Projection.Block.WorldAxis.y.Max Physics store result score #Physics.BlockCenterPos.y Physics run data get storage physics:temp data.Blocks[-1].Pos[1]
        execute if score #Physics.Settings.ReactToBlockUpdates Physics matches 1 store result storage physics:temp data.BlockPos.z float 0.001 store result score #Physics.Projection.Block.WorldAxis.z.Min Physics store result score #Physics.Projection.Block.WorldAxis.z.Max Physics store result score #Physics.BlockCenterPos.z Physics run data get storage physics:temp data.Blocks[-1].Pos[2]
        execute if score #Physics.Settings.ReactToBlockUpdates Physics matches 1 run function physics:zprivate/contact_generation/accumulate/world/not_touching/get_hitbox/set_position with storage physics:temp data.BlockPos
        execute if score #Physics.Settings.ReactToBlockUpdates Physics matches 0 run function physics:zprivate/contact_generation/accumulate/world/not_touching/main_no_block_updates
        execute unless data storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[0] run data remove storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1]

        # Block 8
        execute if score #Physics.BlockCount Physics matches 7 run return 0
        data remove storage physics:temp data.Blocks[-1]

        data modify storage physics:zprivate ContactGroups[-1].Objects[0].Blocks append value {}
        data modify storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Pos set from storage physics:temp data.Blocks[-1].Pos
        execute if score #Physics.Settings.ReactToBlockUpdates Physics matches 1 store result storage physics:temp data.BlockPos.x float 0.001 store result score #Physics.Projection.Block.WorldAxis.x.Min Physics store result score #Physics.Projection.Block.WorldAxis.x.Max Physics store result score #Physics.BlockCenterPos.x Physics run data get storage physics:temp data.Blocks[-1].Pos[0]
        execute if score #Physics.Settings.ReactToBlockUpdates Physics matches 1 store result storage physics:temp data.BlockPos.y float 0.001 store result score #Physics.Projection.Block.WorldAxis.y.Min Physics store result score #Physics.Projection.Block.WorldAxis.y.Max Physics store result score #Physics.BlockCenterPos.y Physics run data get storage physics:temp data.Blocks[-1].Pos[1]
        execute if score #Physics.Settings.ReactToBlockUpdates Physics matches 1 store result storage physics:temp data.BlockPos.z float 0.001 store result score #Physics.Projection.Block.WorldAxis.z.Min Physics store result score #Physics.Projection.Block.WorldAxis.z.Max Physics store result score #Physics.BlockCenterPos.z Physics run data get storage physics:temp data.Blocks[-1].Pos[2]
        execute if score #Physics.Settings.ReactToBlockUpdates Physics matches 1 run function physics:zprivate/contact_generation/accumulate/world/not_touching/get_hitbox/set_position with storage physics:temp data.BlockPos
        execute if score #Physics.Settings.ReactToBlockUpdates Physics matches 0 run function physics:zprivate/contact_generation/accumulate/world/not_touching/main_no_block_updates
        execute unless data storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[0] run data remove storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1]

        # Block 9
        execute if score #Physics.BlockCount Physics matches 8 run return 0
        data remove storage physics:temp data.Blocks[-1]

        data modify storage physics:zprivate ContactGroups[-1].Objects[0].Blocks append value {}
        data modify storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Pos set from storage physics:temp data.Blocks[-1].Pos
        execute if score #Physics.Settings.ReactToBlockUpdates Physics matches 1 store result storage physics:temp data.BlockPos.x float 0.001 store result score #Physics.Projection.Block.WorldAxis.x.Min Physics store result score #Physics.Projection.Block.WorldAxis.x.Max Physics store result score #Physics.BlockCenterPos.x Physics run data get storage physics:temp data.Blocks[-1].Pos[0]
        execute if score #Physics.Settings.ReactToBlockUpdates Physics matches 1 store result storage physics:temp data.BlockPos.y float 0.001 store result score #Physics.Projection.Block.WorldAxis.y.Min Physics store result score #Physics.Projection.Block.WorldAxis.y.Max Physics store result score #Physics.BlockCenterPos.y Physics run data get storage physics:temp data.Blocks[-1].Pos[1]
        execute if score #Physics.Settings.ReactToBlockUpdates Physics matches 1 store result storage physics:temp data.BlockPos.z float 0.001 store result score #Physics.Projection.Block.WorldAxis.z.Min Physics store result score #Physics.Projection.Block.WorldAxis.z.Max Physics store result score #Physics.BlockCenterPos.z Physics run data get storage physics:temp data.Blocks[-1].Pos[2]
        execute if score #Physics.Settings.ReactToBlockUpdates Physics matches 1 run function physics:zprivate/contact_generation/accumulate/world/not_touching/get_hitbox/set_position with storage physics:temp data.BlockPos
        execute if score #Physics.Settings.ReactToBlockUpdates Physics matches 0 run function physics:zprivate/contact_generation/accumulate/world/not_touching/main_no_block_updates
        execute unless data storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[0] run data remove storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1]

        # Block 10
        execute if score #Physics.BlockCount Physics matches 9 run return 0
        data remove storage physics:temp data.Blocks[-1]

        data modify storage physics:zprivate ContactGroups[-1].Objects[0].Blocks append value {}
        data modify storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Pos set from storage physics:temp data.Blocks[-1].Pos
        execute if score #Physics.Settings.ReactToBlockUpdates Physics matches 1 store result storage physics:temp data.BlockPos.x float 0.001 store result score #Physics.Projection.Block.WorldAxis.x.Min Physics store result score #Physics.Projection.Block.WorldAxis.x.Max Physics store result score #Physics.BlockCenterPos.x Physics run data get storage physics:temp data.Blocks[-1].Pos[0]
        execute if score #Physics.Settings.ReactToBlockUpdates Physics matches 1 store result storage physics:temp data.BlockPos.y float 0.001 store result score #Physics.Projection.Block.WorldAxis.y.Min Physics store result score #Physics.Projection.Block.WorldAxis.y.Max Physics store result score #Physics.BlockCenterPos.y Physics run data get storage physics:temp data.Blocks[-1].Pos[1]
        execute if score #Physics.Settings.ReactToBlockUpdates Physics matches 1 store result storage physics:temp data.BlockPos.z float 0.001 store result score #Physics.Projection.Block.WorldAxis.z.Min Physics store result score #Physics.Projection.Block.WorldAxis.z.Max Physics store result score #Physics.BlockCenterPos.z Physics run data get storage physics:temp data.Blocks[-1].Pos[2]
        execute if score #Physics.Settings.ReactToBlockUpdates Physics matches 1 run function physics:zprivate/contact_generation/accumulate/world/not_touching/get_hitbox/set_position with storage physics:temp data.BlockPos
        execute if score #Physics.Settings.ReactToBlockUpdates Physics matches 0 run function physics:zprivate/contact_generation/accumulate/world/not_touching/main_no_block_updates
        execute unless data storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[0] run data remove storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1]

        # Start next loop
        execute if score #Physics.BlockCount Physics matches 10 run return 0
        scoreboard players remove #Physics.BlockCount Physics 10
        function physics:zprivate/contact_generation/accumulate/world/not_touching/main_loop
