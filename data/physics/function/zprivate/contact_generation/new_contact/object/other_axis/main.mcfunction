# Get ObjectB's feature (Face that's closest to ObjectA)
# (Important): There are 2 candidate faces (those normal to the axis), and I select the correct one by looking at the projection of a single point of them and looking which is closer. If I look at the same point for both faces, I can easily get which face is closer.
# (Important): The FeatureB score is set in "get_features", so I don't have to try all the 6 possibilities here. Better for performance.
$execute store success score #Physics.InvertValues Physics if score #Physics.Projection.Object.OtherObjectAxis.$(OtherAxis).Min Physics < @s Physics.Object.ProjectionOwnAxis.$(OtherAxis).Min

# Get ObjectA's feature (Corner that's closest to ObjectB)
# (Important): I check which of the 8 corners' projection is the closest to ObjectB along the axis (furthest along the axis), so I have to get either the min or the max.
$scoreboard players operation #Physics.DeepestProjection Physics = #Physics.Projection.Object.OtherObjectAxis.$(OtherAxis).Max Physics

    # Set the feature
    # (Important): There are only 8 corners (and unique macro variable combinations), so everything is cached. Reduces duplicate files.
    # (Important): Because only the min and max projections are scaled down, I need to scale the corner projections down here and turn the DeepestProjection relative again. In addition, to account for rounding errors that are different for positive and negative values (It matters whether I first multiply by -1 and then divide, or the other way around), I turn the min back to the max and just invert which corner matches which corner projection if it tries to get the min projection's corner.
    $scoreboard players operation #Physics.DeepestProjection Physics -= #Physics.Projection.ObjectCenter.OtherObjectAxis.$(OtherAxis) Physics
    $execute if score #Physics.InvertValues Physics matches 0 run function physics:zprivate/contact_generation/new_contact/object/other_axis/check_corner_min {OtherAxis:"$(OtherAxis)"}
    $execute if score #Physics.InvertValues Physics matches 1 run function physics:zprivate/contact_generation/new_contact/object/other_axis/check_corner_max {OtherAxis:"$(OtherAxis)"}

