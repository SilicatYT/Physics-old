# (Important): All the "reject the contact entirely" checks have to be run before the "keep the contact but mark it as invalid" checks.

# Check if the contact should be discarded
# (Important): Everything is cached, because there are only 8 possible corners.
# (Important): If the penetration depth is negative or the contact point is not inside the other object, the contact is just appended (so it can still be updated during resolution) without being updated. In that case, the separating velocity data is removed to avoid potential bugs.
    # Calculate the Penetration Depth
    $scoreboard players operation #Physics.PenetrationDepth Physics = #Physics.Projection.BlockCornerBase$(FeatureB).ObjectAxis.x Physics
    scoreboard players operation #Physics.PenetrationDepth Physics += #Physics.Projection.BlockCenter.ObjectAxis.x Physics
    execute if score #Physics.Contact.FeatureA Physics matches 10 run scoreboard players operation #Physics.PenetrationDepth Physics -= #Physics.ThisObject Physics.Object.ProjectionOwnAxis.x.Min
    execute if score #Physics.Contact.FeatureA Physics matches 11 run scoreboard players operation #Physics.PenetrationDepth Physics -= #Physics.ThisObject Physics.Object.ProjectionOwnAxis.x.Max
    execute if score #Physics.Contact.FeatureA Physics matches 11 run scoreboard players operation #Physics.PenetrationDepth Physics *= #Physics.Constants.-1 Physics

    # Check if the Penetration Depth is within the threshold (Can be slightly negative)
    execute if score #Physics.PenetrationDepth Physics < #Physics.Settings.Accumulation.MinPenetrationDepth Physics run return 0

    # Check if the contact is still relevant
    # (Important): I project this contact's normal onto the current tick's contact's normal. If it's less than 70%, the contact is discarded completely for stability and performance reasons. If it's less than 90%, just carry over the contact without updating it (invalid contact).
    scoreboard players operation #Physics.DotProduct Physics = #Physics.ThisObject Physics.Object.Axis.x.x
    scoreboard players operation #Physics.DotProduct Physics *= #Physics.ContactNormal.x Physics

    scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Axis.x.y
    scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.ContactNormal.y Physics
    scoreboard players operation #Physics.DotProduct Physics += #Physics.Maths.Value1 Physics

    scoreboard players operation #Physics.Maths.Value2 Physics = #Physics.ThisObject Physics.Object.Axis.x.z
    scoreboard players operation #Physics.Maths.Value2 Physics *= #Physics.ContactNormal.z Physics
    scoreboard players operation #Physics.DotProduct Physics += #Physics.Maths.Value2 Physics

    execute if score #Physics.Contact.FeatureA Physics matches 10 run scoreboard players operation #Physics.DotProduct Physics *= #Physics.Constants.-1 Physics

    execute if score #Physics.DotProduct Physics matches ..700000 run return 0
    $execute if score #Physics.DotProduct Physics matches ..900000 run data modify storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts append value {FeatureB:$(FeatureB)b}
    execute if score #Physics.DotProduct Physics matches ..900000 store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].FeatureA byte 1 run return run scoreboard players get #Physics.Contact.FeatureA Physics

    # Check if the PenetrationDepth is negative
    # (Important): In that case, it still needs to store the contact point, penetration depth and contact normal so it can later be updated during contact resolution.
    $execute if score #Physics.PenetrationDepth Physics matches ..-1 run return run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact/object_axis_x/penetration_depth_negative {FeatureB:$(FeatureB)b}

    # Check if the Contact Corner is within the hitbox
    # (Important): This is necessary because the penetration depth could be positive even if the hitboxes aren't touching. So if they aren't touching, the contact should be ignored during resolution, but it should still be stored because we can't be sure whether the hitboxes are only slightly distanced or far away.
    # (Important): A point is within a cuboid when the point's projections onto the cuboid's 3 axes all lie within the cuboid's min and max.
    # (Important): If this check fails, the contact is still kept for later ticks, but it will be completely ignored during resolution.
    scoreboard players set #Physics.IsInside Physics 0
    execute if score #Physics.ContactCorner.x Physics <= #Physics.ThisObject Physics.Object.ProjectionOwnAxis.x.Max if score #Physics.ThisObject Physics.Object.ProjectionOwnAxis.x.Min <= #Physics.ContactCorner.x Physics if score #Physics.ContactCorner.y Physics <= #Physics.ThisObject Physics.Object.ProjectionOwnAxis.y.Max if score #Physics.ThisObject Physics.Object.ProjectionOwnAxis.y.Min <= #Physics.ContactCorner.y Physics if score #Physics.ContactCorner.z Physics <= #Physics.ThisObject Physics.Object.ProjectionOwnAxis.z.Max if score #Physics.ThisObject Physics.Object.ProjectionOwnAxis.z.Min <= #Physics.ContactCorner.z Physics run scoreboard players set #Physics.IsInside Physics 1
    $execute if score #Physics.IsInside Physics matches 0 run data modify storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts append value {FeatureB:$(FeatureB)b,Invalid:1b}
    execute if score #Physics.IsInside Physics matches 0 store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].FeatureA byte 1 run return run scoreboard players get #Physics.Contact.FeatureA Physics

