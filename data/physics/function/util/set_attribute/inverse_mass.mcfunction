# Set the object's inverse mass
scoreboard players add #Physics.SetAttribute.InverseMass Physics 0
scoreboard players operation @s Physics.Object.InverseMass = #Physics.SetAttribute.InverseMass Physics
execute if score #Physics.SetAttribute.InverseMass Physics matches 1000000001.. run scoreboard players set @s Physics.Object.InverseMass 1000000000
execute if score #Physics.SetAttribute.InverseMass Physics matches ..0 run scoreboard players set @s Physics.Object.InverseMass 1

scoreboard players operation @s Physics.Object.InverseMassScaled = @s Physics.Object.InverseMass
scoreboard players operation @s Physics.Object.InverseMassScaled /= #Physics.Constants.1000 Physics

scoreboard players operation @s Physics.Object.InverseMassScaled2 = @s Physics.Object.InverseMassScaled
scoreboard players operation @s Physics.Object.InverseMassScaled2 /= #Physics.Constants.100 Physics

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
