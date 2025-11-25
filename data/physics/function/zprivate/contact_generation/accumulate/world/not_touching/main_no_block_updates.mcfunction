# (Important): It iterates over all hitboxes in a hardcoded (not recursive) way to save performance. The limit for the number of hitboxes is arbitrarily set to 8.
# (Important): A hitbox's contacts are discarded if the object's AABB and the extended block AABB (extended by the MinPenetrationDepth) don't intersect. Perhaps there's a more accurate way, but this should be quite efficient and prevent contacts from staying too long because updating only looks at the penetrationDepth.

# Setup
execute store result score #Physics.HitboxCount Physics if data storage physics:temp data.Blocks[-1].Hitboxes[]

# Hitbox 1
data modify storage physics:temp data.Hitbox set from storage physics:temp data.Blocks[-1].Hitboxes[-1]
data modify storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes append from storage physics:temp data.Hitbox
data remove storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts

    # Get the projections
    execute store result score #Physics.BlockAABB.x.Min Physics store result score #Physics.Projection.Block.WorldAxis.x.Min Physics run data get storage physics:temp data.Hitbox.BoundingBox[0]
    execute store result score #Physics.BlockAABB.y.Min Physics store result score #Physics.Projection.Block.WorldAxis.y.Min Physics run data get storage physics:temp data.Hitbox.BoundingBox[1]
    execute store result score #Physics.BlockAABB.z.Min Physics store result score #Physics.Projection.Block.WorldAxis.z.Min Physics run data get storage physics:temp data.Hitbox.BoundingBox[2]
    execute store result score #Physics.BlockAABB.x.Max Physics store result score #Physics.Projection.Block.WorldAxis.x.Max Physics run data get storage physics:temp data.Hitbox.BoundingBox[3]
    execute store result score #Physics.BlockAABB.y.Max Physics store result score #Physics.Projection.Block.WorldAxis.y.Max Physics run data get storage physics:temp data.Hitbox.BoundingBox[4]
    execute store result score #Physics.BlockAABB.z.Max Physics store result score #Physics.Projection.Block.WorldAxis.z.Max Physics run data get storage physics:temp data.Hitbox.BoundingBox[5]

    # Update the hitbox's contacts
    scoreboard players operation #Physics.BlockAABB.x.Min Physics += #Physics.Settings.Accumulation.MinPenetrationDepth Physics
    scoreboard players operation #Physics.BlockAABB.y.Min Physics += #Physics.Settings.Accumulation.MinPenetrationDepth Physics
    scoreboard players operation #Physics.BlockAABB.z.Min Physics += #Physics.Settings.Accumulation.MinPenetrationDepth Physics
    scoreboard players operation #Physics.BlockAABB.x.Max Physics -= #Physics.Settings.Accumulation.MinPenetrationDepth Physics
    scoreboard players operation #Physics.BlockAABB.y.Max Physics -= #Physics.Settings.Accumulation.MinPenetrationDepth Physics
    scoreboard players operation #Physics.BlockAABB.z.Max Physics -= #Physics.Settings.Accumulation.MinPenetrationDepth Physics

    execute store result score #Physics.ContactCount Physics if data storage physics:temp data.Hitbox.Contacts[]
    execute if score #Physics.BlockAABB.x.Min Physics <= #Physics.ThisObject Physics.Object.BoundingBoxGlobalMax.x if score #Physics.ThisObject Physics.Object.BoundingBoxGlobalMin.x <= #Physics.BlockAABB.x.Max Physics if score #Physics.BlockAABB.y.Min Physics <= #Physics.ThisObject Physics.Object.BoundingBoxGlobalMax.y if score #Physics.ThisObject Physics.Object.BoundingBoxGlobalMin.y <= #Physics.BlockAABB.y.Max Physics if score #Physics.BlockAABB.z.Min Physics <= #Physics.ThisObject Physics.Object.BoundingBoxGlobalMax.z if score #Physics.ThisObject Physics.Object.BoundingBoxGlobalMin.z <= #Physics.BlockAABB.z.Max Physics run function physics:zprivate/contact_generation/accumulate/world/not_touching/update_hitbox
    execute unless data storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[0] run data remove storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1]

