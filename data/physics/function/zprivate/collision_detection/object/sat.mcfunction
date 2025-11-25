# (VERY IMPORTANT): Apparently, blindly using the axis of minimum overlap is not correct, and could lead to point-face contacts being detected where not a single corner intersects. After implementing resolution, check how much of a problem this is. To fix, either verify the proposed contact somehow, or use Ian Millington's method that doesn't use the axis of min overlap but instead checks every combination. Whatever is faster.

# (VERY IMPORTANT): When I implement object-object contact accumulation, I need to remember that not all projections are properly scaled (some are still 1000x). But in check_corner_min (for point-face), it scales two projections instead of 1 (like in check_corner_max). To avoid complexity, it's probably best to just scale everything regardless. How is it done in edge-edge? Is everything scaled there, or just 1-2? Maybe I could scale both in check_corner_max too (point-face) and then use a score distinction to... argh, but that would be a function call, which is more expensive than just scaling it.
# => Scale all corner projections directly in *this* function, instead of only scaling the min/max.
# (Note to the above): Currently, check_corner_min is broken because I *don't* scale two corners, only one. "If corner2 is the min, corner5 is the one I'm looking for. Run function with corner 5 as a macro", but corner5 isn't scaled down. But because I'll need to change the stuff anyway, I chose not to fix it for now.
# (Additional note to the above): Probably do this instead: Don't scale the values during the SAT, but DO scale all the cornerpoints along the respective axis (e.g. this_axis_x), then keep track of which of these are scaled. But always scale *ALL* points for any given axis, don't make it confusing.



# (ACCUMULATION NOTE FOR OBJECT-OBJECT): During object-object accumulation, I'll need to compare the MaxPenetrationDepth of the current objectB with the PenetrationDepth to see if it needs to be updated. In new_contact, it can just assume it's the Max, because there's only one contact.














# Setup (Precalculations)
execute if score #Physics.SetupDone Physics matches 0 run function physics:zprivate/collision_detection/object/setup