# Calculate Penetration Depth, Contact Normal, Contact Point & Separating Velocity
    # Penetration Depth
    # (Important): For point-face collisions, the penetration depth is the projection of (point - <any point on the face>) onto the contact normal. It's distributive, so I can also subtract the projection of any point on the face from the (already calculated) projection of the corner.
    # (Important): Calculations are done in "get_features" to avoid redundant score checks and to utilize "return run".

    # Contact Normal
    # (Important): For point-face collisions, the contact normal is the face's normal. So it's the axis of minimum overlap. Also set in "get_features".

    # Contact Point
    # (Important): For point-face collisions, the contact point is the point projected onto the surface (= moved along contact normal with the penetration depth as the amount).
    # (Important): I use the "execute store" from earlier to avoid an additional scoreboard call. Also, the point's coordinates are copied over in "get_features".
    scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.PenetrationDepth Physics
    scoreboard players operation #Physics.Maths.Value1 Physics /= #Physics.Constants.1000 Physics
    execute store result storage physics:temp data.NewContact.ContactPoint[0] int 1 store result score #Physics.ContactPointCopy.x Physics run scoreboard players operation #Physics.ContactPoint.x Physics += #Physics.Maths.Value1 Physics

    scoreboard players operation #Physics.Maths.Value2 Physics *= #Physics.PenetrationDepth Physics
    scoreboard players operation #Physics.Maths.Value2 Physics /= #Physics.Constants.1000 Physics
    execute store result storage physics:temp data.NewContact.ContactPoint[1] int 1 store result score #Physics.ContactPointCopy.y Physics run scoreboard players operation #Physics.ContactPoint.y Physics += #Physics.Maths.Value2 Physics

    scoreboard players operation #Physics.Maths.Value3 Physics *= #Physics.PenetrationDepth Physics
    scoreboard players operation #Physics.Maths.Value3 Physics /= #Physics.Constants.1000 Physics
    execute store result storage physics:temp data.NewContact.ContactPoint[2] int 1 store result score #Physics.ContactPointCopy.z Physics run scoreboard players operation #Physics.ContactPoint.z Physics += #Physics.Maths.Value3 Physics

    # Separating Velocity
    # (Important): The separating velocity for one object is the dot product between the contact point (relative to that object)'s relative velocity and the contact normal. The relative velocity is the cross product between the object's angular velocity and the contact point (relative to the object's center) that's added together with the object's linear velocity.
    # (Important): To get the actual separating velocity, I subtract ObjectA's separating velocity from ObjectB's (because they face different directions, they're sign-flipped), as both objects may be moving or rotating.
        # Separating Velocity for ObjectB
            # Calculate relative contact point
            execute store result score #Physics.PointVelocity.z Physics run scoreboard players operation #Physics.ContactPoint.x Physics -= @s Physics.Object.Pos.x
            execute store result score #Physics.PointVelocity.x Physics run scoreboard players operation #Physics.ContactPoint.y Physics -= @s Physics.Object.Pos.y
            execute store result score #Physics.PointVelocity.y Physics run scoreboard players operation #Physics.ContactPoint.z Physics -= @s Physics.Object.Pos.z

            # Calculate cross product between angular velocity and relative contact point
            # (Important): I overwrite the contact point scores here, as I don't need those values (relative to this object) anymore.
            # (Important): I messed up the order (relativeContactPoint x angularVelocity instead of angularVelocity x relativeContactPoint). To accomodate for that without spending hours rewriting it, I divide by -1000 instead of 1000.
            scoreboard players operation #Physics.PointVelocity.x Physics *= @s Physics.Object.AngularVelocity.z
            scoreboard players operation #Physics.ContactPoint.z Physics *= @s Physics.Object.AngularVelocity.y
            scoreboard players operation #Physics.PointVelocity.x Physics -= #Physics.ContactPoint.z Physics
            scoreboard players operation #Physics.PointVelocity.x Physics /= #Physics.Constants.-1000 Physics

            scoreboard players operation #Physics.PointVelocity.y Physics *= @s Physics.Object.AngularVelocity.x
            scoreboard players operation #Physics.ContactPoint.x Physics *= @s Physics.Object.AngularVelocity.z
            scoreboard players operation #Physics.PointVelocity.y Physics -= #Physics.ContactPoint.x Physics
            scoreboard players operation #Physics.PointVelocity.y Physics /= #Physics.Constants.-1000 Physics

            scoreboard players operation #Physics.PointVelocity.z Physics *= @s Physics.Object.AngularVelocity.y
            scoreboard players operation #Physics.ContactPoint.y Physics *= @s Physics.Object.AngularVelocity.x
            scoreboard players operation #Physics.PointVelocity.z Physics -= #Physics.ContactPoint.y Physics
            scoreboard players operation #Physics.PointVelocity.z Physics /= #Physics.Constants.-1000 Physics

            # Add the linear velocity to obtain the relative velocity of the contact point
            scoreboard players operation #Physics.PointVelocity.x Physics += @s Physics.Object.Velocity.x
            scoreboard players operation #Physics.PointVelocity.y Physics += @s Physics.Object.Velocity.y
            scoreboard players operation #Physics.PointVelocity.z Physics += @s Physics.Object.Velocity.z

        # Separating Velocity for ObjectA
            # Calculate relative contact point
            execute store result score #Physics.SeparatingVelocity.z Physics run scoreboard players operation #Physics.ContactPointCopy.x Physics -= #Physics.ThisObject Physics.Object.Pos.x
            execute store result score #Physics.SeparatingVelocity.x Physics run scoreboard players operation #Physics.ContactPointCopy.y Physics -= #Physics.ThisObject Physics.Object.Pos.y
            execute store result score #Physics.SeparatingVelocity.y Physics run scoreboard players operation #Physics.ContactPointCopy.z Physics -= #Physics.ThisObject Physics.Object.Pos.z

            # Calculate cross product between angular velocity and relative contact point
            # (Important): I overwrite the contact point scores here, as I don't need those values (relative to this object) anymore.
            # (Important): I messed up the order (relativeContactPoint x angularVelocity instead of angularVelocity x relativeContactPoint). To accomodate for that without spending hours rewriting it, I divide by -1000 instead of 1000.
            scoreboard players operation #Physics.SeparatingVelocity.x Physics *= #Physics.ThisObject Physics.Object.AngularVelocity.z
            scoreboard players operation #Physics.ContactPointCopy.z Physics *= #Physics.ThisObject Physics.Object.AngularVelocity.y
            scoreboard players operation #Physics.SeparatingVelocity.x Physics -= #Physics.ContactPointCopy.z Physics
            scoreboard players operation #Physics.SeparatingVelocity.x Physics /= #Physics.Constants.-1000 Physics

            scoreboard players operation #Physics.SeparatingVelocity.y Physics *= #Physics.ThisObject Physics.Object.AngularVelocity.x
            scoreboard players operation #Physics.ContactPointCopy.x Physics *= #Physics.ThisObject Physics.Object.AngularVelocity.z
            scoreboard players operation #Physics.SeparatingVelocity.y Physics -= #Physics.ContactPointCopy.x Physics
            scoreboard players operation #Physics.SeparatingVelocity.y Physics /= #Physics.Constants.-1000 Physics

            scoreboard players operation #Physics.SeparatingVelocity.z Physics *= #Physics.ThisObject Physics.Object.AngularVelocity.y
            scoreboard players operation #Physics.ContactPointCopy.y Physics *= #Physics.ThisObject Physics.Object.AngularVelocity.x
            scoreboard players operation #Physics.SeparatingVelocity.z Physics -= #Physics.ContactPointCopy.y Physics
            scoreboard players operation #Physics.SeparatingVelocity.z Physics /= #Physics.Constants.-1000 Physics

            # Add the linear velocity to obtain the relative velocity of the contact point
            scoreboard players operation #Physics.SeparatingVelocity.x Physics += #Physics.ThisObject Physics.Object.Velocity.x
            scoreboard players operation #Physics.SeparatingVelocity.y Physics += #Physics.ThisObject Physics.Object.Velocity.y
            scoreboard players operation #Physics.SeparatingVelocity.z Physics += #Physics.ThisObject Physics.Object.Velocity.z

        # Subtract velocity from acceleration along contact normal
        # (Important): Normally you just subtract it from SeparatingVelocity so that ContactVelocity remains intact (the tangents need to be untouched!), but if I subtract the projection from both, then I don't have to repeatedly do that during each iteration of resolution.
        # (Important): I project the VelocityFromAcceleration (currently only gravity) onto the contactNormal. Then I multiply this scalar with the ContactNormal, and subtract this new vector from the ContactVelocity. This means the SeparatingVelocity will already be adjusted once it's calculated, and I don't have to apply the projection every time it resolves a contact.
        scoreboard players operation #Physics.VelocityFromAcceleration.y Physics = #Physics.ThisObject Physics.Object.DefactoGravity
        scoreboard players operation #Physics.VelocityFromAcceleration.y Physics -= @s Physics.Object.DefactoGravity
        scoreboard players operation #Physics.VelocityFromAcceleration.y Physics *= #Physics.ContactNormal.y Physics
        execute store result score #Physics.SubtractVector.x Physics store result score #Physics.SubtractVector.y Physics store result score #Physics.SubtractVector.z Physics run scoreboard players operation #Physics.VelocityFromAcceleration.y Physics /= #Physics.Constants.1000 Physics

        scoreboard players operation #Physics.SubtractVector.x Physics *= #Physics.ContactNormal.x Physics
        scoreboard players operation #Physics.SubtractVector.y Physics *= #Physics.ContactNormal.y Physics
        scoreboard players operation #Physics.SubtractVector.z Physics *= #Physics.ContactNormal.z Physics
        scoreboard players operation #Physics.SubtractVector.x Physics /= #Physics.Constants.1000 Physics
        scoreboard players operation #Physics.SubtractVector.y Physics /= #Physics.Constants.1000 Physics
        scoreboard players operation #Physics.SubtractVector.z Physics /= #Physics.Constants.1000 Physics

        scoreboard players operation #Physics.SeparatingVelocity.x Physics -= #Physics.SubtractVector.x Physics
        scoreboard players operation #Physics.SeparatingVelocity.y Physics -= #Physics.SubtractVector.y Physics
        scoreboard players operation #Physics.SeparatingVelocity.z Physics -= #Physics.SubtractVector.z Physics

        # Add the point velocities together
        # (Important): For other_axis ONLY: ContactVelocity is A - B, so that projecting it onto the contact normal directly gives me the correct SeparatingVelocity without needing to invert it.
        execute store result storage physics:temp data.NewContact.ContactVelocity[0] int 1 run scoreboard players operation #Physics.SeparatingVelocity.x Physics -= #Physics.PointVelocity.x Physics
        execute store result storage physics:temp data.NewContact.ContactVelocity[1] int 1 run scoreboard players operation #Physics.SeparatingVelocity.y Physics -= #Physics.PointVelocity.y Physics
        execute store result storage physics:temp data.NewContact.ContactVelocity[2] int 1 run scoreboard players operation #Physics.SeparatingVelocity.z Physics -= #Physics.PointVelocity.z Physics

        # Calculate the relative velocity's dot product with the contact normal to get the separation velocity (single number, not a vector) and store it
        # (Important): I also adjust the scale and invert the number here instead of doing it for both individual velocities.
        scoreboard players operation #Physics.SeparatingVelocity.x Physics *= #Physics.ContactNormal.x Physics
        scoreboard players operation #Physics.SeparatingVelocity.y Physics *= #Physics.ContactNormal.y Physics
        scoreboard players operation #Physics.SeparatingVelocity.z Physics *= #Physics.ContactNormal.z Physics

        scoreboard players operation #Physics.SeparatingVelocity.x Physics += #Physics.SeparatingVelocity.y Physics
        scoreboard players operation #Physics.SeparatingVelocity.x Physics += #Physics.SeparatingVelocity.z Physics

        execute store result storage physics:temp data.NewContact.SeparatingVelocity short 1 store result storage physics:zprivate ContactGroups[-1].Objects[-1].MinSeparatingVelocity short 1 run scoreboard players operation #Physics.SeparatingVelocity.x Physics /= #Physics.Constants.1000 Physics

