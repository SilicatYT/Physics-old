# Get the object's feature (Face that's closest to the world-geometry block)
# (Important): There are 2 candidate faces (those normal to the axis), and I select the correct one by looking at the projection of a single point of them and looking which is closer. If I look at the same point for both faces, I can easily get which face is closer.
execute store success score #Physics.InvertValues Physics if score #Physics.ThisObject Physics.Object.BoundingBoxGlobalMin.z < #Physics.Projection.Block.WorldAxis.z.Min Physics
execute if score #Physics.InvertValues Physics matches 1 store result storage physics:temp data.NewContact.FeatureB byte 1 store result storage physics:temp data.FeatureB byte 1 run scoreboard players set #Physics.FeatureB Physics 14
execute if score #Physics.InvertValues Physics matches 0 store result storage physics:temp data.NewContact.FeatureB byte 1 store result storage physics:temp data.FeatureB byte 1 run scoreboard players set #Physics.FeatureB Physics 15

# Get the world-geometry block's feature (Corner that's closest to the object)
# (Important): I check which of the 8 corners' projection is the closest to the object along the axis (furthest along the axis), so I have to get either the min or the max.
execute if score #Physics.InvertValues Physics matches 1 run scoreboard players operation #Physics.DeepestProjection Physics = #Physics.ThisObject Physics.Object.BoundingBoxGlobalMax.z
execute if score #Physics.InvertValues Physics matches 0 run scoreboard players operation #Physics.DeepestProjection Physics = #Physics.ThisObject Physics.Object.BoundingBoxGlobalMin.z

    # Set the feature
    # (Important): There are only 8 corners (and unique macro variable combinations), so everything is cached. Reduces duplicate files.
    execute if score #Physics.DeepestProjection Physics = #Physics.ThisObject Physics.Object.CornerPosGlobal.0.z run function physics:zprivate/contact_generation/new_contact/world/world_axis_z/get_corner {Corner:0b}
    execute if score #Physics.DeepestProjection Physics = #Physics.ThisObject Physics.Object.CornerPosGlobal.1.z run function physics:zprivate/contact_generation/new_contact/world/world_axis_z/get_corner {Corner:1b}
    execute if score #Physics.DeepestProjection Physics = #Physics.ThisObject Physics.Object.CornerPosGlobal.2.z run function physics:zprivate/contact_generation/new_contact/world/world_axis_z/get_corner {Corner:2b}
    execute if score #Physics.DeepestProjection Physics = #Physics.ThisObject Physics.Object.CornerPosGlobal.3.z run function physics:zprivate/contact_generation/new_contact/world/world_axis_z/get_corner {Corner:3b}
    execute if score #Physics.DeepestProjection Physics = #Physics.ThisObject Physics.Object.CornerPosGlobal.4.z run function physics:zprivate/contact_generation/new_contact/world/world_axis_z/get_corner {Corner:4b}
    execute if score #Physics.DeepestProjection Physics = #Physics.ThisObject Physics.Object.CornerPosGlobal.5.z run function physics:zprivate/contact_generation/new_contact/world/world_axis_z/get_corner {Corner:5b}
    execute if score #Physics.DeepestProjection Physics = #Physics.ThisObject Physics.Object.CornerPosGlobal.6.z run function physics:zprivate/contact_generation/new_contact/world/world_axis_z/get_corner {Corner:6b}
    execute if score #Physics.DeepestProjection Physics = #Physics.ThisObject Physics.Object.CornerPosGlobal.7.z run function physics:zprivate/contact_generation/new_contact/world/world_axis_z/get_corner {Corner:7b}