# Perform the Separating Axes Theorem to get whether there's a collision, the depth of the collision and what kind it is (Edge-Edge, Point-Face)
    # Check the different axes
    # (Important): This function is executed as ObjectB aka "Other"
    # (Important): I project the relative coordinates of the cornerpoints, so I only have to project 4 corners (The other 4 are sign-flipped). Then I project the center coordinate of the object and add that to the 8 corner projections. The mirror pairs are 0/7, 1/6, 2/5, 3/4.
    # (Important): I need every corner's CornerPosRelative for both objects for every axis I project them onto. But because there are early-outs, I DON'T use the "execute store" trick here.
    # (Important): In the world collision precalculations, I scaled down the individual corner projections directly. There it made sense, as it was a 1-time thing and avoided duplicate operations. But here, I have early-outs, so any extra work I do at the start may never be used. So I only scale down the min/max until I actually need the corner projections themselves for contact generation.
    # (Important): This overwrites the cross product axis scores. But it's not a problem, as those old ones are not used after that point.
    # (Important): In order to prevent the world cross product axis and its projections from getting overwritten, I use CrossProductAxis here. These always refer to cross product axes between two objects, instead of an object and a regular block.
        # x_this
            # Projection: This (Precalculated in integration)

            # Projection: Other
                # Corner 0
                scoreboard players operation #Physics.Projection.OtherObjectCorner0.ObjectAxis.x Physics = @s Physics.Object.CornerPosRelative.0.x
                scoreboard players operation #Physics.Projection.OtherObjectCorner0.ObjectAxis.x Physics *= #Physics.ThisObject Physics.Object.Axis.x.x

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.0.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.ThisObject Physics.Object.Axis.x.y
                scoreboard players operation #Physics.Projection.OtherObjectCorner0.ObjectAxis.x Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.0.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.ThisObject Physics.Object.Axis.x.z
                execute store result score #Physics.Projection.OtherObjectCorner7.ObjectAxis.x Physics store result score #Physics.Projection.OtherObject.ObjectAxis.x.Max Physics run scoreboard players operation #Physics.Projection.OtherObjectCorner0.ObjectAxis.x Physics += #Physics.Maths.Value1 Physics

                # Corner 1
                scoreboard players operation #Physics.Projection.OtherObjectCorner1.ObjectAxis.x Physics = @s Physics.Object.CornerPosRelative.1.x
                scoreboard players operation #Physics.Projection.OtherObjectCorner1.ObjectAxis.x Physics *= #Physics.ThisObject Physics.Object.Axis.x.x

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.1.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.ThisObject Physics.Object.Axis.x.y
                scoreboard players operation #Physics.Projection.OtherObjectCorner1.ObjectAxis.x Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.1.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.ThisObject Physics.Object.Axis.x.z
                execute store result score #Physics.Projection.OtherObjectCorner6.ObjectAxis.x Physics run scoreboard players operation #Physics.Projection.OtherObjectCorner1.ObjectAxis.x Physics += #Physics.Maths.Value1 Physics

                # Corner 2
                scoreboard players operation #Physics.Projection.OtherObjectCorner2.ObjectAxis.x Physics = @s Physics.Object.CornerPosRelative.2.x
                scoreboard players operation #Physics.Projection.OtherObjectCorner2.ObjectAxis.x Physics *= #Physics.ThisObject Physics.Object.Axis.x.x

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.2.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.ThisObject Physics.Object.Axis.x.y
                scoreboard players operation #Physics.Projection.OtherObjectCorner2.ObjectAxis.x Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.2.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.ThisObject Physics.Object.Axis.x.z
                execute store result score #Physics.Projection.OtherObjectCorner5.ObjectAxis.x Physics run scoreboard players operation #Physics.Projection.OtherObjectCorner2.ObjectAxis.x Physics += #Physics.Maths.Value1 Physics

                # Corner 3
                scoreboard players operation #Physics.Projection.OtherObjectCorner3.ObjectAxis.x Physics = @s Physics.Object.CornerPosRelative.3.x
                scoreboard players operation #Physics.Projection.OtherObjectCorner3.ObjectAxis.x Physics *= #Physics.ThisObject Physics.Object.Axis.x.x

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.3.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.ThisObject Physics.Object.Axis.x.y
                scoreboard players operation #Physics.Projection.OtherObjectCorner3.ObjectAxis.x Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.3.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.ThisObject Physics.Object.Axis.x.z
                execute store result score #Physics.Projection.OtherObjectCorner4.ObjectAxis.x Physics run scoreboard players operation #Physics.Projection.OtherObjectCorner3.ObjectAxis.x Physics += #Physics.Maths.Value1 Physics

                # Corner 4
                scoreboard players operation #Physics.Projection.OtherObjectCorner4.ObjectAxis.x Physics *= #Physics.Constants.-1 Physics

                # Corner 5
                scoreboard players operation #Physics.Projection.OtherObjectCorner5.ObjectAxis.x Physics *= #Physics.Constants.-1 Physics

                # Corner 6
                scoreboard players operation #Physics.Projection.OtherObjectCorner6.ObjectAxis.x Physics *= #Physics.Constants.-1 Physics

                # Corner 7
                scoreboard players operation #Physics.Projection.OtherObjectCorner7.ObjectAxis.x Physics *= #Physics.Constants.-1 Physics

                # Find min and max (relative)
                execute if score #Physics.Projection.OtherObjectCorner1.ObjectAxis.x Physics > #Physics.Projection.OtherObject.ObjectAxis.x.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.ObjectAxis.x.Max Physics = #Physics.Projection.OtherObjectCorner1.ObjectAxis.x Physics
                execute if score #Physics.Projection.OtherObjectCorner2.ObjectAxis.x Physics > #Physics.Projection.OtherObject.ObjectAxis.x.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.ObjectAxis.x.Max Physics = #Physics.Projection.OtherObjectCorner2.ObjectAxis.x Physics
                execute if score #Physics.Projection.OtherObjectCorner3.ObjectAxis.x Physics > #Physics.Projection.OtherObject.ObjectAxis.x.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.ObjectAxis.x.Max Physics = #Physics.Projection.OtherObjectCorner3.ObjectAxis.x Physics
                execute if score #Physics.Projection.OtherObjectCorner4.ObjectAxis.x Physics > #Physics.Projection.OtherObject.ObjectAxis.x.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.ObjectAxis.x.Max Physics = #Physics.Projection.OtherObjectCorner4.ObjectAxis.x Physics
                execute if score #Physics.Projection.OtherObjectCorner5.ObjectAxis.x Physics > #Physics.Projection.OtherObject.ObjectAxis.x.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.ObjectAxis.x.Max Physics = #Physics.Projection.OtherObjectCorner5.ObjectAxis.x Physics
                execute if score #Physics.Projection.OtherObjectCorner6.ObjectAxis.x Physics > #Physics.Projection.OtherObject.ObjectAxis.x.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.ObjectAxis.x.Max Physics = #Physics.Projection.OtherObjectCorner6.ObjectAxis.x Physics
                execute if score #Physics.Projection.OtherObjectCorner7.ObjectAxis.x Physics > #Physics.Projection.OtherObject.ObjectAxis.x.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.ObjectAxis.x.Max Physics = #Physics.Projection.OtherObjectCorner7.ObjectAxis.x Physics
                execute store result score #Physics.Projection.OtherObject.ObjectAxis.x.Min Physics run scoreboard players operation #Physics.Projection.OtherObject.ObjectAxis.x.Max Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.OtherObject.ObjectAxis.x.Min Physics *= #Physics.Constants.-1 Physics

                # Turn the projections and the min/max global by projecting the center point onto the same axis and adding it
                scoreboard players operation #Physics.Projection.OtherObjectCenter.ObjectAxis.x Physics = @s Physics.Object.Pos.x
                scoreboard players operation #Physics.Projection.OtherObjectCenter.ObjectAxis.x Physics *= #Physics.ThisObject Physics.Object.Axis.x.x

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.Pos.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.ThisObject Physics.Object.Axis.x.y
                scoreboard players operation #Physics.Projection.OtherObjectCenter.ObjectAxis.x Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.Pos.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.ThisObject Physics.Object.Axis.x.z
                scoreboard players operation #Physics.Projection.OtherObjectCenter.ObjectAxis.x Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Projection.OtherObjectCenter.ObjectAxis.x Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.OtherObject.ObjectAxis.x.Min Physics += #Physics.Projection.OtherObjectCenter.ObjectAxis.x Physics
                scoreboard players operation #Physics.Projection.OtherObject.ObjectAxis.x.Max Physics += #Physics.Projection.OtherObjectCenter.ObjectAxis.x Physics

            # Overlap check
            execute unless score #Physics.ThisObject Physics.Object.ProjectionOwnAxis.x.Min <= #Physics.Projection.OtherObject.ObjectAxis.x.Max Physics run return 0
            execute unless score #Physics.Projection.OtherObject.ObjectAxis.x.Min Physics <= #Physics.ThisObject Physics.Object.ProjectionOwnAxis.x.Max run return 0

        # y_this
            # Projection: This (Precalculated in integration)

            # Projection: Other
                # Corner 0
                scoreboard players operation #Physics.Projection.OtherObjectCorner0.ObjectAxis.y Physics = @s Physics.Object.CornerPosRelative.0.x
                scoreboard players operation #Physics.Projection.OtherObjectCorner0.ObjectAxis.y Physics *= #Physics.ThisObject Physics.Object.Axis.y.x

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.0.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.ThisObject Physics.Object.Axis.y.y
                scoreboard players operation #Physics.Projection.OtherObjectCorner0.ObjectAxis.y Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.0.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.ThisObject Physics.Object.Axis.y.z
                execute store result score #Physics.Projection.OtherObjectCorner7.ObjectAxis.y Physics store result score #Physics.Projection.OtherObject.ObjectAxis.y.Max Physics run scoreboard players operation #Physics.Projection.OtherObjectCorner0.ObjectAxis.y Physics += #Physics.Maths.Value1 Physics

                # Corner 1
                scoreboard players operation #Physics.Projection.OtherObjectCorner1.ObjectAxis.y Physics = @s Physics.Object.CornerPosRelative.1.x
                scoreboard players operation #Physics.Projection.OtherObjectCorner1.ObjectAxis.y Physics *= #Physics.ThisObject Physics.Object.Axis.y.x

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.1.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.ThisObject Physics.Object.Axis.y.y
                scoreboard players operation #Physics.Projection.OtherObjectCorner1.ObjectAxis.y Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.1.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.ThisObject Physics.Object.Axis.y.z
                execute store result score #Physics.Projection.OtherObjectCorner6.ObjectAxis.y Physics run scoreboard players operation #Physics.Projection.OtherObjectCorner1.ObjectAxis.y Physics += #Physics.Maths.Value1 Physics

                # Corner 2
                scoreboard players operation #Physics.Projection.OtherObjectCorner2.ObjectAxis.y Physics = @s Physics.Object.CornerPosRelative.2.x
                scoreboard players operation #Physics.Projection.OtherObjectCorner2.ObjectAxis.y Physics *= #Physics.ThisObject Physics.Object.Axis.y.x

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.2.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.ThisObject Physics.Object.Axis.y.y
                scoreboard players operation #Physics.Projection.OtherObjectCorner2.ObjectAxis.y Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.2.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.ThisObject Physics.Object.Axis.y.z
                execute store result score #Physics.Projection.OtherObjectCorner5.ObjectAxis.y Physics run scoreboard players operation #Physics.Projection.OtherObjectCorner2.ObjectAxis.y Physics += #Physics.Maths.Value1 Physics

                # Corner 3
                scoreboard players operation #Physics.Projection.OtherObjectCorner3.ObjectAxis.y Physics = @s Physics.Object.CornerPosRelative.3.x
                scoreboard players operation #Physics.Projection.OtherObjectCorner3.ObjectAxis.y Physics *= #Physics.ThisObject Physics.Object.Axis.y.x

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.3.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.ThisObject Physics.Object.Axis.y.y
                scoreboard players operation #Physics.Projection.OtherObjectCorner3.ObjectAxis.y Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.3.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.ThisObject Physics.Object.Axis.y.z
                execute store result score #Physics.Projection.OtherObjectCorner4.ObjectAxis.y Physics run scoreboard players operation #Physics.Projection.OtherObjectCorner3.ObjectAxis.y Physics += #Physics.Maths.Value1 Physics

                # Corner 4
                scoreboard players operation #Physics.Projection.OtherObjectCorner4.ObjectAxis.y Physics *= #Physics.Constants.-1 Physics

                # Corner 5
                scoreboard players operation #Physics.Projection.OtherObjectCorner5.ObjectAxis.y Physics *= #Physics.Constants.-1 Physics

                # Corner 6
                scoreboard players operation #Physics.Projection.OtherObjectCorner6.ObjectAxis.y Physics *= #Physics.Constants.-1 Physics

                # Corner 7
                scoreboard players operation #Physics.Projection.OtherObjectCorner7.ObjectAxis.y Physics *= #Physics.Constants.-1 Physics

                # Find min and max (relative)
                execute if score #Physics.Projection.OtherObjectCorner1.ObjectAxis.y Physics > #Physics.Projection.OtherObject.ObjectAxis.y.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.ObjectAxis.y.Max Physics = #Physics.Projection.OtherObjectCorner1.ObjectAxis.y Physics
                execute if score #Physics.Projection.OtherObjectCorner2.ObjectAxis.y Physics > #Physics.Projection.OtherObject.ObjectAxis.y.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.ObjectAxis.y.Max Physics = #Physics.Projection.OtherObjectCorner2.ObjectAxis.y Physics
                execute if score #Physics.Projection.OtherObjectCorner3.ObjectAxis.y Physics > #Physics.Projection.OtherObject.ObjectAxis.y.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.ObjectAxis.y.Max Physics = #Physics.Projection.OtherObjectCorner3.ObjectAxis.y Physics
                execute if score #Physics.Projection.OtherObjectCorner4.ObjectAxis.y Physics > #Physics.Projection.OtherObject.ObjectAxis.y.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.ObjectAxis.y.Max Physics = #Physics.Projection.OtherObjectCorner4.ObjectAxis.y Physics
                execute if score #Physics.Projection.OtherObjectCorner5.ObjectAxis.y Physics > #Physics.Projection.OtherObject.ObjectAxis.y.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.ObjectAxis.y.Max Physics = #Physics.Projection.OtherObjectCorner5.ObjectAxis.y Physics
                execute if score #Physics.Projection.OtherObjectCorner6.ObjectAxis.y Physics > #Physics.Projection.OtherObject.ObjectAxis.y.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.ObjectAxis.y.Max Physics = #Physics.Projection.OtherObjectCorner6.ObjectAxis.y Physics
                execute if score #Physics.Projection.OtherObjectCorner7.ObjectAxis.y Physics > #Physics.Projection.OtherObject.ObjectAxis.y.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.ObjectAxis.y.Max Physics = #Physics.Projection.OtherObjectCorner7.ObjectAxis.y Physics
                execute store result score #Physics.Projection.OtherObject.ObjectAxis.y.Min Physics run scoreboard players operation #Physics.Projection.OtherObject.ObjectAxis.y.Max Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.OtherObject.ObjectAxis.y.Min Physics *= #Physics.Constants.-1 Physics

                # Turn the projections and the min/max global by projecting the center point onto the same axis and adding it
                scoreboard players operation #Physics.Projection.OtherObjectCenter.ObjectAxis.y Physics = @s Physics.Object.Pos.x
                scoreboard players operation #Physics.Projection.OtherObjectCenter.ObjectAxis.y Physics *= #Physics.ThisObject Physics.Object.Axis.y.x

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.Pos.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.ThisObject Physics.Object.Axis.y.y
                scoreboard players operation #Physics.Projection.OtherObjectCenter.ObjectAxis.y Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.Pos.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.ThisObject Physics.Object.Axis.y.z
                scoreboard players operation #Physics.Projection.OtherObjectCenter.ObjectAxis.y Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Projection.OtherObjectCenter.ObjectAxis.y Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.OtherObject.ObjectAxis.y.Min Physics += #Physics.Projection.OtherObjectCenter.ObjectAxis.y Physics
                scoreboard players operation #Physics.Projection.OtherObject.ObjectAxis.y.Max Physics += #Physics.Projection.OtherObjectCenter.ObjectAxis.y Physics

            # Overlap check
            execute unless score #Physics.ThisObject Physics.Object.ProjectionOwnAxis.y.Min <= #Physics.Projection.OtherObject.ObjectAxis.y.Max Physics run return 0
            execute unless score #Physics.Projection.OtherObject.ObjectAxis.y.Min Physics <= #Physics.ThisObject Physics.Object.ProjectionOwnAxis.y.Max run return 0

        # z_this
            # Projection: This (Precalculated in integration)

            # Projection: Other
                # Corner 0
                scoreboard players operation #Physics.Projection.OtherObjectCorner0.ObjectAxis.z Physics = @s Physics.Object.CornerPosRelative.0.x
                scoreboard players operation #Physics.Projection.OtherObjectCorner0.ObjectAxis.z Physics *= #Physics.ThisObject Physics.Object.Axis.z.x

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.0.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.ThisObject Physics.Object.Axis.z.y
                scoreboard players operation #Physics.Projection.OtherObjectCorner0.ObjectAxis.z Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.0.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.ThisObject Physics.Object.Axis.z.z
                execute store result score #Physics.Projection.OtherObjectCorner7.ObjectAxis.z Physics store result score #Physics.Projection.OtherObject.ObjectAxis.z.Max Physics run scoreboard players operation #Physics.Projection.OtherObjectCorner0.ObjectAxis.z Physics += #Physics.Maths.Value1 Physics

                # Corner 1
                scoreboard players operation #Physics.Projection.OtherObjectCorner1.ObjectAxis.z Physics = @s Physics.Object.CornerPosRelative.1.x
                scoreboard players operation #Physics.Projection.OtherObjectCorner1.ObjectAxis.z Physics *= #Physics.ThisObject Physics.Object.Axis.z.x

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.1.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.ThisObject Physics.Object.Axis.z.y
                scoreboard players operation #Physics.Projection.OtherObjectCorner1.ObjectAxis.z Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.1.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.ThisObject Physics.Object.Axis.z.z
                execute store result score #Physics.Projection.OtherObjectCorner6.ObjectAxis.z Physics run scoreboard players operation #Physics.Projection.OtherObjectCorner1.ObjectAxis.z Physics += #Physics.Maths.Value1 Physics

                # Corner 2
                scoreboard players operation #Physics.Projection.OtherObjectCorner2.ObjectAxis.z Physics = @s Physics.Object.CornerPosRelative.2.x
                scoreboard players operation #Physics.Projection.OtherObjectCorner2.ObjectAxis.z Physics *= #Physics.ThisObject Physics.Object.Axis.z.x

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.2.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.ThisObject Physics.Object.Axis.z.y
                scoreboard players operation #Physics.Projection.OtherObjectCorner2.ObjectAxis.z Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.2.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.ThisObject Physics.Object.Axis.z.z
                execute store result score #Physics.Projection.OtherObjectCorner5.ObjectAxis.z Physics run scoreboard players operation #Physics.Projection.OtherObjectCorner2.ObjectAxis.z Physics += #Physics.Maths.Value1 Physics

                # Corner 3
                scoreboard players operation #Physics.Projection.OtherObjectCorner3.ObjectAxis.z Physics = @s Physics.Object.CornerPosRelative.3.x
                scoreboard players operation #Physics.Projection.OtherObjectCorner3.ObjectAxis.z Physics *= #Physics.ThisObject Physics.Object.Axis.z.x

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.3.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.ThisObject Physics.Object.Axis.z.y
                scoreboard players operation #Physics.Projection.OtherObjectCorner3.ObjectAxis.z Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.3.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.ThisObject Physics.Object.Axis.z.z
                execute store result score #Physics.Projection.OtherObjectCorner4.ObjectAxis.z Physics run scoreboard players operation #Physics.Projection.OtherObjectCorner3.ObjectAxis.z Physics += #Physics.Maths.Value1 Physics

                # Corner 4
                scoreboard players operation #Physics.Projection.OtherObjectCorner4.ObjectAxis.z Physics *= #Physics.Constants.-1 Physics

                # Corner 5
                scoreboard players operation #Physics.Projection.OtherObjectCorner5.ObjectAxis.z Physics *= #Physics.Constants.-1 Physics

                # Corner 6
                scoreboard players operation #Physics.Projection.OtherObjectCorner6.ObjectAxis.z Physics *= #Physics.Constants.-1 Physics

                # Corner 7
                scoreboard players operation #Physics.Projection.OtherObjectCorner7.ObjectAxis.z Physics *= #Physics.Constants.-1 Physics

                # Find min and max (relative)
                execute if score #Physics.Projection.OtherObjectCorner1.ObjectAxis.z Physics > #Physics.Projection.OtherObject.ObjectAxis.z.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.ObjectAxis.z.Max Physics = #Physics.Projection.OtherObjectCorner1.ObjectAxis.z Physics
                execute if score #Physics.Projection.OtherObjectCorner2.ObjectAxis.z Physics > #Physics.Projection.OtherObject.ObjectAxis.z.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.ObjectAxis.z.Max Physics = #Physics.Projection.OtherObjectCorner2.ObjectAxis.z Physics
                execute if score #Physics.Projection.OtherObjectCorner3.ObjectAxis.z Physics > #Physics.Projection.OtherObject.ObjectAxis.z.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.ObjectAxis.z.Max Physics = #Physics.Projection.OtherObjectCorner3.ObjectAxis.z Physics
                execute if score #Physics.Projection.OtherObjectCorner4.ObjectAxis.z Physics > #Physics.Projection.OtherObject.ObjectAxis.z.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.ObjectAxis.z.Max Physics = #Physics.Projection.OtherObjectCorner4.ObjectAxis.z Physics
                execute if score #Physics.Projection.OtherObjectCorner5.ObjectAxis.z Physics > #Physics.Projection.OtherObject.ObjectAxis.z.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.ObjectAxis.z.Max Physics = #Physics.Projection.OtherObjectCorner5.ObjectAxis.z Physics
                execute if score #Physics.Projection.OtherObjectCorner6.ObjectAxis.z Physics > #Physics.Projection.OtherObject.ObjectAxis.z.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.ObjectAxis.z.Max Physics = #Physics.Projection.OtherObjectCorner6.ObjectAxis.z Physics
                execute if score #Physics.Projection.OtherObjectCorner7.ObjectAxis.z Physics > #Physics.Projection.OtherObject.ObjectAxis.z.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.ObjectAxis.z.Max Physics = #Physics.Projection.OtherObjectCorner7.ObjectAxis.z Physics
                execute store result score #Physics.Projection.OtherObject.ObjectAxis.z.Min Physics run scoreboard players operation #Physics.Projection.OtherObject.ObjectAxis.z.Max Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.OtherObject.ObjectAxis.z.Min Physics *= #Physics.Constants.-1 Physics

                # Turn the projections and the min/max global by projecting the center point onto the same axis and adding it
                scoreboard players operation #Physics.Projection.OtherObjectCenter.ObjectAxis.z Physics = @s Physics.Object.Pos.x
                scoreboard players operation #Physics.Projection.OtherObjectCenter.ObjectAxis.z Physics *= #Physics.ThisObject Physics.Object.Axis.z.x

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.Pos.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.ThisObject Physics.Object.Axis.z.y
                scoreboard players operation #Physics.Projection.OtherObjectCenter.ObjectAxis.z Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.Pos.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.ThisObject Physics.Object.Axis.z.z
                scoreboard players operation #Physics.Projection.OtherObjectCenter.ObjectAxis.z Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Projection.OtherObjectCenter.ObjectAxis.z Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.OtherObject.ObjectAxis.z.Min Physics += #Physics.Projection.OtherObjectCenter.ObjectAxis.z Physics
                scoreboard players operation #Physics.Projection.OtherObject.ObjectAxis.z.Max Physics += #Physics.Projection.OtherObjectCenter.ObjectAxis.z Physics

            # Overlap check
            execute unless score #Physics.ThisObject Physics.Object.ProjectionOwnAxis.z.Min <= #Physics.Projection.OtherObject.ObjectAxis.z.Max Physics run return 0
            execute unless score #Physics.Projection.OtherObject.ObjectAxis.z.Min Physics <= #Physics.ThisObject Physics.Object.ProjectionOwnAxis.z.Max run return 0

        # x_other
            # Projection: This
                # Corner 0
                scoreboard players operation #Physics.Projection.ObjectCorner0.OtherObjectAxis.x Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.0.x
                scoreboard players operation #Physics.Projection.ObjectCorner0.OtherObjectAxis.x Physics *= @s Physics.Object.Axis.x.x

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.0.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.x.y
                scoreboard players operation #Physics.Projection.ObjectCorner0.OtherObjectAxis.x Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.0.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.x.z
                execute store result score #Physics.Projection.ObjectCorner7.OtherObjectAxis.x Physics store result score #Physics.Projection.Object.OtherObjectAxis.x.Max Physics run scoreboard players operation #Physics.Projection.ObjectCorner0.OtherObjectAxis.x Physics += #Physics.Maths.Value1 Physics

                # Corner 1
                scoreboard players operation #Physics.Projection.ObjectCorner1.OtherObjectAxis.x Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.1.x
                scoreboard players operation #Physics.Projection.ObjectCorner1.OtherObjectAxis.x Physics *= @s Physics.Object.Axis.x.x

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.1.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.x.y
                scoreboard players operation #Physics.Projection.ObjectCorner1.OtherObjectAxis.x Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.1.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.x.z
                execute store result score #Physics.Projection.ObjectCorner6.OtherObjectAxis.x Physics run scoreboard players operation #Physics.Projection.ObjectCorner1.OtherObjectAxis.x Physics += #Physics.Maths.Value1 Physics

                # Corner 2
                scoreboard players operation #Physics.Projection.ObjectCorner2.OtherObjectAxis.x Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.2.x
                scoreboard players operation #Physics.Projection.ObjectCorner2.OtherObjectAxis.x Physics *= @s Physics.Object.Axis.x.x

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.2.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.x.y
                scoreboard players operation #Physics.Projection.ObjectCorner2.OtherObjectAxis.x Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.2.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.x.z
                execute store result score #Physics.Projection.ObjectCorner5.OtherObjectAxis.x Physics run scoreboard players operation #Physics.Projection.ObjectCorner2.OtherObjectAxis.x Physics += #Physics.Maths.Value1 Physics

                # Corner 3
                scoreboard players operation #Physics.Projection.ObjectCorner3.OtherObjectAxis.x Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.3.x
                scoreboard players operation #Physics.Projection.ObjectCorner3.OtherObjectAxis.x Physics *= @s Physics.Object.Axis.x.x

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.3.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.x.y
                scoreboard players operation #Physics.Projection.ObjectCorner3.OtherObjectAxis.x Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.3.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.x.z
                execute store result score #Physics.Projection.ObjectCorner4.OtherObjectAxis.x Physics run scoreboard players operation #Physics.Projection.ObjectCorner3.OtherObjectAxis.x Physics += #Physics.Maths.Value1 Physics

                # Corner 4
                scoreboard players operation #Physics.Projection.ObjectCorner4.OtherObjectAxis.x Physics *= #Physics.Constants.-1 Physics

                # Corner 5
                scoreboard players operation #Physics.Projection.ObjectCorner5.OtherObjectAxis.x Physics *= #Physics.Constants.-1 Physics

                # Corner 6
                scoreboard players operation #Physics.Projection.ObjectCorner6.OtherObjectAxis.x Physics *= #Physics.Constants.-1 Physics

                # Corner 7
                scoreboard players operation #Physics.Projection.ObjectCorner7.OtherObjectAxis.x Physics *= #Physics.Constants.-1 Physics

                # Find min and max (relative)
                execute if score #Physics.Projection.ObjectCorner1.OtherObjectAxis.x Physics > #Physics.Projection.Object.OtherObjectAxis.x.Max Physics run scoreboard players operation #Physics.Projection.Object.OtherObjectAxis.x.Max Physics = #Physics.Projection.ObjectCorner1.OtherObjectAxis.x Physics
                execute if score #Physics.Projection.ObjectCorner2.OtherObjectAxis.x Physics > #Physics.Projection.Object.OtherObjectAxis.x.Max Physics run scoreboard players operation #Physics.Projection.Object.OtherObjectAxis.x.Max Physics = #Physics.Projection.ObjectCorner2.OtherObjectAxis.x Physics
                execute if score #Physics.Projection.ObjectCorner3.OtherObjectAxis.x Physics > #Physics.Projection.Object.OtherObjectAxis.x.Max Physics run scoreboard players operation #Physics.Projection.Object.OtherObjectAxis.x.Max Physics = #Physics.Projection.ObjectCorner3.OtherObjectAxis.x Physics
                execute if score #Physics.Projection.ObjectCorner4.OtherObjectAxis.x Physics > #Physics.Projection.Object.OtherObjectAxis.x.Max Physics run scoreboard players operation #Physics.Projection.Object.OtherObjectAxis.x.Max Physics = #Physics.Projection.ObjectCorner4.OtherObjectAxis.x Physics
                execute if score #Physics.Projection.ObjectCorner5.OtherObjectAxis.x Physics > #Physics.Projection.Object.OtherObjectAxis.x.Max Physics run scoreboard players operation #Physics.Projection.Object.OtherObjectAxis.x.Max Physics = #Physics.Projection.ObjectCorner5.OtherObjectAxis.x Physics
                execute if score #Physics.Projection.ObjectCorner6.OtherObjectAxis.x Physics > #Physics.Projection.Object.OtherObjectAxis.x.Max Physics run scoreboard players operation #Physics.Projection.Object.OtherObjectAxis.x.Max Physics = #Physics.Projection.ObjectCorner6.OtherObjectAxis.x Physics
                execute if score #Physics.Projection.ObjectCorner7.OtherObjectAxis.x Physics > #Physics.Projection.Object.OtherObjectAxis.x.Max Physics run scoreboard players operation #Physics.Projection.Object.OtherObjectAxis.x.Max Physics = #Physics.Projection.ObjectCorner7.OtherObjectAxis.x Physics
                execute store result score #Physics.Projection.Object.OtherObjectAxis.x.Min Physics run scoreboard players operation #Physics.Projection.Object.OtherObjectAxis.x.Max Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.Object.OtherObjectAxis.x.Min Physics *= #Physics.Constants.-1 Physics

                # Turn the projections and the min/max global by projecting the center point onto the same axis and adding it
                scoreboard players operation #Physics.Projection.ObjectCenter.OtherObjectAxis.x Physics = #Physics.ThisObject Physics.Object.Pos.x
                scoreboard players operation #Physics.Projection.ObjectCenter.OtherObjectAxis.x Physics *= @s Physics.Object.Axis.x.x

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Pos.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.x.y
                scoreboard players operation #Physics.Projection.ObjectCenter.OtherObjectAxis.x Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Pos.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.x.z
                scoreboard players operation #Physics.Projection.ObjectCenter.OtherObjectAxis.x Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Projection.ObjectCenter.OtherObjectAxis.x Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.Object.OtherObjectAxis.x.Min Physics += #Physics.Projection.ObjectCenter.OtherObjectAxis.x Physics
                scoreboard players operation #Physics.Projection.Object.OtherObjectAxis.x.Max Physics += #Physics.Projection.ObjectCenter.OtherObjectAxis.x Physics

            # Projection: Other (Precalculated in integration)

            # Overlap check
            execute unless score @s Physics.Object.ProjectionOwnAxis.x.Min <= #Physics.Projection.Object.OtherObjectAxis.x.Max Physics run return 0
            execute unless score #Physics.Projection.Object.OtherObjectAxis.x.Min Physics <= @s Physics.Object.ProjectionOwnAxis.x.Max run return 0

        # y_other
            # Projection: This
                # Corner 0
                scoreboard players operation #Physics.Projection.ObjectCorner0.OtherObjectAxis.y Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.0.x
                scoreboard players operation #Physics.Projection.ObjectCorner0.OtherObjectAxis.y Physics *= @s Physics.Object.Axis.y.x

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.0.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.y.y
                scoreboard players operation #Physics.Projection.ObjectCorner0.OtherObjectAxis.y Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.0.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.y.z
                execute store result score #Physics.Projection.ObjectCorner7.OtherObjectAxis.y Physics store result score #Physics.Projection.Object.OtherObjectAxis.y.Max Physics run scoreboard players operation #Physics.Projection.ObjectCorner0.OtherObjectAxis.y Physics += #Physics.Maths.Value1 Physics

                # Corner 1
                scoreboard players operation #Physics.Projection.ObjectCorner1.OtherObjectAxis.y Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.1.x
                scoreboard players operation #Physics.Projection.ObjectCorner1.OtherObjectAxis.y Physics *= @s Physics.Object.Axis.y.x

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.1.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.y.y
                scoreboard players operation #Physics.Projection.ObjectCorner1.OtherObjectAxis.y Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.1.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.y.z
                execute store result score #Physics.Projection.ObjectCorner6.OtherObjectAxis.y Physics run scoreboard players operation #Physics.Projection.ObjectCorner1.OtherObjectAxis.y Physics += #Physics.Maths.Value1 Physics

                # Corner 2
                scoreboard players operation #Physics.Projection.ObjectCorner2.OtherObjectAxis.y Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.2.x
                scoreboard players operation #Physics.Projection.ObjectCorner2.OtherObjectAxis.y Physics *= @s Physics.Object.Axis.y.x

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.2.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.y.y
                scoreboard players operation #Physics.Projection.ObjectCorner2.OtherObjectAxis.y Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.2.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.y.z
                execute store result score #Physics.Projection.ObjectCorner5.OtherObjectAxis.y Physics run scoreboard players operation #Physics.Projection.ObjectCorner2.OtherObjectAxis.y Physics += #Physics.Maths.Value1 Physics

                # Corner 3
                scoreboard players operation #Physics.Projection.ObjectCorner3.OtherObjectAxis.y Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.3.x
                scoreboard players operation #Physics.Projection.ObjectCorner3.OtherObjectAxis.y Physics *= @s Physics.Object.Axis.y.x

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.3.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.y.y
                scoreboard players operation #Physics.Projection.ObjectCorner3.OtherObjectAxis.y Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.3.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.y.z
                execute store result score #Physics.Projection.ObjectCorner4.OtherObjectAxis.y Physics run scoreboard players operation #Physics.Projection.ObjectCorner3.OtherObjectAxis.y Physics += #Physics.Maths.Value1 Physics

                # Corner 4
                scoreboard players operation #Physics.Projection.ObjectCorner4.OtherObjectAxis.y Physics *= #Physics.Constants.-1 Physics

                # Corner 5
                scoreboard players operation #Physics.Projection.ObjectCorner5.OtherObjectAxis.y Physics *= #Physics.Constants.-1 Physics

                # Corner 6
                scoreboard players operation #Physics.Projection.ObjectCorner6.OtherObjectAxis.y Physics *= #Physics.Constants.-1 Physics

                # Corner 7
                scoreboard players operation #Physics.Projection.ObjectCorner7.OtherObjectAxis.y Physics *= #Physics.Constants.-1 Physics

                # Find min and max (relative)
                execute if score #Physics.Projection.ObjectCorner1.OtherObjectAxis.y Physics > #Physics.Projection.Object.OtherObjectAxis.y.Max Physics run scoreboard players operation #Physics.Projection.Object.OtherObjectAxis.y.Max Physics = #Physics.Projection.ObjectCorner1.OtherObjectAxis.y Physics
                execute if score #Physics.Projection.ObjectCorner2.OtherObjectAxis.y Physics > #Physics.Projection.Object.OtherObjectAxis.y.Max Physics run scoreboard players operation #Physics.Projection.Object.OtherObjectAxis.y.Max Physics = #Physics.Projection.ObjectCorner2.OtherObjectAxis.y Physics
                execute if score #Physics.Projection.ObjectCorner3.OtherObjectAxis.y Physics > #Physics.Projection.Object.OtherObjectAxis.y.Max Physics run scoreboard players operation #Physics.Projection.Object.OtherObjectAxis.y.Max Physics = #Physics.Projection.ObjectCorner3.OtherObjectAxis.y Physics
                execute if score #Physics.Projection.ObjectCorner4.OtherObjectAxis.y Physics > #Physics.Projection.Object.OtherObjectAxis.y.Max Physics run scoreboard players operation #Physics.Projection.Object.OtherObjectAxis.y.Max Physics = #Physics.Projection.ObjectCorner4.OtherObjectAxis.y Physics
                execute if score #Physics.Projection.ObjectCorner5.OtherObjectAxis.y Physics > #Physics.Projection.Object.OtherObjectAxis.y.Max Physics run scoreboard players operation #Physics.Projection.Object.OtherObjectAxis.y.Max Physics = #Physics.Projection.ObjectCorner5.OtherObjectAxis.y Physics
                execute if score #Physics.Projection.ObjectCorner6.OtherObjectAxis.y Physics > #Physics.Projection.Object.OtherObjectAxis.y.Max Physics run scoreboard players operation #Physics.Projection.Object.OtherObjectAxis.y.Max Physics = #Physics.Projection.ObjectCorner6.OtherObjectAxis.y Physics
                execute if score #Physics.Projection.ObjectCorner7.OtherObjectAxis.y Physics > #Physics.Projection.Object.OtherObjectAxis.y.Max Physics run scoreboard players operation #Physics.Projection.Object.OtherObjectAxis.y.Max Physics = #Physics.Projection.ObjectCorner7.OtherObjectAxis.y Physics
                execute store result score #Physics.Projection.Object.OtherObjectAxis.y.Min Physics run scoreboard players operation #Physics.Projection.Object.OtherObjectAxis.y.Max Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.Object.OtherObjectAxis.y.Min Physics *= #Physics.Constants.-1 Physics

                # Turn the projections and the min/max global by projecting the center point onto the same axis and adding it
                scoreboard players operation #Physics.Projection.ObjectCenter.OtherObjectAxis.y Physics = #Physics.ThisObject Physics.Object.Pos.x
                scoreboard players operation #Physics.Projection.ObjectCenter.OtherObjectAxis.y Physics *= @s Physics.Object.Axis.y.x

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Pos.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.y.y
                scoreboard players operation #Physics.Projection.ObjectCenter.OtherObjectAxis.y Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Pos.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.y.z
                scoreboard players operation #Physics.Projection.ObjectCenter.OtherObjectAxis.y Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Projection.ObjectCenter.OtherObjectAxis.y Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.Object.OtherObjectAxis.y.Min Physics += #Physics.Projection.ObjectCenter.OtherObjectAxis.y Physics
                scoreboard players operation #Physics.Projection.Object.OtherObjectAxis.y.Max Physics += #Physics.Projection.ObjectCenter.OtherObjectAxis.y Physics

            # Projection: Other (Precalculated in integration)

            # Overlap check
            execute unless score @s Physics.Object.ProjectionOwnAxis.y.Min <= #Physics.Projection.Object.OtherObjectAxis.y.Max Physics run return 0
            execute unless score #Physics.Projection.Object.OtherObjectAxis.y.Min Physics <= @s Physics.Object.ProjectionOwnAxis.y.Max run return 0

        # z_other
            # Projection: This
                # Corner 0
                scoreboard players operation #Physics.Projection.ObjectCorner0.OtherObjectAxis.z Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.0.x
                scoreboard players operation #Physics.Projection.ObjectCorner0.OtherObjectAxis.z Physics *= @s Physics.Object.Axis.z.x

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.0.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.z.y
                scoreboard players operation #Physics.Projection.ObjectCorner0.OtherObjectAxis.z Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.0.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.z.z
                execute store result score #Physics.Projection.ObjectCorner7.OtherObjectAxis.z Physics store result score #Physics.Projection.Object.OtherObjectAxis.z.Max Physics run scoreboard players operation #Physics.Projection.ObjectCorner0.OtherObjectAxis.z Physics += #Physics.Maths.Value1 Physics

                # Corner 1
                scoreboard players operation #Physics.Projection.ObjectCorner1.OtherObjectAxis.z Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.1.x
                scoreboard players operation #Physics.Projection.ObjectCorner1.OtherObjectAxis.z Physics *= @s Physics.Object.Axis.z.x

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.1.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.z.y
                scoreboard players operation #Physics.Projection.ObjectCorner1.OtherObjectAxis.z Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.1.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.z.z
                execute store result score #Physics.Projection.ObjectCorner6.OtherObjectAxis.z Physics run scoreboard players operation #Physics.Projection.ObjectCorner1.OtherObjectAxis.z Physics += #Physics.Maths.Value1 Physics

                # Corner 2
                scoreboard players operation #Physics.Projection.ObjectCorner2.OtherObjectAxis.z Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.2.x
                scoreboard players operation #Physics.Projection.ObjectCorner2.OtherObjectAxis.z Physics *= @s Physics.Object.Axis.z.x

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.2.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.z.y
                scoreboard players operation #Physics.Projection.ObjectCorner2.OtherObjectAxis.z Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.2.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.z.z
                execute store result score #Physics.Projection.ObjectCorner5.OtherObjectAxis.z Physics run scoreboard players operation #Physics.Projection.ObjectCorner2.OtherObjectAxis.z Physics += #Physics.Maths.Value1 Physics

                # Corner 3
                scoreboard players operation #Physics.Projection.ObjectCorner3.OtherObjectAxis.z Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.3.x
                scoreboard players operation #Physics.Projection.ObjectCorner3.OtherObjectAxis.z Physics *= @s Physics.Object.Axis.z.x

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.3.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.z.y
                scoreboard players operation #Physics.Projection.ObjectCorner3.OtherObjectAxis.z Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.3.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.z.z
                execute store result score #Physics.Projection.ObjectCorner4.OtherObjectAxis.z Physics run scoreboard players operation #Physics.Projection.ObjectCorner3.OtherObjectAxis.z Physics += #Physics.Maths.Value1 Physics

                # Corner 4
                scoreboard players operation #Physics.Projection.ObjectCorner4.OtherObjectAxis.z Physics *= #Physics.Constants.-1 Physics

                # Corner 5
                scoreboard players operation #Physics.Projection.ObjectCorner5.OtherObjectAxis.z Physics *= #Physics.Constants.-1 Physics

                # Corner 6
                scoreboard players operation #Physics.Projection.ObjectCorner6.OtherObjectAxis.z Physics *= #Physics.Constants.-1 Physics

                # Corner 7
                scoreboard players operation #Physics.Projection.ObjectCorner7.OtherObjectAxis.z Physics *= #Physics.Constants.-1 Physics

                # Find min and max (relative)
                execute if score #Physics.Projection.ObjectCorner1.OtherObjectAxis.z Physics > #Physics.Projection.Object.OtherObjectAxis.z.Max Physics run scoreboard players operation #Physics.Projection.Object.OtherObjectAxis.z.Max Physics = #Physics.Projection.ObjectCorner1.OtherObjectAxis.z Physics
                execute if score #Physics.Projection.ObjectCorner2.OtherObjectAxis.z Physics > #Physics.Projection.Object.OtherObjectAxis.z.Max Physics run scoreboard players operation #Physics.Projection.Object.OtherObjectAxis.z.Max Physics = #Physics.Projection.ObjectCorner2.OtherObjectAxis.z Physics
                execute if score #Physics.Projection.ObjectCorner3.OtherObjectAxis.z Physics > #Physics.Projection.Object.OtherObjectAxis.z.Max Physics run scoreboard players operation #Physics.Projection.Object.OtherObjectAxis.z.Max Physics = #Physics.Projection.ObjectCorner3.OtherObjectAxis.z Physics
                execute if score #Physics.Projection.ObjectCorner4.OtherObjectAxis.z Physics > #Physics.Projection.Object.OtherObjectAxis.z.Max Physics run scoreboard players operation #Physics.Projection.Object.OtherObjectAxis.z.Max Physics = #Physics.Projection.ObjectCorner4.OtherObjectAxis.z Physics
                execute if score #Physics.Projection.ObjectCorner5.OtherObjectAxis.z Physics > #Physics.Projection.Object.OtherObjectAxis.z.Max Physics run scoreboard players operation #Physics.Projection.Object.OtherObjectAxis.z.Max Physics = #Physics.Projection.ObjectCorner5.OtherObjectAxis.z Physics
                execute if score #Physics.Projection.ObjectCorner6.OtherObjectAxis.z Physics > #Physics.Projection.Object.OtherObjectAxis.z.Max Physics run scoreboard players operation #Physics.Projection.Object.OtherObjectAxis.z.Max Physics = #Physics.Projection.ObjectCorner6.OtherObjectAxis.z Physics
                execute if score #Physics.Projection.ObjectCorner7.OtherObjectAxis.z Physics > #Physics.Projection.Object.OtherObjectAxis.z.Max Physics run scoreboard players operation #Physics.Projection.Object.OtherObjectAxis.z.Max Physics = #Physics.Projection.ObjectCorner7.OtherObjectAxis.z Physics
                execute store result score #Physics.Projection.Object.OtherObjectAxis.z.Min Physics run scoreboard players operation #Physics.Projection.Object.OtherObjectAxis.z.Max Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.Object.OtherObjectAxis.z.Min Physics *= #Physics.Constants.-1 Physics

                # Turn the projections and the min/max global by projecting the center point onto the same axis and adding it
                scoreboard players operation #Physics.Projection.ObjectCenter.OtherObjectAxis.z Physics = #Physics.ThisObject Physics.Object.Pos.x
                scoreboard players operation #Physics.Projection.ObjectCenter.OtherObjectAxis.z Physics *= @s Physics.Object.Axis.z.x

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Pos.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.z.y
                scoreboard players operation #Physics.Projection.ObjectCenter.OtherObjectAxis.z Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Pos.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.z.z
                scoreboard players operation #Physics.Projection.ObjectCenter.OtherObjectAxis.z Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Projection.ObjectCenter.OtherObjectAxis.z Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.Object.OtherObjectAxis.z.Min Physics += #Physics.Projection.ObjectCenter.OtherObjectAxis.z Physics
                scoreboard players operation #Physics.Projection.Object.OtherObjectAxis.z.Max Physics += #Physics.Projection.ObjectCenter.OtherObjectAxis.z Physics

            # Projection: Other (Precalculated in integration)

            # Overlap check
            execute unless score @s Physics.Object.ProjectionOwnAxis.z.Min <= #Physics.Projection.Object.OtherObjectAxis.z.Max Physics run return 0
            execute unless score #Physics.Projection.Object.OtherObjectAxis.z.Min Physics <= @s Physics.Object.ProjectionOwnAxis.z.Max run return 0

        # Cross Product: x_this x x_other
            # Calculation
            scoreboard players operation #Physics.CrossProductAxis.xx.x Physics = #Physics.ThisObject Physics.Object.Axis.x.y
            scoreboard players operation #Physics.CrossProductAxis.xx.x Physics *= @s Physics.Object.Axis.x.z
            scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Axis.x.z
            scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.x.y
            execute store result score #Physics.Maths.SquareRoot.Input Physics run scoreboard players operation #Physics.CrossProductAxis.xx.x Physics -= #Physics.Maths.Value1 Physics

            scoreboard players operation #Physics.CrossProductAxis.xx.y Physics = #Physics.ThisObject Physics.Object.Axis.x.z
            scoreboard players operation #Physics.CrossProductAxis.xx.y Physics *= @s Physics.Object.Axis.x.x
            scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Axis.x.x
            scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.x.z
            execute store result score #Physics.Maths.Value2 Physics run scoreboard players operation #Physics.CrossProductAxis.xx.y Physics -= #Physics.Maths.Value1 Physics

            scoreboard players operation #Physics.CrossProductAxis.xx.z Physics = #Physics.ThisObject Physics.Object.Axis.x.x
            scoreboard players operation #Physics.CrossProductAxis.xx.z Physics *= @s Physics.Object.Axis.x.y
            scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Axis.x.y
            scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.x.x
            execute store result score #Physics.Maths.Value3 Physics run scoreboard players operation #Physics.CrossProductAxis.xx.z Physics -= #Physics.Maths.Value1 Physics

            # Normalization
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics /= #Physics.Constants.1000 Physics
            scoreboard players operation #Physics.Maths.Value2 Physics /= #Physics.Constants.1000 Physics
            scoreboard players operation #Physics.Maths.Value3 Physics /= #Physics.Constants.1000 Physics

            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics *= #Physics.Maths.SquareRoot.Input Physics
            scoreboard players operation #Physics.Maths.Value2 Physics *= #Physics.Maths.Value2 Physics
            scoreboard players operation #Physics.Maths.Value3 Physics *= #Physics.Maths.Value3 Physics
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics += #Physics.Maths.Value2 Physics
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics += #Physics.Maths.Value3 Physics
            function physics:zprivate/maths/get_square_root

            scoreboard players operation #Physics.CrossProductAxis.xx.x Physics /= #Physics.Maths.SquareRoot.Output Physics
            scoreboard players operation #Physics.CrossProductAxis.xx.y Physics /= #Physics.Maths.SquareRoot.Output Physics
            scoreboard players operation #Physics.CrossProductAxis.xx.z Physics /= #Physics.Maths.SquareRoot.Output Physics

            # Projection: This
            # (Important): Because the cross product is perpendicular to this object's x axis, points along that axis have the same projection. Because of this: Corner 2 = Corner 0 / Corner 3 = Corner 1 / Corner 6 = Corner 4 / Corner 7 = Corner 5
                # Corner 0
                scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.xx Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.0.x
                scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.xx Physics *= #Physics.CrossProductAxis.xx.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.0.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.xx.y Physics
                scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.xx Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.0.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.xx.z Physics
                execute store result score #Physics.Projection.ObjectCorner5.CrossProductAxis.xx Physics store result score #Physics.Projection.Object.CrossProductAxis.xx.Max Physics run scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.xx Physics += #Physics.Maths.Value1 Physics

                # Corner 1
                scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis.xx Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.1.x
                scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis.xx Physics *= #Physics.CrossProductAxis.xx.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.1.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.xx.y Physics
                scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis.xx Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.1.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.xx.z Physics
                execute store result score #Physics.Projection.ObjectCorner4.CrossProductAxis.xx Physics run scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis.xx Physics += #Physics.Maths.Value1 Physics

                # Corner 4 (Mirrored version of 1)
                scoreboard players operation #Physics.Projection.ObjectCorner4.CrossProductAxis.xx Physics *= #Physics.Constants.-1 Physics

                # Corner 5 (Mirrored version of 0)
                scoreboard players operation #Physics.Projection.ObjectCorner5.CrossProductAxis.xx Physics *= #Physics.Constants.-1 Physics

                # Find min and max (relative)
                execute if score #Physics.Projection.ObjectCorner1.CrossProductAxis.xx Physics > #Physics.Projection.Object.CrossProductAxis.xx.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xx.Max Physics = #Physics.Projection.ObjectCorner1.CrossProductAxis.xx Physics
                execute if score #Physics.Projection.ObjectCorner4.CrossProductAxis.xx Physics > #Physics.Projection.Object.CrossProductAxis.xx.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xx.Max Physics = #Physics.Projection.ObjectCorner4.CrossProductAxis.xx Physics
                execute if score #Physics.Projection.ObjectCorner5.CrossProductAxis.xx Physics > #Physics.Projection.Object.CrossProductAxis.xx.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xx.Max Physics = #Physics.Projection.ObjectCorner5.CrossProductAxis.xx Physics
                execute store result score #Physics.Projection.Object.CrossProductAxis.xx.Min Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xx.Max Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xx.Min Physics *= #Physics.Constants.-1 Physics

                # Turn the projections and the min/max global by projecting the center point onto the same axis and adding it
                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.xx Physics = #Physics.ThisObject Physics.Object.Pos.x
                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.xx Physics *= #Physics.CrossProductAxis.xx.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Pos.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.xx.y Physics
                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.xx Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Pos.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.xx.z Physics
                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.xx Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.xx Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xx.Min Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.xx Physics
                scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xx.Max Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.xx Physics

            # Projection: Other
            # (Important): Because the cross product is perpendicular to the other object's x axis, points along that axis have the same projection. Because of this: Corner 2 = Corner 0 / Corner 3 = Corner 1 / Corner 6 = Corner 4 / Corner 7 = Corner 5
                # Corner 0
                scoreboard players operation #Physics.Projection.OtherObjectCorner0.CrossProductAxis.xx Physics = @s Physics.Object.CornerPosRelative.0.x
                scoreboard players operation #Physics.Projection.OtherObjectCorner0.CrossProductAxis.xx Physics *= #Physics.CrossProductAxis.xx.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.0.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.xx.y Physics
                scoreboard players operation #Physics.Projection.OtherObjectCorner0.CrossProductAxis.xx Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.0.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.xx.z Physics
                execute store result score #Physics.Projection.OtherObjectCorner5.CrossProductAxis.xx Physics store result score #Physics.Projection.OtherObject.CrossProductAxis.xx.Max Physics run scoreboard players operation #Physics.Projection.OtherObjectCorner0.CrossProductAxis.xx Physics += #Physics.Maths.Value1 Physics

                # Corner 1
                scoreboard players operation #Physics.Projection.OtherObjectCorner1.CrossProductAxis.xx Physics = @s Physics.Object.CornerPosRelative.1.x
                scoreboard players operation #Physics.Projection.OtherObjectCorner1.CrossProductAxis.xx Physics *= #Physics.CrossProductAxis.xx.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.1.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.xx.y Physics
                scoreboard players operation #Physics.Projection.OtherObjectCorner1.CrossProductAxis.xx Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.1.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.xx.z Physics
                execute store result score #Physics.Projection.OtherObjectCorner4.CrossProductAxis.xx Physics run scoreboard players operation #Physics.Projection.OtherObjectCorner1.CrossProductAxis.xx Physics += #Physics.Maths.Value1 Physics

                # Corner 4 (Mirrored version of 1)
                scoreboard players operation #Physics.Projection.OtherObjectCorner4.CrossProductAxis.xx Physics *= #Physics.Constants.-1 Physics

                # Corner 5 (Mirrored version of 0)
                scoreboard players operation #Physics.Projection.OtherObjectCorner5.CrossProductAxis.xx Physics *= #Physics.Constants.-1 Physics

                # Find min and max (relative)
                execute if score #Physics.Projection.OtherObjectCorner1.CrossProductAxis.xx Physics > #Physics.Projection.OtherObject.CrossProductAxis.xx.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis.xx.Max Physics = #Physics.Projection.OtherObjectCorner1.CrossProductAxis.xx Physics
                execute if score #Physics.Projection.OtherObjectCorner4.CrossProductAxis.xx Physics > #Physics.Projection.OtherObject.CrossProductAxis.xx.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis.xx.Max Physics = #Physics.Projection.OtherObjectCorner4.CrossProductAxis.xx Physics
                execute if score #Physics.Projection.OtherObjectCorner5.CrossProductAxis.xx Physics > #Physics.Projection.OtherObject.CrossProductAxis.xx.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis.xx.Max Physics = #Physics.Projection.OtherObjectCorner5.CrossProductAxis.xx Physics
                execute store result score #Physics.Projection.OtherObject.CrossProductAxis.xx.Min Physics run scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis.xx.Max Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis.xx.Min Physics *= #Physics.Constants.-1 Physics

                # Turn the projections and the min/max global by projecting the center point onto the same axis and adding it
                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis.xx Physics = @s Physics.Object.Pos.x
                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis.xx Physics *= #Physics.CrossProductAxis.xx.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.Pos.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.xx.y Physics
                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis.xx Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.Pos.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.xx.z Physics
                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis.xx Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis.xx Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis.xx.Min Physics += #Physics.Projection.OtherObjectCenter.CrossProductAxis.xx Physics
                scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis.xx.Max Physics += #Physics.Projection.OtherObjectCenter.CrossProductAxis.xx Physics

            # Overlap check
            execute unless score #Physics.Projection.Object.CrossProductAxis.xx.Min Physics <= #Physics.Projection.OtherObject.CrossProductAxis.xx.Max Physics run return 0
            execute unless score #Physics.Projection.OtherObject.CrossProductAxis.xx.Min Physics <= #Physics.Projection.Object.CrossProductAxis.xx.Max Physics run return 0

        # Cross Product: x_this x y_other
            # Calculation
            scoreboard players operation #Physics.CrossProductAxis.xy.x Physics = #Physics.ThisObject Physics.Object.Axis.x.y
            scoreboard players operation #Physics.CrossProductAxis.xy.x Physics *= @s Physics.Object.Axis.y.z
            scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Axis.x.z
            scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.y.y
            execute store result score #Physics.Maths.SquareRoot.Input Physics run scoreboard players operation #Physics.CrossProductAxis.xy.x Physics -= #Physics.Maths.Value1 Physics

            scoreboard players operation #Physics.CrossProductAxis.xy.y Physics = #Physics.ThisObject Physics.Object.Axis.x.z
            scoreboard players operation #Physics.CrossProductAxis.xy.y Physics *= @s Physics.Object.Axis.y.x
            scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Axis.x.x
            scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.y.z
            execute store result score #Physics.Maths.Value2 Physics run scoreboard players operation #Physics.CrossProductAxis.xy.y Physics -= #Physics.Maths.Value1 Physics

            scoreboard players operation #Physics.CrossProductAxis.xy.z Physics = #Physics.ThisObject Physics.Object.Axis.x.x
            scoreboard players operation #Physics.CrossProductAxis.xy.z Physics *= @s Physics.Object.Axis.y.y
            scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Axis.x.y
            scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.y.x
            execute store result score #Physics.Maths.Value3 Physics run scoreboard players operation #Physics.CrossProductAxis.xy.z Physics -= #Physics.Maths.Value1 Physics

            # Normalization
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics /= #Physics.Constants.1000 Physics
            scoreboard players operation #Physics.Maths.Value2 Physics /= #Physics.Constants.1000 Physics
            scoreboard players operation #Physics.Maths.Value3 Physics /= #Physics.Constants.1000 Physics

            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics *= #Physics.Maths.SquareRoot.Input Physics
            scoreboard players operation #Physics.Maths.Value2 Physics *= #Physics.Maths.Value2 Physics
            scoreboard players operation #Physics.Maths.Value3 Physics *= #Physics.Maths.Value3 Physics
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics += #Physics.Maths.Value2 Physics
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics += #Physics.Maths.Value3 Physics
            function physics:zprivate/maths/get_square_root

            scoreboard players operation #Physics.CrossProductAxis.xy.x Physics /= #Physics.Maths.SquareRoot.Output Physics
            scoreboard players operation #Physics.CrossProductAxis.xy.y Physics /= #Physics.Maths.SquareRoot.Output Physics
            scoreboard players operation #Physics.CrossProductAxis.xy.z Physics /= #Physics.Maths.SquareRoot.Output Physics

            # Projection: This
            # (Important): Because the cross product is perpendicular to this object's x axis, points along that axis have the same projection. Because of this: Corner 2 = Corner 0 / Corner 3 = Corner 1 / Corner 6 = Corner 4 / Corner 7 = Corner 5
                # Corner 0
                scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.xy Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.0.x
                scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.xy Physics *= #Physics.CrossProductAxis.xy.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.0.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.xy.y Physics
                scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.xy Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.0.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.xy.z Physics
                execute store result score #Physics.Projection.ObjectCorner5.CrossProductAxis.xy Physics store result score #Physics.Projection.Object.CrossProductAxis.xy.Max Physics run scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.xy Physics += #Physics.Maths.Value1 Physics

                # Corner 1
                scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis.xy Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.1.x
                scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis.xy Physics *= #Physics.CrossProductAxis.xy.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.1.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.xy.y Physics
                scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis.xy Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.1.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.xy.z Physics
                execute store result score #Physics.Projection.ObjectCorner4.CrossProductAxis.xy Physics run scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis.xy Physics += #Physics.Maths.Value1 Physics

                # Corner 4 (Mirrored version of 1)
                scoreboard players operation #Physics.Projection.ObjectCorner4.CrossProductAxis.xy Physics *= #Physics.Constants.-1 Physics

                # Corner 5 (Mirrored version of 0)
                scoreboard players operation #Physics.Projection.ObjectCorner5.CrossProductAxis.xy Physics *= #Physics.Constants.-1 Physics

                # Find min and max (relative)
                execute if score #Physics.Projection.ObjectCorner1.CrossProductAxis.xy Physics > #Physics.Projection.Object.CrossProductAxis.xy.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xy.Max Physics = #Physics.Projection.ObjectCorner1.CrossProductAxis.xy Physics
                execute if score #Physics.Projection.ObjectCorner4.CrossProductAxis.xy Physics > #Physics.Projection.Object.CrossProductAxis.xy.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xy.Max Physics = #Physics.Projection.ObjectCorner4.CrossProductAxis.xy Physics
                execute if score #Physics.Projection.ObjectCorner5.CrossProductAxis.xy Physics > #Physics.Projection.Object.CrossProductAxis.xy.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xy.Max Physics = #Physics.Projection.ObjectCorner5.CrossProductAxis.xy Physics
                execute store result score #Physics.Projection.Object.CrossProductAxis.xy.Min Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xy.Max Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xy.Min Physics *= #Physics.Constants.-1 Physics

                # Turn the projections and the min/max global by projecting the center point onto the same axis and adding it
                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.xy Physics = #Physics.ThisObject Physics.Object.Pos.x
                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.xy Physics *= #Physics.CrossProductAxis.xy.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Pos.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.xy.y Physics
                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.xy Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Pos.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.xy.z Physics
                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.xy Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.xy Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xy.Min Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.xy Physics
                scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xy.Max Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.xy Physics

            # Projection: Other
            # (Important): Because the cross product is perpendicular to the other object's y axis, points along that axis have the same projection. Because of this: Corner 4 = Corner 0 / Corner 5 = Corner 1 / Corner 6 = Corner 2 / Corner 7 = Corner 3
                # Corner 0
                scoreboard players operation #Physics.Projection.OtherObjectCorner0.CrossProductAxis.xy Physics = @s Physics.Object.CornerPosRelative.0.x
                scoreboard players operation #Physics.Projection.OtherObjectCorner0.CrossProductAxis.xy Physics *= #Physics.CrossProductAxis.xy.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.0.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.xy.y Physics
                scoreboard players operation #Physics.Projection.OtherObjectCorner0.CrossProductAxis.xy Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.0.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.xy.z Physics
                execute store result score #Physics.Projection.OtherObjectCorner3.CrossProductAxis.xy Physics store result score #Physics.Projection.OtherObject.CrossProductAxis.xy.Max Physics run scoreboard players operation #Physics.Projection.OtherObjectCorner0.CrossProductAxis.xy Physics += #Physics.Maths.Value1 Physics

                # Corner 1
                scoreboard players operation #Physics.Projection.OtherObjectCorner1.CrossProductAxis.xy Physics = @s Physics.Object.CornerPosRelative.1.x
                scoreboard players operation #Physics.Projection.OtherObjectCorner1.CrossProductAxis.xy Physics *= #Physics.CrossProductAxis.xy.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.1.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.xy.y Physics
                scoreboard players operation #Physics.Projection.OtherObjectCorner1.CrossProductAxis.xy Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.1.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.xy.z Physics
                execute store result score #Physics.Projection.OtherObjectCorner2.CrossProductAxis.xy Physics run scoreboard players operation #Physics.Projection.OtherObjectCorner1.CrossProductAxis.xy Physics += #Physics.Maths.Value1 Physics

                # Corner 2 (Mirrored version of 1)
                scoreboard players operation #Physics.Projection.OtherObjectCorner2.CrossProductAxis.xy Physics *= #Physics.Constants.-1 Physics

                # Corner 3 (Mirrored version of 0)
                scoreboard players operation #Physics.Projection.OtherObjectCorner3.CrossProductAxis.xy Physics *= #Physics.Constants.-1 Physics

                # Find min and max (relative)
                execute if score #Physics.Projection.OtherObjectCorner1.CrossProductAxis.xy Physics > #Physics.Projection.OtherObject.CrossProductAxis.xy.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis.xy.Max Physics = #Physics.Projection.OtherObjectCorner1.CrossProductAxis.xy Physics
                execute if score #Physics.Projection.OtherObjectCorner2.CrossProductAxis.xy Physics > #Physics.Projection.OtherObject.CrossProductAxis.xy.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis.xy.Max Physics = #Physics.Projection.OtherObjectCorner2.CrossProductAxis.xy Physics
                execute if score #Physics.Projection.OtherObjectCorner3.CrossProductAxis.xy Physics > #Physics.Projection.OtherObject.CrossProductAxis.xy.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis.xy.Max Physics = #Physics.Projection.OtherObjectCorner3.CrossProductAxis.xy Physics
                execute store result score #Physics.Projection.OtherObject.CrossProductAxis.xy.Min Physics run scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis.xy.Max Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis.xy.Min Physics *= #Physics.Constants.-1 Physics

                # Turn the projections and the min/max global by projecting the center point onto the same axis and adding it
                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis.xy Physics = @s Physics.Object.Pos.x
                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis.xy Physics *= #Physics.CrossProductAxis.xy.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.Pos.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.xy.y Physics
                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis.xy Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.Pos.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.xy.z Physics
                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis.xy Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis.xy Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis.xy.Min Physics += #Physics.Projection.OtherObjectCenter.CrossProductAxis.xy Physics
                scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis.xy.Max Physics += #Physics.Projection.OtherObjectCenter.CrossProductAxis.xy Physics

            # Overlap check
            execute unless score #Physics.Projection.Object.CrossProductAxis.xy.Min Physics <= #Physics.Projection.OtherObject.CrossProductAxis.xy.Max Physics run return 0
            execute unless score #Physics.Projection.OtherObject.CrossProductAxis.xy.Min Physics <= #Physics.Projection.Object.CrossProductAxis.xy.Max Physics run return 0

        # Cross Product: x_this x z_other
            # Calculation
            scoreboard players operation #Physics.CrossProductAxis.xz.x Physics = #Physics.ThisObject Physics.Object.Axis.x.y
            scoreboard players operation #Physics.CrossProductAxis.xz.x Physics *= @s Physics.Object.Axis.z.z
            scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Axis.x.z
            scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.z.y
            execute store result score #Physics.Maths.SquareRoot.Input Physics run scoreboard players operation #Physics.CrossProductAxis.xz.x Physics -= #Physics.Maths.Value1 Physics

            scoreboard players operation #Physics.CrossProductAxis.xz.y Physics = #Physics.ThisObject Physics.Object.Axis.x.z
            scoreboard players operation #Physics.CrossProductAxis.xz.y Physics *= @s Physics.Object.Axis.z.x
            scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Axis.x.x
            scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.z.z
            execute store result score #Physics.Maths.Value2 Physics run scoreboard players operation #Physics.CrossProductAxis.xz.y Physics -= #Physics.Maths.Value1 Physics

            scoreboard players operation #Physics.CrossProductAxis.xz.z Physics = #Physics.ThisObject Physics.Object.Axis.x.x
            scoreboard players operation #Physics.CrossProductAxis.xz.z Physics *= @s Physics.Object.Axis.z.y
            scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Axis.x.y
            scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.z.x
            execute store result score #Physics.Maths.Value3 Physics run scoreboard players operation #Physics.CrossProductAxis.xz.z Physics -= #Physics.Maths.Value1 Physics

            # Normalization
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics /= #Physics.Constants.1000 Physics
            scoreboard players operation #Physics.Maths.Value2 Physics /= #Physics.Constants.1000 Physics
            scoreboard players operation #Physics.Maths.Value3 Physics /= #Physics.Constants.1000 Physics

            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics *= #Physics.Maths.SquareRoot.Input Physics
            scoreboard players operation #Physics.Maths.Value2 Physics *= #Physics.Maths.Value2 Physics
            scoreboard players operation #Physics.Maths.Value3 Physics *= #Physics.Maths.Value3 Physics
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics += #Physics.Maths.Value2 Physics
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics += #Physics.Maths.Value3 Physics
            function physics:zprivate/maths/get_square_root

            scoreboard players operation #Physics.CrossProductAxis.xz.x Physics /= #Physics.Maths.SquareRoot.Output Physics
            scoreboard players operation #Physics.CrossProductAxis.xz.y Physics /= #Physics.Maths.SquareRoot.Output Physics
            scoreboard players operation #Physics.CrossProductAxis.xz.z Physics /= #Physics.Maths.SquareRoot.Output Physics

            # Projection: This
            # (Important): Because the cross product is perpendicular to this object's x axis, points along that axis have the same projection. Because of this: Corner 2 = Corner 0 / Corner 3 = Corner 1 / Corner 6 = Corner 4 / Corner 7 = Corner 5
                # Corner 0
                scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.xz Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.0.x
                scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.xz Physics *= #Physics.CrossProductAxis.xz.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.0.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.xz.y Physics
                scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.xz Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.0.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.xz.z Physics
                execute store result score #Physics.Projection.ObjectCorner5.CrossProductAxis.xz Physics store result score #Physics.Projection.Object.CrossProductAxis.xz.Max Physics run scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.xz Physics += #Physics.Maths.Value1 Physics

                # Corner 1
                scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis.xz Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.1.x
                scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis.xz Physics *= #Physics.CrossProductAxis.xz.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.1.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.xz.y Physics
                scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis.xz Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.1.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.xz.z Physics
                execute store result score #Physics.Projection.ObjectCorner4.CrossProductAxis.xz Physics run scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis.xz Physics += #Physics.Maths.Value1 Physics

                # Corner 4 (Mirrored version of 1)
                scoreboard players operation #Physics.Projection.ObjectCorner4.CrossProductAxis.xz Physics *= #Physics.Constants.-1 Physics

                # Corner 5 (Mirrored version of 0)
                scoreboard players operation #Physics.Projection.ObjectCorner5.CrossProductAxis.xz Physics *= #Physics.Constants.-1 Physics

                # Find min and max (relative)
                execute if score #Physics.Projection.ObjectCorner1.CrossProductAxis.xz Physics > #Physics.Projection.Object.CrossProductAxis.xz.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xz.Max Physics = #Physics.Projection.ObjectCorner1.CrossProductAxis.xz Physics
                execute if score #Physics.Projection.ObjectCorner4.CrossProductAxis.xz Physics > #Physics.Projection.Object.CrossProductAxis.xz.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xz.Max Physics = #Physics.Projection.ObjectCorner4.CrossProductAxis.xz Physics
                execute if score #Physics.Projection.ObjectCorner5.CrossProductAxis.xz Physics > #Physics.Projection.Object.CrossProductAxis.xz.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xz.Max Physics = #Physics.Projection.ObjectCorner5.CrossProductAxis.xz Physics
                execute store result score #Physics.Projection.Object.CrossProductAxis.xz.Min Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xz.Max Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xz.Min Physics *= #Physics.Constants.-1 Physics

                # Turn the projections and the min/max global by projecting the center point onto the same axis and adding it
                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.xz Physics = #Physics.ThisObject Physics.Object.Pos.x
                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.xz Physics *= #Physics.CrossProductAxis.xz.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Pos.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.xz.y Physics
                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.xz Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Pos.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.xz.z Physics
                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.xz Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.xz Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xz.Min Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.xz Physics
                scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xz.Max Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.xz Physics

            # Projection: Other
            # (Important): Because the cross product is perpendicular to the other object's z axis, points along that axis have the same projection. Because of this: Corner 1 = Corner 0 / Corner 3 = Corner 2 / Corner 5 = Corner 4 / Corner 7 = Corner 6
                # Corner 0
                scoreboard players operation #Physics.Projection.OtherObjectCorner0.CrossProductAxis.xz Physics = @s Physics.Object.CornerPosRelative.0.x
                scoreboard players operation #Physics.Projection.OtherObjectCorner0.CrossProductAxis.xz Physics *= #Physics.CrossProductAxis.xz.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.0.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.xz.y Physics
                scoreboard players operation #Physics.Projection.OtherObjectCorner0.CrossProductAxis.xz Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.0.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.xz.z Physics
                execute store result score #Physics.Projection.OtherObjectCorner6.CrossProductAxis.xz Physics store result score #Physics.Projection.OtherObject.CrossProductAxis.xz.Max Physics run scoreboard players operation #Physics.Projection.OtherObjectCorner0.CrossProductAxis.xz Physics += #Physics.Maths.Value1 Physics

                # Corner 2
                scoreboard players operation #Physics.Projection.OtherObjectCorner2.CrossProductAxis.xz Physics = @s Physics.Object.CornerPosRelative.2.x
                scoreboard players operation #Physics.Projection.OtherObjectCorner2.CrossProductAxis.xz Physics *= #Physics.CrossProductAxis.xz.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.2.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.xz.y Physics
                scoreboard players operation #Physics.Projection.OtherObjectCorner2.CrossProductAxis.xz Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.2.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.xz.z Physics
                execute store result score #Physics.Projection.OtherObjectCorner4.CrossProductAxis.xz Physics run scoreboard players operation #Physics.Projection.OtherObjectCorner2.CrossProductAxis.xz Physics += #Physics.Maths.Value1 Physics

                # Corner 4 (Mirrored version of 2)
                scoreboard players operation #Physics.Projection.OtherObjectCorner4.CrossProductAxis.xz Physics *= #Physics.Constants.-1 Physics

                # Corner 6 (Mirrored version of 0)
                scoreboard players operation #Physics.Projection.OtherObjectCorner6.CrossProductAxis.xz Physics *= #Physics.Constants.-1 Physics

                # Find min and max (relative)
                execute if score #Physics.Projection.OtherObjectCorner2.CrossProductAxis.xz Physics > #Physics.Projection.OtherObject.CrossProductAxis.xz.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis.xz.Max Physics = #Physics.Projection.OtherObjectCorner2.CrossProductAxis.xz Physics
                execute if score #Physics.Projection.OtherObjectCorner4.CrossProductAxis.xz Physics > #Physics.Projection.OtherObject.CrossProductAxis.xz.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis.xz.Max Physics = #Physics.Projection.OtherObjectCorner4.CrossProductAxis.xz Physics
                execute if score #Physics.Projection.OtherObjectCorner6.CrossProductAxis.xz Physics > #Physics.Projection.OtherObject.CrossProductAxis.xz.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis.xz.Max Physics = #Physics.Projection.OtherObjectCorner6.CrossProductAxis.xz Physics
                execute store result score #Physics.Projection.OtherObject.CrossProductAxis.xz.Min Physics run scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis.xz.Max Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis.xz.Min Physics *= #Physics.Constants.-1 Physics

                # Turn the projections and the min/max global by projecting the center point onto the same axis and adding it
                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis.xz Physics = @s Physics.Object.Pos.x
                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis.xz Physics *= #Physics.CrossProductAxis.xz.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.Pos.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.xz.y Physics
                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis.xz Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.Pos.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.xz.z Physics
                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis.xz Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis.xz Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis.xz.Min Physics += #Physics.Projection.OtherObjectCenter.CrossProductAxis.xz Physics
                scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis.xz.Max Physics += #Physics.Projection.OtherObjectCenter.CrossProductAxis.xz Physics

            # Overlap check
            execute unless score #Physics.Projection.Object.CrossProductAxis.xz.Min Physics <= #Physics.Projection.OtherObject.CrossProductAxis.xz.Max Physics run return 0
            execute unless score #Physics.Projection.OtherObject.CrossProductAxis.xz.Min Physics <= #Physics.Projection.Object.CrossProductAxis.xz.Max Physics run return 0

        # Cross Product: y_this x x_other
            # Calculation
            scoreboard players operation #Physics.CrossProductAxis.yx.x Physics = #Physics.ThisObject Physics.Object.Axis.y.y
            scoreboard players operation #Physics.CrossProductAxis.yx.x Physics *= @s Physics.Object.Axis.x.z
            scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Axis.y.z
            scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.x.y
            execute store result score #Physics.Maths.SquareRoot.Input Physics run scoreboard players operation #Physics.CrossProductAxis.yx.x Physics -= #Physics.Maths.Value1 Physics

            scoreboard players operation #Physics.CrossProductAxis.yx.y Physics = #Physics.ThisObject Physics.Object.Axis.y.z
            scoreboard players operation #Physics.CrossProductAxis.yx.y Physics *= @s Physics.Object.Axis.x.x
            scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Axis.y.x
            scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.x.z
            execute store result score #Physics.Maths.Value2 Physics run scoreboard players operation #Physics.CrossProductAxis.yx.y Physics -= #Physics.Maths.Value1 Physics

            scoreboard players operation #Physics.CrossProductAxis.yx.z Physics = #Physics.ThisObject Physics.Object.Axis.y.x
            scoreboard players operation #Physics.CrossProductAxis.yx.z Physics *= @s Physics.Object.Axis.x.y
            scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Axis.y.y
            scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.x.x
            execute store result score #Physics.Maths.Value3 Physics run scoreboard players operation #Physics.CrossProductAxis.yx.z Physics -= #Physics.Maths.Value1 Physics

            # Normalization
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics /= #Physics.Constants.1000 Physics
            scoreboard players operation #Physics.Maths.Value2 Physics /= #Physics.Constants.1000 Physics
            scoreboard players operation #Physics.Maths.Value3 Physics /= #Physics.Constants.1000 Physics

            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics *= #Physics.Maths.SquareRoot.Input Physics
            scoreboard players operation #Physics.Maths.Value2 Physics *= #Physics.Maths.Value2 Physics
            scoreboard players operation #Physics.Maths.Value3 Physics *= #Physics.Maths.Value3 Physics
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics += #Physics.Maths.Value2 Physics
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics += #Physics.Maths.Value3 Physics
            function physics:zprivate/maths/get_square_root

            scoreboard players operation #Physics.CrossProductAxis.yx.x Physics /= #Physics.Maths.SquareRoot.Output Physics
            scoreboard players operation #Physics.CrossProductAxis.yx.y Physics /= #Physics.Maths.SquareRoot.Output Physics
            scoreboard players operation #Physics.CrossProductAxis.yx.z Physics /= #Physics.Maths.SquareRoot.Output Physics

            # Projection: This
            # (Important): Because the cross product is perpendicular to this object's y axis, points along that axis have the same projection. Because of this: Corner 4 = Corner 0 / Corner 5 = Corner 1 / Corner 6 = Corner 2 / Corner 7 = Corner 3
                # Corner 0
                scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.yx Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.0.x
                scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.yx Physics *= #Physics.CrossProductAxis.yx.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.0.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.yx.y Physics
                scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.yx Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.0.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.yx.z Physics
                execute store result score #Physics.Projection.ObjectCorner3.CrossProductAxis.yx Physics store result score #Physics.Projection.Object.CrossProductAxis.yx.Max Physics run scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.yx Physics += #Physics.Maths.Value1 Physics

                # Corner 1
                scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis.yx Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.1.x
                scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis.yx Physics *= #Physics.CrossProductAxis.yx.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.1.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.yx.y Physics
                scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis.yx Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.1.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.yx.z Physics
                execute store result score #Physics.Projection.ObjectCorner2.CrossProductAxis.yx Physics run scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis.yx Physics += #Physics.Maths.Value1 Physics

                # Corner 2 (Mirrored version of 1)
                scoreboard players operation #Physics.Projection.ObjectCorner2.CrossProductAxis.yx Physics *= #Physics.Constants.-1 Physics

                # Corner 3 (Mirrored version of 0)
                scoreboard players operation #Physics.Projection.ObjectCorner3.CrossProductAxis.yx Physics *= #Physics.Constants.-1 Physics

                # Find min and max (relative)
                execute if score #Physics.Projection.ObjectCorner1.CrossProductAxis.yx Physics > #Physics.Projection.Object.CrossProductAxis.yx.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.yx.Max Physics = #Physics.Projection.ObjectCorner1.CrossProductAxis.yx Physics
                execute if score #Physics.Projection.ObjectCorner2.CrossProductAxis.yx Physics > #Physics.Projection.Object.CrossProductAxis.yx.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.yx.Max Physics = #Physics.Projection.ObjectCorner2.CrossProductAxis.yx Physics
                execute if score #Physics.Projection.ObjectCorner3.CrossProductAxis.yx Physics > #Physics.Projection.Object.CrossProductAxis.yx.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.yx.Max Physics = #Physics.Projection.ObjectCorner3.CrossProductAxis.yx Physics
                execute store result score #Physics.Projection.Object.CrossProductAxis.yx.Min Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.yx.Max Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.Object.CrossProductAxis.yx.Min Physics *= #Physics.Constants.-1 Physics

                # Turn the projections and the min/max global by projecting the center point onto the same axis and adding it
                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.yx Physics = #Physics.ThisObject Physics.Object.Pos.x
                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.yx Physics *= #Physics.CrossProductAxis.yx.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Pos.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.yx.y Physics
                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.yx Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Pos.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.yx.z Physics
                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.yx Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.yx Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.Object.CrossProductAxis.yx.Min Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.yx Physics
                scoreboard players operation #Physics.Projection.Object.CrossProductAxis.yx.Max Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.yx Physics

            # Projection: Other
            # (Important): Because the cross product is perpendicular to the other object's x axis, points along that axis have the same projection. Because of this: Corner 2 = Corner 0 / Corner 3 = Corner 1 / Corner 6 = Corner 4 / Corner 7 = Corner 5
                # Corner 0
                scoreboard players operation #Physics.Projection.OtherObjectCorner0.CrossProductAxis.yx Physics = @s Physics.Object.CornerPosRelative.0.x
                scoreboard players operation #Physics.Projection.OtherObjectCorner0.CrossProductAxis.yx Physics *= #Physics.CrossProductAxis.yx.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.0.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.yx.y Physics
                scoreboard players operation #Physics.Projection.OtherObjectCorner0.CrossProductAxis.yx Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.0.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.yx.z Physics
                execute store result score #Physics.Projection.OtherObjectCorner5.CrossProductAxis.yx Physics store result score #Physics.Projection.OtherObject.CrossProductAxis.yx.Max Physics run scoreboard players operation #Physics.Projection.OtherObjectCorner0.CrossProductAxis.yx Physics += #Physics.Maths.Value1 Physics

                # Corner 1
                scoreboard players operation #Physics.Projection.OtherObjectCorner1.CrossProductAxis.yx Physics = @s Physics.Object.CornerPosRelative.1.x
                scoreboard players operation #Physics.Projection.OtherObjectCorner1.CrossProductAxis.yx Physics *= #Physics.CrossProductAxis.yx.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.1.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.yx.y Physics
                scoreboard players operation #Physics.Projection.OtherObjectCorner1.CrossProductAxis.yx Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.1.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.yx.z Physics
                execute store result score #Physics.Projection.OtherObjectCorner4.CrossProductAxis.yx Physics run scoreboard players operation #Physics.Projection.OtherObjectCorner1.CrossProductAxis.yx Physics += #Physics.Maths.Value1 Physics

                # Corner 4 (Mirrored version of 1)
                scoreboard players operation #Physics.Projection.OtherObjectCorner4.CrossProductAxis.yx Physics *= #Physics.Constants.-1 Physics

                # Corner 5 (Mirrored version of 0)
                scoreboard players operation #Physics.Projection.OtherObjectCorner5.CrossProductAxis.yx Physics *= #Physics.Constants.-1 Physics

                # Find min and max (relative)
                execute if score #Physics.Projection.OtherObjectCorner1.CrossProductAxis.yx Physics > #Physics.Projection.OtherObject.CrossProductAxis.yx.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis.yx.Max Physics = #Physics.Projection.OtherObjectCorner1.CrossProductAxis.yx Physics
                execute if score #Physics.Projection.OtherObjectCorner4.CrossProductAxis.yx Physics > #Physics.Projection.OtherObject.CrossProductAxis.yx.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis.yx.Max Physics = #Physics.Projection.OtherObjectCorner4.CrossProductAxis.yx Physics
                execute if score #Physics.Projection.OtherObjectCorner5.CrossProductAxis.yx Physics > #Physics.Projection.OtherObject.CrossProductAxis.yx.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis.yx.Max Physics = #Physics.Projection.OtherObjectCorner5.CrossProductAxis.yx Physics
                execute store result score #Physics.Projection.OtherObject.CrossProductAxis.yx.Min Physics run scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis.yx.Max Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis.yx.Min Physics *= #Physics.Constants.-1 Physics

                # Turn the projections and the min/max global by projecting the center point onto the same axis and adding it
                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis.yx Physics = @s Physics.Object.Pos.x
                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis.yx Physics *= #Physics.CrossProductAxis.yx.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.Pos.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.yx.y Physics
                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis.yx Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.Pos.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.yx.z Physics
                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis.yx Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis.yx Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis.yx.Min Physics += #Physics.Projection.OtherObjectCenter.CrossProductAxis.yx Physics
                scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis.yx.Max Physics += #Physics.Projection.OtherObjectCenter.CrossProductAxis.yx Physics

            # Overlap check
            execute unless score #Physics.Projection.Object.CrossProductAxis.yx.Min Physics <= #Physics.Projection.OtherObject.CrossProductAxis.yx.Max Physics run return 0
            execute unless score #Physics.Projection.OtherObject.CrossProductAxis.yx.Min Physics <= #Physics.Projection.Object.CrossProductAxis.yx.Max Physics run return 0

        # Cross Product: y_this x y_other
            # Calculation
            scoreboard players operation #Physics.CrossProductAxis.yy.x Physics = #Physics.ThisObject Physics.Object.Axis.y.y
            scoreboard players operation #Physics.CrossProductAxis.yy.x Physics *= @s Physics.Object.Axis.y.z
            scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Axis.y.z
            scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.y.y
            execute store result score #Physics.Maths.SquareRoot.Input Physics run scoreboard players operation #Physics.CrossProductAxis.yy.x Physics -= #Physics.Maths.Value1 Physics

            scoreboard players operation #Physics.CrossProductAxis.yy.y Physics = #Physics.ThisObject Physics.Object.Axis.y.z
            scoreboard players operation #Physics.CrossProductAxis.yy.y Physics *= @s Physics.Object.Axis.y.x
            scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Axis.y.x
            scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.y.z
            execute store result score #Physics.Maths.Value2 Physics run scoreboard players operation #Physics.CrossProductAxis.yy.y Physics -= #Physics.Maths.Value1 Physics

            scoreboard players operation #Physics.CrossProductAxis.yy.z Physics = #Physics.ThisObject Physics.Object.Axis.y.x
            scoreboard players operation #Physics.CrossProductAxis.yy.z Physics *= @s Physics.Object.Axis.y.y
            scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Axis.y.y
            scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.y.x
            execute store result score #Physics.Maths.Value3 Physics run scoreboard players operation #Physics.CrossProductAxis.yy.z Physics -= #Physics.Maths.Value1 Physics

            # Normalization
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics /= #Physics.Constants.1000 Physics
            scoreboard players operation #Physics.Maths.Value2 Physics /= #Physics.Constants.1000 Physics
            scoreboard players operation #Physics.Maths.Value3 Physics /= #Physics.Constants.1000 Physics

            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics *= #Physics.Maths.SquareRoot.Input Physics
            scoreboard players operation #Physics.Maths.Value2 Physics *= #Physics.Maths.Value2 Physics
            scoreboard players operation #Physics.Maths.Value3 Physics *= #Physics.Maths.Value3 Physics
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics += #Physics.Maths.Value2 Physics
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics += #Physics.Maths.Value3 Physics
            function physics:zprivate/maths/get_square_root

            scoreboard players operation #Physics.CrossProductAxis.yy.x Physics /= #Physics.Maths.SquareRoot.Output Physics
            scoreboard players operation #Physics.CrossProductAxis.yy.y Physics /= #Physics.Maths.SquareRoot.Output Physics
            scoreboard players operation #Physics.CrossProductAxis.yy.z Physics /= #Physics.Maths.SquareRoot.Output Physics

            # Projection: This
            # (Important): Because the cross product is perpendicular to this object's y axis, points along that axis have the same projection. Because of this: Corner 4 = Corner 0 / Corner 5 = Corner 1 / Corner 6 = Corner 2 / Corner 7 = Corner 3
                # Corner 0
                scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.yy Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.0.x
                scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.yy Physics *= #Physics.CrossProductAxis.yy.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.0.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.yy.y Physics
                scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.yy Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.0.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.yy.z Physics
                execute store result score #Physics.Projection.ObjectCorner3.CrossProductAxis.yy Physics store result score #Physics.Projection.Object.CrossProductAxis.yy.Max Physics run scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.yy Physics += #Physics.Maths.Value1 Physics

                # Corner 1
                scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis.yy Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.1.x
                scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis.yy Physics *= #Physics.CrossProductAxis.yy.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.1.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.yy.y Physics
                scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis.yy Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.1.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.yy.z Physics
                execute store result score #Physics.Projection.ObjectCorner2.CrossProductAxis.yy Physics run scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis.yy Physics += #Physics.Maths.Value1 Physics

                # Corner 2 (Mirrored version of 1)
                scoreboard players operation #Physics.Projection.ObjectCorner2.CrossProductAxis.yy Physics *= #Physics.Constants.-1 Physics

                # Corner 3 (Mirrored version of 0)
                scoreboard players operation #Physics.Projection.ObjectCorner3.CrossProductAxis.yy Physics *= #Physics.Constants.-1 Physics

                # Find min and max (relative)
                execute if score #Physics.Projection.ObjectCorner1.CrossProductAxis.yy Physics > #Physics.Projection.Object.CrossProductAxis.yy.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.yy.Max Physics = #Physics.Projection.ObjectCorner1.CrossProductAxis.yy Physics
                execute if score #Physics.Projection.ObjectCorner2.CrossProductAxis.yy Physics > #Physics.Projection.Object.CrossProductAxis.yy.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.yy.Max Physics = #Physics.Projection.ObjectCorner2.CrossProductAxis.yy Physics
                execute if score #Physics.Projection.ObjectCorner3.CrossProductAxis.yy Physics > #Physics.Projection.Object.CrossProductAxis.yy.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.yy.Max Physics = #Physics.Projection.ObjectCorner3.CrossProductAxis.yy Physics
                execute store result score #Physics.Projection.Object.CrossProductAxis.yy.Min Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.yy.Max Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.Object.CrossProductAxis.yy.Min Physics *= #Physics.Constants.-1 Physics

                # Turn the projections and the min/max global by projecting the center point onto the same axis and adding it
                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.yy Physics = #Physics.ThisObject Physics.Object.Pos.x
                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.yy Physics *= #Physics.CrossProductAxis.yy.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Pos.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.yy.y Physics
                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.yy Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Pos.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.yy.z Physics
                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.yy Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.yy Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.Object.CrossProductAxis.yy.Min Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.yy Physics
                scoreboard players operation #Physics.Projection.Object.CrossProductAxis.yy.Max Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.yy Physics

            # Projection: Other
            # (Important): Because the cross product is perpendicular to the other object's y axis, points along that axis have the same projection. Because of this: Corner 4 = Corner 0 / Corner 5 = Corner 1 / Corner 6 = Corner 2 / Corner 7 = Corner 3
                # Corner 0
                scoreboard players operation #Physics.Projection.OtherObjectCorner0.CrossProductAxis.yy Physics = @s Physics.Object.CornerPosRelative.0.x
                scoreboard players operation #Physics.Projection.OtherObjectCorner0.CrossProductAxis.yy Physics *= #Physics.CrossProductAxis.yy.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.0.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.yy.y Physics
                scoreboard players operation #Physics.Projection.OtherObjectCorner0.CrossProductAxis.yy Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.0.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.yy.z Physics
                execute store result score #Physics.Projection.OtherObjectCorner3.CrossProductAxis.yy Physics store result score #Physics.Projection.OtherObject.CrossProductAxis.yy.Max Physics run scoreboard players operation #Physics.Projection.OtherObjectCorner0.CrossProductAxis.yy Physics += #Physics.Maths.Value1 Physics

                # Corner 1
                scoreboard players operation #Physics.Projection.OtherObjectCorner1.CrossProductAxis.yy Physics = @s Physics.Object.CornerPosRelative.1.x
                scoreboard players operation #Physics.Projection.OtherObjectCorner1.CrossProductAxis.yy Physics *= #Physics.CrossProductAxis.yy.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.1.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.yy.y Physics
                scoreboard players operation #Physics.Projection.OtherObjectCorner1.CrossProductAxis.yy Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.1.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.yy.z Physics
                execute store result score #Physics.Projection.OtherObjectCorner2.CrossProductAxis.yy Physics run scoreboard players operation #Physics.Projection.OtherObjectCorner1.CrossProductAxis.yy Physics += #Physics.Maths.Value1 Physics

                # Corner 2 (Mirrored version of 1)
                scoreboard players operation #Physics.Projection.OtherObjectCorner2.CrossProductAxis.yy Physics *= #Physics.Constants.-1 Physics

                # Corner 3 (Mirrored version of 0)
                scoreboard players operation #Physics.Projection.OtherObjectCorner3.CrossProductAxis.yy Physics *= #Physics.Constants.-1 Physics

                # Find min and max (relative)
                execute if score #Physics.Projection.OtherObjectCorner1.CrossProductAxis.yy Physics > #Physics.Projection.OtherObject.CrossProductAxis.yy.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis.yy.Max Physics = #Physics.Projection.OtherObjectCorner1.CrossProductAxis.yy Physics
                execute if score #Physics.Projection.OtherObjectCorner2.CrossProductAxis.yy Physics > #Physics.Projection.OtherObject.CrossProductAxis.yy.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis.yy.Max Physics = #Physics.Projection.OtherObjectCorner2.CrossProductAxis.yy Physics
                execute if score #Physics.Projection.OtherObjectCorner3.CrossProductAxis.yy Physics > #Physics.Projection.OtherObject.CrossProductAxis.yy.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis.yy.Max Physics = #Physics.Projection.OtherObjectCorner3.CrossProductAxis.yy Physics
                execute store result score #Physics.Projection.OtherObject.CrossProductAxis.yy.Min Physics run scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis.yy.Max Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis.yy.Min Physics *= #Physics.Constants.-1 Physics

                # Turn the projections and the min/max global by projecting the center point onto the same axis and adding it
                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis.yy Physics = @s Physics.Object.Pos.x
                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis.yy Physics *= #Physics.CrossProductAxis.yy.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.Pos.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.yy.y Physics
                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis.yy Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.Pos.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.yy.z Physics
                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis.yy Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis.yy Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis.yy.Min Physics += #Physics.Projection.OtherObjectCenter.CrossProductAxis.yy Physics
                scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis.yy.Max Physics += #Physics.Projection.OtherObjectCenter.CrossProductAxis.yy Physics

            # Overlap check
            execute unless score #Physics.Projection.Object.CrossProductAxis.yy.Min Physics <= #Physics.Projection.OtherObject.CrossProductAxis.yy.Max Physics run return 0
            execute unless score #Physics.Projection.OtherObject.CrossProductAxis.yy.Min Physics <= #Physics.Projection.Object.CrossProductAxis.yy.Max Physics run return 0

        # Cross Product: y_this x z_other
            # Calculation
            scoreboard players operation #Physics.CrossProductAxis.yz.x Physics = #Physics.ThisObject Physics.Object.Axis.y.y
            scoreboard players operation #Physics.CrossProductAxis.yz.x Physics *= @s Physics.Object.Axis.z.z
            scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Axis.y.z
            scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.z.y
            execute store result score #Physics.Maths.SquareRoot.Input Physics run scoreboard players operation #Physics.CrossProductAxis.yz.x Physics -= #Physics.Maths.Value1 Physics

            scoreboard players operation #Physics.CrossProductAxis.yz.y Physics = #Physics.ThisObject Physics.Object.Axis.y.z
            scoreboard players operation #Physics.CrossProductAxis.yz.y Physics *= @s Physics.Object.Axis.z.x
            scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Axis.y.x
            scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.z.z
            execute store result score #Physics.Maths.Value2 Physics run scoreboard players operation #Physics.CrossProductAxis.yz.y Physics -= #Physics.Maths.Value1 Physics

            scoreboard players operation #Physics.CrossProductAxis.yz.z Physics = #Physics.ThisObject Physics.Object.Axis.y.x
            scoreboard players operation #Physics.CrossProductAxis.yz.z Physics *= @s Physics.Object.Axis.z.y
            scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Axis.y.y
            scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.z.x
            execute store result score #Physics.Maths.Value3 Physics run scoreboard players operation #Physics.CrossProductAxis.yz.z Physics -= #Physics.Maths.Value1 Physics

            # Normalization
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics /= #Physics.Constants.1000 Physics
            scoreboard players operation #Physics.Maths.Value2 Physics /= #Physics.Constants.1000 Physics
            scoreboard players operation #Physics.Maths.Value3 Physics /= #Physics.Constants.1000 Physics

            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics *= #Physics.Maths.SquareRoot.Input Physics
            scoreboard players operation #Physics.Maths.Value2 Physics *= #Physics.Maths.Value2 Physics
            scoreboard players operation #Physics.Maths.Value3 Physics *= #Physics.Maths.Value3 Physics
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics += #Physics.Maths.Value2 Physics
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics += #Physics.Maths.Value3 Physics
            function physics:zprivate/maths/get_square_root

            scoreboard players operation #Physics.CrossProductAxis.yz.x Physics /= #Physics.Maths.SquareRoot.Output Physics
            scoreboard players operation #Physics.CrossProductAxis.yz.y Physics /= #Physics.Maths.SquareRoot.Output Physics
            scoreboard players operation #Physics.CrossProductAxis.yz.z Physics /= #Physics.Maths.SquareRoot.Output Physics

            # Projection: This
            # (Important): Because the cross product is perpendicular to this object's y axis, points along that axis have the same projection. Because of this: Corner 4 = Corner 0 / Corner 5 = Corner 1 / Corner 6 = Corner 2 / Corner 7 = Corner 3
                # Corner 0
                scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.yz Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.0.x
                scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.yz Physics *= #Physics.CrossProductAxis.yz.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.0.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.yz.y Physics
                scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.yz Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.0.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.yz.z Physics
                execute store result score #Physics.Projection.ObjectCorner3.CrossProductAxis.yz Physics store result score #Physics.Projection.Object.CrossProductAxis.yz.Max Physics run scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.yz Physics += #Physics.Maths.Value1 Physics

                # Corner 1
                scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis.yz Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.1.x
                scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis.yz Physics *= #Physics.CrossProductAxis.yz.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.1.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.yz.y Physics
                scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis.yz Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.1.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.yz.z Physics
                execute store result score #Physics.Projection.ObjectCorner2.CrossProductAxis.yz Physics run scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis.yz Physics += #Physics.Maths.Value1 Physics

                # Corner 2 (Mirrored version of 1)
                scoreboard players operation #Physics.Projection.ObjectCorner2.CrossProductAxis.yz Physics *= #Physics.Constants.-1 Physics

                # Corner 3 (Mirrored version of 0)
                scoreboard players operation #Physics.Projection.ObjectCorner3.CrossProductAxis.yz Physics *= #Physics.Constants.-1 Physics

                # Find min and max (relative)
                execute if score #Physics.Projection.ObjectCorner1.CrossProductAxis.yz Physics > #Physics.Projection.Object.CrossProductAxis.yz.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.yz.Max Physics = #Physics.Projection.ObjectCorner1.CrossProductAxis.yz Physics
                execute if score #Physics.Projection.ObjectCorner2.CrossProductAxis.yz Physics > #Physics.Projection.Object.CrossProductAxis.yz.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.yz.Max Physics = #Physics.Projection.ObjectCorner2.CrossProductAxis.yz Physics
                execute if score #Physics.Projection.ObjectCorner3.CrossProductAxis.yz Physics > #Physics.Projection.Object.CrossProductAxis.yz.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.yz.Max Physics = #Physics.Projection.ObjectCorner3.CrossProductAxis.yz Physics
                execute store result score #Physics.Projection.Object.CrossProductAxis.yz.Min Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.yz.Max Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.Object.CrossProductAxis.yz.Min Physics *= #Physics.Constants.-1 Physics

                # Turn the projections and the min/max global by projecting the center point onto the same axis and adding it
                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.yz Physics = #Physics.ThisObject Physics.Object.Pos.x
                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.yz Physics *= #Physics.CrossProductAxis.yz.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Pos.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.yz.y Physics
                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.yz Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Pos.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.yz.z Physics
                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.yz Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.yz Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.Object.CrossProductAxis.yz.Min Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.yz Physics
                scoreboard players operation #Physics.Projection.Object.CrossProductAxis.yz.Max Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.yz Physics

            # Projection: Other
            # (Important): Because the cross product is perpendicular to the other object's z axis, points along that axis have the same projection. Because of this: Corner 1 = Corner 0 / Corner 3 = Corner 2 / Corner 5 = Corner 4 / Corner 7 = Corner 6
                # Corner 0
                scoreboard players operation #Physics.Projection.OtherObjectCorner0.CrossProductAxis.yz Physics = @s Physics.Object.CornerPosRelative.0.x
                scoreboard players operation #Physics.Projection.OtherObjectCorner0.CrossProductAxis.yz Physics *= #Physics.CrossProductAxis.yz.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.0.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.yz.y Physics
                scoreboard players operation #Physics.Projection.OtherObjectCorner0.CrossProductAxis.yz Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.0.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.yz.z Physics
                execute store result score #Physics.Projection.OtherObjectCorner6.CrossProductAxis.yz Physics store result score #Physics.Projection.OtherObject.CrossProductAxis.yz.Max Physics run scoreboard players operation #Physics.Projection.OtherObjectCorner0.CrossProductAxis.yz Physics += #Physics.Maths.Value1 Physics

                # Corner 2
                scoreboard players operation #Physics.Projection.OtherObjectCorner2.CrossProductAxis.yz Physics = @s Physics.Object.CornerPosRelative.2.x
                scoreboard players operation #Physics.Projection.OtherObjectCorner2.CrossProductAxis.yz Physics *= #Physics.CrossProductAxis.yz.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.2.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.yz.y Physics
                scoreboard players operation #Physics.Projection.OtherObjectCorner2.CrossProductAxis.yz Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.2.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.yz.z Physics
                execute store result score #Physics.Projection.OtherObjectCorner4.CrossProductAxis.yz Physics run scoreboard players operation #Physics.Projection.OtherObjectCorner2.CrossProductAxis.yz Physics += #Physics.Maths.Value1 Physics

                # Corner 4 (Mirrored version of 2)
                scoreboard players operation #Physics.Projection.OtherObjectCorner4.CrossProductAxis.yz Physics *= #Physics.Constants.-1 Physics

                # Corner 6 (Mirrored version of 0)
                scoreboard players operation #Physics.Projection.OtherObjectCorner6.CrossProductAxis.yz Physics *= #Physics.Constants.-1 Physics

                # Find min and max (relative)
                execute if score #Physics.Projection.OtherObjectCorner2.CrossProductAxis.yz Physics > #Physics.Projection.OtherObject.CrossProductAxis.yz.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis.yz.Max Physics = #Physics.Projection.OtherObjectCorner2.CrossProductAxis.yz Physics
                execute if score #Physics.Projection.OtherObjectCorner4.CrossProductAxis.yz Physics > #Physics.Projection.OtherObject.CrossProductAxis.yz.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis.yz.Max Physics = #Physics.Projection.OtherObjectCorner4.CrossProductAxis.yz Physics
                execute if score #Physics.Projection.OtherObjectCorner6.CrossProductAxis.yz Physics > #Physics.Projection.OtherObject.CrossProductAxis.yz.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis.yz.Max Physics = #Physics.Projection.OtherObjectCorner6.CrossProductAxis.yz Physics
                execute store result score #Physics.Projection.OtherObject.CrossProductAxis.yz.Min Physics run scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis.yz.Max Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis.yz.Min Physics *= #Physics.Constants.-1 Physics

                # Turn the projections and the min/max global by projecting the center point onto the same axis and adding it
                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis.yz Physics = @s Physics.Object.Pos.x
                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis.yz Physics *= #Physics.CrossProductAxis.yz.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.Pos.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.yz.y Physics
                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis.yz Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.Pos.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.yz.z Physics
                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis.yz Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis.yz Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis.yz.Min Physics += #Physics.Projection.OtherObjectCenter.CrossProductAxis.yz Physics
                scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis.yz.Max Physics += #Physics.Projection.OtherObjectCenter.CrossProductAxis.yz Physics

            # Overlap check
            execute unless score #Physics.Projection.Object.CrossProductAxis.yz.Min Physics <= #Physics.Projection.OtherObject.CrossProductAxis.yz.Max Physics run return 0
            execute unless score #Physics.Projection.OtherObject.CrossProductAxis.yz.Min Physics <= #Physics.Projection.Object.CrossProductAxis.yz.Max Physics run return 0

        # Cross Product: z_this x x_other
            # Calculation
            scoreboard players operation #Physics.CrossProductAxis.zx.x Physics = #Physics.ThisObject Physics.Object.Axis.z.y
            scoreboard players operation #Physics.CrossProductAxis.zx.x Physics *= @s Physics.Object.Axis.x.z
            scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Axis.z.z
            scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.x.y
            execute store result score #Physics.Maths.SquareRoot.Input Physics run scoreboard players operation #Physics.CrossProductAxis.zx.x Physics -= #Physics.Maths.Value1 Physics

            scoreboard players operation #Physics.CrossProductAxis.zx.y Physics = #Physics.ThisObject Physics.Object.Axis.z.z
            scoreboard players operation #Physics.CrossProductAxis.zx.y Physics *= @s Physics.Object.Axis.x.x
            scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Axis.z.x
            scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.x.z
            execute store result score #Physics.Maths.Value2 Physics run scoreboard players operation #Physics.CrossProductAxis.zx.y Physics -= #Physics.Maths.Value1 Physics

            scoreboard players operation #Physics.CrossProductAxis.zx.z Physics = #Physics.ThisObject Physics.Object.Axis.z.x
            scoreboard players operation #Physics.CrossProductAxis.zx.z Physics *= @s Physics.Object.Axis.x.y
            scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Axis.z.y
            scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.x.x
            execute store result score #Physics.Maths.Value3 Physics run scoreboard players operation #Physics.CrossProductAxis.zx.z Physics -= #Physics.Maths.Value1 Physics

            # Normalization
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics /= #Physics.Constants.1000 Physics
            scoreboard players operation #Physics.Maths.Value2 Physics /= #Physics.Constants.1000 Physics
            scoreboard players operation #Physics.Maths.Value3 Physics /= #Physics.Constants.1000 Physics

            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics *= #Physics.Maths.SquareRoot.Input Physics
            scoreboard players operation #Physics.Maths.Value2 Physics *= #Physics.Maths.Value2 Physics
            scoreboard players operation #Physics.Maths.Value3 Physics *= #Physics.Maths.Value3 Physics
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics += #Physics.Maths.Value2 Physics
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics += #Physics.Maths.Value3 Physics
            function physics:zprivate/maths/get_square_root

            scoreboard players operation #Physics.CrossProductAxis.zx.x Physics /= #Physics.Maths.SquareRoot.Output Physics
            scoreboard players operation #Physics.CrossProductAxis.zx.y Physics /= #Physics.Maths.SquareRoot.Output Physics
            scoreboard players operation #Physics.CrossProductAxis.zx.z Physics /= #Physics.Maths.SquareRoot.Output Physics

            # Projection: This
            # (Important): Because the cross product is perpendicular to this object's z axis, points along that axis have the same projection. Because of this: Corner 1 = Corner 0 / Corner 3 = Corner 2 / Corner 5 = Corner 4 / Corner 7 = Corner 6
                # Corner 0
                scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.zx Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.0.x
                scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.zx Physics *= #Physics.CrossProductAxis.zx.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.0.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.zx.y Physics
                scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.zx Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.0.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.zx.z Physics
                execute store result score #Physics.Projection.ObjectCorner6.CrossProductAxis.zx Physics store result score #Physics.Projection.Object.CrossProductAxis.zx.Max Physics run scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.zx Physics += #Physics.Maths.Value1 Physics

                # Corner 2
                scoreboard players operation #Physics.Projection.ObjectCorner2.CrossProductAxis.zx Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.2.x
                scoreboard players operation #Physics.Projection.ObjectCorner2.CrossProductAxis.zx Physics *= #Physics.CrossProductAxis.zx.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.2.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.zx.y Physics
                scoreboard players operation #Physics.Projection.ObjectCorner2.CrossProductAxis.zx Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.2.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.zx.z Physics
                execute store result score #Physics.Projection.ObjectCorner4.CrossProductAxis.zx Physics run scoreboard players operation #Physics.Projection.ObjectCorner2.CrossProductAxis.zx Physics += #Physics.Maths.Value1 Physics

                # Corner 4 (Mirrored version of 2)
                scoreboard players operation #Physics.Projection.ObjectCorner4.CrossProductAxis.zx Physics *= #Physics.Constants.-1 Physics

                # Corner 6 (Mirrored version of 0)
                scoreboard players operation #Physics.Projection.ObjectCorner6.CrossProductAxis.zx Physics *= #Physics.Constants.-1 Physics

                # Find min and max (relative)
                execute if score #Physics.Projection.ObjectCorner2.CrossProductAxis.zx Physics > #Physics.Projection.Object.CrossProductAxis.zx.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.zx.Max Physics = #Physics.Projection.ObjectCorner2.CrossProductAxis.zx Physics
                execute if score #Physics.Projection.ObjectCorner4.CrossProductAxis.zx Physics > #Physics.Projection.Object.CrossProductAxis.zx.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.zx.Max Physics = #Physics.Projection.ObjectCorner4.CrossProductAxis.zx Physics
                execute if score #Physics.Projection.ObjectCorner6.CrossProductAxis.zx Physics > #Physics.Projection.Object.CrossProductAxis.zx.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.zx.Max Physics = #Physics.Projection.ObjectCorner6.CrossProductAxis.zx Physics
                execute store result score #Physics.Projection.Object.CrossProductAxis.zx.Min Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.zx.Max Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.Object.CrossProductAxis.zx.Min Physics *= #Physics.Constants.-1 Physics

                # Turn the projections and the min/max global by projecting the center point onto the same axis and adding it
                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.zx Physics = #Physics.ThisObject Physics.Object.Pos.x
                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.zx Physics *= #Physics.CrossProductAxis.zx.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Pos.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.zx.y Physics
                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.zx Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Pos.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.zx.z Physics
                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.zx Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.zx Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.Object.CrossProductAxis.zx.Min Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.zx Physics
                scoreboard players operation #Physics.Projection.Object.CrossProductAxis.zx.Max Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.zx Physics

            # Projection: Other
            # (Important): Because the cross product is perpendicular to the other object's x axis, points along that axis have the same projection. Because of this: Corner 2 = Corner 0 / Corner 3 = Corner 1 / Corner 6 = Corner 4 / Corner 7 = Corner 5
                # Corner 0
                scoreboard players operation #Physics.Projection.OtherObjectCorner0.CrossProductAxis.zx Physics = @s Physics.Object.CornerPosRelative.0.x
                scoreboard players operation #Physics.Projection.OtherObjectCorner0.CrossProductAxis.zx Physics *= #Physics.CrossProductAxis.zx.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.0.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.zx.y Physics
                scoreboard players operation #Physics.Projection.OtherObjectCorner0.CrossProductAxis.zx Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.0.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.zx.z Physics
                execute store result score #Physics.Projection.OtherObjectCorner5.CrossProductAxis.zx Physics store result score #Physics.Projection.OtherObject.CrossProductAxis.zx.Max Physics run scoreboard players operation #Physics.Projection.OtherObjectCorner0.CrossProductAxis.zx Physics += #Physics.Maths.Value1 Physics

                # Corner 1
                scoreboard players operation #Physics.Projection.OtherObjectCorner1.CrossProductAxis.zx Physics = @s Physics.Object.CornerPosRelative.1.x
                scoreboard players operation #Physics.Projection.OtherObjectCorner1.CrossProductAxis.zx Physics *= #Physics.CrossProductAxis.zx.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.1.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.zx.y Physics
                scoreboard players operation #Physics.Projection.OtherObjectCorner1.CrossProductAxis.zx Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.1.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.zx.z Physics
                execute store result score #Physics.Projection.OtherObjectCorner4.CrossProductAxis.zx Physics run scoreboard players operation #Physics.Projection.OtherObjectCorner1.CrossProductAxis.zx Physics += #Physics.Maths.Value1 Physics

                # Corner 4 (Mirrored version of 1)
                scoreboard players operation #Physics.Projection.OtherObjectCorner4.CrossProductAxis.zx Physics *= #Physics.Constants.-1 Physics

                # Corner 5 (Mirrored version of 0)
                scoreboard players operation #Physics.Projection.OtherObjectCorner5.CrossProductAxis.zx Physics *= #Physics.Constants.-1 Physics

                # Find min and max (relative)
                execute if score #Physics.Projection.OtherObjectCorner1.CrossProductAxis.zx Physics > #Physics.Projection.OtherObject.CrossProductAxis.zx.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis.zx.Max Physics = #Physics.Projection.OtherObjectCorner1.CrossProductAxis.zx Physics
                execute if score #Physics.Projection.OtherObjectCorner4.CrossProductAxis.zx Physics > #Physics.Projection.OtherObject.CrossProductAxis.zx.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis.zx.Max Physics = #Physics.Projection.OtherObjectCorner4.CrossProductAxis.zx Physics
                execute if score #Physics.Projection.OtherObjectCorner5.CrossProductAxis.zx Physics > #Physics.Projection.OtherObject.CrossProductAxis.zx.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis.zx.Max Physics = #Physics.Projection.OtherObjectCorner5.CrossProductAxis.zx Physics
                execute store result score #Physics.Projection.OtherObject.CrossProductAxis.zx.Min Physics run scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis.zx.Max Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis.zx.Min Physics *= #Physics.Constants.-1 Physics

                # Turn the projections and the min/max global by projecting the center point onto the same axis and adding it
                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis.zx Physics = @s Physics.Object.Pos.x
                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis.zx Physics *= #Physics.CrossProductAxis.zx.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.Pos.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.zx.y Physics
                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis.zx Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.Pos.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.zx.z Physics
                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis.zx Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis.zx Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis.zx.Min Physics += #Physics.Projection.OtherObjectCenter.CrossProductAxis.zx Physics
                scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis.zx.Max Physics += #Physics.Projection.OtherObjectCenter.CrossProductAxis.zx Physics

            # Overlap check
            execute unless score #Physics.Projection.Object.CrossProductAxis.zx.Min Physics <= #Physics.Projection.OtherObject.CrossProductAxis.zx.Max Physics run return 0
            execute unless score #Physics.Projection.OtherObject.CrossProductAxis.zx.Min Physics <= #Physics.Projection.Object.CrossProductAxis.zx.Max Physics run return 0

        # Cross Product: z_this x y_other
            # Calculation
            scoreboard players operation #Physics.CrossProductAxis.zy.x Physics = #Physics.ThisObject Physics.Object.Axis.z.y
            scoreboard players operation #Physics.CrossProductAxis.zy.x Physics *= @s Physics.Object.Axis.y.z
            scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Axis.z.z
            scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.y.y
            execute store result score #Physics.Maths.SquareRoot.Input Physics run scoreboard players operation #Physics.CrossProductAxis.zy.x Physics -= #Physics.Maths.Value1 Physics

            scoreboard players operation #Physics.CrossProductAxis.zy.y Physics = #Physics.ThisObject Physics.Object.Axis.z.z
            scoreboard players operation #Physics.CrossProductAxis.zy.y Physics *= @s Physics.Object.Axis.y.x
            scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Axis.z.x
            scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.y.z
            execute store result score #Physics.Maths.Value2 Physics run scoreboard players operation #Physics.CrossProductAxis.zy.y Physics -= #Physics.Maths.Value1 Physics

            scoreboard players operation #Physics.CrossProductAxis.zy.z Physics = #Physics.ThisObject Physics.Object.Axis.z.x
            scoreboard players operation #Physics.CrossProductAxis.zy.z Physics *= @s Physics.Object.Axis.y.y
            scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Axis.z.y
            scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.y.x
            execute store result score #Physics.Maths.Value3 Physics run scoreboard players operation #Physics.CrossProductAxis.zy.z Physics -= #Physics.Maths.Value1 Physics

            # Normalization
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics /= #Physics.Constants.1000 Physics
            scoreboard players operation #Physics.Maths.Value2 Physics /= #Physics.Constants.1000 Physics
            scoreboard players operation #Physics.Maths.Value3 Physics /= #Physics.Constants.1000 Physics

            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics *= #Physics.Maths.SquareRoot.Input Physics
            scoreboard players operation #Physics.Maths.Value2 Physics *= #Physics.Maths.Value2 Physics
            scoreboard players operation #Physics.Maths.Value3 Physics *= #Physics.Maths.Value3 Physics
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics += #Physics.Maths.Value2 Physics
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics += #Physics.Maths.Value3 Physics
            function physics:zprivate/maths/get_square_root

            scoreboard players operation #Physics.CrossProductAxis.zy.x Physics /= #Physics.Maths.SquareRoot.Output Physics
            scoreboard players operation #Physics.CrossProductAxis.zy.y Physics /= #Physics.Maths.SquareRoot.Output Physics
            scoreboard players operation #Physics.CrossProductAxis.zy.z Physics /= #Physics.Maths.SquareRoot.Output Physics

            # Projection: This
            # (Important): Because the cross product is perpendicular to this object's z axis, points along that axis have the same projection. Because of this: Corner 1 = Corner 0 / Corner 3 = Corner 2 / Corner 5 = Corner 4 / Corner 7 = Corner 6
                # Corner 0
                scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.zy Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.0.x
                scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.zy Physics *= #Physics.CrossProductAxis.zy.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.0.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.zy.y Physics
                scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.zy Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.0.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.zy.z Physics
                execute store result score #Physics.Projection.ObjectCorner6.CrossProductAxis.zy Physics store result score #Physics.Projection.Object.CrossProductAxis.zy.Max Physics run scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.zy Physics += #Physics.Maths.Value1 Physics

                # Corner 2
                scoreboard players operation #Physics.Projection.ObjectCorner2.CrossProductAxis.zy Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.2.x
                scoreboard players operation #Physics.Projection.ObjectCorner2.CrossProductAxis.zy Physics *= #Physics.CrossProductAxis.zy.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.2.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.zy.y Physics
                scoreboard players operation #Physics.Projection.ObjectCorner2.CrossProductAxis.zy Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.2.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.zy.z Physics
                execute store result score #Physics.Projection.ObjectCorner4.CrossProductAxis.zy Physics run scoreboard players operation #Physics.Projection.ObjectCorner2.CrossProductAxis.zy Physics += #Physics.Maths.Value1 Physics

                # Corner 4 (Mirrored version of 2)
                scoreboard players operation #Physics.Projection.ObjectCorner4.CrossProductAxis.zy Physics *= #Physics.Constants.-1 Physics

                # Corner 6 (Mirrored version of 0)
                scoreboard players operation #Physics.Projection.ObjectCorner6.CrossProductAxis.zy Physics *= #Physics.Constants.-1 Physics

                # Find min and max (relative)
                execute if score #Physics.Projection.ObjectCorner2.CrossProductAxis.zy Physics > #Physics.Projection.Object.CrossProductAxis.zy.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.zy.Max Physics = #Physics.Projection.ObjectCorner2.CrossProductAxis.zy Physics
                execute if score #Physics.Projection.ObjectCorner4.CrossProductAxis.zy Physics > #Physics.Projection.Object.CrossProductAxis.zy.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.zy.Max Physics = #Physics.Projection.ObjectCorner4.CrossProductAxis.zy Physics
                execute if score #Physics.Projection.ObjectCorner6.CrossProductAxis.zy Physics > #Physics.Projection.Object.CrossProductAxis.zy.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.zy.Max Physics = #Physics.Projection.ObjectCorner6.CrossProductAxis.zy Physics
                execute store result score #Physics.Projection.Object.CrossProductAxis.zy.Min Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.zy.Max Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.Object.CrossProductAxis.zy.Min Physics *= #Physics.Constants.-1 Physics

                # Turn the projections and the min/max global by projecting the center point onto the same axis and adding it
                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.zy Physics = #Physics.ThisObject Physics.Object.Pos.x
                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.zy Physics *= #Physics.CrossProductAxis.zy.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Pos.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.zy.y Physics
                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.zy Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Pos.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.zy.z Physics
                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.zy Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.zy Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.Object.CrossProductAxis.zy.Min Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.zy Physics
                scoreboard players operation #Physics.Projection.Object.CrossProductAxis.zy.Max Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.zy Physics

            # Projection: Other
            # (Important): Because the cross product is perpendicular to the other object's y axis, points along that axis have the same projection. Because of this: Corner 4 = Corner 0 / Corner 5 = Corner 1 / Corner 6 = Corner 2 / Corner 7 = Corner 3
                # Corner 0
                scoreboard players operation #Physics.Projection.OtherObjectCorner0.CrossProductAxis.zy Physics = @s Physics.Object.CornerPosRelative.0.x
                scoreboard players operation #Physics.Projection.OtherObjectCorner0.CrossProductAxis.zy Physics *= #Physics.CrossProductAxis.zy.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.0.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.zy.y Physics
                scoreboard players operation #Physics.Projection.OtherObjectCorner0.CrossProductAxis.zy Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.0.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.zy.z Physics
                execute store result score #Physics.Projection.OtherObjectCorner3.CrossProductAxis.zy Physics store result score #Physics.Projection.OtherObject.CrossProductAxis.zy.Max Physics run scoreboard players operation #Physics.Projection.OtherObjectCorner0.CrossProductAxis.zy Physics += #Physics.Maths.Value1 Physics

                # Corner 1
                scoreboard players operation #Physics.Projection.OtherObjectCorner1.CrossProductAxis.zy Physics = @s Physics.Object.CornerPosRelative.1.x
                scoreboard players operation #Physics.Projection.OtherObjectCorner1.CrossProductAxis.zy Physics *= #Physics.CrossProductAxis.zy.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.1.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.zy.y Physics
                scoreboard players operation #Physics.Projection.OtherObjectCorner1.CrossProductAxis.zy Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.1.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.zy.z Physics
                execute store result score #Physics.Projection.OtherObjectCorner2.CrossProductAxis.zy Physics run scoreboard players operation #Physics.Projection.OtherObjectCorner1.CrossProductAxis.zy Physics += #Physics.Maths.Value1 Physics

                # Corner 2 (Mirrored version of 1)
                scoreboard players operation #Physics.Projection.OtherObjectCorner2.CrossProductAxis.zy Physics *= #Physics.Constants.-1 Physics

                # Corner 3 (Mirrored version of 0)
                scoreboard players operation #Physics.Projection.OtherObjectCorner3.CrossProductAxis.zy Physics *= #Physics.Constants.-1 Physics

                # Find min and max (relative)
                execute if score #Physics.Projection.OtherObjectCorner1.CrossProductAxis.zy Physics > #Physics.Projection.OtherObject.CrossProductAxis.zy.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis.zy.Max Physics = #Physics.Projection.OtherObjectCorner1.CrossProductAxis.zy Physics
                execute if score #Physics.Projection.OtherObjectCorner2.CrossProductAxis.zy Physics > #Physics.Projection.OtherObject.CrossProductAxis.zy.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis.zy.Max Physics = #Physics.Projection.OtherObjectCorner2.CrossProductAxis.zy Physics
                execute if score #Physics.Projection.OtherObjectCorner3.CrossProductAxis.zy Physics > #Physics.Projection.OtherObject.CrossProductAxis.zy.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis.zy.Max Physics = #Physics.Projection.OtherObjectCorner3.CrossProductAxis.zy Physics
                execute store result score #Physics.Projection.OtherObject.CrossProductAxis.zy.Min Physics run scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis.zy.Max Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis.zy.Min Physics *= #Physics.Constants.-1 Physics

                # Turn the projections and the min/max global by projecting the center point onto the same axis and adding it
                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis.zy Physics = @s Physics.Object.Pos.x
                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis.zy Physics *= #Physics.CrossProductAxis.zy.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.Pos.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.zy.y Physics
                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis.zy Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.Pos.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.zy.z Physics
                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis.zy Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis.zy Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis.zy.Min Physics += #Physics.Projection.OtherObjectCenter.CrossProductAxis.zy Physics
                scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis.zy.Max Physics += #Physics.Projection.OtherObjectCenter.CrossProductAxis.zy Physics

            # Overlap check
            execute unless score #Physics.Projection.Object.CrossProductAxis.zy.Min Physics <= #Physics.Projection.OtherObject.CrossProductAxis.zy.Max Physics run return 0
            execute unless score #Physics.Projection.OtherObject.CrossProductAxis.zy.Min Physics <= #Physics.Projection.Object.CrossProductAxis.zy.Max Physics run return 0

        # Cross Product: z_this x z_other
            # Calculation
            scoreboard players operation #Physics.CrossProductAxis.zz.x Physics = #Physics.ThisObject Physics.Object.Axis.z.y
            scoreboard players operation #Physics.CrossProductAxis.zz.x Physics *= @s Physics.Object.Axis.z.z
            scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Axis.z.z
            scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.z.y
            execute store result score #Physics.Maths.SquareRoot.Input Physics run scoreboard players operation #Physics.CrossProductAxis.zz.x Physics -= #Physics.Maths.Value1 Physics

            scoreboard players operation #Physics.CrossProductAxis.zz.y Physics = #Physics.ThisObject Physics.Object.Axis.z.z
            scoreboard players operation #Physics.CrossProductAxis.zz.y Physics *= @s Physics.Object.Axis.z.x
            scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Axis.z.x
            scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.z.z
            execute store result score #Physics.Maths.Value2 Physics run scoreboard players operation #Physics.CrossProductAxis.zz.y Physics -= #Physics.Maths.Value1 Physics

            scoreboard players operation #Physics.CrossProductAxis.zz.z Physics = #Physics.ThisObject Physics.Object.Axis.z.x
            scoreboard players operation #Physics.CrossProductAxis.zz.z Physics *= @s Physics.Object.Axis.z.y
            scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Axis.z.y
            scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.Axis.z.x
            execute store result score #Physics.Maths.Value3 Physics run scoreboard players operation #Physics.CrossProductAxis.zz.z Physics -= #Physics.Maths.Value1 Physics

            # Normalization
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics /= #Physics.Constants.1000 Physics
            scoreboard players operation #Physics.Maths.Value2 Physics /= #Physics.Constants.1000 Physics
            scoreboard players operation #Physics.Maths.Value3 Physics /= #Physics.Constants.1000 Physics

            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics *= #Physics.Maths.SquareRoot.Input Physics
            scoreboard players operation #Physics.Maths.Value2 Physics *= #Physics.Maths.Value2 Physics
            scoreboard players operation #Physics.Maths.Value3 Physics *= #Physics.Maths.Value3 Physics
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics += #Physics.Maths.Value2 Physics
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics += #Physics.Maths.Value3 Physics
            function physics:zprivate/maths/get_square_root

            scoreboard players operation #Physics.CrossProductAxis.zz.x Physics /= #Physics.Maths.SquareRoot.Output Physics
            scoreboard players operation #Physics.CrossProductAxis.zz.y Physics /= #Physics.Maths.SquareRoot.Output Physics
            scoreboard players operation #Physics.CrossProductAxis.zz.z Physics /= #Physics.Maths.SquareRoot.Output Physics
            # Projection: This
            # (Important): Because the cross product is perpendicular to this object's z axis, points along that axis have the same projection. Because of this: Corner 1 = Corner 0 / Corner 3 = Corner 2 / Corner 5 = Corner 4 / Corner 7 = Corner 6
                # Corner 0
                scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.zz Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.0.x
                scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.zz Physics *= #Physics.CrossProductAxis.zz.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.0.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.zz.y Physics
                scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.zz Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.0.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.zz.z Physics
                execute store result score #Physics.Projection.ObjectCorner6.CrossProductAxis.zz Physics store result score #Physics.Projection.Object.CrossProductAxis.zz.Max Physics run scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.zz Physics += #Physics.Maths.Value1 Physics

                # Corner 2
                scoreboard players operation #Physics.Projection.ObjectCorner2.CrossProductAxis.zz Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.2.x
                scoreboard players operation #Physics.Projection.ObjectCorner2.CrossProductAxis.zz Physics *= #Physics.CrossProductAxis.zz.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.2.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.zz.y Physics
                scoreboard players operation #Physics.Projection.ObjectCorner2.CrossProductAxis.zz Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosRelative.2.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.zz.z Physics
                execute store result score #Physics.Projection.ObjectCorner4.CrossProductAxis.zz Physics run scoreboard players operation #Physics.Projection.ObjectCorner2.CrossProductAxis.zz Physics += #Physics.Maths.Value1 Physics

                # Corner 4 (Mirrored version of 2)
                scoreboard players operation #Physics.Projection.ObjectCorner4.CrossProductAxis.zz Physics *= #Physics.Constants.-1 Physics

                # Corner 6 (Mirrored version of 0)
                scoreboard players operation #Physics.Projection.ObjectCorner6.CrossProductAxis.zz Physics *= #Physics.Constants.-1 Physics

                # Find min and max (relative)
                execute if score #Physics.Projection.ObjectCorner2.CrossProductAxis.zz Physics > #Physics.Projection.Object.CrossProductAxis.zz.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.zz.Max Physics = #Physics.Projection.ObjectCorner2.CrossProductAxis.zz Physics
                execute if score #Physics.Projection.ObjectCorner4.CrossProductAxis.zz Physics > #Physics.Projection.Object.CrossProductAxis.zz.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.zz.Max Physics = #Physics.Projection.ObjectCorner4.CrossProductAxis.zz Physics
                execute if score #Physics.Projection.ObjectCorner6.CrossProductAxis.zz Physics > #Physics.Projection.Object.CrossProductAxis.zz.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.zz.Max Physics = #Physics.Projection.ObjectCorner6.CrossProductAxis.zz Physics
                execute store result score #Physics.Projection.Object.CrossProductAxis.zz.Min Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.zz.Max Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.Object.CrossProductAxis.zz.Min Physics *= #Physics.Constants.-1 Physics

                # Turn the projections and the min/max global by projecting the center point onto the same axis and adding it
                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.zz Physics = #Physics.ThisObject Physics.Object.Pos.x
                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.zz Physics *= #Physics.CrossProductAxis.zz.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Pos.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.zz.y Physics
                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.zz Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.Pos.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.zz.z Physics
                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.zz Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.zz Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.Object.CrossProductAxis.zz.Min Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.zz Physics
                scoreboard players operation #Physics.Projection.Object.CrossProductAxis.zz.Max Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.zz Physics

            # Projection: Other
            # (Important): Because the cross product is perpendicular to the other object's z axis, points along that axis have the same projection. Because of this: Corner 1 = Corner 0 / Corner 3 = Corner 2 / Corner 5 = Corner 4 / Corner 7 = Corner 6
                # Corner 0
                scoreboard players operation #Physics.Projection.OtherObjectCorner0.CrossProductAxis.zz Physics = @s Physics.Object.CornerPosRelative.0.x
                scoreboard players operation #Physics.Projection.OtherObjectCorner0.CrossProductAxis.zz Physics *= #Physics.CrossProductAxis.zz.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.0.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.zz.y Physics
                scoreboard players operation #Physics.Projection.OtherObjectCorner0.CrossProductAxis.zz Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.0.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.zz.z Physics
                execute store result score #Physics.Projection.OtherObjectCorner6.CrossProductAxis.zz Physics store result score #Physics.Projection.OtherObject.CrossProductAxis.zz.Max Physics run scoreboard players operation #Physics.Projection.OtherObjectCorner0.CrossProductAxis.zz Physics += #Physics.Maths.Value1 Physics

                # Corner 2
                scoreboard players operation #Physics.Projection.OtherObjectCorner2.CrossProductAxis.zz Physics = @s Physics.Object.CornerPosRelative.2.x
                scoreboard players operation #Physics.Projection.OtherObjectCorner2.CrossProductAxis.zz Physics *= #Physics.CrossProductAxis.zz.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.2.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.zz.y Physics
                scoreboard players operation #Physics.Projection.OtherObjectCorner2.CrossProductAxis.zz Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.CornerPosRelative.2.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.zz.z Physics
                execute store result score #Physics.Projection.OtherObjectCorner4.CrossProductAxis.zz Physics run scoreboard players operation #Physics.Projection.OtherObjectCorner2.CrossProductAxis.zz Physics += #Physics.Maths.Value1 Physics

                # Corner 4 (Mirrored version of 2)
                scoreboard players operation #Physics.Projection.OtherObjectCorner4.CrossProductAxis.zz Physics *= #Physics.Constants.-1 Physics

                # Corner 6 (Mirrored version of 0)
                scoreboard players operation #Physics.Projection.OtherObjectCorner6.CrossProductAxis.zz Physics *= #Physics.Constants.-1 Physics

                # Find min and max (relative)
                execute if score #Physics.Projection.OtherObjectCorner2.CrossProductAxis.zz Physics > #Physics.Projection.OtherObject.CrossProductAxis.zz.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis.zz.Max Physics = #Physics.Projection.OtherObjectCorner2.CrossProductAxis.zz Physics
                execute if score #Physics.Projection.OtherObjectCorner4.CrossProductAxis.zz Physics > #Physics.Projection.OtherObject.CrossProductAxis.zz.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis.zz.Max Physics = #Physics.Projection.OtherObjectCorner4.CrossProductAxis.zz Physics
                execute if score #Physics.Projection.OtherObjectCorner6.CrossProductAxis.zz Physics > #Physics.Projection.OtherObject.CrossProductAxis.zz.Max Physics run scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis.zz.Max Physics = #Physics.Projection.OtherObjectCorner6.CrossProductAxis.zz Physics
                execute store result score #Physics.Projection.OtherObject.CrossProductAxis.zz.Min Physics run scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis.zz.Max Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis.zz.Min Physics *= #Physics.Constants.-1 Physics

                # Turn the projections and the min/max global by projecting the center point onto the same axis and adding it
                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis.zz Physics = @s Physics.Object.Pos.x
                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis.zz Physics *= #Physics.CrossProductAxis.zz.x Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.Pos.y
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.zz.y Physics
                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis.zz Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.Pos.z
                scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.CrossProductAxis.zz.z Physics
                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis.zz Physics += #Physics.Maths.Value1 Physics

                scoreboard players operation #Physics.Projection.OtherObjectCenter.CrossProductAxis.zz Physics /= #Physics.Constants.1000 Physics
                scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis.zz.Min Physics += #Physics.Projection.OtherObjectCenter.CrossProductAxis.zz Physics
                scoreboard players operation #Physics.Projection.OtherObject.CrossProductAxis.zz.Max Physics += #Physics.Projection.OtherObjectCenter.CrossProductAxis.zz Physics

            # Overlap check
            execute unless score #Physics.Projection.Object.CrossProductAxis.zz.Min Physics <= #Physics.Projection.OtherObject.CrossProductAxis.zz.Max Physics run return 0
            execute unless score #Physics.Projection.OtherObject.CrossProductAxis.zz.Min Physics <= #Physics.Projection.Object.CrossProductAxis.zz.Max Physics run return 0