# Hitbox 2
execute if score #Physics.HitboxCount Physics matches 1 run return 0
data modify storage physics:temp data.Hitbox set from storage physics:temp data.Blocks[-1].Hitboxes[-2]
data modify storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes append from storage physics:temp data.Hitbox
data remove storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts

    # Get the projections
    execute store result score #Physics.BlockAABB.x.Min Physics store result score #Physics.Projection.Block.WorldAxis.x.Min Physics run data get storage physics:temp data.Hitbox.BoundingBox[0]
    execute store result score #Physics.BlockAABB.y.Min Physics store result score #Physics.Projection.Block.WorldAxis.y.Min Physics run data get storage physics:temp data.Hitbox.BoundingBox[1]
    execute store result score #Physics.BlockAABB.z.Min Physics store result score #Physics.Projection.Block.WorldAxis.z.Min Physics run data get storage physics:temp data.Hitbox.BoundingBox[2]
    execute store result score #Physics.BlockAABB.x.Max Physics store result score #Physics.Projection.Block.WorldAxis.x.Max Physics run data get storage physics:temp data.Hitbox.BoundingBox[3]
    execute store result score #Physics.BlockAABB.y.Max Physics store result score #Physics.Projection.Block.WorldAxis.y.Max Physics run data get storage physics:temp data.Hitbox.BoundingBox[4]
    execute store result score #Physics.BlockAABB.z.Max Physics store result score #Physics.Projection.Block.WorldAxis.z.Max Physics run data get storage physics:temp data.Hitbox.BoundingBox[5]

    # Update the hitbox's contacts
    scoreboard players operation #Physics.BlockAABB.x.Min Physics += #Physics.Settings.Accumulation.MinPenetrationDepth Physics
    scoreboard players operation #Physics.BlockAABB.y.Min Physics += #Physics.Settings.Accumulation.MinPenetrationDepth Physics
    scoreboard players operation #Physics.BlockAABB.z.Min Physics += #Physics.Settings.Accumulation.MinPenetrationDepth Physics
    scoreboard players operation #Physics.BlockAABB.x.Max Physics -= #Physics.Settings.Accumulation.MinPenetrationDepth Physics
    scoreboard players operation #Physics.BlockAABB.y.Max Physics -= #Physics.Settings.Accumulation.MinPenetrationDepth Physics
    scoreboard players operation #Physics.BlockAABB.z.Max Physics -= #Physics.Settings.Accumulation.MinPenetrationDepth Physics

    execute store result score #Physics.ContactCount Physics if data storage physics:temp data.Hitbox.Contacts[]
    execute if score #Physics.BlockAABB.x.Min Physics <= #Physics.ThisObject Physics.Object.BoundingBoxGlobalMax.x if score #Physics.ThisObject Physics.Object.BoundingBoxGlobalMin.x <= #Physics.BlockAABB.x.Max Physics if score #Physics.BlockAABB.y.Min Physics <= #Physics.ThisObject Physics.Object.BoundingBoxGlobalMax.y if score #Physics.ThisObject Physics.Object.BoundingBoxGlobalMin.y <= #Physics.BlockAABB.y.Max Physics if score #Physics.BlockAABB.z.Min Physics <= #Physics.ThisObject Physics.Object.BoundingBoxGlobalMax.z if score #Physics.ThisObject Physics.Object.BoundingBoxGlobalMin.z <= #Physics.BlockAABB.z.Max Physics run function physics:zprivate/contact_generation/accumulate/world/not_touching/update_hitbox
    execute unless data storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[0] run data remove storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1]

