# Transform the relative ray origin to the object's local coordinate system by applying the transpose of the rotation matrix (Transpose because I convert from world to local coordinates)
# (Important): Because of the multiplication, I need to divide the result by 1,000 to keep the 1,000x scaling. But I divide by the object's dimensions afterwards, which does the job too. Same applies for the ray direction.
scoreboard players operation #Physics.RayPosRelative.x Physics /= #Physics.Constants.1000 Physics
scoreboard players operation #Physics.RayPosRelative.y Physics /= #Physics.Constants.1000 Physics
scoreboard players operation #Physics.RayPosRelative.z Physics /= #Physics.Constants.1000 Physics

scoreboard players operation #Physics.RayPosLocal.x Physics = @s Physics.Object.RotationMatrixTranspose.0
scoreboard players operation #Physics.RayPosLocal.x Physics *= #Physics.RayPosRelative.x Physics
scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.RotationMatrixTranspose.1
scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.RayPosRelative.y Physics
scoreboard players operation #Physics.RayPosLocal.x Physics += #Physics.Maths.Value1 Physics
scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.RotationMatrixTranspose.2
scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.RayPosRelative.z Physics
scoreboard players operation #Physics.RayPosLocal.x Physics += #Physics.Maths.Value1 Physics

scoreboard players operation #Physics.RayPosLocal.y Physics = @s Physics.Object.RotationMatrixTranspose.3
scoreboard players operation #Physics.RayPosLocal.y Physics *= #Physics.RayPosRelative.x Physics
scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.RotationMatrixTranspose.4
scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.RayPosRelative.y Physics
scoreboard players operation #Physics.RayPosLocal.y Physics += #Physics.Maths.Value1 Physics
scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.RotationMatrixTranspose.5
scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.RayPosRelative.z Physics
scoreboard players operation #Physics.RayPosLocal.y Physics += #Physics.Maths.Value1 Physics

scoreboard players operation #Physics.RayPosLocal.z Physics = @s Physics.Object.RotationMatrixTranspose.6
scoreboard players operation #Physics.RayPosLocal.z Physics *= #Physics.RayPosRelative.x Physics
scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.RotationMatrixTranspose.7
scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.RayPosRelative.y Physics
scoreboard players operation #Physics.RayPosLocal.z Physics += #Physics.Maths.Value1 Physics
scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.RotationMatrixTranspose.8
scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.RayPosRelative.z Physics
scoreboard players operation #Physics.RayPosLocal.z Physics += #Physics.Maths.Value1 Physics

# Transform the ray direction to the object's local coordinate system
scoreboard players operation #Physics.RayDirectionLocal.x Physics = @s Physics.Object.RotationMatrixTranspose.0
scoreboard players operation #Physics.RayDirectionLocal.x Physics *= #Physics.RayDirectionOriginal.x Physics
scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.RotationMatrixTranspose.1
scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.RayDirectionOriginal.y Physics
scoreboard players operation #Physics.RayDirectionLocal.x Physics += #Physics.Maths.Value1 Physics
scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.RotationMatrixTranspose.2
scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.RayDirectionOriginal.z Physics
scoreboard players operation #Physics.RayDirectionLocal.x Physics += #Physics.Maths.Value1 Physics

scoreboard players operation #Physics.RayDirectionLocal.y Physics = @s Physics.Object.RotationMatrixTranspose.3
scoreboard players operation #Physics.RayDirectionLocal.y Physics *= #Physics.RayDirectionOriginal.x Physics
scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.RotationMatrixTranspose.4
scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.RayDirectionOriginal.y Physics
scoreboard players operation #Physics.RayDirectionLocal.y Physics += #Physics.Maths.Value1 Physics
scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.RotationMatrixTranspose.5
scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.RayDirectionOriginal.z Physics
scoreboard players operation #Physics.RayDirectionLocal.y Physics += #Physics.Maths.Value1 Physics

scoreboard players operation #Physics.RayDirectionLocal.z Physics = @s Physics.Object.RotationMatrixTranspose.6
scoreboard players operation #Physics.RayDirectionLocal.z Physics *= #Physics.RayDirectionOriginal.x Physics
scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.RotationMatrixTranspose.7
scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.RayDirectionOriginal.y Physics
scoreboard players operation #Physics.RayDirectionLocal.z Physics += #Physics.Maths.Value1 Physics
scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.RotationMatrixTranspose.8
scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.RayDirectionOriginal.z Physics
scoreboard players operation #Physics.RayDirectionLocal.z Physics += #Physics.Maths.Value1 Physics