# Create an entry in the final storage
data modify storage physics:zprivate ContactGroups[-1].Objects append value {}
execute store result storage physics:zprivate ContactGroups[-1].Objects[-1].B int 1 run scoreboard players get @s Physics.Object.ID

# Get how much each axis is overlapping & get the least overlap
# (Important): If two axes are exactly parallel to each other (Like if the objects are resting ontop of each other), their cross product is [0,0,0]. I'm unsure if discarding cross products with an overlap of 0 or with a value of [0,0,0] is more stable, so I'll revisit it once the resolver is done. For now, I discard cross products with an overlap of 0.
    # x_this
    scoreboard players operation #Physics.Overlap.ObjectAxis.x Physics = #Physics.ThisObject Physics.Object.ProjectionOwnAxis.x.Max
    scoreboard players operation #Physics.Overlap.ObjectAxis.x Physics -= #Physics.Projection.OtherObject.ObjectAxis.x.Min Physics
    scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.Projection.OtherObject.ObjectAxis.x.Max Physics
    scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.ThisObject Physics.Object.ProjectionOwnAxis.x.Min
    execute if score #Physics.Overlap.ObjectAxis.x Physics > #Physics.Maths.Value1 Physics run scoreboard players operation #Physics.Overlap.ObjectAxis.x Physics = #Physics.Maths.Value1 Physics

    scoreboard players operation #Physics.MinOverlap Physics = #Physics.Overlap.ObjectAxis.x Physics

    # y_this
    scoreboard players operation #Physics.Overlap.ObjectAxis.y Physics = #Physics.ThisObject Physics.Object.ProjectionOwnAxis.y.Max
    scoreboard players operation #Physics.Overlap.ObjectAxis.y Physics -= #Physics.Projection.OtherObject.ObjectAxis.y.Min Physics
    scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.Projection.OtherObject.ObjectAxis.y.Max Physics
    scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.ThisObject Physics.Object.ProjectionOwnAxis.y.Min
    execute if score #Physics.Overlap.ObjectAxis.y Physics > #Physics.Maths.Value1 Physics run scoreboard players operation #Physics.Overlap.ObjectAxis.y Physics = #Physics.Maths.Value1 Physics

    execute if score #Physics.MinOverlap Physics > #Physics.Overlap.ObjectAxis.y Physics run scoreboard players operation #Physics.MinOverlap Physics = #Physics.Overlap.ObjectAxis.y Physics

    # z_this
    scoreboard players operation #Physics.Overlap.ObjectAxis.z Physics = #Physics.ThisObject Physics.Object.ProjectionOwnAxis.z.Max
    scoreboard players operation #Physics.Overlap.ObjectAxis.z Physics -= #Physics.Projection.OtherObject.ObjectAxis.z.Min Physics
    scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.Projection.OtherObject.ObjectAxis.z.Max Physics
    scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.ThisObject Physics.Object.ProjectionOwnAxis.z.Min
    execute if score #Physics.Overlap.ObjectAxis.z Physics > #Physics.Maths.Value1 Physics run scoreboard players operation #Physics.Overlap.ObjectAxis.z Physics = #Physics.Maths.Value1 Physics

    execute if score #Physics.MinOverlap Physics > #Physics.Overlap.ObjectAxis.z Physics run scoreboard players operation #Physics.MinOverlap Physics = #Physics.Overlap.ObjectAxis.z Physics

    # x_other
    scoreboard players operation #Physics.Overlap.OtherObjectAxis.x Physics = #Physics.Projection.Object.OtherObjectAxis.x.Max Physics
    scoreboard players operation #Physics.Overlap.OtherObjectAxis.x Physics -= @s Physics.Object.ProjectionOwnAxis.x.Min
    scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.ProjectionOwnAxis.x.Max
    scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.Projection.Object.OtherObjectAxis.x.Min Physics
    execute if score #Physics.Overlap.OtherObjectAxis.x Physics > #Physics.Maths.Value1 Physics run scoreboard players operation #Physics.Overlap.OtherObjectAxis.x Physics = #Physics.Maths.Value1 Physics

    execute if score #Physics.MinOverlap Physics > #Physics.Overlap.OtherObjectAxis.x Physics run scoreboard players operation #Physics.MinOverlap Physics = #Physics.Overlap.OtherObjectAxis.x Physics

    # y_other
    scoreboard players operation #Physics.Overlap.OtherObjectAxis.y Physics = #Physics.Projection.Object.OtherObjectAxis.y.Max Physics
    scoreboard players operation #Physics.Overlap.OtherObjectAxis.y Physics -= @s Physics.Object.ProjectionOwnAxis.y.Min
    scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.ProjectionOwnAxis.y.Max
    scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.Projection.Object.OtherObjectAxis.y.Min Physics
    execute if score #Physics.Overlap.OtherObjectAxis.y Physics > #Physics.Maths.Value1 Physics run scoreboard players operation #Physics.Overlap.OtherObjectAxis.y Physics = #Physics.Maths.Value1 Physics

    execute if score #Physics.MinOverlap Physics > #Physics.Overlap.OtherObjectAxis.y Physics run scoreboard players operation #Physics.MinOverlap Physics = #Physics.Overlap.OtherObjectAxis.y Physics

    # z_other
    scoreboard players operation #Physics.Overlap.OtherObjectAxis.z Physics = #Physics.Projection.Object.OtherObjectAxis.z.Max Physics
    scoreboard players operation #Physics.Overlap.OtherObjectAxis.z Physics -= @s Physics.Object.ProjectionOwnAxis.z.Min
    scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.ProjectionOwnAxis.z.Max
    scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.Projection.Object.OtherObjectAxis.z.Min Physics
    execute if score #Physics.Overlap.OtherObjectAxis.z Physics > #Physics.Maths.Value1 Physics run scoreboard players operation #Physics.Overlap.OtherObjectAxis.z Physics = #Physics.Maths.Value1 Physics

    execute if score #Physics.MinOverlap Physics > #Physics.Overlap.OtherObjectAxis.z Physics run scoreboard players operation #Physics.MinOverlap Physics = #Physics.Overlap.OtherObjectAxis.z Physics

    # Cross Product: x_this x x_other
    scoreboard players operation #Physics.Overlap.CrossProductAxis.xx Physics = #Physics.Projection.Object.CrossProductAxis.xx.Max Physics
    scoreboard players operation #Physics.Overlap.CrossProductAxis.xx Physics -= #Physics.Projection.OtherObject.CrossProductAxis.xx.Min Physics
    scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.Projection.OtherObject.CrossProductAxis.xx.Max Physics
    scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.Projection.Object.CrossProductAxis.xx.Min Physics
    execute if score #Physics.Overlap.CrossProductAxis.xx Physics > #Physics.Maths.Value1 Physics run scoreboard players operation #Physics.Overlap.CrossProductAxis.xx Physics = #Physics.Maths.Value1 Physics

    execute if score #Physics.MinOverlap Physics > #Physics.Overlap.CrossProductAxis.xx Physics unless score #Physics.Overlap.CrossProductAxis.xx Physics matches 0 run scoreboard players operation #Physics.MinOverlap Physics = #Physics.Overlap.CrossProductAxis.xx Physics

    # Cross Product: x_this x y_other
    scoreboard players operation #Physics.Overlap.CrossProductAxis.xy Physics = #Physics.Projection.Object.CrossProductAxis.xy.Max Physics
    scoreboard players operation #Physics.Overlap.CrossProductAxis.xy Physics -= #Physics.Projection.OtherObject.CrossProductAxis.xy.Min Physics
    scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.Projection.OtherObject.CrossProductAxis.xy.Max Physics
    scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.Projection.Object.CrossProductAxis.xy.Min Physics
    execute if score #Physics.Overlap.CrossProductAxis.xy Physics > #Physics.Maths.Value1 Physics run scoreboard players operation #Physics.Overlap.CrossProductAxis.xy Physics = #Physics.Maths.Value1 Physics

    execute if score #Physics.MinOverlap Physics > #Physics.Overlap.CrossProductAxis.xy Physics unless score #Physics.Overlap.CrossProductAxis.xy Physics matches 0 run scoreboard players operation #Physics.MinOverlap Physics = #Physics.Overlap.CrossProductAxis.xy Physics

    # Cross Product: x_this x z_other
    scoreboard players operation #Physics.Overlap.CrossProductAxis.xz Physics = #Physics.Projection.Object.CrossProductAxis.xz.Max Physics
    scoreboard players operation #Physics.Overlap.CrossProductAxis.xz Physics -= #Physics.Projection.OtherObject.CrossProductAxis.xz.Min Physics
    scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.Projection.OtherObject.CrossProductAxis.xz.Max Physics
    scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.Projection.Object.CrossProductAxis.xz.Min Physics
    execute if score #Physics.Overlap.CrossProductAxis.xz Physics > #Physics.Maths.Value1 Physics run scoreboard players operation #Physics.Overlap.CrossProductAxis.xz Physics = #Physics.Maths.Value1 Physics

    execute if score #Physics.MinOverlap Physics > #Physics.Overlap.CrossProductAxis.xz Physics unless score #Physics.Overlap.CrossProductAxis.xz Physics matches 0 run scoreboard players operation #Physics.MinOverlap Physics = #Physics.Overlap.CrossProductAxis.xz Physics

    # Cross Product: y_this x x_other
    scoreboard players operation #Physics.Overlap.CrossProductAxis.yx Physics = #Physics.Projection.Object.CrossProductAxis.yx.Max Physics
    scoreboard players operation #Physics.Overlap.CrossProductAxis.yx Physics -= #Physics.Projection.OtherObject.CrossProductAxis.yx.Min Physics
    scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.Projection.OtherObject.CrossProductAxis.yx.Max Physics
    scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.Projection.Object.CrossProductAxis.yx.Min Physics
    execute if score #Physics.Overlap.CrossProductAxis.yx Physics > #Physics.Maths.Value1 Physics run scoreboard players operation #Physics.Overlap.CrossProductAxis.yx Physics = #Physics.Maths.Value1 Physics

    execute if score #Physics.MinOverlap Physics > #Physics.Overlap.CrossProductAxis.yx Physics unless score #Physics.Overlap.CrossProductAxis.yx Physics matches 0 run scoreboard players operation #Physics.MinOverlap Physics = #Physics.Overlap.CrossProductAxis.yx Physics

    # Cross Product: y_this x y_other
    scoreboard players operation #Physics.Overlap.CrossProductAxis.yy Physics = #Physics.Projection.Object.CrossProductAxis.yy.Max Physics
    scoreboard players operation #Physics.Overlap.CrossProductAxis.yy Physics -= #Physics.Projection.OtherObject.CrossProductAxis.yy.Min Physics
    scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.Projection.OtherObject.CrossProductAxis.yy.Max Physics
    scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.Projection.Object.CrossProductAxis.yy.Min Physics
    execute if score #Physics.Overlap.CrossProductAxis.yy Physics > #Physics.Maths.Value1 Physics run scoreboard players operation #Physics.Overlap.CrossProductAxis.yy Physics = #Physics.Maths.Value1 Physics

    execute if score #Physics.MinOverlap Physics > #Physics.Overlap.CrossProductAxis.yy Physics unless score #Physics.Overlap.CrossProductAxis.yy Physics matches 0 run scoreboard players operation #Physics.MinOverlap Physics = #Physics.Overlap.CrossProductAxis.yy Physics

    # Cross Product: y_this x z_other
    scoreboard players operation #Physics.Overlap.CrossProductAxis.yz Physics = #Physics.Projection.Object.CrossProductAxis.yz.Max Physics
    scoreboard players operation #Physics.Overlap.CrossProductAxis.yz Physics -= #Physics.Projection.OtherObject.CrossProductAxis.yz.Min Physics
    scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.Projection.OtherObject.CrossProductAxis.yz.Max Physics
    scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.Projection.Object.CrossProductAxis.yz.Min Physics
    execute if score #Physics.Overlap.CrossProductAxis.yz Physics > #Physics.Maths.Value1 Physics run scoreboard players operation #Physics.Overlap.CrossProductAxis.yz Physics = #Physics.Maths.Value1 Physics

    execute if score #Physics.MinOverlap Physics > #Physics.Overlap.CrossProductAxis.yz Physics unless score #Physics.Overlap.CrossProductAxis.yz Physics matches 0 run scoreboard players operation #Physics.MinOverlap Physics = #Physics.Overlap.CrossProductAxis.yz Physics

    # Cross Product: z_this x x_other
    scoreboard players operation #Physics.Overlap.CrossProductAxis.zx Physics = #Physics.Projection.Object.CrossProductAxis.zx.Max Physics
    scoreboard players operation #Physics.Overlap.CrossProductAxis.zx Physics -= #Physics.Projection.OtherObject.CrossProductAxis.zx.Min Physics
    scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.Projection.OtherObject.CrossProductAxis.zx.Max Physics
    scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.Projection.Object.CrossProductAxis.zx.Min Physics
    execute if score #Physics.Overlap.CrossProductAxis.zx Physics > #Physics.Maths.Value1 Physics run scoreboard players operation #Physics.Overlap.CrossProductAxis.zx Physics = #Physics.Maths.Value1 Physics

    execute if score #Physics.MinOverlap Physics > #Physics.Overlap.CrossProductAxis.zx Physics unless score #Physics.Overlap.CrossProductAxis.zx Physics matches 0 run scoreboard players operation #Physics.MinOverlap Physics = #Physics.Overlap.CrossProductAxis.zx Physics

    # Cross Product: z_this x y_other
    scoreboard players operation #Physics.Overlap.CrossProductAxis.zy Physics = #Physics.Projection.Object.CrossProductAxis.zy.Max Physics
    scoreboard players operation #Physics.Overlap.CrossProductAxis.zy Physics -= #Physics.Projection.OtherObject.CrossProductAxis.zy.Min Physics
    scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.Projection.OtherObject.CrossProductAxis.zy.Max Physics
    scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.Projection.Object.CrossProductAxis.zy.Min Physics
    execute if score #Physics.Overlap.CrossProductAxis.zy Physics > #Physics.Maths.Value1 Physics run scoreboard players operation #Physics.Overlap.CrossProductAxis.zy Physics = #Physics.Maths.Value1 Physics

    execute if score #Physics.MinOverlap Physics > #Physics.Overlap.CrossProductAxis.zy Physics unless score #Physics.Overlap.CrossProductAxis.zy Physics matches 0 run scoreboard players operation #Physics.MinOverlap Physics = #Physics.Overlap.CrossProductAxis.zy Physics

    # Cross Product: z_this x z_other
    scoreboard players operation #Physics.Overlap.CrossProductAxis.zz Physics = #Physics.Projection.Object.CrossProductAxis.zz.Max Physics
    scoreboard players operation #Physics.Overlap.CrossProductAxis.zz Physics -= #Physics.Projection.OtherObject.CrossProductAxis.zz.Min Physics
    scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.Projection.OtherObject.CrossProductAxis.zz.Max Physics
    scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.Projection.Object.CrossProductAxis.zz.Min Physics
    execute if score #Physics.Overlap.CrossProductAxis.zz Physics > #Physics.Maths.Value1 Physics run scoreboard players operation #Physics.Overlap.CrossProductAxis.zz Physics = #Physics.Maths.Value1 Physics

    execute if score #Physics.MinOverlap Physics > #Physics.Overlap.CrossProductAxis.zz Physics unless score #Physics.Overlap.CrossProductAxis.zz Physics matches 0 run return run function physics:zprivate/contact_generation/new_contact/object/edge_edge/this_axis_z/main {OtherAxis:"z"}