# Hitbox 3
execute if score #Physics.HitboxCount Physics matches 2 run return 0
data modify storage physics:temp data.Hitbox set from storage physics:temp data.Blocks[-1].Hitboxes[-3]
data modify storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes append from storage physics:temp data.Hitbox
data remove storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts

    # Get the projections
    execute store result score #Physics.BlockAABB.x.Min Physics store result score #Physics.Projection.Block.WorldAxis.x.Min Physics run data get storage physics:temp data.Hitbox.BoundingBox[0]
    execute store result score #Physics.BlockAABB.y.Min Physics store result score #Physics.Projection.Block.WorldAxis.y.Min Physics run data get storage physics:temp data.Hitbox.BoundingBox[1]
    execute store result score #Physics.BlockAABB.z.Min Physics store result score #Physics.Projection.Block.WorldAxis.z.Min Physics run data get storage physics:temp data.Hitbox.BoundingBox[2]
    execute store result score #Physics.BlockAABB.x.Max Physics store result score #Physics.Projection.Block.WorldAxis.x.Max Physics run data get storage physics:temp data.Hitbox.BoundingBox[3]
    execute store result score #Physics.BlockAABB.y.Max Physics store result score #Physics.Projection.Block.WorldAxis.y.Max Physics run data get storage physics:temp data.Hitbox.BoundingBox[4]
    execute store result score #Physics.BlockAABB.z.Max Physics store result score #Physics.Projection.Block.WorldAxis.z.Max Physics run data get storage physics:temp data.Hitbox.BoundingBox[5]

    # Update the hitbox's contacts
    scoreboard players operation #Physics.BlockAABB.x.Min Physics += #Physics.Settings.Accumulation.MinPenetrationDepth Physics
    scoreboard players operation #Physics.BlockAABB.y.Min Physics += #Physics.Settings.Accumulation.MinPenetrationDepth Physics
    scoreboard players operation #Physics.BlockAABB.z.Min Physics += #Physics.Settings.Accumulation.MinPenetrationDepth Physics
    scoreboard players operation #Physics.BlockAABB.x.Max Physics -= #Physics.Settings.Accumulation.MinPenetrationDepth Physics
    scoreboard players operation #Physics.BlockAABB.y.Max Physics -= #Physics.Settings.Accumulation.MinPenetrationDepth Physics
    scoreboard players operation #Physics.BlockAABB.z.Max Physics -= #Physics.Settings.Accumulation.MinPenetrationDepth Physics

    execute store result score #Physics.ContactCount Physics if data storage physics:temp data.Hitbox.Contacts[]
    execute if score #Physics.BlockAABB.x.Min Physics <= #Physics.ThisObject Physics.Object.BoundingBoxGlobalMax.x if score #Physics.ThisObject Physics.Object.BoundingBoxGlobalMin.x <= #Physics.BlockAABB.x.Max Physics if score #Physics.BlockAABB.y.Min Physics <= #Physics.ThisObject Physics.Object.BoundingBoxGlobalMax.y if score #Physics.ThisObject Physics.Object.BoundingBoxGlobalMin.y <= #Physics.BlockAABB.y.Max Physics if score #Physics.BlockAABB.z.Min Physics <= #Physics.ThisObject Physics.Object.BoundingBoxGlobalMax.z if score #Physics.ThisObject Physics.Object.BoundingBoxGlobalMin.z <= #Physics.BlockAABB.z.Max Physics run function physics:zprivate/contact_generation/accumulate/world/not_touching/update_hitbox
    execute unless data storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[0] run data remove storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1]

# Hitbox 4
execute if score #Physics.HitboxCount Physics matches 3 run return 0
data modify storage physics:temp data.Hitbox set from storage physics:temp data.Blocks[-1].Hitboxes[-4]
data modify storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes append from storage physics:temp data.Hitbox
data remove storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts

    # Get the projections
    execute store result score #Physics.BlockAABB.x.Min Physics store result score #Physics.Projection.Block.WorldAxis.x.Min Physics run data get storage physics:temp data.Hitbox.BoundingBox[0]
    execute store result score #Physics.BlockAABB.y.Min Physics store result score #Physics.Projection.Block.WorldAxis.y.Min Physics run data get storage physics:temp data.Hitbox.BoundingBox[1]
    execute store result score #Physics.BlockAABB.z.Min Physics store result score #Physics.Projection.Block.WorldAxis.z.Min Physics run data get storage physics:temp data.Hitbox.BoundingBox[2]
    execute store result score #Physics.BlockAABB.x.Max Physics store result score #Physics.Projection.Block.WorldAxis.x.Max Physics run data get storage physics:temp data.Hitbox.BoundingBox[3]
    execute store result score #Physics.BlockAABB.y.Max Physics store result score #Physics.Projection.Block.WorldAxis.y.Max Physics run data get storage physics:temp data.Hitbox.BoundingBox[4]
    execute store result score #Physics.BlockAABB.z.Max Physics store result score #Physics.Projection.Block.WorldAxis.z.Max Physics run data get storage physics:temp data.Hitbox.BoundingBox[5]

    # Update the hitbox's contacts
    scoreboard players operation #Physics.BlockAABB.x.Min Physics += #Physics.Settings.Accumulation.MinPenetrationDepth Physics
    scoreboard players operation #Physics.BlockAABB.y.Min Physics += #Physics.Settings.Accumulation.MinPenetrationDepth Physics
    scoreboard players operation #Physics.BlockAABB.z.Min Physics += #Physics.Settings.Accumulation.MinPenetrationDepth Physics
    scoreboard players operation #Physics.BlockAABB.x.Max Physics -= #Physics.Settings.Accumulation.MinPenetrationDepth Physics
    scoreboard players operation #Physics.BlockAABB.y.Max Physics -= #Physics.Settings.Accumulation.MinPenetrationDepth Physics
    scoreboard players operation #Physics.BlockAABB.z.Max Physics -= #Physics.Settings.Accumulation.MinPenetrationDepth Physics

    execute store result score #Physics.ContactCount Physics if data storage physics:temp data.Hitbox.Contacts[]
    execute if score #Physics.BlockAABB.x.Min Physics <= #Physics.ThisObject Physics.Object.BoundingBoxGlobalMax.x if score #Physics.ThisObject Physics.Object.BoundingBoxGlobalMin.x <= #Physics.BlockAABB.x.Max Physics if score #Physics.BlockAABB.y.Min Physics <= #Physics.ThisObject Physics.Object.BoundingBoxGlobalMax.y if score #Physics.ThisObject Physics.Object.BoundingBoxGlobalMin.y <= #Physics.BlockAABB.y.Max Physics if score #Physics.BlockAABB.z.Min Physics <= #Physics.ThisObject Physics.Object.BoundingBoxGlobalMax.z if score #Physics.ThisObject Physics.Object.BoundingBoxGlobalMin.z <= #Physics.BlockAABB.z.Max Physics run function physics:zprivate/contact_generation/accumulate/world/not_touching/update_hitbox
    execute unless data storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[0] run data remove storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1]

