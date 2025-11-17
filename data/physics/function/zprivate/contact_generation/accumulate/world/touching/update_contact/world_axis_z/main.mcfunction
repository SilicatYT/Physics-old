# (Important): All the "reject the contact entirely" checks have to be run before the "keep the contact but mark it as invalid" checks.

# Check if the contact should be discarded
    # Check if the contact is still relevant
    # (Important): I project this contact's normal onto the current tick's contact's normal. If it's less than 70%, the contact is discarded completely for stability and performance reasons. If it's less than 90%, just carry over the contact without updating it (invalid contact).
    scoreboard players operation #Physics.DotProduct Physics = #Physics.ContactNormal.z Physics
    execute if score #Physics.Contact.FeatureB Physics matches 14 run scoreboard players operation #Physics.DotProduct Physics *= #Physics.Constants.-1 Physics

    execute if score #Physics.DotProduct Physics matches ..700 run return 0

    # Calculate the Penetration Depth
    # (Important): Everything is cached, because there are only 8 possible corners.
    # (Important): If the penetration depth is negative or the contact point is not inside the other object, the contact is just appended (so it can still be updated during resolution) without being updated. In that case, the separating velocity data is removed to avoid potential bugs.
    $execute if score #Physics.Contact.FeatureB Physics matches 14 run scoreboard players operation #Physics.PenetrationDepth Physics = #Physics.ThisObject Physics.Object.CornerPosGlobal.$(FeatureA).z
    execute if score #Physics.Contact.FeatureB Physics matches 14 run scoreboard players operation #Physics.PenetrationDepth Physics -= #Physics.Projection.Block.WorldAxis.z.Min Physics
    execute if score #Physics.Contact.FeatureB Physics matches 15 run scoreboard players operation #Physics.PenetrationDepth Physics = #Physics.Projection.Block.WorldAxis.z.Max Physics
    $execute if score #Physics.Contact.FeatureB Physics matches 15 run scoreboard players operation #Physics.PenetrationDepth Physics -= #Physics.ThisObject Physics.Object.CornerPosGlobal.$(FeatureA).z

    # Check if the Penetration Depth is within the threshold (Can be slightly negative)
    execute if score #Physics.PenetrationDepth Physics < #Physics.Settings.Accumulation.MinPenetrationDepth Physics run return 0
    $execute if score #Physics.PenetrationDepth Physics matches ..-1 run return run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact/world_axis_z/penetration_depth_negative {FeatureA:$(FeatureA)b}

    $execute if score #Physics.DotProduct Physics matches ..900 run data modify storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts append value {FeatureA:$(FeatureA)b}
    execute if score #Physics.DotProduct Physics matches ..900 store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].FeatureB byte 1 run return run scoreboard players get #Physics.Contact.FeatureB Physics

# Check if the Contact Corner is within the hitbox
# (Important): This is necessary because the penetration depth could be positive even if the hitboxes aren't touching. So if they aren't touching, the contact should be ignored during resolution, but it should still be stored because we can't be sure whether the hitboxes are only slightly distanced or far away.
# (Important): A point is within a cuboid when the point's projections onto the cuboid's 3 axes all lie within the cuboid's min and max.
# (Important): If this check fails, the contact is still kept for later ticks, but it will be completely ignored during resolution.
# (Important): The contact point's z component is defined to be the min or max, so I don't have to check for that.
scoreboard players set #Physics.IsInside Physics 0
$execute if score #Physics.Projection.Block.WorldAxis.x.Min Physics <= #Physics.ThisObject Physics.Object.CornerPosGlobal.$(FeatureA).x if score #Physics.ThisObject Physics.Object.CornerPosGlobal.$(FeatureA).x <= #Physics.Projection.Block.WorldAxis.x.Max Physics if score #Physics.Projection.Block.WorldAxis.y.Min Physics <= #Physics.ThisObject Physics.Object.CornerPosGlobal.$(FeatureA).y if score #Physics.ThisObject Physics.Object.CornerPosGlobal.$(FeatureA).y <= #Physics.Projection.Block.WorldAxis.y.Max Physics run scoreboard players set #Physics.IsInside Physics 1
$execute if score #Physics.IsInside Physics matches 0 run data modify storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts append value {FeatureA:$(FeatureA)b,Invalid:1b}
execute if score #Physics.IsInside Physics matches 0 store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].FeatureB byte 1 run return run scoreboard players get #Physics.Contact.FeatureB Physics

