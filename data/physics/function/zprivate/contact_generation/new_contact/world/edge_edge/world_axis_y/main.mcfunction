# Get the object's feature (Edge that's closest to the world-geometry block)
# (Important): The edge is perpendicular to the axis with the minimum overlap, so it projects onto a single point. Meaning I only have to look at 1 corner point of each of the 4 candidate edges to see which one is farther along the axis.
$execute store success score #Physics.InvertValues Physics if score #Physics.Projection.Block.CrossProductAxis.y$(ObjectAxis).Min Physics >= #Physics.Projection.Object.CrossProductAxis.y$(ObjectAxis).Min Physics
$execute if score #Physics.InvertValues Physics matches 0 run scoreboard players operation #Physics.DeepestProjection Physics = #Physics.Projection.Object.CrossProductAxis.y$(ObjectAxis).Min Physics
$execute if score #Physics.InvertValues Physics matches 1 run scoreboard players operation #Physics.DeepestProjection Physics = #Physics.Projection.Object.CrossProductAxis.y$(ObjectAxis).Max Physics

    # Set the feature
    $execute if score #Physics.DeepestProjection Physics = #Physics.Projection.ObjectCorner$(StartCorner0).CrossProductAxis.y$(ObjectAxis) Physics run function physics:zprivate/contact_generation/new_contact/world/edge_edge/world_axis_y/get_edge_a_$(ObjectAxis) with storage physics:temp data.ObjectEdge.$(ObjectAxis)[0]
    $execute if score #Physics.DeepestProjection Physics = #Physics.Projection.ObjectCorner$(StartCorner1).CrossProductAxis.y$(ObjectAxis) Physics run function physics:zprivate/contact_generation/new_contact/world/edge_edge/world_axis_y/get_edge_a_$(ObjectAxis) with storage physics:temp data.ObjectEdge.$(ObjectAxis)[1]
    $execute if score #Physics.DeepestProjection Physics = #Physics.Projection.ObjectCorner$(StartCorner2).CrossProductAxis.y$(ObjectAxis) Physics run function physics:zprivate/contact_generation/new_contact/world/edge_edge/world_axis_y/get_edge_a_$(ObjectAxis) with storage physics:temp data.ObjectEdge.$(ObjectAxis)[2]
    $execute if score #Physics.DeepestProjection Physics = #Physics.Projection.ObjectCorner$(StartCorner3).CrossProductAxis.y$(ObjectAxis) Physics run function physics:zprivate/contact_generation/new_contact/world/edge_edge/world_axis_y/get_edge_a_$(ObjectAxis) with storage physics:temp data.ObjectEdge.$(ObjectAxis)[3]

# Get the world-geometry block's feature (Edge that's closest to the object)
# (Important): The edge is perpendicular to the axis with the minimum overlap, so it projects onto a single point. Meaning I only have to look at 1 corner point of each of the 4 candidate edges to see which one is farther along the axis.
$execute if score #Physics.InvertValues Physics matches 0 run scoreboard players operation #Physics.DeepestProjection Physics = #Physics.Projection.BlockBase.CrossProductAxis.y$(ObjectAxis).Max Physics
$execute if score #Physics.InvertValues Physics matches 1 run scoreboard players operation #Physics.DeepestProjection Physics = #Physics.Projection.BlockBase.CrossProductAxis.y$(ObjectAxis).Min Physics

    # Set the feature
    $execute if score #Physics.DeepestProjection Physics = #Physics.Projection.BlockCornerBase0.CrossProductAxis.y$(ObjectAxis) Physics run function physics:zprivate/contact_generation/new_contact/world/edge_edge/world_axis_y/get_edge_b_$(ObjectAxis) {Edge:24b,StartCorner:0b,x:"Min",y:"Min",z:"Min"}
    $execute if score #Physics.DeepestProjection Physics = #Physics.Projection.BlockCornerBase1.CrossProductAxis.y$(ObjectAxis) Physics run function physics:zprivate/contact_generation/new_contact/world/edge_edge/world_axis_y/get_edge_b_$(ObjectAxis) {Edge:25b,StartCorner:1b,x:"Min",y:"Min",z:"Max"}
    $execute if score #Physics.DeepestProjection Physics = #Physics.Projection.BlockCornerBase4.CrossProductAxis.y$(ObjectAxis) Physics run function physics:zprivate/contact_generation/new_contact/world/edge_edge/world_axis_y/get_edge_b_$(ObjectAxis) {Edge:26b,StartCorner:2b,x:"Max",y:"Min",z:"Min"}
    $execute if score #Physics.DeepestProjection Physics = #Physics.Projection.BlockCornerBase5.CrossProductAxis.y$(ObjectAxis) Physics run function physics:zprivate/contact_generation/new_contact/world/edge_edge/world_axis_y/get_edge_b_$(ObjectAxis) {Edge:27b,StartCorner:3b,x:"Max",y:"Min",z:"Max"}

