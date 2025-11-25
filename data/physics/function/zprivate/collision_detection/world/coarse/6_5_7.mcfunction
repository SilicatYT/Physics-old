# Check all blocks in the bounding box
    # Layer 1
    execute unless block ~ ~ ~ #physics:ignored run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~ ~1 #physics:ignored positioned ~ ~ ~1 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~ ~2 #physics:ignored positioned ~ ~ ~2 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~ ~3 #physics:ignored positioned ~ ~ ~3 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~ ~4 #physics:ignored positioned ~ ~ ~4 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~ ~5 #physics:ignored positioned ~ ~ ~5 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~ ~6 #physics:ignored positioned ~ ~ ~6 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~ ~ ~7 #physics:ignored positioned ~ ~ ~7 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.x Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~1 ~ ~7 #physics:ignored positioned ~1 ~ ~7 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~1 ~ ~6 #physics:ignored positioned ~1 ~ ~6 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~1 ~ ~5 #physics:ignored positioned ~1 ~ ~5 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~1 ~ ~4 #physics:ignored positioned ~1 ~ ~4 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~1 ~ ~3 #physics:ignored positioned ~1 ~ ~3 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~1 ~ ~2 #physics:ignored positioned ~1 ~ ~2 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~1 ~ ~1 #physics:ignored positioned ~1 ~ ~1 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~1 ~ ~ #physics:ignored positioned ~1 ~ ~ run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.x Physics 1000
    execute unless block ~2 ~ ~ #physics:ignored positioned ~2 ~ ~ run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~2 ~ ~1 #physics:ignored positioned ~2 ~ ~1 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~2 ~ ~2 #physics:ignored positioned ~2 ~ ~2 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~2 ~ ~3 #physics:ignored positioned ~2 ~ ~3 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~2 ~ ~4 #physics:ignored positioned ~2 ~ ~4 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~2 ~ ~5 #physics:ignored positioned ~2 ~ ~5 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~2 ~ ~6 #physics:ignored positioned ~2 ~ ~6 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~2 ~ ~7 #physics:ignored positioned ~2 ~ ~7 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.x Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~3 ~ ~7 #physics:ignored positioned ~3 ~ ~7 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~3 ~ ~6 #physics:ignored positioned ~3 ~ ~6 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~3 ~ ~5 #physics:ignored positioned ~3 ~ ~5 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~3 ~ ~4 #physics:ignored positioned ~3 ~ ~4 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~3 ~ ~3 #physics:ignored positioned ~3 ~ ~3 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~3 ~ ~2 #physics:ignored positioned ~3 ~ ~2 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~3 ~ ~1 #physics:ignored positioned ~3 ~ ~1 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~3 ~ ~ #physics:ignored positioned ~3 ~ ~ run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.x Physics 1000
    execute unless block ~4 ~ ~ #physics:ignored positioned ~4 ~ ~ run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~4 ~ ~1 #physics:ignored positioned ~4 ~ ~1 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~4 ~ ~2 #physics:ignored positioned ~4 ~ ~2 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~4 ~ ~3 #physics:ignored positioned ~4 ~ ~3 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~4 ~ ~4 #physics:ignored positioned ~4 ~ ~4 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~4 ~ ~5 #physics:ignored positioned ~4 ~ ~5 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~4 ~ ~6 #physics:ignored positioned ~4 ~ ~6 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~4 ~ ~7 #physics:ignored positioned ~4 ~ ~7 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.x Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~5 ~ ~7 #physics:ignored positioned ~5 ~ ~7 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~5 ~ ~6 #physics:ignored positioned ~5 ~ ~6 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~5 ~ ~5 #physics:ignored positioned ~5 ~ ~5 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~5 ~ ~4 #physics:ignored positioned ~5 ~ ~4 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~5 ~ ~3 #physics:ignored positioned ~5 ~ ~3 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~5 ~ ~2 #physics:ignored positioned ~5 ~ ~2 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~5 ~ ~1 #physics:ignored positioned ~5 ~ ~1 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~5 ~ ~ #physics:ignored positioned ~5 ~ ~ run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.x Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~6 ~ ~ #physics:ignored positioned ~6 ~ ~ run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~6 ~ ~1 #physics:ignored positioned ~6 ~ ~1 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~6 ~ ~2 #physics:ignored positioned ~6 ~ ~2 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~6 ~ ~3 #physics:ignored positioned ~6 ~ ~3 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~6 ~ ~4 #physics:ignored positioned ~6 ~ ~4 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~6 ~ ~5 #physics:ignored positioned ~6 ~ ~5 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~6 ~ ~6 #physics:ignored positioned ~6 ~ ~6 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~6 ~ ~7 #physics:ignored positioned ~6 ~ ~7 run function physics:zprivate/collision_detection/world/get_hitbox/main

    # Layer 2
    scoreboard players add #Physics.BlockPos.y Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~6 ~1 ~7 #physics:ignored positioned ~6 ~1 ~7 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~6 ~1 ~6 #physics:ignored positioned ~6 ~1 ~6 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~6 ~1 ~5 #physics:ignored positioned ~6 ~1 ~5 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~6 ~1 ~4 #physics:ignored positioned ~6 ~1 ~4 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~6 ~1 ~3 #physics:ignored positioned ~6 ~1 ~3 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~6 ~1 ~2 #physics:ignored positioned ~6 ~1 ~2 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~6 ~1 ~1 #physics:ignored positioned ~6 ~1 ~1 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~6 ~1 ~ #physics:ignored positioned ~6 ~1 ~ run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.x Physics 1000
    execute unless block ~5 ~1 ~ #physics:ignored positioned ~5 ~1 ~ run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~5 ~1 ~1 #physics:ignored positioned ~5 ~1 ~1 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~5 ~1 ~2 #physics:ignored positioned ~5 ~1 ~2 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~5 ~1 ~3 #physics:ignored positioned ~5 ~1 ~3 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~5 ~1 ~4 #physics:ignored positioned ~5 ~1 ~4 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~5 ~1 ~5 #physics:ignored positioned ~5 ~1 ~5 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~5 ~1 ~6 #physics:ignored positioned ~5 ~1 ~6 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~5 ~1 ~7 #physics:ignored positioned ~5 ~1 ~7 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.x Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~4 ~1 ~7 #physics:ignored positioned ~4 ~1 ~7 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~4 ~1 ~6 #physics:ignored positioned ~4 ~1 ~6 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~4 ~1 ~5 #physics:ignored positioned ~4 ~1 ~5 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~4 ~1 ~4 #physics:ignored positioned ~4 ~1 ~4 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~4 ~1 ~3 #physics:ignored positioned ~4 ~1 ~3 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~4 ~1 ~2 #physics:ignored positioned ~4 ~1 ~2 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~4 ~1 ~1 #physics:ignored positioned ~4 ~1 ~1 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~4 ~1 ~ #physics:ignored positioned ~4 ~1 ~ run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.x Physics 1000
    execute unless block ~3 ~1 ~ #physics:ignored positioned ~3 ~1 ~ run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~3 ~1 ~1 #physics:ignored positioned ~3 ~1 ~1 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~3 ~1 ~2 #physics:ignored positioned ~3 ~1 ~2 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~3 ~1 ~3 #physics:ignored positioned ~3 ~1 ~3 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~3 ~1 ~4 #physics:ignored positioned ~3 ~1 ~4 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~3 ~1 ~5 #physics:ignored positioned ~3 ~1 ~5 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~3 ~1 ~6 #physics:ignored positioned ~3 ~1 ~6 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~3 ~1 ~7 #physics:ignored positioned ~3 ~1 ~7 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.x Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~2 ~1 ~7 #physics:ignored positioned ~2 ~1 ~7 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~2 ~1 ~6 #physics:ignored positioned ~2 ~1 ~6 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~2 ~1 ~5 #physics:ignored positioned ~2 ~1 ~5 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~2 ~1 ~4 #physics:ignored positioned ~2 ~1 ~4 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~2 ~1 ~3 #physics:ignored positioned ~2 ~1 ~3 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~2 ~1 ~2 #physics:ignored positioned ~2 ~1 ~2 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~2 ~1 ~1 #physics:ignored positioned ~2 ~1 ~1 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~2 ~1 ~ #physics:ignored positioned ~2 ~1 ~ run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.x Physics 1000
    execute unless block ~1 ~1 ~ #physics:ignored positioned ~1 ~1 ~ run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~1 ~1 ~1 #physics:ignored positioned ~1 ~1 ~1 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~1 ~1 ~2 #physics:ignored positioned ~1 ~1 ~2 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~1 ~1 ~3 #physics:ignored positioned ~1 ~1 ~3 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~1 ~1 ~4 #physics:ignored positioned ~1 ~1 ~4 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~1 ~1 ~5 #physics:ignored positioned ~1 ~1 ~5 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~1 ~1 ~6 #physics:ignored positioned ~1 ~1 ~6 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~1 ~1 ~7 #physics:ignored positioned ~1 ~1 ~7 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.x Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~ ~1 ~7 #physics:ignored positioned ~ ~1 ~7 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~1 ~6 #physics:ignored positioned ~ ~1 ~6 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~1 ~5 #physics:ignored positioned ~ ~1 ~5 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~1 ~4 #physics:ignored positioned ~ ~1 ~4 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~1 ~3 #physics:ignored positioned ~ ~1 ~3 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~1 ~2 #physics:ignored positioned ~ ~1 ~2 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~1 ~1 #physics:ignored positioned ~ ~1 ~1 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~1 ~ #physics:ignored positioned ~ ~1 ~ run function physics:zprivate/collision_detection/world/get_hitbox/main

    # Layer 3
    scoreboard players add #Physics.BlockPos.y Physics 1000
    execute unless block ~ ~2 ~ #physics:ignored positioned ~ ~2 ~ run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~2 ~1 #physics:ignored positioned ~ ~2 ~1 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~2 ~2 #physics:ignored positioned ~ ~2 ~2 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~2 ~3 #physics:ignored positioned ~ ~2 ~3 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~2 ~4 #physics:ignored positioned ~ ~2 ~4 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~2 ~5 #physics:ignored positioned ~ ~2 ~5 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~2 ~6 #physics:ignored positioned ~ ~2 ~6 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~ ~2 ~7 #physics:ignored positioned ~ ~2 ~7 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.x Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~1 ~2 ~7 #physics:ignored positioned ~1 ~2 ~7 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~1 ~2 ~6 #physics:ignored positioned ~1 ~2 ~6 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~1 ~2 ~5 #physics:ignored positioned ~1 ~2 ~5 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~1 ~2 ~4 #physics:ignored positioned ~1 ~2 ~4 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~1 ~2 ~3 #physics:ignored positioned ~1 ~2 ~3 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~1 ~2 ~2 #physics:ignored positioned ~1 ~2 ~2 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~1 ~2 ~1 #physics:ignored positioned ~1 ~2 ~1 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~1 ~2 ~ #physics:ignored positioned ~1 ~2 ~ run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.x Physics 1000
    execute unless block ~2 ~2 ~ #physics:ignored positioned ~2 ~2 ~ run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~2 ~2 ~1 #physics:ignored positioned ~2 ~2 ~1 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~2 ~2 ~2 #physics:ignored positioned ~2 ~2 ~2 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~2 ~2 ~3 #physics:ignored positioned ~2 ~2 ~3 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~2 ~2 ~4 #physics:ignored positioned ~2 ~2 ~4 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~2 ~2 ~5 #physics:ignored positioned ~2 ~2 ~5 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~2 ~2 ~6 #physics:ignored positioned ~2 ~2 ~6 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~2 ~2 ~7 #physics:ignored positioned ~2 ~2 ~7 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.x Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~3 ~2 ~7 #physics:ignored positioned ~3 ~2 ~7 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~3 ~2 ~6 #physics:ignored positioned ~3 ~2 ~6 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~3 ~2 ~5 #physics:ignored positioned ~3 ~2 ~5 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~3 ~2 ~4 #physics:ignored positioned ~3 ~2 ~4 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~3 ~2 ~3 #physics:ignored positioned ~3 ~2 ~3 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~3 ~2 ~2 #physics:ignored positioned ~3 ~2 ~2 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~3 ~2 ~1 #physics:ignored positioned ~3 ~2 ~1 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~3 ~2 ~ #physics:ignored positioned ~3 ~2 ~ run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.x Physics 1000
    execute unless block ~4 ~2 ~ #physics:ignored positioned ~4 ~2 ~ run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~4 ~2 ~1 #physics:ignored positioned ~4 ~2 ~1 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~4 ~2 ~2 #physics:ignored positioned ~4 ~2 ~2 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~4 ~2 ~3 #physics:ignored positioned ~4 ~2 ~3 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~4 ~2 ~4 #physics:ignored positioned ~4 ~2 ~4 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~4 ~2 ~5 #physics:ignored positioned ~4 ~2 ~5 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~4 ~2 ~6 #physics:ignored positioned ~4 ~2 ~6 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~4 ~2 ~7 #physics:ignored positioned ~4 ~2 ~7 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.x Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~5 ~2 ~7 #physics:ignored positioned ~5 ~2 ~7 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~5 ~2 ~6 #physics:ignored positioned ~5 ~2 ~6 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~5 ~2 ~5 #physics:ignored positioned ~5 ~2 ~5 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~5 ~2 ~4 #physics:ignored positioned ~5 ~2 ~4 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~5 ~2 ~3 #physics:ignored positioned ~5 ~2 ~3 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~5 ~2 ~2 #physics:ignored positioned ~5 ~2 ~2 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~5 ~2 ~1 #physics:ignored positioned ~5 ~2 ~1 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~5 ~2 ~ #physics:ignored positioned ~5 ~2 ~ run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.x Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~6 ~2 ~ #physics:ignored positioned ~6 ~2 ~ run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~6 ~2 ~1 #physics:ignored positioned ~6 ~2 ~1 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~6 ~2 ~2 #physics:ignored positioned ~6 ~2 ~2 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~6 ~2 ~3 #physics:ignored positioned ~6 ~2 ~3 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~6 ~2 ~4 #physics:ignored positioned ~6 ~2 ~4 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~6 ~2 ~5 #physics:ignored positioned ~6 ~2 ~5 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~6 ~2 ~6 #physics:ignored positioned ~6 ~2 ~6 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~6 ~2 ~7 #physics:ignored positioned ~6 ~2 ~7 run function physics:zprivate/collision_detection/world/get_hitbox/main

    # Layer 4
    scoreboard players add #Physics.BlockPos.y Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~6 ~3 ~7 #physics:ignored positioned ~6 ~3 ~7 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~6 ~3 ~6 #physics:ignored positioned ~6 ~3 ~6 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~6 ~3 ~5 #physics:ignored positioned ~6 ~3 ~5 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~6 ~3 ~4 #physics:ignored positioned ~6 ~3 ~4 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~6 ~3 ~3 #physics:ignored positioned ~6 ~3 ~3 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~6 ~3 ~2 #physics:ignored positioned ~6 ~3 ~2 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~6 ~3 ~1 #physics:ignored positioned ~6 ~3 ~1 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~6 ~3 ~ #physics:ignored positioned ~6 ~3 ~ run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.x Physics 1000
    execute unless block ~5 ~3 ~ #physics:ignored positioned ~5 ~3 ~ run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~5 ~3 ~1 #physics:ignored positioned ~5 ~3 ~1 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~5 ~3 ~2 #physics:ignored positioned ~5 ~3 ~2 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~5 ~3 ~3 #physics:ignored positioned ~5 ~3 ~3 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~5 ~3 ~4 #physics:ignored positioned ~5 ~3 ~4 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~5 ~3 ~5 #physics:ignored positioned ~5 ~3 ~5 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~5 ~3 ~6 #physics:ignored positioned ~5 ~3 ~6 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~5 ~3 ~7 #physics:ignored positioned ~5 ~3 ~7 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.x Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~4 ~3 ~7 #physics:ignored positioned ~4 ~3 ~7 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~4 ~3 ~6 #physics:ignored positioned ~4 ~3 ~6 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~4 ~3 ~5 #physics:ignored positioned ~4 ~3 ~5 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~4 ~3 ~4 #physics:ignored positioned ~4 ~3 ~4 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~4 ~3 ~3 #physics:ignored positioned ~4 ~3 ~3 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~4 ~3 ~2 #physics:ignored positioned ~4 ~3 ~2 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~4 ~3 ~1 #physics:ignored positioned ~4 ~3 ~1 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~4 ~3 ~ #physics:ignored positioned ~4 ~3 ~ run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.x Physics 1000
    execute unless block ~3 ~3 ~ #physics:ignored positioned ~3 ~3 ~ run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~3 ~3 ~1 #physics:ignored positioned ~3 ~3 ~1 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~3 ~3 ~2 #physics:ignored positioned ~3 ~3 ~2 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~3 ~3 ~3 #physics:ignored positioned ~3 ~3 ~3 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~3 ~3 ~4 #physics:ignored positioned ~3 ~3 ~4 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~3 ~3 ~5 #physics:ignored positioned ~3 ~3 ~5 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~3 ~3 ~6 #physics:ignored positioned ~3 ~3 ~6 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~3 ~3 ~7 #physics:ignored positioned ~3 ~3 ~7 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.x Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~2 ~3 ~7 #physics:ignored positioned ~2 ~3 ~7 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~2 ~3 ~6 #physics:ignored positioned ~2 ~3 ~6 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~2 ~3 ~5 #physics:ignored positioned ~2 ~3 ~5 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~2 ~3 ~4 #physics:ignored positioned ~2 ~3 ~4 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~2 ~3 ~3 #physics:ignored positioned ~2 ~3 ~3 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~2 ~3 ~2 #physics:ignored positioned ~2 ~3 ~2 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~2 ~3 ~1 #physics:ignored positioned ~2 ~3 ~1 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~2 ~3 ~ #physics:ignored positioned ~2 ~3 ~ run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.x Physics 1000
    execute unless block ~1 ~3 ~ #physics:ignored positioned ~1 ~3 ~ run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~1 ~3 ~1 #physics:ignored positioned ~1 ~3 ~1 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~1 ~3 ~2 #physics:ignored positioned ~1 ~3 ~2 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~1 ~3 ~3 #physics:ignored positioned ~1 ~3 ~3 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~1 ~3 ~4 #physics:ignored positioned ~1 ~3 ~4 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~1 ~3 ~5 #physics:ignored positioned ~1 ~3 ~5 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~1 ~3 ~6 #physics:ignored positioned ~1 ~3 ~6 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~1 ~3 ~7 #physics:ignored positioned ~1 ~3 ~7 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.x Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~ ~3 ~7 #physics:ignored positioned ~ ~3 ~7 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~3 ~6 #physics:ignored positioned ~ ~3 ~6 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~3 ~5 #physics:ignored positioned ~ ~3 ~5 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~3 ~4 #physics:ignored positioned ~ ~3 ~4 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~3 ~3 #physics:ignored positioned ~ ~3 ~3 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~3 ~2 #physics:ignored positioned ~ ~3 ~2 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~3 ~1 #physics:ignored positioned ~ ~3 ~1 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~3 ~ #physics:ignored positioned ~ ~3 ~ run function physics:zprivate/collision_detection/world/get_hitbox/main

    # Layer 5
    scoreboard players add #Physics.BlockPos.y Physics 1000
    execute unless block ~ ~4 ~ #physics:ignored positioned ~ ~4 ~ run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~4 ~1 #physics:ignored positioned ~ ~4 ~1 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~4 ~2 #physics:ignored positioned ~ ~4 ~2 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~4 ~3 #physics:ignored positioned ~ ~4 ~3 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~4 ~4 #physics:ignored positioned ~ ~4 ~4 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~4 ~5 #physics:ignored positioned ~ ~4 ~5 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~4 ~6 #physics:ignored positioned ~ ~4 ~6 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~ ~4 ~7 #physics:ignored positioned ~ ~4 ~7 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.x Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~1 ~4 ~7 #physics:ignored positioned ~1 ~4 ~7 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~1 ~4 ~6 #physics:ignored positioned ~1 ~4 ~6 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~1 ~4 ~5 #physics:ignored positioned ~1 ~4 ~5 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~1 ~4 ~4 #physics:ignored positioned ~1 ~4 ~4 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~1 ~4 ~3 #physics:ignored positioned ~1 ~4 ~3 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~1 ~4 ~2 #physics:ignored positioned ~1 ~4 ~2 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~1 ~4 ~1 #physics:ignored positioned ~1 ~4 ~1 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~1 ~4 ~ #physics:ignored positioned ~1 ~4 ~ run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.x Physics 1000
    execute unless block ~2 ~4 ~ #physics:ignored positioned ~2 ~4 ~ run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~2 ~4 ~1 #physics:ignored positioned ~2 ~4 ~1 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~2 ~4 ~2 #physics:ignored positioned ~2 ~4 ~2 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~2 ~4 ~3 #physics:ignored positioned ~2 ~4 ~3 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~2 ~4 ~4 #physics:ignored positioned ~2 ~4 ~4 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~2 ~4 ~5 #physics:ignored positioned ~2 ~4 ~5 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~2 ~4 ~6 #physics:ignored positioned ~2 ~4 ~6 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~2 ~4 ~7 #physics:ignored positioned ~2 ~4 ~7 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.x Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~3 ~4 ~7 #physics:ignored positioned ~3 ~4 ~7 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~3 ~4 ~6 #physics:ignored positioned ~3 ~4 ~6 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~3 ~4 ~5 #physics:ignored positioned ~3 ~4 ~5 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~3 ~4 ~4 #physics:ignored positioned ~3 ~4 ~4 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~3 ~4 ~3 #physics:ignored positioned ~3 ~4 ~3 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~3 ~4 ~2 #physics:ignored positioned ~3 ~4 ~2 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~3 ~4 ~1 #physics:ignored positioned ~3 ~4 ~1 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~3 ~4 ~ #physics:ignored positioned ~3 ~4 ~ run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.x Physics 1000
    execute unless block ~4 ~4 ~ #physics:ignored positioned ~4 ~4 ~ run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~4 ~4 ~1 #physics:ignored positioned ~4 ~4 ~1 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~4 ~4 ~2 #physics:ignored positioned ~4 ~4 ~2 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~4 ~4 ~3 #physics:ignored positioned ~4 ~4 ~3 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~4 ~4 ~4 #physics:ignored positioned ~4 ~4 ~4 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~4 ~4 ~5 #physics:ignored positioned ~4 ~4 ~5 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~4 ~4 ~6 #physics:ignored positioned ~4 ~4 ~6 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~4 ~4 ~7 #physics:ignored positioned ~4 ~4 ~7 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.x Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~5 ~4 ~7 #physics:ignored positioned ~5 ~4 ~7 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~5 ~4 ~6 #physics:ignored positioned ~5 ~4 ~6 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~5 ~4 ~5 #physics:ignored positioned ~5 ~4 ~5 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~5 ~4 ~4 #physics:ignored positioned ~5 ~4 ~4 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~5 ~4 ~3 #physics:ignored positioned ~5 ~4 ~3 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~5 ~4 ~2 #physics:ignored positioned ~5 ~4 ~2 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~5 ~4 ~1 #physics:ignored positioned ~5 ~4 ~1 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~5 ~4 ~ #physics:ignored positioned ~5 ~4 ~ run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.x Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~6 ~4 ~ #physics:ignored positioned ~6 ~4 ~ run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~6 ~4 ~1 #physics:ignored positioned ~6 ~4 ~1 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~6 ~4 ~2 #physics:ignored positioned ~6 ~4 ~2 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~6 ~4 ~3 #physics:ignored positioned ~6 ~4 ~3 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~6 ~4 ~4 #physics:ignored positioned ~6 ~4 ~4 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~6 ~4 ~5 #physics:ignored positioned ~6 ~4 ~5 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~6 ~4 ~6 #physics:ignored positioned ~6 ~4 ~6 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~6 ~4 ~7 #physics:ignored positioned ~6 ~4 ~7 run function physics:zprivate/collision_detection/world/get_hitbox/main

    # Layer 6
    scoreboard players add #Physics.BlockPos.y Physics 1000
    execute if score #Physics.BlockPos.y Physics > #Physics.Maths.BoundingBoxLimit.y Physics run return 0

    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~6 ~5 ~7 #physics:ignored positioned ~6 ~5 ~7 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~6 ~5 ~6 #physics:ignored positioned ~6 ~5 ~6 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~6 ~5 ~5 #physics:ignored positioned ~6 ~5 ~5 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~6 ~5 ~4 #physics:ignored positioned ~6 ~5 ~4 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~6 ~5 ~3 #physics:ignored positioned ~6 ~5 ~3 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~6 ~5 ~2 #physics:ignored positioned ~6 ~5 ~2 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~6 ~5 ~1 #physics:ignored positioned ~6 ~5 ~1 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~6 ~5 ~ #physics:ignored positioned ~6 ~5 ~ run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.x Physics 1000
    execute unless block ~5 ~5 ~ #physics:ignored positioned ~5 ~5 ~ run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~5 ~5 ~1 #physics:ignored positioned ~5 ~5 ~1 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~5 ~5 ~2 #physics:ignored positioned ~5 ~5 ~2 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~5 ~5 ~3 #physics:ignored positioned ~5 ~5 ~3 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~5 ~5 ~4 #physics:ignored positioned ~5 ~5 ~4 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~5 ~5 ~5 #physics:ignored positioned ~5 ~5 ~5 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~5 ~5 ~6 #physics:ignored positioned ~5 ~5 ~6 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~5 ~5 ~7 #physics:ignored positioned ~5 ~5 ~7 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.x Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~4 ~5 ~7 #physics:ignored positioned ~4 ~5 ~7 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~4 ~5 ~6 #physics:ignored positioned ~4 ~5 ~6 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~4 ~5 ~5 #physics:ignored positioned ~4 ~5 ~5 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~4 ~5 ~4 #physics:ignored positioned ~4 ~5 ~4 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~4 ~5 ~3 #physics:ignored positioned ~4 ~5 ~3 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~4 ~5 ~2 #physics:ignored positioned ~4 ~5 ~2 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~4 ~5 ~1 #physics:ignored positioned ~4 ~5 ~1 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~4 ~5 ~ #physics:ignored positioned ~4 ~5 ~ run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.x Physics 1000
    execute unless block ~3 ~5 ~ #physics:ignored positioned ~3 ~5 ~ run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~3 ~5 ~1 #physics:ignored positioned ~3 ~5 ~1 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~3 ~5 ~2 #physics:ignored positioned ~3 ~5 ~2 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~3 ~5 ~3 #physics:ignored positioned ~3 ~5 ~3 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~3 ~5 ~4 #physics:ignored positioned ~3 ~5 ~4 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~3 ~5 ~5 #physics:ignored positioned ~3 ~5 ~5 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~3 ~5 ~6 #physics:ignored positioned ~3 ~5 ~6 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~3 ~5 ~7 #physics:ignored positioned ~3 ~5 ~7 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.x Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~2 ~5 ~7 #physics:ignored positioned ~2 ~5 ~7 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~2 ~5 ~6 #physics:ignored positioned ~2 ~5 ~6 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~2 ~5 ~5 #physics:ignored positioned ~2 ~5 ~5 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~2 ~5 ~4 #physics:ignored positioned ~2 ~5 ~4 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~2 ~5 ~3 #physics:ignored positioned ~2 ~5 ~3 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~2 ~5 ~2 #physics:ignored positioned ~2 ~5 ~2 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~2 ~5 ~1 #physics:ignored positioned ~2 ~5 ~1 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~2 ~5 ~ #physics:ignored positioned ~2 ~5 ~ run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.x Physics 1000
    execute unless block ~1 ~5 ~ #physics:ignored positioned ~1 ~5 ~ run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~1 ~5 ~1 #physics:ignored positioned ~1 ~5 ~1 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~1 ~5 ~2 #physics:ignored positioned ~1 ~5 ~2 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~1 ~5 ~3 #physics:ignored positioned ~1 ~5 ~3 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~1 ~5 ~4 #physics:ignored positioned ~1 ~5 ~4 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~1 ~5 ~5 #physics:ignored positioned ~1 ~5 ~5 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute unless block ~1 ~5 ~6 #physics:ignored positioned ~1 ~5 ~6 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~1 ~5 ~7 #physics:ignored positioned ~1 ~5 ~7 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.x Physics 1000
    execute if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~ ~5 ~7 #physics:ignored positioned ~ ~5 ~7 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~5 ~6 #physics:ignored positioned ~ ~5 ~6 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~5 ~5 #physics:ignored positioned ~ ~5 ~5 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~5 ~4 #physics:ignored positioned ~ ~5 ~4 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~5 ~3 #physics:ignored positioned ~ ~5 ~3 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~5 ~2 #physics:ignored positioned ~ ~5 ~2 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~5 ~1 #physics:ignored positioned ~ ~5 ~1 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute unless block ~ ~5 ~ #physics:ignored positioned ~ ~5 ~ run function physics:zprivate/collision_detection/world/get_hitbox/main