# Compress the object's dimensions to a unit cube, and adjust the ray origin and direction accordingly
execute store result score #Physics.RayPosLocalScaled.x Physics run scoreboard players operation #Physics.RayPosLocal.x Physics /= @s Physics.Object.Dimension.x
execute store result score #Physics.RayPosLocalScaled.y Physics run scoreboard players operation #Physics.RayPosLocal.y Physics /= @s Physics.Object.Dimension.y
execute store result score #Physics.RayPosLocalScaled.z Physics run scoreboard players operation #Physics.RayPosLocal.z Physics /= @s Physics.Object.Dimension.z
scoreboard players operation #Physics.RayDirectionLocal.x Physics /= @s Physics.Object.Dimension.x
scoreboard players operation #Physics.RayDirectionLocal.y Physics /= @s Physics.Object.Dimension.y
scoreboard players operation #Physics.RayDirectionLocal.z Physics /= @s Physics.Object.Dimension.z

# Check if / where the ray hits the object
# (Important): The local position is scaled up by 1,000x (So 1,000,000x in total) to provide accuracy when calculating t.
# (Important): The "exiting faces" checks explicitly allow for punching the object while facing the backside of a surface.
# (Important): If the 1st check for any face (entering the object) succeeds, all other checks can be ignored (there will at most be a single more intersection that goes out of the object which would be farther away). If the 2nd check for any face (exiting the object) succeeds, all remaining "exiting" checks can be ignored too.
scoreboard players operation #Physics.RayPosLocalScaled.x Physics *= #Physics.Constants.1000 Physics
scoreboard players operation #Physics.RayPosLocalScaled.y Physics *= #Physics.Constants.1000 Physics
scoreboard players operation #Physics.RayPosLocalScaled.z Physics *= #Physics.Constants.1000 Physics

    # Entering faces
        # x axis
        execute if score #Physics.RayPosLocal.x Physics matches ..-500 if score #Physics.RayDirectionLocal.x Physics matches 0.. if function physics:zprivate/line_of_sight/check_ray_intersections/precise/0 run return 0
        execute if score #Physics.RayPosLocal.x Physics matches 500.. if score #Physics.RayDirectionLocal.x Physics matches ..-1 if function physics:zprivate/line_of_sight/check_ray_intersections/precise/1 run return 0

        # y axis
        execute if score #Physics.RayPosLocal.y Physics matches ..-500 if score #Physics.RayDirectionLocal.y Physics matches 0.. if function physics:zprivate/line_of_sight/check_ray_intersections/precise/2 run return 0
        execute if score #Physics.RayPosLocal.y Physics matches 500.. if score #Physics.RayDirectionLocal.y Physics matches ..-1 if function physics:zprivate/line_of_sight/check_ray_intersections/precise/3 run return 0

        # z axis
        execute if score #Physics.RayPosLocal.z Physics matches ..-500 if score #Physics.RayDirectionLocal.z Physics matches 0.. if function physics:zprivate/line_of_sight/check_ray_intersections/precise/4 run return 0
        execute if score #Physics.RayPosLocal.z Physics matches 500.. if score #Physics.RayDirectionLocal.z Physics matches ..-1 if function physics:zprivate/line_of_sight/check_ray_intersections/precise/5 run return 0

    # Exiting faces
        # x axis
        execute if score #Physics.RayPosLocal.x Physics matches -499.. if score #Physics.RayDirectionLocal.x Physics matches ..-1 if function physics:zprivate/line_of_sight/check_ray_intersections/precise/0 run return 0
        execute if score #Physics.RayPosLocal.x Physics matches ..499 if score #Physics.RayDirectionLocal.x Physics matches 0.. if function physics:zprivate/line_of_sight/check_ray_intersections/precise/1 run return 0

        # y axis
        execute if score #Physics.RayPosLocal.y Physics matches -499.. if score #Physics.RayDirectionLocal.y Physics matches ..-1 if function physics:zprivate/line_of_sight/check_ray_intersections/precise/2 run return 0
        execute if score #Physics.RayPosLocal.y Physics matches ..499 if score #Physics.RayDirectionLocal.y Physics matches 0.. if function physics:zprivate/line_of_sight/check_ray_intersections/precise/3 run return 0

        # z axis
        execute if score #Physics.RayPosLocal.z Physics matches -499.. if score #Physics.RayDirectionLocal.z Physics matches ..-1 if function physics:zprivate/line_of_sight/check_ray_intersections/precise/4 run return 0
        execute if score #Physics.RayPosLocal.z Physics matches ..499 if score #Physics.RayDirectionLocal.z Physics matches 0.. run function physics:zprivate/line_of_sight/check_ray_intersections/precise/5
