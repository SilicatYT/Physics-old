# TODO: Rework the formulas to use an impulse. Right now, it's not physically accurate that the linear force is just added ontop. (maybe it's correct?)
# THIS IS RUDIMENTARY. THE SCALING ALSO ISN'T PROPERLY IMPLEMENTED, IT'S JUST HARDCODED.

# Display a crit particle at the intersection coordinates
tp 0-0-0-0-0 ~ ~ ~
data modify entity 0-0-0-0-0 Pos set from storage physics:temp data.HitboxPos
execute positioned as 0-0-0-0-0 run particle minecraft:crit ~ ~ ~ 0.1 0.1 0.1 0 3
execute in minecraft:overworld run tp 0-0-0-0-0 0.0 0.0 0.0

# Calculate the physics of the attack
# (Important): I now scale the RayDirection to match the force the player punched with. Now it's the force that's applied on the hit point.
    # Torque
        # Get the relative coordinates of the intersection (intersection_pos - object_pos). In other words, the vector from the object's center of mass to the intersection point that I hit, in global coordinates.
        scoreboard players operation #Physics.IntersectionPos.x Physics -= @s Physics.Object.Pos.x
        scoreboard players operation #Physics.IntersectionPos.y Physics -= @s Physics.Object.Pos.y
        scoreboard players operation #Physics.IntersectionPos.z Physics -= @s Physics.Object.Pos.z

        # Torque = r x force (With r being the vector from the object origin to the global point that was hit)
        # (Important): Because both Pos and Direction are scaled by 1,000x, this means their product is scaled by 1,000,000x. So I have to divide the result by 1,000x before adding it to the accumulated torque.
        # ^ wrong
        # ^ What's wrong? I just reverted that and instead added a multiplier for player attack strength, and it looks fine?
        scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.IntersectionPos.y Physics
        scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.RayDirection.z Physics
        scoreboard players operation #Physics.Maths.Value2 Physics = #Physics.IntersectionPos.z Physics
        scoreboard players operation #Physics.Maths.Value2 Physics *= #Physics.RayDirection.y Physics
        scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.Maths.Value2 Physics
        scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.PlayerPunchStrength Physics
        scoreboard players operation #Physics.Maths.Value1 Physics /= #Physics.Constants.1000 Physics
        scoreboard players operation @s Physics.Object.AccumulatedTorque.x += #Physics.Maths.Value1 Physics

        scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.IntersectionPos.z Physics
        scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.RayDirection.x Physics
        scoreboard players operation #Physics.Maths.Value2 Physics = #Physics.IntersectionPos.x Physics
        scoreboard players operation #Physics.Maths.Value2 Physics *= #Physics.RayDirection.z Physics
        scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.Maths.Value2 Physics
        scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.PlayerPunchStrength Physics
        scoreboard players operation #Physics.Maths.Value1 Physics /= #Physics.Constants.1000 Physics
        scoreboard players operation @s Physics.Object.AccumulatedTorque.y += #Physics.Maths.Value1 Physics

        scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.IntersectionPos.x Physics
        scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.RayDirection.y Physics
        scoreboard players operation #Physics.Maths.Value2 Physics = #Physics.IntersectionPos.y Physics
        scoreboard players operation #Physics.Maths.Value2 Physics *= #Physics.RayDirection.x Physics
        scoreboard players operation #Physics.Maths.Value1 Physics -= #Physics.Maths.Value2 Physics
        scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.PlayerPunchStrength Physics
        scoreboard players operation #Physics.Maths.Value1 Physics /= #Physics.Constants.1000 Physics
        scoreboard players operation @s Physics.Object.AccumulatedTorque.z += #Physics.Maths.Value1 Physics

    # Linear force
    scoreboard players operation #Physics.RayDirection.x Physics *= #Physics.PlayerPunchStrength Physics
    scoreboard players operation #Physics.RayDirection.y Physics *= #Physics.PlayerPunchStrength Physics
    scoreboard players operation #Physics.RayDirection.z Physics *= #Physics.PlayerPunchStrength Physics

    scoreboard players operation @s Physics.Object.AccumulatedForce.x += #Physics.RayDirection.x Physics
    scoreboard players operation @s Physics.Object.AccumulatedForce.y += #Physics.RayDirection.y Physics
    scoreboard players operation @s Physics.Object.AccumulatedForce.z += #Physics.RayDirection.z Physics