# Update the contact
    # Update the Penetration Depth
    execute store result storage physics:temp data.NewContact.PenetrationDepth short 1 run scoreboard players get #Physics.PenetrationDepth Physics

    # Update the Contact Point & Contact Normal
    # (Important): The ContactPoint is not set with the earlier FeatureB check because of the "early out". I don't want to run too many commands if the contact is thrown out anyway.
    data modify storage physics:temp data.NewContact.ContactNormal set value [I;0,0,1000]
    $execute store result storage physics:temp data.NewContact.ContactPoint[0] int 1 run scoreboard players operation #Physics.ContactPoint.x Physics = #Physics.ThisObject Physics.Object.CornerPosGlobal.$(FeatureA).x
    $execute store result storage physics:temp data.NewContact.ContactPoint[1] int 1 run scoreboard players operation #Physics.ContactPoint.y Physics = #Physics.ThisObject Physics.Object.CornerPosGlobal.$(FeatureA).y
    execute if score #Physics.Contact.FeatureB Physics matches 14 store success storage physics:temp data.NewContact.ContactNormal[2] int -1000 store result storage physics:temp data.NewContact.ContactPoint[2] int 1 store result score #Physics.ContactPoint.z Physics run scoreboard players get #Physics.Projection.Block.WorldAxis.z.Min Physics
    execute if score #Physics.Contact.FeatureB Physics matches 15 store result storage physics:temp data.NewContact.ContactPoint[2] int 1 store result score #Physics.ContactPoint.z Physics run scoreboard players get #Physics.Projection.Block.WorldAxis.z.Max Physics

    # Update the Separating Velocity
        # Calculate relative contact point
        execute store result score #Physics.PointVelocity.z Physics run scoreboard players operation #Physics.ContactPoint.x Physics -= #Physics.ThisObject Physics.Object.Pos.x
        execute store result score #Physics.PointVelocity.x Physics run scoreboard players operation #Physics.ContactPoint.y Physics -= #Physics.ThisObject Physics.Object.Pos.y
        execute store result score #Physics.PointVelocity.y Physics run scoreboard players operation #Physics.ContactPoint.z Physics -= #Physics.ThisObject Physics.Object.Pos.z

        # Calculate cross product between angular velocity and relative contact point
        scoreboard players operation #Physics.PointVelocity.x Physics *= #Physics.ThisObject Physics.Object.AngularVelocity.z
        scoreboard players operation #Physics.ContactPoint.z Physics *= #Physics.ThisObject Physics.Object.AngularVelocity.y
        scoreboard players operation #Physics.PointVelocity.x Physics -= #Physics.ContactPoint.z Physics
        scoreboard players operation #Physics.PointVelocity.x Physics /= #Physics.Constants.-1000 Physics

        scoreboard players operation #Physics.PointVelocity.y Physics *= #Physics.ThisObject Physics.Object.AngularVelocity.x
        scoreboard players operation #Physics.ContactPoint.x Physics *= #Physics.ThisObject Physics.Object.AngularVelocity.z
        scoreboard players operation #Physics.PointVelocity.y Physics -= #Physics.ContactPoint.x Physics
        scoreboard players operation #Physics.PointVelocity.y Physics /= #Physics.Constants.-1000 Physics

        scoreboard players operation #Physics.PointVelocity.z Physics *= #Physics.ThisObject Physics.Object.AngularVelocity.y
        scoreboard players operation #Physics.ContactPoint.y Physics *= #Physics.ThisObject Physics.Object.AngularVelocity.x
        scoreboard players operation #Physics.PointVelocity.z Physics -= #Physics.ContactPoint.y Physics
        scoreboard players operation #Physics.PointVelocity.z Physics /= #Physics.Constants.-1000 Physics

        # Subtract velocity from acceleration along contact normal
        # (Important): Because the contact normal is axis-aligned, the calculations are simplified.
        # ...

        # Add the linear velocity to obtain the relative velocity of the contact point
        execute store result storage physics:temp data.NewContact.ContactVelocity[0] int 1 run scoreboard players operation #Physics.PointVelocity.x Physics += #Physics.ThisObject Physics.Object.Velocity.x
        execute store result storage physics:temp data.NewContact.ContactVelocity[1] int 1 run scoreboard players operation #Physics.PointVelocity.y Physics += #Physics.ThisObject Physics.Object.Velocity.y
        execute store result storage physics:temp data.NewContact.ContactVelocity[2] int 1 run scoreboard players operation #Physics.PointVelocity.z Physics += #Physics.ThisObject Physics.Object.Velocity.z

        # Take the dot product with the contact normal
        # (Important): For the SeparatingVelocity, I only care about a single component because the contact normal is a world axis.
        execute if score #Physics.FeatureB Physics matches 14 run scoreboard players operation #Physics.PointVelocity.z Physics *= #Physics.Constants.-1 Physics
        execute store result storage physics:temp data.NewContact.SeparatingVelocity short 1 run scoreboard players get #Physics.PointVelocity.z Physics

# Store the contact
data modify storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts append from storage physics:temp data.NewContact

# Update the MaxPenetrationDepth (& keep track of the contact with the MaxPenetrationDepth)
# (Important): The contact with the MaxPenetrationDepth has "HasMaxPenetrationDepth:0b" instead of 1b so the "store result storage ..." command works even if the command afterwards (to remove the previously tagged contact's tag) fails.
execute if score #Physics.PenetrationDepth Physics > #Physics.ThisObject Physics.Object.MaxPenetrationDepth store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].HasMaxPenetrationDepth byte 0 run data remove storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[].Hitboxes[].Contacts[].HasMaxPenetrationDepth
execute if score #Physics.PenetrationDepth Physics > #Physics.ThisObject Physics.Object.MaxPenetrationDepth run scoreboard players operation #Physics.ThisObject Physics.Object.MaxPenetrationDepth = #Physics.PenetrationDepth Physics

# Process the separating velocity (Keep track of the most negative separating velocity for the current ObjectA & tag the contact with the lowest value)
# (Important): The contact with the MinSeparatingVelocity has "HasMinSeparatingVelocity:0b" for the same reason as "HasMaxPenetrationDepth".
execute if score #Physics.PointVelocity.z Physics >= #Physics.ThisObject Physics.Object.MinSeparatingVelocity run return 0
execute store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].HasMinSeparatingVelocity byte 0 run data remove storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[].Hitboxes[].Contacts[].HasMinSeparatingVelocity
scoreboard players operation #Physics.ThisObject Physics.Object.MinSeparatingVelocity = #Physics.PointVelocity.z Physics