# Store the new contact
# (Important): The values are stored in their scaled up form, just like how I need them to process them.
# (Important): The object's entry in the final storage is already created after the SAT.
data modify storage physics:zprivate ContactGroups[-1].Objects[-1].Contacts append from storage physics:temp data.NewContact

# Set up contact accumulation for that object
function physics:zprivate/contact_generation/new_contact/object/get_previous_contacts with storage physics:zprivate ContactGroups[-1].Objects[-1]

# Update the MaxPenetrationDepth (& keep track of the contact with the MaxPenetrationDepth)
# (Important): The contact with the MaxPenetrationDepth has "HasMaxPenetrationDepth:0b" instead of 1b so the "store result storage ..." command works even if the command afterwards (to remove the previously tagged contact's tag) fails. Same for "MaxPenetrationDepthIsObjectContact".
# (Important): MaxPenetrationDepth.World will be set even if no world contacts exist, but it doesn't cause any bugs or noteworthy performance cost, so I ignore that.
execute if score #Physics.PenetrationDepth Physics > #Physics.ThisObject Physics.Object.MaxPenetrationDepth if score #Physics.ThisObject Physics.Object.MaxPenetrationDepth = #Physics.ThisObject Physics.Object.MaxPenetrationDepth.World store result storage physics:zprivate ContactGroups[-1].Objects[-1].Contacts[-1].HasMaxPenetrationDepth byte 0 store result storage physics:zprivate ContactGroups[-1].MaxPenetrationDepthIsObjectContact byte 0 run data remove storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[].Hitboxes[].Contacts[].HasMaxPenetrationDepth
execute if score #Physics.PenetrationDepth Physics > #Physics.ThisObject Physics.Object.MaxPenetrationDepth unless score #Physics.ThisObject Physics.Object.MaxPenetrationDepth = #Physics.ThisObject Physics.Object.MaxPenetrationDepth.World store result storage physics:zprivate ContactGroups[-1].Objects[-1].Contacts[-1].HasMaxPenetrationDepth byte 0 run data remove storage physics:zprivate ContactGroups[-1].Objects[].Contacts[].HasMaxPenetrationDepth
execute if score #Physics.PenetrationDepth Physics > #Physics.ThisObject Physics.Object.MaxPenetrationDepth run scoreboard players operation #Physics.ThisObject Physics.Object.MaxPenetrationDepth = #Physics.PenetrationDepth Physics

