# (Important) (TODO): Minor issue is that several scores like the bounding box min and max (and the step counts) are not updated when changing dimensions or when summoning the object in the first place, so it can't properly detect collisions until the next tick.

# Set the object's x, y and z dimensions (width, height and length)
# (Important): Because of the AABB check between world geometry and the object, the max dimensions are currently restricted to 4 blocks along each axis (Because there's currently 1 function for every single bounding box, which would be 350MB of data even for just 8x8x8 cubes)
scoreboard players add #Physics.SetAttribute.Dimension.x Physics 0
scoreboard players add #Physics.SetAttribute.Dimension.y Physics 0
scoreboard players add #Physics.SetAttribute.Dimension.z Physics 0
execute if score #Physics.SetAttribute.Dimension.x Physics matches ..0 run scoreboard players set #Physics.SetAttribute.Dimension.x Physics 1
execute if score #Physics.SetAttribute.Dimension.y Physics matches ..0 run scoreboard players set #Physics.SetAttribute.Dimension.y Physics 1
execute if score #Physics.SetAttribute.Dimension.z Physics matches ..0 run scoreboard players set #Physics.SetAttribute.Dimension.z Physics 1
execute if score #Physics.SetAttribute.Dimension.x Physics matches 4001.. run scoreboard players set #Physics.SetAttribute.Dimension.x Physics 4000
execute if score #Physics.SetAttribute.Dimension.y Physics matches 4001.. run scoreboard players set #Physics.SetAttribute.Dimension.y Physics 4000
execute if score #Physics.SetAttribute.Dimension.z Physics matches 4001.. run scoreboard players set #Physics.SetAttribute.Dimension.z Physics 4000

scoreboard players operation @s Physics.Object.Dimension.x = #Physics.SetAttribute.Dimension.x Physics
scoreboard players operation @s Physics.Object.Dimension.y = #Physics.SetAttribute.Dimension.y Physics
scoreboard players operation @s Physics.Object.Dimension.z = #Physics.SetAttribute.Dimension.z Physics

# Update the display entity's width and height NBT (Unused, because it doesn't work properly right now. I'll just use the default for now (= unlimited)
data remove storage physics:temp data.Object
#scoreboard players operation #Physics.Maths.Max Physics = #Physics.SetAttribute.Dimension.x Physics
#execute if score #Physics.Maths.Max Physics < #Physics.SetAttribute.Dimension.y Physics run scoreboard players operation #Physics.Maths.Max Physics = #Physics.SetAttribute.Dimension.y Physics
#execute if score #Physics.Maths.Max Physics < #Physics.SetAttribute.Dimension.z Physics run scoreboard players operation #Physics.Maths.Max Physics = #Physics.SetAttribute.Dimension.z Physics
#execute store result storage physics:temp data.Object.width float 0.0015 store result storage physics:temp data.Object.height float 0.0015 run scoreboard players get #Physics.Maths.Max Physics

# Update the entity's scale & translation
data modify storage physics:temp data.Object.transformation set value {scale:[0f,0f,0f]}
execute store result storage physics:temp data.Object.transformation.scale[0] float 0.001 run scoreboard players get #Physics.SetAttribute.Dimension.x Physics
execute store result storage physics:temp data.Object.transformation.scale[1] float 0.001 run scoreboard players get #Physics.SetAttribute.Dimension.y Physics
execute store result storage physics:temp data.Object.transformation.scale[2] float 0.001 run scoreboard players get #Physics.SetAttribute.Dimension.z Physics
data modify entity @s {} merge from storage physics:temp data.Object

# Update the local bounding box
scoreboard players operation @s Physics.Object.BoundingBoxLocalMax.x = #Physics.SetAttribute.Dimension.x Physics
execute store result score @s Physics.Object.BoundingBoxLocalMin.x run scoreboard players operation @s Physics.Object.BoundingBoxLocalMax.x /= #Physics.Constants.2 Physics
scoreboard players operation @s Physics.Object.BoundingBoxLocalMin.x *= #Physics.Constants.-1 Physics

