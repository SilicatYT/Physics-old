# Face 4: Negative z

# Step 1: Calculate t = (aabb_z_max_relative - origin_z) / direction_z
scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.BoundingBoxGlobalMin.z
scoreboard players operation #Physics.Maths.Value1 Physics -= @s Physics.Object.Pos.z
scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.Constants.1000 Physics
scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.RayPosRelative.z Physics
execute store result score #Physics.RayIntersection.t Physics run scoreboard players operation #Physics.Maths.Value1 Physics /= #Physics.RayDirectionOriginal.z Physics

# Step 2: If t is too large, stop. This means no collision with this face is happening.
execute if score #Physics.IsExitingFaceAABB Physics matches 0 if score #Physics.Maths.Value1 Physics > #Physics.EntityInteractionRange Physics run return 0

# Step 3: Calculate the point of intersection for the other two axes: origin + t * direction
    # x
    scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.RayDirectionOriginal.x Physics
    scoreboard players operation #Physics.Maths.Value1 Physics += #Physics.RayPosRelative.x Physics

    scoreboard players operation #Physics.RelativeAABB.x.Max Physics = @s Physics.Object.BoundingBoxGlobalMax.x
    scoreboard players operation #Physics.RelativeAABB.x.Max Physics -= @s Physics.Object.Pos.x
    scoreboard players operation #Physics.RelativeAABB.x.Max Physics *= #Physics.Constants.1000 Physics
    execute if score #Physics.Maths.Value1 Physics > #Physics.RelativeAABB.x.Max Physics run return 0

    scoreboard players operation #Physics.RelativeAABB.x.Min Physics = @s Physics.Object.BoundingBoxGlobalMin.x
    scoreboard players operation #Physics.RelativeAABB.x.Min Physics -= @s Physics.Object.Pos.x
    scoreboard players operation #Physics.RelativeAABB.x.Min Physics *= #Physics.Constants.1000 Physics
    execute if score #Physics.Maths.Value1 Physics < #Physics.RelativeAABB.x.Min Physics run return 0

    # y
    scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.RayIntersection.t Physics
    scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.RayDirectionOriginal.y Physics
    scoreboard players operation #Physics.Maths.Value1 Physics += #Physics.RayPosRelative.y Physics

    scoreboard players operation #Physics.RelativeAABB.y.Max Physics = @s Physics.Object.BoundingBoxGlobalMax.y
    scoreboard players operation #Physics.RelativeAABB.y.Max Physics -= @s Physics.Object.Pos.y
    scoreboard players operation #Physics.RelativeAABB.y.Max Physics *= #Physics.Constants.1000 Physics
    execute if score #Physics.Maths.Value1 Physics > #Physics.RelativeAABB.y.Max Physics run return 0

    scoreboard players operation #Physics.RelativeAABB.y.Min Physics = @s Physics.Object.BoundingBoxGlobalMin.y
    scoreboard players operation #Physics.RelativeAABB.y.Min Physics -= @s Physics.Object.Pos.y
    scoreboard players operation #Physics.RelativeAABB.y.Min Physics *= #Physics.Constants.1000 Physics
    execute if score #Physics.Maths.Value1 Physics < #Physics.RelativeAABB.y.Min Physics run return 0

execute if score #Physics.IsExitingFaceAABB Physics matches 1 run return 1
execute if score #Physics.RayIntersection.t Physics < #Physics.MinDistance Physics run return 1