# Process the separating velocity (Keep track of the most negative separating velocity for the current ObjectA & tag the contact with the lowest value)
# (Important): The contact with the MinSeparatingVelocity has "HasMinSeparatingVelocity:0b" for the same reason as "HasMaxPenetrationDepth". Same for "MinSeparatingVelocityIsObjectContact".
execute if score #Physics.SeparatingVelocity.x Physics >= #Physics.ThisObject Physics.Object.MinSeparatingVelocity run return 0
execute if score #Physics.ThisObject Physics.Object.MinSeparatingVelocity = #Physics.ThisObject Physics.Object.MinSeparatingVelocity.World store result storage physics:zprivate ContactGroups[-1].Objects[-1].Contacts[-1].HasMinSeparatingVelocity byte 0 store result storage physics:zprivate ContactGroups[-1].MinSeparatingVelocityIsObjectContact byte 0 run data remove storage physics:zprivate ContactGroups[-1].Objects[0].Blocks[].Hitboxes[].Contacts[].HasMinSeparatingVelocity
execute unless score #Physics.ThisObject Physics.Object.MinSeparatingVelocity = #Physics.ThisObject Physics.Object.MinSeparatingVelocity.World store result storage physics:zprivate ContactGroups[-1].Objects[-1].Contacts[-1].HasMinSeparatingVelocity byte 0 run data remove storage physics:zprivate ContactGroups[-1].Objects[].Contacts[].HasMinSeparatingVelocity
scoreboard players operation #Physics.ThisObject Physics.Object.MinSeparatingVelocity = #Physics.SeparatingVelocity.x Physics
