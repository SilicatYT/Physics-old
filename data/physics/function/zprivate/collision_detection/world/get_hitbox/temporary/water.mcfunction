scoreboard players set #Physics.BlockDiagonalLength Physics 1670

# HitboxType
execute store result storage physics:temp data.HitboxType byte 1 run scoreboard players set #Physics.HitboxType Physics 2

# Block Hitbox
execute if block ~ ~ ~ minecraft:water[level=0] run scoreboard players add #Physics.Projection.Block.WorldAxis.y.Max Physics 388
execute if block ~ ~ ~ minecraft:water[level=0] run scoreboard players remove #Physics.BlockCenterPos.y Physics 55
execute if block ~ ~ ~ minecraft:water[level=0] run scoreboard players set #Physics.BlockDiagonalLength Physics 1670

execute if block ~ ~ ~ minecraft:water[level=1] run scoreboard players add #Physics.Projection.Block.WorldAxis.y.Max Physics 277
execute if block ~ ~ ~ minecraft:water[level=1] run scoreboard players remove #Physics.BlockCenterPos.y Physics 111
execute if block ~ ~ ~ minecraft:water[level=1] run scoreboard players set #Physics.BlockDiagonalLength Physics 1613

execute if block ~ ~ ~ minecraft:water[level=2] run scoreboard players add #Physics.Projection.Block.WorldAxis.y.Max Physics 166
execute if block ~ ~ ~ minecraft:water[level=2] run scoreboard players remove #Physics.BlockCenterPos.y Physics 166
execute if block ~ ~ ~ minecraft:water[level=2] run scoreboard players set #Physics.BlockDiagonalLength Physics 1563

execute if block ~ ~ ~ minecraft:water[level=3] run scoreboard players add #Physics.Projection.Block.WorldAxis.y.Max Physics 55
execute if block ~ ~ ~ minecraft:water[level=3] run scoreboard players remove #Physics.BlockCenterPos.y Physics 222
execute if block ~ ~ ~ minecraft:water[level=3] run scoreboard players set #Physics.BlockDiagonalLength Physics 1519

execute if block ~ ~ ~ minecraft:water[level=4] run scoreboard players remove #Physics.Projection.Block.WorldAxis.y.Max Physics 55
execute if block ~ ~ ~ minecraft:water[level=4] run scoreboard players remove #Physics.BlockCenterPos.y Physics 277
execute if block ~ ~ ~ minecraft:water[level=4] run scoreboard players set #Physics.BlockDiagonalLength Physics 1482

execute if block ~ ~ ~ minecraft:water[level=5] run scoreboard players remove #Physics.Projection.Block.WorldAxis.y.Max Physics 166
execute if block ~ ~ ~ minecraft:water[level=5] run scoreboard players remove #Physics.BlockCenterPos.y Physics 333
execute if block ~ ~ ~ minecraft:water[level=5] run scoreboard players set #Physics.BlockDiagonalLength Physics 1452

execute if block ~ ~ ~ minecraft:water[level=6] run scoreboard players remove #Physics.Projection.Block.WorldAxis.y.Max Physics 277
execute if block ~ ~ ~ minecraft:water[level=6] run scoreboard players remove #Physics.BlockCenterPos.y Physics 388
execute if block ~ ~ ~ minecraft:water[level=6] run scoreboard players set #Physics.BlockDiagonalLength Physics 1431

execute if block ~ ~ ~ minecraft:water[level=7] run scoreboard players remove #Physics.Projection.Block.WorldAxis.y.Max Physics 388
execute if block ~ ~ ~ minecraft:water[level=7] run scoreboard players remove #Physics.BlockCenterPos.y Physics 444
execute if block ~ ~ ~ minecraft:water[level=7] run scoreboard players set #Physics.BlockDiagonalLength Physics 1418

execute if block ~ ~ ~ minecraft:water[level=8] run scoreboard players add #Physics.Projection.Block.WorldAxis.y.Max Physics 388
execute if block ~ ~ ~ minecraft:water[level=9] run scoreboard players add #Physics.Projection.Block.WorldAxis.y.Max Physics 388
execute if block ~ ~ ~ minecraft:water[level=10] run scoreboard players add #Physics.Projection.Block.WorldAxis.y.Max Physics 388
execute if block ~ ~ ~ minecraft:water[level=11] run scoreboard players add #Physics.Projection.Block.WorldAxis.y.Max Physics 388
execute if block ~ ~ ~ minecraft:water[level=12] run scoreboard players add #Physics.Projection.Block.WorldAxis.y.Max Physics 388
execute if block ~ ~ ~ minecraft:water[level=13] run scoreboard players add #Physics.Projection.Block.WorldAxis.y.Max Physics 388
execute if block ~ ~ ~ minecraft:water[level=14] run scoreboard players add #Physics.Projection.Block.WorldAxis.y.Max Physics 388
execute if block ~ ~ ~ minecraft:water[level=15] run scoreboard players add #Physics.Projection.Block.WorldAxis.y.Max Physics 388
execute if block ~ ~ ~ minecraft:water[level=8] run scoreboard players remove #Physics.BlockCenterPos.y Physics 55
execute if block ~ ~ ~ minecraft:water[level=9] run scoreboard players remove #Physics.BlockCenterPos.y Physics 55
execute if block ~ ~ ~ minecraft:water[level=10] run scoreboard players remove #Physics.BlockCenterPos.y Physics 55
execute if block ~ ~ ~ minecraft:water[level=11] run scoreboard players remove #Physics.BlockCenterPos.y Physics 55
execute if block ~ ~ ~ minecraft:water[level=12] run scoreboard players remove #Physics.BlockCenterPos.y Physics 55
execute if block ~ ~ ~ minecraft:water[level=13] run scoreboard players remove #Physics.BlockCenterPos.y Physics 55
execute if block ~ ~ ~ minecraft:water[level=14] run scoreboard players remove #Physics.BlockCenterPos.y Physics 55
execute if block ~ ~ ~ minecraft:water[level=15] run scoreboard players remove #Physics.BlockCenterPos.y Physics 55

# Run SAT
function physics:zprivate/collision_detection/world/sat

# Reset HitboxType
# (Important): This is done after every non-1 HitboxType, so it doesn't have to set it to 1 constantly (Lowers the cost of solid hitboxes, which are already the most expensive type)
scoreboard players set #Physics.HitboxType Physics 1