# Hitbox 5
execute if score #Physics.HitboxCount Physics matches 4 run return 0
data modify storage physics:temp data.Hitbox set from storage physics:temp data.Blocks[-1].Hitboxes[-5]
data modify storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes append from storage physics:temp data.Hitbox
data remove storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts

    # Get the projections
    execute store result score #Physics.BlockAABB.x.Min Physics store result score #Physics.Projection.Block.WorldAxis.x.Min Physics run data get storage physics:temp data.Hitbox.BoundingBox[0]
    execute store result score #Physics.BlockAABB.y.Min Physics store result score #Physics.Projection.Block.WorldAxis.y.Min Physics run data get storage physics:temp data.Hitbox.BoundingBox[1]
    execute store result score #Physics.BlockAABB.z.Min Physics store result score #Physics.Projection.Block.WorldAxis.z.Min Physics run data get storage physics:temp data.Hitbox.BoundingBox[2]
    execute store result score #Physics.BlockAABB.x.Max Physics store result score #Physics.Projection.Block.WorldAxis.x.Max Physics run data get storage physics:temp data.Hitbox.BoundingBox[3]
    execute store result score #Physics.BlockAABB.y.Max Physics store result score #Physics.Projection.Block.WorldAxis.y.Max Physics run data get storage physics:temp data.Hitbox.BoundingBox[4]
    execute store result score #Physics.BlockAABB.z.Max Physics store result score #Physics.Projection.Block.WorldAxis.z.Max Physics run data get storage physics:temp data.Hitbox.BoundingBox[5]

    # Update the hitbox's contacts
    scoreboard players operation #Physics.BlockAABB.x.Min Physics += #Physics.Settings.Accumulation.MinPenetrationDepth Physics
    scoreboard players operation #Physics.BlockAABB.y.Min Physics += #Physics.Settings.Accumulation.MinPenetrationDepth Physics
    scoreboard players operation #Physics.BlockAABB.z.Min Physics += #Physics.Settings.Accumulation.MinPenetrationDepth Physics
    scoreboard players operation #Physics.BlockAABB.x.Max Physics -= #Physics.Settings.Accumulation.MinPenetrationDepth Physics
    scoreboard players operation #Physics.BlockAABB.y.Max Physics -= #Physics.Settings.Accumulation.MinPenetrationDepth Physics
    scoreboard players operation #Physics.BlockAABB.z.Max Physics -= #Physics.Settings.Accumulation.MinPenetrationDepth Physics

    execute store result score #Physics.ContactCount Physics if data storage physics:temp data.Hitbox.Contacts[]
    execute if score #Physics.BlockAABB.x.Min Physics <= #Physics.ThisObject Physics.Object.BoundingBoxGlobalMax.x if score #Physics.ThisObject Physics.Object.BoundingBoxGlobalMin.x <= #Physics.BlockAABB.x.Max Physics if score #Physics.BlockAABB.y.Min Physics <= #Physics.ThisObject Physics.Object.BoundingBoxGlobalMax.y if score #Physics.ThisObject Physics.Object.BoundingBoxGlobalMin.y <= #Physics.BlockAABB.y.Max Physics if score #Physics.BlockAABB.z.Min Physics <= #Physics.ThisObject Physics.Object.BoundingBoxGlobalMax.z if score #Physics.ThisObject Physics.Object.BoundingBoxGlobalMin.z <= #Physics.BlockAABB.z.Max Physics run function physics:zprivate/contact_generation/accumulate/world/not_touching/update_hitbox
    execute unless data storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[0] run data remove storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1]