# Calculate Penetration Depth, Contact Normal, Contact Point & Separating Velocity
    # Penetration Depth
    # (Important): For point-face collisions, the penetration depth is the projection of (point - <any point on the face>) onto the contact normal. It's distributive, so I can also subtract the projection of any point on the face from the (already calculated) projection of the corner.
    # (Important): Calculations are done in "get_corner/..." to avoid redundant score checks and to utilize "return run".

    # Contact Normal
    # (Important): For point-face collisions, the contact normal is the face's normal. So it's the axis of minimum overlap.
    # (Important): The scores are set for accumulation later.
    execute if score #Physics.InvertValues Physics matches 0 run data modify storage physics:temp data.NewContact.ContactNormal set value [I;0,0,1000]
    execute if score #Physics.InvertValues Physics matches 0 run scoreboard players set #Physics.ContactNormal.z Physics 1000
    execute store result score #Physics.ContactNormal.y Physics run scoreboard players set #Physics.ContactNormal.x Physics 0

    # Contact Point
    # (Important): For point-face collisions, the contact point is the point projected onto the surface (= moved along contact normal with the penetration depth as the amount).
    # (Important): I use the "execute store" from earlier to avoid an additional scoreboard call. Also, the point's coordinates are copied over in "get_corner/...".

    # Separating Velocity
    # (Important): The separating velocity is the dot product between the contact point's relative velocity and the contact normal. The relative velocity is the cross product between the angular velocity and the contact point (relative to the object's center) that's added together with the object's linear velocity.
    # (Important): Because the static object is now the one with the face, the result of the separating velocity is inverted.
        # Calculate relative contact point
        execute store result score #Physics.PointVelocity.z Physics run scoreboard players operation #Physics.ContactPoint.x Physics -= #Physics.ThisObject Physics.Object.Pos.x
        execute store result score #Physics.PointVelocity.x Physics run scoreboard players operation #Physics.ContactPoint.y Physics -= #Physics.ThisObject Physics.Object.Pos.y
        execute store result score #Physics.PointVelocity.y Physics run scoreboard players operation #Physics.ContactPoint.z Physics -= #Physics.ThisObject Physics.Object.Pos.z

        # Calculate cross product between angular velocity and relative contact point
        # (Important): I overwrite the contact point scores here, as I don't need them anymore after this.
        # (Important): I messed up the order (relativeContactPoint x angularVelocity instead of angularVelocity x relativeContactPoint). To accomodate for that without spending hours rewriting it, I divide by -1000 instead of 1000.
        # (Important): Although I only need a single component for the separating velocity, I still need the full ContactVelocity vector to calculate the impulse (because of friction).
        # (Important): For world_axis_? ONLY: ContactVelocity is A - B, so I keep the calculations inverted, so that projecting ContactVelocity onto the ContactNormal gives the SeparatingVelocity directly.
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
        # (Important): Normally you just subtract it from SeparatingVelocity so that ContactVelocity remains intact (the tangents need to be untouched!), but if I subtract the projection from both, then I don't have to repeatedly do that during each iteration of resolution.
        # (Important): Because the contact normal is axis-aligned, these calculations are simplified.
        # ...

        # Add the linear velocity to obtain the relative velocity of the contact point
        execute store result storage physics:temp data.NewContact.ContactVelocity[0] int 1 run scoreboard players operation #Physics.PointVelocity.x Physics += #Physics.ThisObject Physics.Object.Velocity.x
        execute store result storage physics:temp data.NewContact.ContactVelocity[1] int 1 run scoreboard players operation #Physics.PointVelocity.y Physics += #Physics.ThisObject Physics.Object.Velocity.y
        execute store result storage physics:temp data.NewContact.ContactVelocity[2] int 1 run scoreboard players operation #Physics.PointVelocity.z Physics += #Physics.ThisObject Physics.Object.Velocity.z

        # Take the dot product with the contact normal
        # (Important): For the SeparatingVelocity, I only care about a single component because the contact normal is a world axis.
        execute if score #Physics.InvertValues Physics matches 1 run scoreboard players operation #Physics.PointVelocity.z Physics *= #Physics.Constants.-1 Physics
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
