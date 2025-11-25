# Get ObjectA's feature (Edge that's closest to ObjectB)
# (Important): The edge is perpendicular to the axis with the minimum overlap, so it projects onto a single point. Meaning I only have to look at 1 corner point of each of the 4 candidate edges to see which one is farther along the axis.
$execute store success score #Physics.InvertValues Physics if score #Physics.Projection.OtherObject.CrossProductAxis.z$(OtherAxis).Min Physics < #Physics.Projection.Object.CrossProductAxis.z$(OtherAxis).Min Physics
$scoreboard players operation #Physics.DeepestProjection Physics = #Physics.Projection.Object.CrossProductAxis.z$(OtherAxis).Max Physics

    # Set the feature
    # (Important): Because only the min and max projections are scaled down, I need to scale the corner projections down here and turn the DeepestProjection relative again. In addition, to account for rounding errors that are different for positive and negative values (It matters whether I first multiply by -1 and then divide, or the other way around), I turn the min back to the max and just invert which corner matches which corner projection if it tries to get the min projection's corner.
    $scoreboard players operation #Physics.DeepestProjection Physics -= #Physics.Projection.ObjectCenter.CrossProductAxis.z$(OtherAxis) Physics
    $execute if score #Physics.Projection.OtherObject.CrossProductAxis.z$(OtherAxis).Min Physics >= #Physics.Projection.Object.CrossProductAxis.z$(OtherAxis).Min Physics run function physics:zprivate/contact_generation/new_contact/object/edge_edge/this_axis_z/check_edge_a_max {Axis:"$(OtherAxis)",StartCorner0:0b,StartCorner1:2b,StartCorner2:4b,StartCorner3:6b}
    $execute if score #Physics.Projection.OtherObject.CrossProductAxis.z$(OtherAxis).Min Physics < #Physics.Projection.Object.CrossProductAxis.z$(OtherAxis).Min Physics run function physics:zprivate/contact_generation/new_contact/object/edge_edge/this_axis_z/check_edge_a_min {Axis:"$(OtherAxis)",StartCorner0:0b,StartCorner1:2b,StartCorner2:4b,StartCorner3:6b}

# Get ObjectB's feature (Edge that's closest to ObjectA)
# (Important): The edge is perpendicular to the axis with the minimum overlap, so it projects onto a single point. Meaning I only have to look at 1 corner point of each of the 4 candidate edges to see which one is farther along the axis.
$scoreboard players operation #Physics.DeepestProjection Physics = #Physics.Projection.OtherObject.CrossProductAxis.z$(OtherAxis).Max Physics

    # Set the feature
    # (Important): Because only the min and max projections are scaled down, I need to scale the corner projections down here and turn the DeepestProjection relative again. In addition, to account for rounding errors that are different for positive and negative values (It matters whether I first multiply by -1 and then divide, or the other way around), I turn the min back to the max and just invert which corner matches which corner projection if it tries to get the min projection's corner.
    $scoreboard players operation #Physics.DeepestProjection Physics -= #Physics.Projection.OtherObjectCenter.CrossProductAxis.z$(OtherAxis) Physics
    $execute if score #Physics.Projection.OtherObject.CrossProductAxis.z$(OtherAxis).Min Physics >= #Physics.Projection.Object.CrossProductAxis.z$(OtherAxis).Min Physics run function physics:zprivate/contact_generation/new_contact/object/edge_edge/this_axis_z/check_edge_b_min with storage physics:temp data.EdgeData.$(OtherAxis)
    $execute if score #Physics.Projection.OtherObject.CrossProductAxis.z$(OtherAxis).Min Physics < #Physics.Projection.Object.CrossProductAxis.z$(OtherAxis).Min Physics run function physics:zprivate/contact_generation/new_contact/object/edge_edge/this_axis_z/check_edge_b_max with storage physics:temp data.EdgeData.$(OtherAxis)