scoreboard players operation @s Physics.Object.BoundingBoxLocalMax.y = #Physics.SetAttribute.Dimension.y Physics
execute store result score @s Physics.Object.BoundingBoxLocalMin.y run scoreboard players operation @s Physics.Object.BoundingBoxLocalMax.y /= #Physics.Constants.2 Physics
scoreboard players operation @s Physics.Object.BoundingBoxLocalMin.y *= #Physics.Constants.-1 Physics

scoreboard players operation @s Physics.Object.BoundingBoxLocalMax.z = #Physics.SetAttribute.Dimension.z Physics
execute store result score @s Physics.Object.BoundingBoxLocalMin.z run scoreboard players operation @s Physics.Object.BoundingBoxLocalMax.z /= #Physics.Constants.2 Physics
scoreboard players operation @s Physics.Object.BoundingBoxLocalMin.z *= #Physics.Constants.-1 Physics

# Update the local inverse inertia tensor (Scaling: InverseMass scaled by 1,000,000/x instead of 100,000,000/x)
# (Important): To prevent an overflow when squaring the dimension, I calculate <added squared dimensions / inversemass> at a scale where the added squared dimensions are 100x too small, but then instead of dividing by 12 after the division, I multiply by 833 and then divide by 100, so that the end result is scaled the same.
    # Calculate the inverted local inertia tensor
    scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.Dimension.y
    scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.Maths.Value1 Physics
    scoreboard players operation #Physics.Maths.Value2 Physics = @s Physics.Object.Dimension.z
    scoreboard players operation #Physics.Maths.Value2 Physics *= #Physics.Maths.Value2 Physics
    scoreboard players operation #Physics.Maths.Value1 Physics += #Physics.Maths.Value2 Physics
    scoreboard players operation #Physics.Maths.Value1 Physics /= @s Physics.Object.InverseMass
    scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.Constants.833 Physics
    scoreboard players operation #Physics.Maths.Value1 Physics /= #Physics.Constants.100 Physics
    scoreboard players set @s Physics.Object.InverseInertiaTensorLocal.0 1000000000
    scoreboard players operation @s Physics.Object.InverseInertiaTensorLocal.0 /= #Physics.Maths.Value1 Physics

    scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.Dimension.x
    scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.Maths.Value1 Physics
    scoreboard players operation #Physics.Maths.Value2 Physics = @s Physics.Object.Dimension.z
    scoreboard players operation #Physics.Maths.Value2 Physics *= #Physics.Maths.Value2 Physics
    scoreboard players operation #Physics.Maths.Value1 Physics += #Physics.Maths.Value2 Physics
    scoreboard players operation #Physics.Maths.Value1 Physics /= @s Physics.Object.InverseMass
    scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.Constants.833 Physics
    scoreboard players operation #Physics.Maths.Value1 Physics /= #Physics.Constants.100 Physics
    scoreboard players set @s Physics.Object.InverseInertiaTensorLocal.4 1000000000
    scoreboard players operation @s Physics.Object.InverseInertiaTensorLocal.4 /= #Physics.Maths.Value1 Physics

    scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.Dimension.x
    scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.Maths.Value1 Physics
    scoreboard players operation #Physics.Maths.Value2 Physics = @s Physics.Object.Dimension.y
    scoreboard players operation #Physics.Maths.Value2 Physics *= #Physics.Maths.Value2 Physics
    scoreboard players operation #Physics.Maths.Value1 Physics += #Physics.Maths.Value2 Physics
    scoreboard players operation #Physics.Maths.Value1 Physics /= @s Physics.Object.InverseMass
    scoreboard players operation #Physics.Maths.Value1 Physics *= #Physics.Constants.833 Physics
    scoreboard players operation #Physics.Maths.Value1 Physics /= #Physics.Constants.100 Physics
    scoreboard players set @s Physics.Object.InverseInertiaTensorLocal.8 1000000000
    scoreboard players operation @s Physics.Object.InverseInertiaTensorLocal.8 /= #Physics.Maths.Value1 Physics
