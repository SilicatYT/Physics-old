# Set the BlockPos (= origin) of the first block I'm checking (which is at ~ ~ ~)
# (Important): The BlockPos is at the center of the block, so I need to offset the BoundingBoxLimit by half a block as well
scoreboard players operation #Physics.BlockPos.x Physics = @s Physics.Object.BoundingBoxGlobalMin.x
scoreboard players operation #Physics.BlockPos.y Physics = @s Physics.Object.BoundingBoxGlobalMin.y
scoreboard players operation #Physics.BlockPos.z Physics = @s Physics.Object.BoundingBoxGlobalMin.z

scoreboard players operation #Physics.BlockPos.x Physics /= #Physics.Constants.1000 Physics
scoreboard players operation #Physics.BlockPos.y Physics /= #Physics.Constants.1000 Physics
scoreboard players operation #Physics.BlockPos.z Physics /= #Physics.Constants.1000 Physics

scoreboard players operation #Physics.BlockPos.x Physics *= #Physics.Constants.1000 Physics
scoreboard players operation #Physics.BlockPos.y Physics *= #Physics.Constants.1000 Physics
scoreboard players operation #Physics.BlockPos.z Physics *= #Physics.Constants.1000 Physics

scoreboard players add #Physics.BlockPos.x Physics 500
scoreboard players add #Physics.BlockPos.y Physics 500
scoreboard players add #Physics.BlockPos.z Physics 500

scoreboard players operation #Physics.Maths.BoundingBoxLimit.x Physics = @s Physics.Object.BoundingBoxGlobalMax.x
scoreboard players operation #Physics.Maths.BoundingBoxLimit.y Physics = @s Physics.Object.BoundingBoxGlobalMax.y
scoreboard players operation #Physics.Maths.BoundingBoxLimit.z Physics = @s Physics.Object.BoundingBoxGlobalMax.z

scoreboard players add #Physics.Maths.BoundingBoxLimit.x Physics 500
scoreboard players add #Physics.Maths.BoundingBoxLimit.y Physics 500
scoreboard players add #Physics.Maths.BoundingBoxLimit.z Physics 500

# Iterate through every single block that collides with the object's AABB
# Note: I could remove the $(Start...), but it would mean that either ~ or ~<StepCount> for any axis could be outside the bounding box, instead of only ~<StepCount>. This would require lots of score checks, even if it would make it cache a lot more. I don't think it's worth it, especially considering larger objects where the number of extra score checks would dramatically increase.
$execute positioned $(StartX) $(StartY) $(StartZ) run function physics:zprivate/collision_detection/world/coarse/$(StepCountX)_$(StepCountY)_$(StepCountZ)