# Update the contact
execute store result storage physics:temp data.NewContact.PenetrationDepth short 1 run scoreboard players get #Physics.PenetrationDepth Physics

    # Get the corner position
    $execute if score #Physics.Contact.FeatureA Physics matches 10 run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact/object_axis_x/get_corner_negative with storage physics:temp data.BlockCorner[$(FeatureB)]
    $execute if score #Physics.Contact.FeatureA Physics matches 11 run function physics:zprivate/contact_generation/accumulate/world/touching/update_contact/object_axis_x/get_corner_positive with storage physics:temp data.BlockCorner[$(FeatureB)]

    # Separating Velocity
        # Calculate relative contact point
        execute store result score #Physics.PointVelocity.z Physics run scoreboard players operation #Physics.ContactPoint.x Physics -= #Physics.ThisObject Physics.Object.Pos.x
        execute store result score #Physics.PointVelocity.x Physics run scoreboard players operation #Physics.ContactPoint.y Physics -= #Physics.ThisObject Physics.Object.Pos.y
        execute store result score #Physics.PointVelocity.y Physics run scoreboard players operation #Physics.ContactPoint.z Physics -= #Physics.ThisObject Physics.Object.Pos.z

        # Calculate cross product between angular velocity and relative contact point
        scoreboard players operation #Physics.PointVelocity.x Physics *= #Physics.ThisObject Physics.Object.AngularVelocity.z
        scoreboard players operation #Physics.ContactPoint.z Physics *= #Physics.ThisObject Physics.Object.AngularVelocity.y
        scoreboard players operation #Physics.PointVelocity.x Physics -= #Physics.ContactPoint.z Physics
        scoreboard players operation #Physics.PointVelocity.x Physics /= #Physics.Constants.1000 Physics

        scoreboard players operation #Physics.PointVelocity.y Physics *= #Physics.ThisObject Physics.Object.AngularVelocity.x
        scoreboard players operation #Physics.ContactPoint.x Physics *= #Physics.ThisObject Physics.Object.AngularVelocity.z
        scoreboard players operation #Physics.PointVelocity.y Physics -= #Physics.ContactPoint.x Physics
        scoreboard players operation #Physics.PointVelocity.y Physics /= #Physics.Constants.1000 Physics

        scoreboard players operation #Physics.PointVelocity.z Physics *= #Physics.ThisObject Physics.Object.AngularVelocity.y
        scoreboard players operation #Physics.ContactPoint.y Physics *= #Physics.ThisObject Physics.Object.AngularVelocity.x
        scoreboard players operation #Physics.PointVelocity.z Physics -= #Physics.ContactPoint.y Physics
        scoreboard players operation #Physics.PointVelocity.z Physics /= #Physics.Constants.1000 Physics

        # Subtract velocity from acceleration along contact normal
        # (Important): Because I multiply by ObjectAxis and then again by ObjectAxis, it doesn't matter that I don't have the direction-corrected contact normal. I don't have to invert the result.
        scoreboard players operation #Physics.VelocityFromAcceleration.y Physics = #Physics.ThisObject Physics.Object.DefactoGravity
        scoreboard players operation #Physics.VelocityFromAcceleration.y Physics *= #Physics.ThisObject Physics.Object.Axis.x.y
        execute store result score #Physics.SubtractVector.x Physics store result score #Physics.SubtractVector.y Physics store result score #Physics.SubtractVector.z Physics run scoreboard players operation #Physics.VelocityFromAcceleration.y Physics /= #Physics.Constants.1000 Physics

        scoreboard players operation #Physics.SubtractVector.x Physics *= #Physics.ThisObject Physics.Object.Axis.x.x
        scoreboard players operation #Physics.SubtractVector.y Physics *= #Physics.ThisObject Physics.Object.Axis.x.y
        scoreboard players operation #Physics.SubtractVector.z Physics *= #Physics.ThisObject Physics.Object.Axis.x.z
        scoreboard players operation #Physics.SubtractVector.x Physics /= #Physics.Constants.1000 Physics
        scoreboard players operation #Physics.SubtractVector.y Physics /= #Physics.Constants.1000 Physics
        scoreboard players operation #Physics.SubtractVector.z Physics /= #Physics.Constants.1000 Physics

        scoreboard players operation #Physics.PointVelocity.x Physics += #Physics.SubtractVector.x Physics
        scoreboard players operation #Physics.PointVelocity.y Physics += #Physics.SubtractVector.y Physics
        scoreboard players operation #Physics.PointVelocity.z Physics += #Physics.SubtractVector.z Physics

        # Add the linear velocity to obtain the relative velocity of the contact point
        execute store result storage physics:temp data.NewContact.ContactVelocity[0] int 1 run scoreboard players operation #Physics.PointVelocity.x Physics -= #Physics.ThisObject Physics.Object.Velocity.x
        execute store result storage physics:temp data.NewContact.ContactVelocity[1] int 1 run scoreboard players operation #Physics.PointVelocity.y Physics -= #Physics.ThisObject Physics.Object.Velocity.y
        execute store result storage physics:temp data.NewContact.ContactVelocity[2] int 1 run scoreboard players operation #Physics.PointVelocity.z Physics -= #Physics.ThisObject Physics.Object.Velocity.z

        # Calculate the relative velocity's dot product with the contact normal to get the separation velocity (single number, not a vector) and store it
        scoreboard players operation #Physics.PointVelocity.x Physics *= #Physics.ThisObject Physics.Object.Axis.x.x
        scoreboard players operation #Physics.PointVelocity.y Physics *= #Physics.ThisObject Physics.Object.Axis.x.y
        scoreboard players operation #Physics.PointVelocity.z Physics *= #Physics.ThisObject Physics.Object.Axis.x.z

        scoreboard players operation #Physics.PointVelocity.x Physics += #Physics.PointVelocity.y Physics
        scoreboard players operation #Physics.PointVelocity.x Physics += #Physics.PointVelocity.z Physics

        execute if score #Physics.Contact.FeatureA Physics matches 10 run scoreboard players operation #Physics.PointVelocity.x Physics *= #Physics.Constants.-1 Physics
        execute store result storage physics:temp data.NewContact.SeparatingVelocity short 1 run scoreboard players operation #Physics.PointVelocity.x Physics /= #Physics.Constants.1000 Physics

    # Store the contact
    data modify storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts append from storage physics:temp data.NewContact