# Calculate contact data
    # Penetration Depth
    # (Important): The calculations are done in "get_edge_b".

    # Contact Point
    # (Important): The contact point is the center of the shortest connecting line between the two edges.
    # (Important): Calculation: Work with the edges as line definitions (starting point + variable * directional vector). Define the "squared distance" function and find its minimum (it's the only critical point, so setting the 1st derivative of the function to 0 is enough). I only calculate s for one edge, as I'm pretty sure it's guaranteed to correspond to a point that's within the edge's bounds. So I don't need a fallback for "If s is out of bounds, do the same for the other edge".
    # (Important): Edge1 = <Corner on the negative end> + s * <Corner on the positive end> => (u + s * v)    //    Edge2 = <Corner on the negative end> + t * <Corner on the positive end> => (m + t * n)
    # (Important): The direction is either the object's axis (Already stored) or 1 along that axis (For world blocks). Because I use 1 instead of 1,000, I have to be aware of the scaling.
        # Calculate intermediate results (Dot products)
            # A = v * v
            # (Important): As the object's axes are normalized, this is always 1.

            # B = n * n
            # (Important): As the block is axis-aligned, this is defined as 1.

            # C = v * n
            # (Important): Because the block is axis-aligned, its edge's directional vector only has one component that is also 1. So C is the same as that component from ObjectA's axis, which is the y component in this case.

            # D = v * (u - m)
            # (Important): Value1-3 are the three components of (u - m), as calculated in the "get_edge_?" functions.
            # (Important): Because I only need to keep the y component of (u - m) for the calculation of E, I can overwrite the other 2 components to save 2 scoreboard operations.
            # (Important): I need the numerator for s and t to be scaled 1,000x higher than the denominator. So keeping D scaled by 1,000x too much saves a few operations.
            $scoreboard players operation #Physics.Maths.D Physics = #Physics.ThisObject Physics.Object.Axis.$(ObjectAxis).y
            scoreboard players operation #Physics.Maths.D Physics *= #Physics.Maths.Value2 Physics

            $scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.ThisObject Physics.Object.Axis.$(ObjectAxis).x
            scoreboard players operation #Physics.Maths.D Physics += #Physics.Maths.Value1 Physics

            $scoreboard players operation #Physics.Maths.Value3 Physics *= #Physics.ThisObject Physics.Object.Axis.$(ObjectAxis).z
            scoreboard players operation #Physics.Maths.D Physics += #Physics.Maths.Value3 Physics

            # E = n * (u - m)
            # (Important): Because the block is axis-aligned, its edge's directional vector only has one component that is also 1. So E is that component from (u - m), which is Value2 in this case.

        # Calculate s (On ObjectA's edge)
            # CE - BD
            $execute store result score #Physics.Maths.Value1 Physics run scoreboard players operation #Physics.Maths.s Physics = #Physics.ThisObject Physics.Object.Axis.$(ObjectAxis).y
            scoreboard players operation #Physics.Maths.s Physics *= #Physics.Maths.Value2 Physics
            scoreboard players operation #Physics.Maths.s Physics -= #Physics.Maths.D Physics

            # AB - CC
            scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.Maths.Value1 Physics
            scoreboard players operation #Physics.Maths.Value1 Physics /= #Physics.Constants.-1000 Physics
            scoreboard players add #Physics.Maths.Value1 Physics 1000

            # s = (CE - BD) / (AB - CC)
            execute store result score #Physics.ContactPoint.y Physics store result score #Physics.ContactPoint.z Physics run scoreboard players operation #Physics.Maths.s Physics /= #Physics.Maths.Value1 Physics

        # Calculate t (On ObjectB's edge)
        # (Important): Some values are set in the "get_edge_b" function.
            # AE - CD
            # (Important): AE condenses down to Value2, which isn't scaled high enough. I directly change its value, as I don't need it anymore after this.
            # (Important): I calculate t directly inside the #Physics.Maths.Value2 score, as I don't want to waste an operation copying it over. I also adjust the scaling of D and overwrite it for the CD calculation, as I don't need it anymore after this.
            scoreboard players operation #Physics.Maths.Value2 Physics *= #Physics.Constants.1000 Physics
            scoreboard players operation #Physics.Maths.D Physics /= #Physics.Constants.1000 Physics
            $scoreboard players operation #Physics.Maths.D Physics *= #Physics.ThisObject Physics.Object.Axis.$(ObjectAxis).y
            scoreboard players operation #Physics.Maths.Value2 Physics -= #Physics.Maths.D Physics

            # t = (AE - CD) / (AB - CC)
            scoreboard players operation #Physics.Maths.Value2 Physics /= #Physics.Maths.Value1 Physics

        # Calculate the contact point (Middle between points on edges A and B)
            # Point on EdgeA
            $scoreboard players operation #Physics.Maths.s Physics *= #Physics.ThisObject Physics.Object.Axis.$(ObjectAxis).x
            scoreboard players operation #Physics.Maths.s Physics /= #Physics.Constants.1000 Physics
            scoreboard players operation #Physics.Maths.s Physics += #Physics.ObjectA.EdgeStart.x Physics

            $scoreboard players operation #Physics.ContactPoint.y Physics *= #Physics.ThisObject Physics.Object.Axis.$(ObjectAxis).y
            scoreboard players operation #Physics.ContactPoint.y Physics /= #Physics.Constants.1000 Physics
            scoreboard players operation #Physics.ContactPoint.y Physics += #Physics.ObjectA.EdgeStart.y Physics

            $scoreboard players operation #Physics.ContactPoint.z Physics *= #Physics.ThisObject Physics.Object.Axis.$(ObjectAxis).z
            scoreboard players operation #Physics.ContactPoint.z Physics /= #Physics.Constants.1000 Physics
            scoreboard players operation #Physics.ContactPoint.z Physics += #Physics.ObjectA.EdgeStart.z Physics

            # Point on EdgeB & Get average
            # (Important): The ObjectB axis only goes along the y direction, so I can just add the EdgeStart for the other components and then divide by 2.
            scoreboard players operation #Physics.ContactPoint.y Physics += #Physics.Maths.Value2 Physics
            execute store result storage physics:temp data.NewContact.ContactPoint[0] int 0.5 run scoreboard players operation #Physics.Maths.s Physics += #Physics.ObjectB.EdgeStart.x Physics
            execute store result storage physics:temp data.NewContact.ContactPoint[1] int 0.5 run scoreboard players operation #Physics.ContactPoint.y Physics += #Physics.ObjectB.EdgeStart.y Physics
            execute store result storage physics:temp data.NewContact.ContactPoint[2] int 0.5 run scoreboard players operation #Physics.ContactPoint.z Physics += #Physics.ObjectB.EdgeStart.z Physics

    # Contact Normal
    # (Important): For edge-edge collisions, the contact normal is the cross product, but it potentially needs to be inverted.
    # (Important): Because the block's y axis only has its y component set, the cross product has an y component of 0.
    # (Important): The contact normal scores are also used for accumulation later.
    $execute if score #Physics.InvertValues Physics matches 0 store result storage physics:temp data.NewContact.ContactNormal[0] int 1 run scoreboard players operation #Physics.ContactNormal.x Physics = #Physics.CrossProductAxis.y$(ObjectAxis).x Physics
    execute store result score #Physics.ContactNormal.y Physics run data modify storage physics:temp data.NewContact.ContactNormal[1] set value 0
    $execute if score #Physics.InvertValues Physics matches 0 store result storage physics:temp data.NewContact.ContactNormal[2] int 1 run scoreboard players operation #Physics.ContactNormal.z Physics = #Physics.CrossProductAxis.y$(ObjectAxis).z Physics

    # Separating Velocity
    # (Important): The separating velocity is the dot product between the contact point's relative velocity and the contact normal. The relative velocity is the cross product between the angular velocity and the contact point (relative to the object's center) that's added together with the object's linear velocity.
        # Calculate relative contact point
        execute store result score #Physics.PointVelocity.z Physics run scoreboard players operation #Physics.Maths.s Physics -= #Physics.ThisObject Physics.Object.Pos.x
        execute store result score #Physics.PointVelocity.x Physics run scoreboard players operation #Physics.ContactPoint.y Physics -= #Physics.ThisObject Physics.Object.Pos.y
        execute store result score #Physics.PointVelocity.y Physics run scoreboard players operation #Physics.ContactPoint.z Physics -= #Physics.ThisObject Physics.Object.Pos.z

        # Calculate cross product between angular velocity and relative contact point
        # (Important): I overwrite the contact point scores here, as I don't need them anymore after this.
        # (Important): Because the contact normal's y component is 0, I could skip some calculations for SeparatingVelocity, but I need all 3 ContactVelocity values for contact resolution (tangential impulses).
        # (Important): I messed up the order (relativeContactPoint x angularVelocity instead of angularVelocity x relativeContactPoint). To accomodate for that without spending hours rewriting it, I divide by -1000 instead of 1000.
        # (Important): I changed ContactVelocity to be B - A, so that the separating velocity immediately has the correct sign. Because of this, the PointVelocity divisions are inverted again. So regular 1000 instead of -1000.
        scoreboard players operation #Physics.PointVelocity.x Physics *= #Physics.ThisObject Physics.Object.AngularVelocity.z
        scoreboard players operation #Physics.ContactPoint.z Physics *= #Physics.ThisObject Physics.Object.AngularVelocity.y
        scoreboard players operation #Physics.PointVelocity.x Physics -= #Physics.ContactPoint.z Physics
        scoreboard players operation #Physics.PointVelocity.x Physics /= #Physics.Constants.1000 Physics

        scoreboard players operation #Physics.PointVelocity.y Physics *= #Physics.ThisObject Physics.Object.AngularVelocity.x
        scoreboard players operation #Physics.Maths.s Physics *= #Physics.ThisObject Physics.Object.AngularVelocity.z
        scoreboard players operation #Physics.PointVelocity.y Physics -= #Physics.Maths.s Physics
        scoreboard players operation #Physics.PointVelocity.y Physics /= #Physics.Constants.1000 Physics

        scoreboard players operation #Physics.PointVelocity.z Physics *= #Physics.ThisObject Physics.Object.AngularVelocity.y
        scoreboard players operation #Physics.ContactPoint.y Physics *= #Physics.ThisObject Physics.Object.AngularVelocity.x
        scoreboard players operation #Physics.PointVelocity.z Physics -= #Physics.ContactPoint.y Physics
        scoreboard players operation #Physics.PointVelocity.z Physics /= #Physics.Constants.1000 Physics

        # Subtract velocity from acceleration along contact normal
        # (Important): Normally you just subtract it from SeparatingVelocity so that ContactVelocity remains intact (the tangents need to be untouched!), but if I subtract the projection from both, then I don't have to repeatedly do that during each iteration of resolution.
        # (Important): I project the VelocityFromAcceleration (currently only gravity) onto the contactNormal. Then I multiply this scalar with the ContactNormal, and subtract this new vector from the ContactVelocity. This means the SeparatingVelocity will already be adjusted once it's calculated, and I don't have to apply the projection every time it resolves a contact.
        # (Important): ContactVelocity is B - A. Because of this, the SubtractVector is added instead of subtracted.
        # ...

        # Add the linear velocity to obtain the relative velocity of the contact point
        # (Important): ContactVelocity is B - A, which is why I subtract the linear velocity instead of add it.
        execute store result storage physics:temp data.NewContact.ContactVelocity[0] int 1 run scoreboard players operation #Physics.PointVelocity.x Physics -= #Physics.ThisObject Physics.Object.Velocity.x
        execute store result storage physics:temp data.NewContact.ContactVelocity[1] int 1 run scoreboard players operation #Physics.PointVelocity.y Physics -= #Physics.ThisObject Physics.Object.Velocity.y
        execute store result storage physics:temp data.NewContact.ContactVelocity[2] int 1 run scoreboard players operation #Physics.PointVelocity.z Physics -= #Physics.ThisObject Physics.Object.Velocity.z

        # Calculate the relative velocity's dot product with the contact normal to get the separation velocity (single number, not a vector) and store it
        # (Important): Because the block's y axis component is 1, the contact normal's y component is 0. So this is simplified.
        scoreboard players operation #Physics.PointVelocity.x Physics *= #Physics.ContactNormal.x Physics
        scoreboard players operation #Physics.PointVelocity.z Physics *= #Physics.ContactNormal.z Physics

        scoreboard players operation #Physics.PointVelocity.x Physics += #Physics.PointVelocity.z Physics
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
