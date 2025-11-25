data modify storage physics:resolution Contact.EffectiveMass set value [I;0,0,0]

# Calculate effective mass along the three orthonormal axes (InverseMass + (RelativeContactPos x Axis) * (InverseInertiaTensorGlobal * (RelativeContactPos x Axis))))
# (Important): RelativeContactPos x Axis = a   |   InverseInertiaTensorGlobal * a = b   |   a * b = c   |   InverseMass + c = EffectiveMass
# (Important): For world_axis_?, the effective mass calculations are scaled up just enough so that InverseMass can be added to it without needing to scale it down. The calculations don't overflow for reasonable numbers. The scaling is different from non-axis-aligned contact normals.
    # RelativeContactPosition
    # (Important): ContactPoint - ObjectPos
    execute store result score #Physics.Maths.RelativeContactPos.x Physics run data get storage physics:resolution Contact.ContactPoint[0]
    execute store result score #Physics.Maths.RelativeContactPos.y Physics run data get storage physics:resolution Contact.ContactPoint[1]
    execute store result score #Physics.Maths.RelativeContactPos.z Physics run data get storage physics:resolution Contact.ContactPoint[2]
    execute store result score #Physics.Maths.a3.y Physics store result score #Physics.Maths.Value4 Physics store result score #Physics.Maths.Value3 Physics store result score #Physics.Maths.a2.z Physics run scoreboard players operation #Physics.Maths.RelativeContactPos.x Physics -= @s Physics.Object.Pos.x
    execute store result score #Physics.Maths.b3.y Physics store result score #Physics.Maths.b3.x Physics store result score #Physics.Maths.a3.x Physics store result score #Physics.Maths.a1.z Physics run scoreboard players operation #Physics.Maths.RelativeContactPos.y Physics -= @s Physics.Object.Pos.y
    execute store result score #Physics.Maths.a2.x Physics store result score #Physics.Maths.a1.y Physics run scoreboard players operation #Physics.Maths.RelativeContactPos.z Physics -= @s Physics.Object.Pos.z

    # Axis 1: ContactNormal [±1.0, 0.0, 0.0]
        # a = RelativeContactPos x Axis
            # x-component
            # (Important): It's always 0.

            # y-component
            # (Important): It's already set during RelativeContactPosition calculation.
            execute if score #Physics.FeatureB Physics matches 10 run scoreboard players operation #Physics.Maths.a1.y Physics *= #Physics.Constants.-1 Physics
            execute store result score #Physics.Maths.b1.z Physics run scoreboard players operation #Physics.Maths.b1.y Physics = #Physics.Maths.a1.y Physics

            # z-component
            execute if score #Physics.FeatureB Physics matches 11 run scoreboard players operation #Physics.Maths.a1.z Physics *= #Physics.Constants.-1 Physics
            execute store result score #Physics.Maths.Value2 Physics run scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.Maths.a1.z Physics

        # b = InverseInertiaTensorGlobal * a
        # (Important): InverseInertiaTensorGlobal is scaled by 100,000x and a is scaled by 1,000x.
        # (Important): Because the next step calculates the cross product between the axis and b, and only the first component of that cross product will be used, I don't need to calculate the x component of b.
        scoreboard players operation #Physics.Maths.b1.y Physics *= @s Physics.Object.InverseInertiaTensorGlobal.4
        scoreboard players operation #Physics.Maths.Value1 Physics *= @s Physics.Object.InverseInertiaTensorGlobal.5
        scoreboard players operation #Physics.Maths.b1.y Physics += #Physics.Maths.Value1 Physics
        scoreboard players operation #Physics.Maths.b1.y Physics /= #Physics.Constants.1000 Physics

        scoreboard players operation #Physics.Maths.b1.z Physics *= @s Physics.Object.InverseInertiaTensorGlobal.7
        scoreboard players operation #Physics.Maths.Value2 Physics *= @s Physics.Object.InverseInertiaTensorGlobal.8
        scoreboard players operation #Physics.Maths.b1.z Physics += #Physics.Maths.Value2 Physics
        scoreboard players operation #Physics.Maths.b1.z Physics /= #Physics.Constants.1000 Physics

        # c = a * b
        # (Important): I overwrite a's scores for efficiency reasons. "a.y" is "c".
        scoreboard players operation #Physics.Maths.a1.y Physics *= #Physics.Maths.b1.y Physics
        scoreboard players operation #Physics.Maths.a1.z Physics *= #Physics.Maths.b1.z Physics
        scoreboard players operation #Physics.Maths.a1.y Physics += #Physics.Maths.a1.z Physics

        # EffectiveMass = InverseMass + d
        execute store result storage physics:resolution Contact.EffectiveMass[0] int 1 run scoreboard players operation #Physics.Maths.a1.y Physics += @s Physics.Object.InverseMass

    # Axis 2: Tangent 1 [0.0, 1.0, 0.0]
        # a = RelativeContactPos x Axis
            # x-component
            execute store result score #Physics.Maths.b2.z Physics store result score #Physics.Maths.b2.x Physics run scoreboard players operation #Physics.Maths.a2.x Physics *= #Physics.Constants.-1 Physics

            # y-component
            # (Important): It's always 0.

            # z-component

        # b = InverseInertiaTensorGlobal * a
        # (Important): Because the next step calculates the cross product between the axis and b, and only the second component of that cross product will be used, I don't need to calculate the y component of b.
        scoreboard players operation #Physics.Maths.b2.x Physics *= @s Physics.Object.InverseInertiaTensorGlobal.0
        scoreboard players operation #Physics.Maths.Value3 Physics *= @s Physics.Object.InverseInertiaTensorGlobal.2
        scoreboard players operation #Physics.Maths.b2.x Physics += #Physics.Maths.Value3 Physics
        scoreboard players operation #Physics.Maths.b2.x Physics /= #Physics.Constants.1000 Physics

        scoreboard players operation #Physics.Maths.b2.z Physics *= @s Physics.Object.InverseInertiaTensorGlobal.6
        scoreboard players operation #Physics.Maths.Value4 Physics *= @s Physics.Object.InverseInertiaTensorGlobal.8
        scoreboard players operation #Physics.Maths.b2.z Physics += #Physics.Maths.Value4 Physics
        scoreboard players operation #Physics.Maths.b2.z Physics /= #Physics.Constants.1000 Physics

        # c = a * b
        # (Important): I overwrite a's scores for efficiency reasons. "a.x" is "c".
        scoreboard players operation #Physics.Maths.a2.x Physics *= #Physics.Maths.b2.x Physics
        scoreboard players operation #Physics.Maths.a2.z Physics *= #Physics.Maths.b2.z Physics
        scoreboard players operation #Physics.Maths.a2.x Physics += #Physics.Maths.a2.z Physics

        # EffectiveMass = InverseMass + c
        execute store result storage physics:resolution Contact.EffectiveMass[1] int 1 run scoreboard players operation #Physics.Maths.a2.x Physics += @s Physics.Object.InverseMass

    # Axis 3: Tangent 2 [0.0, 0.0, 1.0]
        # a = RelativeContactPos x Axis
            # x-component

            # y-component
            execute store result score #Physics.Maths.Value6 Physics store result score #Physics.Maths.Value5 Physics run scoreboard players operation #Physics.Maths.a3.y Physics *= #Physics.Constants.-1 Physics

            # z-component
            # (Important): It's always 0.

        # b = InverseInertiaTensorGlobal * a
        # (Important): Because the next step calculates the cross product between the axis and b, and only the third component of that cross product will be used, I don't need to calculate the z component of b.
        scoreboard players operation #Physics.Maths.b3.x Physics *= @s Physics.Object.InverseInertiaTensorGlobal.0
        scoreboard players operation #Physics.Maths.Value5 Physics *= @s Physics.Object.InverseInertiaTensorGlobal.1
        scoreboard players operation #Physics.Maths.b3.x Physics += #Physics.Maths.Value5 Physics
        scoreboard players operation #Physics.Maths.b3.x Physics /= #Physics.Constants.1000 Physics

        scoreboard players operation #Physics.Maths.b3.y Physics *= @s Physics.Object.InverseInertiaTensorGlobal.3
        scoreboard players operation #Physics.Maths.Value6 Physics *= @s Physics.Object.InverseInertiaTensorGlobal.4
        scoreboard players operation #Physics.Maths.b3.y Physics += #Physics.Maths.Value6 Physics
        scoreboard players operation #Physics.Maths.b3.y Physics /= #Physics.Constants.1000 Physics

        # c = a * b
        # (Important): I overwrite a's scores for efficiency reasons. "a.x" is "c".
        scoreboard players operation #Physics.Maths.a3.x Physics *= #Physics.Maths.b3.x Physics
        scoreboard players operation #Physics.Maths.a3.y Physics *= #Physics.Maths.b3.y Physics
        scoreboard players operation #Physics.Maths.a3.x Physics += #Physics.Maths.a3.y Physics

        # EffectiveMass = InverseMass + c
        execute store result storage physics:resolution Contact.EffectiveMass[2] int 1 run scoreboard players operation #Physics.Maths.a3.x Physics += @s Physics.Object.InverseMass
