scoreboard players set #Physics.IsInside Physics 0
$execute if score #Physics.Projection.Block.WorldAxis.x.Min Physics <= #Physics.ThisObject Physics.Object.CornerPosGlobal.$(Corner).x if score #Physics.ThisObject Physics.Object.CornerPosGlobal.$(Corner).x <= #Physics.Projection.Block.WorldAxis.x.Max Physics if score #Physics.Projection.Block.WorldAxis.y.Min Physics <= #Physics.ThisObject Physics.Object.CornerPosGlobal.$(Corner).y if score #Physics.ThisObject Physics.Object.CornerPosGlobal.$(Corner).y <= #Physics.Projection.Block.WorldAxis.y.Max Physics if score #Physics.Projection.Block.WorldAxis.z.Min Physics <= #Physics.ThisObject Physics.Object.CornerPosGlobal.$(Corner).z if score #Physics.ThisObject Physics.Object.CornerPosGlobal.$(Corner).z <= #Physics.Projection.Block.WorldAxis.z.Max Physics run scoreboard players set #Physics.IsInside Physics 1
execute if score #Physics.IsInside Physics matches 0 run return 0
#$say $(Corner) inside
$execute if score #Physics.InvertValues Physics matches 1 if score #Physics.ThisObject Physics.Object.CornerPosGlobal.$(Corner).y > #Physics.DeepestProjection Physics run scoreboard players set #Physics.FeatureA Physics $(Corner)
#$execute if score #Physics.InvertValues Physics matches 1 if score #Physics.ThisObject Physics.Object.CornerPosGlobal.$(Corner).y < #Physics.DeepestProjection Physics run say $(Corner) new deepest
$execute if score #Physics.InvertValues Physics matches 1 if score #Physics.ThisObject Physics.Object.CornerPosGlobal.$(Corner).y > #Physics.DeepestProjection Physics run scoreboard players operation #Physics.DeepestProjection Physics = #Physics.ThisObject Physics.Object.CornerPosGlobal.$(Corner).y
$execute if score #Physics.InvertValues Physics matches 0 if score #Physics.ThisObject Physics.Object.CornerPosGlobal.$(Corner).y < #Physics.DeepestProjection Physics run scoreboard players set #Physics.FeatureA Physics $(Corner)
#$execute if score #Physics.InvertValues Physics matches 0 if score #Physics.ThisObject Physics.Object.CornerPosGlobal.$(Corner).y > #Physics.DeepestProjection Physics run say $(Corner) new deepest
$execute if score #Physics.InvertValues Physics matches 0 if score #Physics.ThisObject Physics.Object.CornerPosGlobal.$(Corner).y < #Physics.DeepestProjection Physics run scoreboard players operation #Physics.DeepestProjection Physics = #Physics.ThisObject Physics.Object.CornerPosGlobal.$(Corner).y





# Why is this necessary again? Of course it's just bad temporary code, but there was a specific problem this solved. But I can't remember. Obviously it had to do with the engine detecting the wrong corner, but in what circumstances?
# Was it just because I hadn't made edge-edge yet, so any would-be edge-edge collisions had to use a corner point, so it chose the deepest even if it wasn't in that block at all (but rather the block next to it)?
# Really unsure if that was the reason I added it. I remember thinking I need to redo the contact generation ("choose which feature to use") to be more like in Ian Millington's book. But idk if it was in reference to this problem or what.
# Was it (see 30.08.2025 11:11)?

# In collision_detection/world/sat: # Currently, collision detection / contact generation can detect the wrong features. For point-face, it just checks which corner has the deepest penetration. But if the object is perfectly aligned, then 4 corners have the deepest penetration, although only 1 is actually inside the other object
# ^ fair point. But what if a corner clips entirely through a block? Will it just not use that corner then?

# I think there were scenarios where using the axis of min overlap and deducing the contact type from there would cause wrong results, so I may have to change that fundamentally.
# ^ Even then, would that fix my problem?