# Hitbox 6
execute if score #Physics.HitboxCount Physics matches 5 run return 0
data modify storage physics:temp data.Hitbox set from storage physics:temp data.Blocks[-1].Hitboxes[-6]
data modify storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes append from storage physics:temp data.Hitbox
data remove storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts

    # Get the projections
    execute store result score #Physics.BlockAABB.x.Min Physics store result score #Physics.Projection.Block.WorldAxis.x.Min Physics run data get storage physics:temp data.Hitbox.BoundingBox[0]
    execute store result score #Physics.BlockAABB.y.Min Physics store result score #Physics.Projection.Block.WorldAxis.y.Min Physics run data get storage physics:temp data.Hitbox.BoundingBox[1]
    execute store result score #Physics.BlockAABB.z.Min Physics store result score #Physics.Projection.Block.WorldAxis.z.Min Physics run data get storage physics:temp data.Hitbox.BoundingBox[2]
    execute store result score #Physics.BlockAABB.x.Max Physics store result score #Physics.Projection.Block.WorldAxis.x.Max Physics run data get storage physics:temp data.Hitbox.BoundingBox[3]
    execute store result score #Physics.BlockAABB.y.Max Physics store result score #Physics.Projection.Block.WorldAxis.y.Max Physics run data get storage physics:temp data.Hitbox.BoundingBox[4]
    execute store result score #Physics.BlockAABB.z.Max Physics store result score #Physics.Projection.Block.WorldAxis.z.Max Physics run data get storage physics:temp data.Hitbox.BoundingBox[5]

    # Update the hitbox's contacts
    scoreboard players operation #Physics.BlockAABB.x.Min Physics += #Physics.Settings.Accumulation.MinPenetrationDepth Physics
    scoreboard players operation #Physics.BlockAABB.y.Min Physics += #Physics.Settings.Accumulation.MinPenetrationDepth Physics
    scoreboard players operation #Physics.BlockAABB.z.Min Physics += #Physics.Settings.Accumulation.MinPenetrationDepth Physics
    scoreboard players operation #Physics.BlockAABB.x.Max Physics -= #Physics.Settings.Accumulation.MinPenetrationDepth Physics
    scoreboard players operation #Physics.BlockAABB.y.Max Physics -= #Physics.Settings.Accumulation.MinPenetrationDepth Physics
    scoreboard players operation #Physics.BlockAABB.z.Max Physics -= #Physics.Settings.Accumulation.MinPenetrationDepth Physics

    execute store result score #Physics.ContactCount Physics if data storage physics:temp data.Hitbox.Contacts[]
    execute if score #Physics.BlockAABB.x.Min Physics <= #Physics.ThisObject Physics.Object.BoundingBoxGlobalMax.x if score #Physics.ThisObject Physics.Object.BoundingBoxGlobalMin.x <= #Physics.BlockAABB.x.Max Physics if score #Physics.BlockAABB.y.Min Physics <= #Physics.ThisObject Physics.Object.BoundingBoxGlobalMax.y if score #Physics.ThisObject Physics.Object.BoundingBoxGlobalMin.y <= #Physics.BlockAABB.y.Max Physics if score #Physics.BlockAABB.z.Min Physics <= #Physics.ThisObject Physics.Object.BoundingBoxGlobalMax.z if score #Physics.ThisObject Physics.Object.BoundingBoxGlobalMin.z <= #Physics.BlockAABB.z.Max Physics run function physics:zprivate/contact_generation/accumulate/world/not_touching/update_hitbox
    execute unless data storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[0] run data remove storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1]

