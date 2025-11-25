# Check if the player's line of sight intersects with the object's AABB
    # Get the ray's origin relative to the object's origin & the ray's direction
    execute if score #Physics.GotRayPos Physics matches 0 run function physics:zprivate/line_of_sight/get_ray

    scoreboard players operation #Physics.RayPosRelative.x Physics = #Physics.RayPosOriginal.x Physics
    scoreboard players operation #Physics.RayPosRelative.y Physics = #Physics.RayPosOriginal.y Physics
    scoreboard players operation #Physics.RayPosRelative.z Physics = #Physics.RayPosOriginal.z Physics

    scoreboard players operation #Physics.RayPosRelative.x Physics -= @s Physics.Object.Pos.x
    scoreboard players operation #Physics.RayPosRelative.y Physics -= @s Physics.Object.Pos.y
    scoreboard players operation #Physics.RayPosRelative.z Physics -= @s Physics.Object.Pos.z

# If the ray hits the AABB (& the distance is less than the current MinDistance, in case another object is in front of that), run the detailed check
# (Important): The relative position is scaled up by 1,000x (So 1,000,000x in total) to provide accuracy when calculating t. Because of this, I use relative coordinates instead of absolute ones, to avoid overflows.
# (Important): The "exiting faces" checks explicitly allow for punching the object while facing the backside of a surface.
# (Important): If the 1st check for any face (entering the object) succeeds, all other checks can be ignored (there will at most be a single more intersection that goes out of the object which would be farther away). If the 2nd check for any face (exiting the object) succeeds, all remaining "exiting" checks can be ignored too.
scoreboard players operation #Physics.RayPosRelative.x Physics *= #Physics.Constants.1000 Physics
scoreboard players operation #Physics.RayPosRelative.y Physics *= #Physics.Constants.1000 Physics
scoreboard players operation #Physics.RayPosRelative.z Physics *= #Physics.Constants.1000 Physics

    # Entering faces
    scoreboard players set #Physics.IsExitingFaceAABB Physics 0
        # x axis
    execute if score #Physics.RayPosOriginal.x Physics <= @s Physics.Object.BoundingBoxGlobalMin.x if score #Physics.RayDirectionOriginal.x Physics matches 0.. if function physics:zprivate/line_of_sight/check_ray_intersections/aabb/0 run return run function physics:zprivate/line_of_sight/check_precise_intersection
    execute if score #Physics.RayPosOriginal.x Physics >= @s Physics.Object.BoundingBoxGlobalMax.x if score #Physics.RayDirectionOriginal.x Physics matches ..-1 if function physics:zprivate/line_of_sight/check_ray_intersections/aabb/1 run return run function physics:zprivate/line_of_sight/check_precise_intersection

        # y axis
    execute if score #Physics.RayPosOriginal.y Physics <= @s Physics.Object.BoundingBoxGlobalMin.y if score #Physics.RayDirectionOriginal.y Physics matches 0.. if function physics:zprivate/line_of_sight/check_ray_intersections/aabb/2 run return run function physics:zprivate/line_of_sight/check_precise_intersection
    execute if score #Physics.RayPosOriginal.y Physics >= @s Physics.Object.BoundingBoxGlobalMax.y if score #Physics.RayDirectionOriginal.y Physics matches ..-1 if function physics:zprivate/line_of_sight/check_ray_intersections/aabb/3 run return run function physics:zprivate/line_of_sight/check_precise_intersection

        # z axis
    execute if score #Physics.RayPosOriginal.z Physics <= @s Physics.Object.BoundingBoxGlobalMin.z if score #Physics.RayDirectionOriginal.z Physics matches 0.. if function physics:zprivate/line_of_sight/check_ray_intersections/aabb/4 run return run function physics:zprivate/line_of_sight/check_precise_intersection
    execute if score #Physics.RayPosOriginal.z Physics >= @s Physics.Object.BoundingBoxGlobalMax.z if score #Physics.RayDirectionOriginal.z Physics matches ..-1 if function physics:zprivate/line_of_sight/check_ray_intersections/aabb/5 run return run function physics:zprivate/line_of_sight/check_precise_intersection

    # Exiting faces
    # (Important): For AABB, when exiting faces, I'll ignore the EntityInteractionRange. That's because the distance to exit the AABB can be vastly greater than the distance to intersect with the model itself.
    scoreboard players set #Physics.IsExitingFaceAABB Physics 1

        # x axis
    execute if score #Physics.RayPosOriginal.x Physics > @s Physics.Object.BoundingBoxGlobalMin.x if score #Physics.RayDirectionOriginal.x Physics matches ..-1 if function physics:zprivate/line_of_sight/check_ray_intersections/aabb/0 run return run function physics:zprivate/line_of_sight/check_precise_intersection
    execute if score #Physics.RayPosOriginal.x Physics < @s Physics.Object.BoundingBoxGlobalMax.x if score #Physics.RayDirectionOriginal.x Physics matches 0.. if function physics:zprivate/line_of_sight/check_ray_intersections/aabb/1 run return run function physics:zprivate/line_of_sight/check_precise_intersection

        # y axis
    execute if score #Physics.RayPosOriginal.y Physics > @s Physics.Object.BoundingBoxGlobalMin.y if score #Physics.RayDirectionOriginal.y Physics matches ..-1 if function physics:zprivate/line_of_sight/check_ray_intersections/aabb/2 run return run function physics:zprivate/line_of_sight/check_precise_intersection
    execute if score #Physics.RayPosOriginal.y Physics < @s Physics.Object.BoundingBoxGlobalMax.y if score #Physics.RayDirectionOriginal.y Physics matches 0.. if function physics:zprivate/line_of_sight/check_ray_intersections/aabb/3 run return run function physics:zprivate/line_of_sight/check_precise_intersection

        # z axis
    execute if score #Physics.RayPosOriginal.z Physics > @s Physics.Object.BoundingBoxGlobalMin.z if score #Physics.RayDirectionOriginal.z Physics matches ..-1 if function physics:zprivate/line_of_sight/check_ray_intersections/aabb/4 run return run function physics:zprivate/line_of_sight/check_precise_intersection
    execute if score #Physics.RayPosOriginal.z Physics < @s Physics.Object.BoundingBoxGlobalMax.z if score #Physics.RayDirectionOriginal.z Physics matches 0.. if function physics:zprivate/line_of_sight/check_ray_intersections/aabb/5 run function physics:zprivate/line_of_sight/check_precise_intersection
