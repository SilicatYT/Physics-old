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
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~1 ~ ~7 #physics:ignored positioned ~1 ~ ~7 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~ ~6 #physics:ignored positioned ~1 ~ ~6 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~ ~5 #physics:ignored positioned ~1 ~ ~5 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~ ~4 #physics:ignored positioned ~1 ~ ~4 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~ ~3 #physics:ignored positioned ~1 ~ ~3 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~ ~2 #physics:ignored positioned ~1 ~ ~2 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~ ~1 #physics:ignored positioned ~1 ~ ~1 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~ ~ #physics:ignored positioned ~1 ~ ~ run function physics:zprivate/collision_detection/world/get_hitbox/main

    # Layer 2
    scoreboard players add #Physics.BlockPos.y Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~1 ~ #physics:ignored positioned ~1 ~1 ~ run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~1 ~1 #physics:ignored positioned ~1 ~1 ~1 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~1 ~2 #physics:ignored positioned ~1 ~1 ~2 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~1 ~3 #physics:ignored positioned ~1 ~1 ~3 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~1 ~4 #physics:ignored positioned ~1 ~1 ~4 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~1 ~5 #physics:ignored positioned ~1 ~1 ~5 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~1 ~6 #physics:ignored positioned ~1 ~1 ~6 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players add #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~1 ~1 ~7 #physics:ignored positioned ~1 ~1 ~7 run function physics:zprivate/collision_detection/world/get_hitbox/main

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
    execute if score #Physics.BlockPos.y Physics > #Physics.Maths.BoundingBoxLimit.y Physics run return 0

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
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics if score #Physics.BlockPos.z Physics <= #Physics.Maths.BoundingBoxLimit.z Physics unless block ~1 ~2 ~7 #physics:ignored positioned ~1 ~2 ~7 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~2 ~6 #physics:ignored positioned ~1 ~2 ~6 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~2 ~5 #physics:ignored positioned ~1 ~2 ~5 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~2 ~4 #physics:ignored positioned ~1 ~2 ~4 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~2 ~3 #physics:ignored positioned ~1 ~2 ~3 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~2 ~2 #physics:ignored positioned ~1 ~2 ~2 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~2 ~1 #physics:ignored positioned ~1 ~2 ~1 run function physics:zprivate/collision_detection/world/get_hitbox/main

    scoreboard players remove #Physics.BlockPos.z Physics 1000
    execute if score #Physics.BlockPos.x Physics <= #Physics.Maths.BoundingBoxLimit.x Physics unless block ~1 ~2 ~ #physics:ignored positioned ~1 ~2 ~ run function physics:zprivate/collision_detection/world/get_hitbox/main