# Hitbox 7
execute if score #Physics.HitboxCount Physics matches 6 run return 0
data modify storage physics:temp data.Hitbox set from storage physics:temp data.Blocks[-1].Hitboxes[-7]
data modify storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes append from storage physics:temp data.Hitbox
data remove storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts

    # Get the projections
    execute store result score #Physics.BlockAABB.x.Min Physics store result score #Physics.Projection.Block.WorldAxis.x.Min Physics run data get storage physics:temp data.Hitbox.BoundingBox[0]
    execute store result score #Physics.BlockAABB.y.Min Physics store result score #Physics.Projection.Block.WorldAxis.y.Min Physics run data get storage physics:temp data.Hitbox.BoundingBox[1]
    execute store result score #Physics.BlockAABB.z.Min Physics store result score #Physics.Projection.Block.WorldAxis.z.Min Physics run data get storage physics:temp data.Hitbox.BoundingBox[2]
    execute store result score #Physics.BlockAABB.x.Max Physics store result score #Physics.Projection.Block.WorldAxis.x.Max Physics run data get storage physics:temp data.Hitbox.BoundingBox[3]
    execute store result score #Physics.BlockAABB.y.Max Physics store result score #Physics.Projection.Block.WorldAxis.y.Max Physics run data get storage physics:temp data.Hitbox.BoundingBox[4]
    execute store result score #Physics.BlockAABB.z.Max Physics store result score #Physics.Projection.Block.WorldAxis.z.Max Physics run data get storage physics:temp data.Hitbox.BoundingBox[5]

    # Update the hitbox's contacts
    scoreboard players operation #Physics.BlockAABB.x.Min Physics += #Physics.Settings.Accumulation.MinPenetrationDepth Physics
    scoreboard players operation #Physics.BlockAABB.y.Min Physics += #Physics.Settings.Accumulation.MinPenetrationDepth Physics
    scoreboard players operation #Physics.BlockAABB.z.Min Physics += #Physics.Settings.Accumulation.MinPenetrationDepth Physics
    scoreboard players operation #Physics.BlockAABB.x.Max Physics -= #Physics.Settings.Accumulation.MinPenetrationDepth Physics
    scoreboard players operation #Physics.BlockAABB.y.Max Physics -= #Physics.Settings.Accumulation.MinPenetrationDepth Physics
    scoreboard players operation #Physics.BlockAABB.z.Max Physics -= #Physics.Settings.Accumulation.MinPenetrationDepth Physics

    execute store result score #Physics.ContactCount Physics if data storage physics:temp data.Hitbox.Contacts[]
    execute if score #Physics.BlockAABB.x.Min Physics <= #Physics.ThisObject Physics.Object.BoundingBoxGlobalMax.x if score #Physics.ThisObject Physics.Object.BoundingBoxGlobalMin.x <= #Physics.BlockAABB.x.Max Physics if score #Physics.BlockAABB.y.Min Physics <= #Physics.ThisObject Physics.Object.BoundingBoxGlobalMax.y if score #Physics.ThisObject Physics.Object.BoundingBoxGlobalMin.y <= #Physics.BlockAABB.y.Max Physics if score #Physics.BlockAABB.z.Min Physics <= #Physics.ThisObject Physics.Object.BoundingBoxGlobalMax.z if score #Physics.ThisObject Physics.Object.BoundingBoxGlobalMin.z <= #Physics.BlockAABB.z.Max Physics run function physics:zprivate/contact_generation/accumulate/world/not_touching/update_hitbox
    execute unless data storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[0] run data remove storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1]

# Hitbox 8
execute if score #Physics.HitboxCount Physics matches 7 run return 0
data modify storage physics:temp data.Hitbox set from storage physics:temp data.Blocks[-1].Hitboxes[-8]
data modify storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes append from storage physics:temp data.Hitbox
data remove storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts

    # Get the projections
    execute store result score #Physics.Projection.Block.WorldAxis.x.Min Physics run data get storage physics:temp data.Hitbox.BoundingBox[0]
    execute store result score #Physics.Projection.Block.WorldAxis.y.Min Physics run data get storage physics:temp data.Hitbox.BoundingBox[1]
    execute store result score #Physics.Projection.Block.WorldAxis.z.Min Physics run data get storage physics:temp data.Hitbox.BoundingBox[2]
    execute store result score #Physics.Projection.Block.WorldAxis.x.Max Physics run data get storage physics:temp data.Hitbox.BoundingBox[3]
    execute store result score #Physics.Projection.Block.WorldAxis.y.Max Physics run data get storage physics:temp data.Hitbox.BoundingBox[4]
    execute store result score #Physics.Projection.Block.WorldAxis.z.Max Physics run data get storage physics:temp data.Hitbox.BoundingBox[5]

    # Update the hitbox's contacts
    execute store result score #Physics.ContactCount Physics if data storage physics:temp data.Hitbox.Contacts[]
    function physics:zprivate/contact_generation/accumulate/world/not_touching/update_hitbox
    execute unless data storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[0] run data remove storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1]