# Update the MaxPenetrationDepth (& keep track of the contact with the MaxPenetrationDepth)
# (Important): The contact with the MaxPenetrationDepth has "HasMaxPenetrationDepth:0b" instead of 1b so the "store result storage ..." command works even if the command afterwards (to remove the previously tagged contact's tag) fails.
execute if score #Physics.PenetrationDepth Physics > #Physics.ThisObject Physics.Object.MaxPenetrationDepth store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].HasMaxPenetrationDepth byte 0 run data remove storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[].Hitboxes[].Contacts[].HasMaxPenetrationDepth
execute if score #Physics.PenetrationDepth Physics > #Physics.ThisObject Physics.Object.MaxPenetrationDepth run scoreboard players operation #Physics.ThisObject Physics.Object.MaxPenetrationDepth = #Physics.PenetrationDepth Physics

# Process the separating velocity (Keep track of the most negative separating velocity for the current ObjectA & tag the contact with the lowest value)
# (Important): The contact with the MinSeparatingVelocity has "HasMinSeparatingVelocity:0b" for the same reason as "HasMaxPenetrationDepth".
execute if score #Physics.PointVelocity.x Physics >= #Physics.ThisObject Physics.Object.MinSeparatingVelocity run return 0
execute store result storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[-1].Hitboxes[-1].Contacts[-1].HasMinSeparatingVelocity byte 0 run data remove storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[].Hitboxes[].Contacts[].HasMinSeparatingVelocity
scoreboard players operation #Physics.ThisObject Physics.Object.MinSeparatingVelocity = #Physics.PointVelocity.x Physics
