# Update each hitbox's contacts
    # Hitbox 1
        # Add hitbox
        data modify storage physics:temp data.Hitbox set from storage physics:temp data.Blocks[-1].Hitboxes[0]

        # Change Min and Max
        execute store result score #Physics.BlockAABB.x.Min Physics store result storage physics:temp data.Hitbox.BoundingBox[0] int 1 run scoreboard players remove #Physics.Projection.Block.WorldAxis.x.Min Physics 500
        execute store result score #Physics.BlockAABB.x.Max Physics store result storage physics:temp data.Hitbox.BoundingBox[3] int 1 run scoreboard players add #Physics.Projection.Block.WorldAxis.x.Max Physics 500
        execute store result score #Physics.BlockAABB.y.Min Physics store result storage physics:temp data.Hitbox.BoundingBox[1] int 1 run scoreboard players remove #Physics.Projection.Block.WorldAxis.y.Min Physics 500
        execute store result score #Physics.BlockAABB.y.Max Physics store result storage physics:temp data.Hitbox.BoundingBox[4] int 1 run scoreboard players add #Physics.Projection.Block.WorldAxis.y.Max Physics 500
        execute store result score #Physics.BlockAABB.z.Min Physics store result storage physics:temp data.Hitbox.BoundingBox[2] int 1 run scoreboard players remove #Physics.Projection.Block.WorldAxis.z.Min Physics 500
        execute store result score #Physics.BlockAABB.z.Max Physics store result storage physics:temp data.Hitbox.BoundingBox[5] int 1 run scoreboard players add #Physics.Projection.Block.WorldAxis.z.Max Physics 500

        # Check AABB
        # (Important): All contacts should be discarded if the object's AABB and the block's extended AABB (extended by the MinPenetrationDepth) don't intersect.
        scoreboard players operation #Physics.BlockAABB.x.Min Physics += #Physics.Settings.Accumulation.MinPenetrationDepth Physics
        execute unless score #Physics.BlockAABB.x.Min Physics <= #Physics.ThisObject Physics.Object.BoundingBoxGlobalMax.x run return 0
        scoreboard players operation #Physics.BlockAABB.x.Max Physics -= #Physics.Settings.Accumulation.MinPenetrationDepth Physics
        execute unless score #Physics.ThisObject Physics.Object.BoundingBoxGlobalMin.x <= #Physics.BlockAABB.x.Max Physics run return 0
        scoreboard players operation #Physics.BlockAABB.y.Min Physics += #Physics.Settings.Accumulation.MinPenetrationDepth Physics
        execute unless score #Physics.BlockAABB.y.Min Physics <= #Physics.ThisObject Physics.Object.BoundingBoxGlobalMax.y run return 0
        scoreboard players operation #Physics.BlockAABB.y.Max Physics -= #Physics.Settings.Accumulation.MinPenetrationDepth Physics
        execute unless score #Physics.ThisObject Physics.Object.BoundingBoxGlobalMin.y <= #Physics.BlockAABB.y.Max Physics run return 0
        scoreboard players operation #Physics.BlockAABB.z.Min Physics += #Physics.Settings.Accumulation.MinPenetrationDepth Physics
        execute unless score #Physics.BlockAABB.z.Min Physics <= #Physics.ThisObject Physics.Object.BoundingBoxGlobalMax.z run return 0
        scoreboard players operation #Physics.BlockAABB.z.Max Physics += #Physics.Settings.Accumulation.MinPenetrationDepth Physics
        execute unless score #Physics.ThisObject Physics.Object.BoundingBoxGlobalMin.z <= #Physics.BlockAABB.z.Max Physics run return 0

        # Add hitbox
        data modify storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes append from storage physics:temp data.Hitbox
        data remove storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts

        # Update its contacts
        # NO! I don't know if I have data for ID:1b, I only know that I have data for **A** hitbox. So I still need to run the "HasContacts" checks from the regular "get_hitbox" function
        # Although.. If I use Hitboxes[0], what then? Then I know for sure, and most of the time the block won't have changed, so the ID should match (IF ITS A SINGLE HITBOX BLOCK).
        # But if the ID doesn't match, what should I do? Try to update the contacts regardless, or just scrap them completely?
        # Need to make sure I account for Hitboxes[{ID:1b}] being empty, causing data from the previous block to get re-used.
        # I could say: Get {ID:1b} (and use store success). If there is data, ...
        execute store result score #Physics.ContactCount Physics if data storage physics:temp data.Hitbox.Contacts[]
        function physics:zprivate/contact_generation/accumulate/world/not_touching/update_hitbox
        execute unless data storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[0] run data remove storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1]

# Don't I need to get the hitbox's data first? Like... the actual contact data for {ID:1} or smth
# If there were more hitboxes, I'd need to do the "HasPreviousContacts" check.
# But I *THINK* I can just use Hitboxes[0] if it's a single-hitbox block (Because the odds that the block has updated in this specific tick are very low, so that extra performance cost is worth it).


# WAIT (SAME PROBLEM EXISTS IN THE ORIGINAL GET_HITBOX), WHAT IF TWO OBJECTS JUST TOUCH THE SAME BLOCK? THEN THE "execute store success" FOR THE HITBOX MIGHT FAIL BECAUSE THE DATA IS THE SAME.
# SO I THINK I HAVE TO COMPLETELY REMOVE THE "data.Hitbox" DATA BEFORE.



# IMPORTANT: The hitbox storage is made from scratch every tick (incl. its BoundingBox data). Is there a good way to check if it's the same, and therefore keep it?


# Currently, it stores the Hitbox boundingbox data even if the hitbox is discarded because it's not in the AABB. But it's overhead if I don't do that and they *are* touching. What's better? And can I even early out this easily, or are there commands that NEED TO run afterwards?