# Calculate Penetration Depth, Contact Normal, Contact Point & Separating Velocity
    # Penetration Depth
    # (Important): The calculations are done in "get_edge_b".

    # Contact Point
    # (Important): The contact point is the center of the shortest connecting line between the two edges.
    # (Important): Calculation: Work with the edges as line definitions (starting point + variable * directional vector). Define the "squared distance" function and find its minimum (it's the only critical point, so setting the 1st derivative of the function to 0 is enough). I only calculate s for one edge, as I'm pretty sure it's guaranteed to correspond to a point that's within the edge's bounds. So I don't need a fallback for "If s is out of bounds, do the same for the other edge".
    # (Important): Edge1 = <Corner on the negative end> + s * <Corner on the positive end> => (u + s * v)    //    Edge2 = <Corner on the negative end> + t * <Corner on the positive end> => (m + t * n)
        # Calculate intermediate results (Dot products)
            # A = v * v
            # (Important): As ObjectA's axes are normalized, this is always 1.

            # B = n * n
            # (Important): As ObjectB's axes are normalized, this is always 1.

            # C = v * n
            execute store result score #Physics.Maths.D Physics run scoreboard players operation #Physics.Maths.C Physics = #Physics.ThisObject Physics.Object.Axis.z.x
            $scoreboard players operation #Physics.Maths.C Physics *= @s Physics.Object.Axis.$(OtherAxis).x

            execute store result score #Physics.Maths.Value7 Physics run scoreboard players operation #Physics.Maths.Value6 Physics = #Physics.ThisObject Physics.Object.Axis.z.y
            $scoreboard players operation #Physics.Maths.Value6 Physics *= @s Physics.Object.Axis.$(OtherAxis).y
            scoreboard players operation #Physics.Maths.C Physics += #Physics.Maths.Value6 Physics

            execute store result score #Physics.Maths.Value8 Physics run scoreboard players operation #Physics.Maths.Value6 Physics = #Physics.ThisObject Physics.Object.Axis.z.z
            $scoreboard players operation #Physics.Maths.Value6 Physics *= @s Physics.Object.Axis.$(OtherAxis).z
            scoreboard players operation #Physics.Maths.C Physics += #Physics.Maths.Value6 Physics
            execute store result score #Physics.Maths.s Physics store result score #Physics.Maths.Value9 Physics run scoreboard players operation #Physics.Maths.C Physics /= #Physics.Constants.1000 Physics

            # D = v * (u - m)
            # (Important): Value1-3 are the three components of (u - m), as calculated in the "get_edge_?" functions.
            # (Important): I need the numerator for s and t to be scaled 1,000x higher than the denominator. So keeping D scaled by 1,000x too much saves a few operations.
            scoreboard players operation #Physics.Maths.D Physics *= #Physics.Maths.Value1 Physics

            scoreboard players operation #Physics.Maths.Value7 Physics *= #Physics.Maths.Value2 Physics
            scoreboard players operation #Physics.Maths.D Physics += #Physics.Maths.Value7 Physics

            scoreboard players operation #Physics.Maths.Value8 Physics *= #Physics.Maths.Value3 Physics
            scoreboard players operation #Physics.Maths.D Physics += #Physics.Maths.Value8 Physics

            # E = n * (u - m)
            # (Important): Because I don't need them afterwards, I overwrite Value1-3 to save 3 scoreboard operations. The resulting E is stored as Value1.
            $scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.$(OtherAxis).x

            $scoreboard players operation #Physics.Maths.Value2 Physics *= @s Physics.Object.Axis.$(OtherAxis).y
            scoreboard players operation #Physics.Maths.Value1 Physics += #Physics.Maths.Value2 Physics

            $scoreboard players operation #Physics.Maths.Value3 Physics *= @s Physics.Object.Axis.$(OtherAxis).z
            scoreboard players operation #Physics.Maths.Value1 Physics += #Physics.Maths.Value3 Physics
            scoreboard players operation #Physics.Maths.Value1 Physics /= #Physics.Constants.1000 Physics

        # Calculate s (On ObjectA's edge)
            # CE - BD
            scoreboard players operation #Physics.Maths.s Physics *= #Physics.Maths.Value1 Physics
            scoreboard players operation #Physics.Maths.s Physics -= #Physics.Maths.D Physics

            # AB - CC
            scoreboard players operation #Physics.Maths.Value9 Physics *= #Physics.Maths.Value9 Physics
            scoreboard players operation #Physics.Maths.Value9 Physics /= #Physics.Constants.-1000 Physics
            scoreboard players add #Physics.Maths.Value9 Physics 1000

            # s = (CE - BD) / (AB - CC)
            execute store result score #Physics.ContactPoint.y Physics store result score #Physics.ContactPoint.z Physics run scoreboard players operation #Physics.Maths.s Physics /= #Physics.Maths.Value9 Physics

        # Calculate t (On ObjectB's edge)
        # (Important): Some values are set in the "get_edge_b" function.
        # (Important): Because I don't need them later, I overwrite some values. t is scored in the #Physics.Maths.Value1 score.
            # AE - CD
            scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.Constants.1000 Physics
            scoreboard players operation #Physics.Maths.D Physics /= #Physics.Constants.1000 Physics
            scoreboard players operation #Physics.Maths.C Physics *= #Physics.Maths.D Physics
            scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.Maths.C Physics

            # t = (AE - CD) / (AB - CC)
            execute store result score #Physics.OtherPoint.y Physics store result score #Physics.OtherPoint.z Physics run scoreboard players operation #Physics.Maths.Value1 Physics /= #Physics.Maths.Value9 Physics

        # Calculate the contact point (Middle between points on edges A and B)
            # Point on EdgeA
            scoreboard players operation #Physics.Maths.s Physics *= #Physics.ThisObject Physics.Object.Axis.z.x
            scoreboard players operation #Physics.Maths.s Physics /= #Physics.Constants.1000 Physics
            scoreboard players operation #Physics.Maths.s Physics += #Physics.ObjectA.EdgeStart.x Physics

            scoreboard players operation #Physics.ContactPoint.y Physics *= #Physics.ThisObject Physics.Object.Axis.z.y
            scoreboard players operation #Physics.ContactPoint.y Physics /= #Physics.Constants.1000 Physics
            scoreboard players operation #Physics.ContactPoint.y Physics += #Physics.ObjectA.EdgeStart.y Physics

            scoreboard players operation #Physics.ContactPoint.z Physics *= #Physics.ThisObject Physics.Object.Axis.z.z
            scoreboard players operation #Physics.ContactPoint.z Physics /= #Physics.Constants.1000 Physics
            scoreboard players operation #Physics.ContactPoint.z Physics += #Physics.ObjectA.EdgeStart.z Physics

            # Point on EdgeB
            $scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.$(OtherAxis).x
            scoreboard players operation #Physics.Maths.Value1 Physics /= #Physics.Constants.1000 Physics
            scoreboard players operation #Physics.Maths.Value1 Physics += #Physics.ObjectB.EdgeStart.x Physics

            $scoreboard players operation #Physics.OtherPoint.y Physics *= @s Physics.Object.Axis.$(OtherAxis).y
            scoreboard players operation #Physics.OtherPoint.y Physics /= #Physics.Constants.1000 Physics
            scoreboard players operation #Physics.OtherPoint.y Physics += #Physics.ObjectB.EdgeStart.y Physics

            $scoreboard players operation #Physics.OtherPoint.z Physics *= @s Physics.Object.Axis.$(OtherAxis).z
            scoreboard players operation #Physics.OtherPoint.z Physics /= #Physics.Constants.1000 Physics
            scoreboard players operation #Physics.OtherPoint.z Physics += #Physics.ObjectB.EdgeStart.z Physics

            # Get average
            execute store result storage physics:temp data.NewContact.ContactPoint[0] int 0.5 run scoreboard players operation #Physics.Maths.s Physics += #Physics.Maths.Value1 Physics
            execute store result storage physics:temp data.NewContact.ContactPoint[1] int 0.5 run scoreboard players operation #Physics.ContactPoint.y Physics += #Physics.OtherPoint.y Physics
            execute store result storage physics:temp data.NewContact.ContactPoint[2] int 0.5 run scoreboard players operation #Physics.ContactPoint.z Physics += #Physics.OtherPoint.z Physics

    # Contact Normal
    # (Important): For edge-edge collisions, the contact normal is the cross product.
    # (Important): In case ObjectA's projection is larger, it inverts the contact normal in "get_edge_b".
    $execute if score #Physics.InvertValues Physics matches 0 store result storage physics:temp data.NewContact.ContactNormal[0] int 1 run scoreboard players operation #Physics.ContactNormal.x Physics = #Physics.CrossProductAxis.z$(OtherAxis).x Physics
    $execute if score #Physics.InvertValues Physics matches 0 store result storage physics:temp data.NewContact.ContactNormal[1] int 1 run scoreboard players operation #Physics.ContactNormal.y Physics = #Physics.CrossProductAxis.z$(OtherAxis).y Physics
    $execute if score #Physics.InvertValues Physics matches 0 store result storage physics:temp data.NewContact.ContactNormal[2] int 1 run scoreboard players operation #Physics.ContactNormal.z Physics = #Physics.CrossProductAxis.z$(OtherAxis).z Physics

    # Separating Velocity
    # (Important): The separating velocity for one object is the dot product between the contact point (relative to that object)'s relative velocity and the contact normal. The relative velocity is the cross product between the object's angular velocity and the contact point (relative to the object's center) that's added together with the object's linear velocity.
    # (Important): To get the actual separating velocity, I subtract ObjectA's separating velocity from ObjectB's (because they face different directions, they're sign-flipped), as both objects may be moving or rotating.
        # Separating Velocity for ObjectB
            # Calculate relative contact point
            execute store result score #Physics.SeparatingVelocity.z Physics run scoreboard players operation #Physics.Maths.s Physics -= @s Physics.Object.Pos.x
            execute store result score #Physics.SeparatingVelocity.x Physics run scoreboard players operation #Physics.ContactPoint.y Physics -= @s Physics.Object.Pos.y
            execute store result score #Physics.SeparatingVelocity.y Physics run scoreboard players operation #Physics.ContactPoint.z Physics -= @s Physics.Object.Pos.z

            # Calculate cross product between angular velocity and relative contact point
            # (Important): I overwrite the contact point scores here, as I don't need those values (relative to this object) anymore.
            # (Important): I messed up the order (relativeContactPoint x angularVelocity instead of angularVelocity x relativeContactPoint). To accomodate for that without spending hours rewriting it, I divide by -1000 instead of 1000.
            scoreboard players operation #Physics.SeparatingVelocity.x Physics *= @s Physics.Object.AngularVelocity.z
            scoreboard players operation #Physics.ContactPoint.z Physics *= @s Physics.Object.AngularVelocity.y
            scoreboard players operation #Physics.SeparatingVelocity.x Physics -= #Physics.ContactPoint.z Physics
            scoreboard players operation #Physics.SeparatingVelocity.x Physics /= #Physics.Constants.-1000 Physics

            scoreboard players operation #Physics.SeparatingVelocity.y Physics *= @s Physics.Object.AngularVelocity.x
            scoreboard players operation #Physics.Maths.s Physics *= @s Physics.Object.AngularVelocity.z
            scoreboard players operation #Physics.SeparatingVelocity.y Physics -= #Physics.Maths.s Physics
            scoreboard players operation #Physics.SeparatingVelocity.y Physics /= #Physics.Constants.-1000 Physics

            scoreboard players operation #Physics.SeparatingVelocity.z Physics *= @s Physics.Object.AngularVelocity.y
            scoreboard players operation #Physics.ContactPoint.y Physics *= @s Physics.Object.AngularVelocity.x
            scoreboard players operation #Physics.SeparatingVelocity.z Physics -= #Physics.ContactPoint.y Physics
            scoreboard players operation #Physics.SeparatingVelocity.z Physics /= #Physics.Constants.-1000 Physics

            # Add the linear velocity to obtain the relative velocity of the contact point
            scoreboard players operation #Physics.SeparatingVelocity.x Physics += @s Physics.Object.Velocity.x
            scoreboard players operation #Physics.SeparatingVelocity.y Physics += @s Physics.Object.Velocity.y
            scoreboard players operation #Physics.SeparatingVelocity.z Physics += @s Physics.Object.Velocity.z

        # Separating Velocity for ObjectA
            # Calculate relative contact point
            execute store result score #Physics.PointVelocity.z Physics run scoreboard players operation #Physics.ContactPointCopy.x Physics -= #Physics.ThisObject Physics.Object.Pos.x
            execute store result score #Physics.PointVelocity.x Physics run scoreboard players operation #Physics.ContactPointCopy.y Physics -= #Physics.ThisObject Physics.Object.Pos.y
            execute store result score #Physics.PointVelocity.y Physics run scoreboard players operation #Physics.ContactPointCopy.z Physics -= #Physics.ThisObject Physics.Object.Pos.z

            # Calculate cross product between angular velocity and relative contact point
            # (Important): I overwrite the contact point scores here, as I don't need those values (relative to this object) anymore.
            # (Important): I messed up the order (relativeContactPoint x angularVelocity instead of angularVelocity x relativeContactPoint). To accomodate for that without spending hours rewriting it, I divide by -1000 instead of 1000.
            scoreboard players operation #Physics.PointVelocity.x Physics *= #Physics.ThisObject Physics.Object.AngularVelocity.z
            scoreboard players operation #Physics.ContactPointCopy.z Physics *= #Physics.ThisObject Physics.Object.AngularVelocity.y
            scoreboard players operation #Physics.PointVelocity.x Physics -= #Physics.ContactPointCopy.z Physics
            scoreboard players operation #Physics.PointVelocity.x Physics /= #Physics.Constants.-1000 Physics

            scoreboard players operation #Physics.PointVelocity.y Physics *= #Physics.ThisObject Physics.Object.AngularVelocity.x
            scoreboard players operation #Physics.ContactPointCopy.x Physics *= #Physics.ThisObject Physics.Object.AngularVelocity.z
            scoreboard players operation #Physics.PointVelocity.y Physics -= #Physics.ContactPointCopy.x Physics
            scoreboard players operation #Physics.PointVelocity.y Physics /= #Physics.Constants.-1000 Physics

            scoreboard players operation #Physics.PointVelocity.z Physics *= #Physics.ThisObject Physics.Object.AngularVelocity.y
            scoreboard players operation #Physics.ContactPointCopy.y Physics *= #Physics.ThisObject Physics.Object.AngularVelocity.x
            scoreboard players operation #Physics.PointVelocity.z Physics -= #Physics.ContactPointCopy.y Physics
            scoreboard players operation #Physics.PointVelocity.z Physics /= #Physics.Constants.-1000 Physics

            # Add the linear velocity to obtain the relative velocity of the contact point
            scoreboard players operation #Physics.PointVelocity.x Physics += #Physics.ThisObject Physics.Object.Velocity.x
            scoreboard players operation #Physics.PointVelocity.y Physics += #Physics.ThisObject Physics.Object.Velocity.y
            scoreboard players operation #Physics.PointVelocity.z Physics += #Physics.ThisObject Physics.Object.Velocity.z

        # Subtract velocity from acceleration along contact normal
        # (Important): Normally you just subtract it from SeparatingVelocity so that ContactVelocity remains intact (the tangents need to be untouched!), but if I subtract the projection from both, then I don't have to repeatedly do that during each iteration of resolution.
        # (Important): I project the VelocityFromAcceleration (currently only gravity) onto the contactNormal. Then I multiply this scalar with the ContactNormal, and subtract this new vector from the ContactVelocity. This means the SeparatingVelocity will already be adjusted once it's calculated, and I don't have to apply the projection every time it resolves a contact.
        scoreboard players operation #Physics.VelocityFromAcceleration.y Physics = @s Physics.Object.DefactoGravity
        scoreboard players operation #Physics.VelocityFromAcceleration.y Physics -= #Physics.ThisObject Physics.Object.DefactoGravity
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
        execute store result storage physics:temp data.NewContact.ContactVelocity[0] int 1 run scoreboard players operation #Physics.SeparatingVelocity.x Physics -= #Physics.PointVelocity.x Physics
        execute store result storage physics:temp data.NewContact.ContactVelocity[1] int 1 run scoreboard players operation #Physics.SeparatingVelocity.y Physics -= #Physics.PointVelocity.y Physics
        execute store result storage physics:temp data.NewContact.ContactVelocity[2] int 1 run scoreboard players operation #Physics.SeparatingVelocity.z Physics -= #Physics.PointVelocity.z Physics

        # Calculate the relative velocity's dot product with the contact normal to get the separation velocity (single number, not a vector) and store it
        # (Important): I also adjust the scale and invert the number here instead of doing it for both individual velocities.
        # (Important): Because I directly inverted the contact normal scores in "get_edge_b" (if they needed to be inverted), I don't need to invert the resulting separating velocity anymore.
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