# Get the involved features of both objects
execute if score #Physics.MinOverlap Physics = #Physics.Overlap.ObjectAxis.y Physics run return run function physics:zprivate/contact_generation/new_contact/object/this_axis/main {ObjectAxis:"y"}
execute if score #Physics.MinOverlap Physics = #Physics.Overlap.ObjectAxis.x Physics run return run function physics:zprivate/contact_generation/new_contact/object/this_axis/main {ObjectAxis:"x"}
execute if score #Physics.MinOverlap Physics = #Physics.Overlap.ObjectAxis.z Physics run return run function physics:zprivate/contact_generation/new_contact/object/this_axis/main {ObjectAxis:"z"}
execute if score #Physics.MinOverlap Physics = #Physics.Overlap.OtherObjectAxis.y Physics run return run function physics:zprivate/contact_generation/new_contact/object/other_axis/main {OtherAxis:"y"}
execute if score #Physics.MinOverlap Physics = #Physics.Overlap.OtherObjectAxis.x Physics run return run function physics:zprivate/contact_generation/new_contact/object/other_axis/main {OtherAxis:"x"}
execute if score #Physics.MinOverlap Physics = #Physics.Overlap.OtherObjectAxis.z Physics run return run function physics:zprivate/contact_generation/new_contact/object/other_axis/main {OtherAxis:"z"}
execute if score #Physics.MinOverlap Physics = #Physics.Overlap.CrossProductAxis.xx Physics run return run function physics:zprivate/contact_generation/new_contact/object/edge_edge/this_axis_x/main {OtherAxis:"x"}
execute if score #Physics.MinOverlap Physics = #Physics.Overlap.CrossProductAxis.xy Physics run return run function physics:zprivate/contact_generation/new_contact/object/edge_edge/this_axis_x/main {OtherAxis:"y"}
execute if score #Physics.MinOverlap Physics = #Physics.Overlap.CrossProductAxis.xz Physics run return run function physics:zprivate/contact_generation/new_contact/object/edge_edge/this_axis_x/main {OtherAxis:"z"}
execute if score #Physics.MinOverlap Physics = #Physics.Overlap.CrossProductAxis.yx Physics run return run function physics:zprivate/contact_generation/new_contact/object/edge_edge/this_axis_y/main {OtherAxis:"x"}
execute if score #Physics.MinOverlap Physics = #Physics.Overlap.CrossProductAxis.yy Physics run return run function physics:zprivate/contact_generation/new_contact/object/edge_edge/this_axis_y/main {OtherAxis:"y"}
execute if score #Physics.MinOverlap Physics = #Physics.Overlap.CrossProductAxis.yz Physics run return run function physics:zprivate/contact_generation/new_contact/object/edge_edge/this_axis_y/main {OtherAxis:"z"}
execute if score #Physics.MinOverlap Physics = #Physics.Overlap.CrossProductAxis.zx Physics run return run function physics:zprivate/contact_generation/new_contact/object/edge_edge/this_axis_z/main {OtherAxis:"x"}
function physics:zprivate/contact_generation/new_contact/object/edge_edge/this_axis_z/main {OtherAxis:"y"}
