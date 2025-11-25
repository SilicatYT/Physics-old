scoreboard players set #Physics.SetupDone Physics 1

# Prepare scores for object-object collision detection & contact generation
# (Important): #Physics.ThisObject Physics.Object.Axis.?.? are set at the start of this function, inside the "execute store result", to squeeze out an extra bit of performance
# (Important): This runs before object-object collision detection happens in this function, because this lets me use a #-fakeplayer instead of using @s, making these accesses (even during world contact generation!) roughly 10% faster. Technically I only *need* those scores after everything related to world contacts is already 100% complete, so any #Physics.ThisObject reference that happens during this function or during world contact stuff is purely because of that.
# (Important): Object.ID is set above to avoid an extra "scoreboard players get".
scoreboard players operation #Physics.ThisObject Physics.Object.DefactoGravity = @s Physics.Object.DefactoGravity

scoreboard players operation #Physics.ThisObject Physics.Object.Pos.x = @s Physics.Object.Pos.x
scoreboard players operation #Physics.ThisObject Physics.Object.Pos.y = @s Physics.Object.Pos.y
scoreboard players operation #Physics.ThisObject Physics.Object.Pos.z = @s Physics.Object.Pos.z

scoreboard players operation #Physics.ThisObject Physics.Object.Velocity.x = @s Physics.Object.Velocity.x
scoreboard players operation #Physics.ThisObject Physics.Object.Velocity.y = @s Physics.Object.Velocity.y
scoreboard players operation #Physics.ThisObject Physics.Object.Velocity.z = @s Physics.Object.Velocity.z

scoreboard players operation #Physics.ThisObject Physics.Object.AngularVelocity.x = @s Physics.Object.AngularVelocity.x
scoreboard players operation #Physics.ThisObject Physics.Object.AngularVelocity.y = @s Physics.Object.AngularVelocity.y
scoreboard players operation #Physics.ThisObject Physics.Object.AngularVelocity.z = @s Physics.Object.AngularVelocity.z

scoreboard players operation #Physics.ThisObject Physics.Object.CornerPosRelative.0.x = @s Physics.Object.CornerPosRelative.0.x
scoreboard players operation #Physics.ThisObject Physics.Object.CornerPosRelative.0.y = @s Physics.Object.CornerPosRelative.0.y
scoreboard players operation #Physics.ThisObject Physics.Object.CornerPosRelative.0.z = @s Physics.Object.CornerPosRelative.0.z
scoreboard players operation #Physics.ThisObject Physics.Object.CornerPosRelative.1.x = @s Physics.Object.CornerPosRelative.1.x
scoreboard players operation #Physics.ThisObject Physics.Object.CornerPosRelative.1.y = @s Physics.Object.CornerPosRelative.1.y
scoreboard players operation #Physics.ThisObject Physics.Object.CornerPosRelative.1.z = @s Physics.Object.CornerPosRelative.1.z
scoreboard players operation #Physics.ThisObject Physics.Object.CornerPosRelative.2.x = @s Physics.Object.CornerPosRelative.2.x
scoreboard players operation #Physics.ThisObject Physics.Object.CornerPosRelative.2.y = @s Physics.Object.CornerPosRelative.2.y
scoreboard players operation #Physics.ThisObject Physics.Object.CornerPosRelative.2.z = @s Physics.Object.CornerPosRelative.2.z
scoreboard players operation #Physics.ThisObject Physics.Object.CornerPosRelative.3.x = @s Physics.Object.CornerPosRelative.3.x
scoreboard players operation #Physics.ThisObject Physics.Object.CornerPosRelative.3.y = @s Physics.Object.CornerPosRelative.3.y
scoreboard players operation #Physics.ThisObject Physics.Object.CornerPosRelative.3.z = @s Physics.Object.CornerPosRelative.3.z

scoreboard players operation #Physics.ThisObject Physics.Object.CornerPosGlobal.0.x = @s Physics.Object.CornerPosGlobal.0.x
scoreboard players operation #Physics.ThisObject Physics.Object.CornerPosGlobal.0.y = @s Physics.Object.CornerPosGlobal.0.y
scoreboard players operation #Physics.ThisObject Physics.Object.CornerPosGlobal.0.z = @s Physics.Object.CornerPosGlobal.0.z
scoreboard players operation #Physics.ThisObject Physics.Object.CornerPosGlobal.1.x = @s Physics.Object.CornerPosGlobal.1.x
scoreboard players operation #Physics.ThisObject Physics.Object.CornerPosGlobal.1.y = @s Physics.Object.CornerPosGlobal.1.y
scoreboard players operation #Physics.ThisObject Physics.Object.CornerPosGlobal.1.z = @s Physics.Object.CornerPosGlobal.1.z
scoreboard players operation #Physics.ThisObject Physics.Object.CornerPosGlobal.2.x = @s Physics.Object.CornerPosGlobal.2.x
scoreboard players operation #Physics.ThisObject Physics.Object.CornerPosGlobal.2.y = @s Physics.Object.CornerPosGlobal.2.y
scoreboard players operation #Physics.ThisObject Physics.Object.CornerPosGlobal.2.z = @s Physics.Object.CornerPosGlobal.2.z
scoreboard players operation #Physics.ThisObject Physics.Object.CornerPosGlobal.3.x = @s Physics.Object.CornerPosGlobal.3.x
scoreboard players operation #Physics.ThisObject Physics.Object.CornerPosGlobal.3.y = @s Physics.Object.CornerPosGlobal.3.y
scoreboard players operation #Physics.ThisObject Physics.Object.CornerPosGlobal.3.z = @s Physics.Object.CornerPosGlobal.3.z
scoreboard players operation #Physics.ThisObject Physics.Object.CornerPosGlobal.4.x = @s Physics.Object.CornerPosGlobal.4.x
scoreboard players operation #Physics.ThisObject Physics.Object.CornerPosGlobal.4.y = @s Physics.Object.CornerPosGlobal.4.y
scoreboard players operation #Physics.ThisObject Physics.Object.CornerPosGlobal.4.z = @s Physics.Object.CornerPosGlobal.4.z
scoreboard players operation #Physics.ThisObject Physics.Object.CornerPosGlobal.5.x = @s Physics.Object.CornerPosGlobal.5.x
scoreboard players operation #Physics.ThisObject Physics.Object.CornerPosGlobal.5.y = @s Physics.Object.CornerPosGlobal.5.y
scoreboard players operation #Physics.ThisObject Physics.Object.CornerPosGlobal.5.z = @s Physics.Object.CornerPosGlobal.5.z
scoreboard players operation #Physics.ThisObject Physics.Object.CornerPosGlobal.6.x = @s Physics.Object.CornerPosGlobal.6.x
scoreboard players operation #Physics.ThisObject Physics.Object.CornerPosGlobal.6.y = @s Physics.Object.CornerPosGlobal.6.y
scoreboard players operation #Physics.ThisObject Physics.Object.CornerPosGlobal.6.z = @s Physics.Object.CornerPosGlobal.6.z
scoreboard players operation #Physics.ThisObject Physics.Object.CornerPosGlobal.7.x = @s Physics.Object.CornerPosGlobal.7.x
scoreboard players operation #Physics.ThisObject Physics.Object.CornerPosGlobal.7.y = @s Physics.Object.CornerPosGlobal.7.y
scoreboard players operation #Physics.ThisObject Physics.Object.CornerPosGlobal.7.z = @s Physics.Object.CornerPosGlobal.7.z

scoreboard players operation #Physics.ThisObject Physics.Object.BoundingBoxGlobalMin.x = @s Physics.Object.BoundingBoxGlobalMin.x
scoreboard players operation #Physics.ThisObject Physics.Object.BoundingBoxGlobalMax.x = @s Physics.Object.BoundingBoxGlobalMax.x
scoreboard players operation #Physics.ThisObject Physics.Object.BoundingBoxGlobalMin.y = @s Physics.Object.BoundingBoxGlobalMin.y
scoreboard players operation #Physics.ThisObject Physics.Object.BoundingBoxGlobalMax.y = @s Physics.Object.BoundingBoxGlobalMax.y
scoreboard players operation #Physics.ThisObject Physics.Object.BoundingBoxGlobalMin.z = @s Physics.Object.BoundingBoxGlobalMin.z
scoreboard players operation #Physics.ThisObject Physics.Object.BoundingBoxGlobalMax.z = @s Physics.Object.BoundingBoxGlobalMax.z

scoreboard players operation #Physics.ThisObject Physics.Object.ProjectionOwnAxis.x.Min = @s Physics.Object.ProjectionOwnAxis.x.Min
scoreboard players operation #Physics.ThisObject Physics.Object.ProjectionOwnAxis.x.Max = @s Physics.Object.ProjectionOwnAxis.x.Max
scoreboard players operation #Physics.ThisObject Physics.Object.ProjectionOwnAxis.y.Min = @s Physics.Object.ProjectionOwnAxis.y.Min
scoreboard players operation #Physics.ThisObject Physics.Object.ProjectionOwnAxis.y.Max = @s Physics.Object.ProjectionOwnAxis.y.Max
scoreboard players operation #Physics.ThisObject Physics.Object.ProjectionOwnAxis.z.Min = @s Physics.Object.ProjectionOwnAxis.z.Min
scoreboard players operation #Physics.ThisObject Physics.Object.ProjectionOwnAxis.z.Max = @s Physics.Object.ProjectionOwnAxis.z.Max

scoreboard players operation #Physics.ThisObject Physics.Object.MaxPenetrationDepth = @s Physics.Object.MaxPenetrationDepth
scoreboard players operation #Physics.ThisObject Physics.Object.MinSeparatingVelocity = @s Physics.Object.MinSeparatingVelocity

# Pre-calculate as much as possible for the world SAT (Collisions with regular blocks)
    # 9 cross products of the 3 axes of the object and the world-geometry block
    # (Important): Because for instance the block's x axis only has its x component set, this results in a cross product whose x component is not set. I make several of these implications directly and don't even set certain values if the solution is always the same value. Then I work with that value directly.
    # (Important): Just like in several other parts of the code, I use "execute store result" when a value is calculated to create copies, instead of manually running "scoreboard players operation ... = ...", because the former is faster.
        # Get scores
        # (Important): Using store result to prevent repeated scoreboard operations. I think it should still be faster this way, even if I have to run a "get" command instead of being able to prepend the store result to where the value is calculated?
        execute store result score #Physics.ThisObject Physics.Object.Axis.x.x store result score #Physics.CrossProductAxis.yx.z Physics store result score #Physics.CrossProductAxis.zx.y Physics run scoreboard players operation #Physics.Maths.Value9 Physics = @s Physics.Object.Axis.x.x
        execute store result score #Physics.ThisObject Physics.Object.Axis.x.y store result score #Physics.CrossProductAxis.xx.z Physics store result score #Physics.Maths.Value3 Physics run scoreboard players operation #Physics.CrossProductAxis.zx.x Physics = @s Physics.Object.Axis.x.y
        execute store result score #Physics.ThisObject Physics.Object.Axis.x.z store result score #Physics.CrossProductAxis.xx.y Physics store result score #Physics.CrossProductAxis.yx.x Physics store result score #Physics.Maths.Value6 Physics run scoreboard players get @s Physics.Object.Axis.x.z

        execute store result score #Physics.ThisObject Physics.Object.Axis.y.x store result score #Physics.CrossProductAxis.yy.z Physics store result score #Physics.CrossProductAxis.zy.y Physics run scoreboard players operation #Physics.Maths.Value10 Physics = @s Physics.Object.Axis.y.x
        execute store result score #Physics.ThisObject Physics.Object.Axis.y.y store result score #Physics.CrossProductAxis.xy.z Physics store result score #Physics.Maths.Value4 Physics run scoreboard players operation #Physics.CrossProductAxis.zy.x Physics = @s Physics.Object.Axis.y.y
        execute store result score #Physics.ThisObject Physics.Object.Axis.y.z store result score #Physics.CrossProductAxis.xy.y Physics store result score #Physics.CrossProductAxis.yy.x Physics run scoreboard players operation #Physics.Maths.Value7 Physics = @s Physics.Object.Axis.y.z

        execute store result score #Physics.ThisObject Physics.Object.Axis.z.x store result score #Physics.CrossProductAxis.yz.z Physics store result score #Physics.CrossProductAxis.zz.y Physics run scoreboard players operation #Physics.Maths.Value11 Physics = @s Physics.Object.Axis.z.x
        execute store result score #Physics.ThisObject Physics.Object.Axis.z.y store result score #Physics.CrossProductAxis.xz.z Physics store result score #Physics.Maths.Value5 Physics run scoreboard players operation #Physics.CrossProductAxis.zz.x Physics = @s Physics.Object.Axis.z.y
        execute store result score #Physics.ThisObject Physics.Object.Axis.z.z store result score #Physics.CrossProductAxis.xz.y Physics store result score #Physics.CrossProductAxis.yz.x Physics run scoreboard players operation #Physics.Maths.Value8 Physics = @s Physics.Object.Axis.z.z

        # x_block x x_object
            # Calculation (x_block => The x component is always 0, the y component is -z from the object's axis, and the z component is y from the object's axis)
            execute store result score #Physics.Maths.SquareRoot.Input Physics run scoreboard players operation #Physics.CrossProductAxis.xx.y Physics *= #Physics.Constants.-1 Physics

            # Normalization
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics *= #Physics.Maths.SquareRoot.Input Physics
            scoreboard players operation #Physics.Maths.Value3 Physics *= #Physics.Maths.Value3 Physics
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics += #Physics.Maths.Value3 Physics
            function physics:zprivate/maths/get_square_root

            scoreboard players operation #Physics.CrossProductAxis.xx.y Physics *= #Physics.Constants.1000 Physics
            scoreboard players operation #Physics.CrossProductAxis.xx.z Physics *= #Physics.Constants.1000 Physics
            execute store result score #Physics.Projection.ObjectCorner0.CrossProductAxis.xx Physics store result score #Physics.Projection.ObjectCorner1.CrossProductAxis.xx Physics store result score #Physics.Projection.ObjectCenter.CrossProductAxis.xx Physics run scoreboard players operation #Physics.CrossProductAxis.xx.y Physics /= #Physics.Maths.SquareRoot.Output Physics
            execute store result score #Physics.Maths.Value12 Physics store result score #Physics.Maths.Value13 Physics store result score #Physics.Maths.Value14 Physics run scoreboard players operation #Physics.CrossProductAxis.xx.z Physics /= #Physics.Maths.SquareRoot.Output Physics

        # x_block x y_object
            # Calculation
            execute store result score #Physics.Maths.SquareRoot.Input Physics run scoreboard players operation #Physics.CrossProductAxis.xy.y Physics *= #Physics.Constants.-1 Physics

            # Normalization
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics *= #Physics.Maths.SquareRoot.Input Physics
            scoreboard players operation #Physics.Maths.Value4 Physics *= #Physics.Maths.Value4 Physics
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics += #Physics.Maths.Value4 Physics
            function physics:zprivate/maths/get_square_root

            scoreboard players operation #Physics.CrossProductAxis.xy.y Physics *= #Physics.Constants.1000 Physics
            scoreboard players operation #Physics.CrossProductAxis.xy.z Physics *= #Physics.Constants.1000 Physics
            execute store result score #Physics.Projection.ObjectCorner0.CrossProductAxis.xy Physics store result score #Physics.Projection.ObjectCorner1.CrossProductAxis.xy Physics store result score #Physics.Projection.ObjectCorner2.CrossProductAxis.xy Physics store result score #Physics.Projection.ObjectCorner3.CrossProductAxis.xy Physics store result score #Physics.Projection.ObjectCenter.CrossProductAxis.xy Physics run scoreboard players operation #Physics.CrossProductAxis.xy.y Physics /= #Physics.Maths.SquareRoot.Output Physics
            execute store result score #Physics.Maths.Value15 Physics store result score #Physics.Maths.Value16 Physics store result score #Physics.Maths.Value17 Physics run scoreboard players operation #Physics.CrossProductAxis.xy.z Physics /= #Physics.Maths.SquareRoot.Output Physics

        # x_block x z_object
            # Calculation
            execute store result score #Physics.Maths.SquareRoot.Input Physics run scoreboard players operation #Physics.CrossProductAxis.xz.y Physics *= #Physics.Constants.-1 Physics

            # Normalization
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics *= #Physics.Maths.SquareRoot.Input Physics
            scoreboard players operation #Physics.Maths.Value5 Physics *= #Physics.Maths.Value5 Physics
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics += #Physics.Maths.Value5 Physics
            function physics:zprivate/maths/get_square_root

            scoreboard players operation #Physics.CrossProductAxis.xz.y Physics *= #Physics.Constants.1000 Physics
            scoreboard players operation #Physics.CrossProductAxis.xz.z Physics *= #Physics.Constants.1000 Physics
            execute store result score #Physics.Projection.ObjectCorner0.CrossProductAxis.xz Physics store result score #Physics.Projection.ObjectCorner2.CrossProductAxis.xz Physics store result score #Physics.Projection.ObjectCenter.CrossProductAxis.xz Physics run scoreboard players operation #Physics.CrossProductAxis.xz.y Physics /= #Physics.Maths.SquareRoot.Output Physics
            execute store result score #Physics.Maths.Value18 Physics store result score #Physics.Maths.Value19 Physics store result score #Physics.Maths.Value20 Physics run scoreboard players operation #Physics.CrossProductAxis.xz.z Physics /= #Physics.Maths.SquareRoot.Output Physics

        # y_block x x_object
            # Calculation (y_block => The x component is z from the object's axis, the y component is always 0, and the z component is -x from the object's axis)
            execute store result score #Physics.Maths.SquareRoot.Input Physics run scoreboard players operation #Physics.CrossProductAxis.yx.z Physics *= #Physics.Constants.-1 Physics

            # Normalization
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics *= #Physics.Maths.SquareRoot.Input Physics
            scoreboard players operation #Physics.Maths.Value6 Physics *= #Physics.Maths.Value6 Physics
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics += #Physics.Maths.Value6 Physics
            function physics:zprivate/maths/get_square_root

            scoreboard players operation #Physics.CrossProductAxis.yx.x Physics *= #Physics.Constants.1000 Physics
            scoreboard players operation #Physics.CrossProductAxis.yx.z Physics *= #Physics.Constants.1000 Physics
            execute store result score #Physics.Projection.ObjectCorner0.CrossProductAxis.yx Physics store result score #Physics.Projection.ObjectCorner1.CrossProductAxis.yx Physics store result score #Physics.Projection.ObjectCenter.CrossProductAxis.yx Physics run scoreboard players operation #Physics.CrossProductAxis.yx.x Physics /= #Physics.Maths.SquareRoot.Output Physics
            execute store result score #Physics.Maths.Value21 Physics store result score #Physics.Maths.Value22 Physics store result score #Physics.Maths.Value23 Physics run scoreboard players operation #Physics.CrossProductAxis.yx.z Physics /= #Physics.Maths.SquareRoot.Output Physics

        # y_block x y_object
            # Calculation
            execute store result score #Physics.Maths.SquareRoot.Input Physics run scoreboard players operation #Physics.CrossProductAxis.yy.z Physics *= #Physics.Constants.-1 Physics

            # Normalization
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics *= #Physics.Maths.SquareRoot.Input Physics
            scoreboard players operation #Physics.Maths.Value7 Physics *= #Physics.Maths.Value7 Physics
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics += #Physics.Maths.Value7 Physics
            function physics:zprivate/maths/get_square_root

            scoreboard players operation #Physics.CrossProductAxis.yy.x Physics *= #Physics.Constants.1000 Physics
            scoreboard players operation #Physics.CrossProductAxis.yy.z Physics *= #Physics.Constants.1000 Physics
            execute store result score #Physics.Projection.ObjectCorner0.CrossProductAxis.yy Physics store result score #Physics.Projection.ObjectCorner1.CrossProductAxis.yy Physics store result score #Physics.Projection.ObjectCorner2.CrossProductAxis.yy Physics store result score #Physics.Projection.ObjectCorner3.CrossProductAxis.yy Physics store result score #Physics.Projection.ObjectCenter.CrossProductAxis.yy Physics run scoreboard players operation #Physics.CrossProductAxis.yy.x Physics /= #Physics.Maths.SquareRoot.Output Physics
            execute store result score #Physics.Maths.Value24 Physics store result score #Physics.Maths.Value25 Physics store result score #Physics.Maths.Value26 Physics run scoreboard players operation #Physics.CrossProductAxis.yy.z Physics /= #Physics.Maths.SquareRoot.Output Physics

        # y_block x z_object
            # Calculation
            execute store result score #Physics.Maths.SquareRoot.Input Physics run scoreboard players operation #Physics.CrossProductAxis.yz.z Physics *= #Physics.Constants.-1 Physics

            # Normalization
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics *= #Physics.Maths.SquareRoot.Input Physics
            scoreboard players operation #Physics.Maths.Value8 Physics *= #Physics.Maths.Value8 Physics
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics += #Physics.Maths.Value8 Physics
            function physics:zprivate/maths/get_square_root

            scoreboard players operation #Physics.CrossProductAxis.yz.x Physics *= #Physics.Constants.1000 Physics
            scoreboard players operation #Physics.CrossProductAxis.yz.z Physics *= #Physics.Constants.1000 Physics
            execute store result score #Physics.Projection.ObjectCorner0.CrossProductAxis.yz Physics store result score #Physics.Projection.ObjectCorner2.CrossProductAxis.yz Physics store result score #Physics.Projection.ObjectCenter.CrossProductAxis.yz Physics run scoreboard players operation #Physics.CrossProductAxis.yz.x Physics /= #Physics.Maths.SquareRoot.Output Physics
            execute store result score #Physics.Maths.Value27 Physics store result score #Physics.Maths.Value28 Physics store result score #Physics.Maths.Value29 Physics run scoreboard players operation #Physics.CrossProductAxis.yz.z Physics /= #Physics.Maths.SquareRoot.Output Physics

        # z_block x x_object
            # Calculation (z_block => The x component is -y from the object's axis, the y component is x from the object's axis, and the z component is always 0)
            execute store result score #Physics.Maths.SquareRoot.Input Physics run scoreboard players operation #Physics.CrossProductAxis.zx.x Physics *= #Physics.Constants.-1 Physics

            # Normalization
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics *= #Physics.Maths.SquareRoot.Input Physics
            scoreboard players operation #Physics.Maths.Value9 Physics *= #Physics.Maths.Value9 Physics
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics += #Physics.Maths.Value9 Physics
            function physics:zprivate/maths/get_square_root

            scoreboard players operation #Physics.CrossProductAxis.zx.x Physics *= #Physics.Constants.1000 Physics
            scoreboard players operation #Physics.CrossProductAxis.zx.y Physics *= #Physics.Constants.1000 Physics
            execute store result score #Physics.Projection.ObjectCorner0.CrossProductAxis.zx Physics store result score #Physics.Projection.ObjectCorner1.CrossProductAxis.zx Physics store result score #Physics.Projection.ObjectCenter.CrossProductAxis.zx Physics run scoreboard players operation #Physics.CrossProductAxis.zx.x Physics /= #Physics.Maths.SquareRoot.Output Physics
            execute store result score #Physics.Maths.Value30 Physics store result score #Physics.Maths.Value31 Physics store result score #Physics.Maths.Value32 Physics run scoreboard players operation #Physics.CrossProductAxis.zx.y Physics /= #Physics.Maths.SquareRoot.Output Physics

        # z_block x y_object
            # Calculation
            execute store result score #Physics.Maths.SquareRoot.Input Physics run scoreboard players operation #Physics.CrossProductAxis.zy.x Physics *= #Physics.Constants.-1 Physics

            # Normalization
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics *= #Physics.Maths.SquareRoot.Input Physics
            scoreboard players operation #Physics.Maths.Value10 Physics *= #Physics.Maths.Value10 Physics
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics += #Physics.Maths.Value10 Physics
            function physics:zprivate/maths/get_square_root

            scoreboard players operation #Physics.CrossProductAxis.zy.x Physics *= #Physics.Constants.1000 Physics
            scoreboard players operation #Physics.CrossProductAxis.zy.y Physics *= #Physics.Constants.1000 Physics
            execute store result score #Physics.Projection.ObjectCorner0.CrossProductAxis.zy Physics store result score #Physics.Projection.ObjectCorner1.CrossProductAxis.zy Physics store result score #Physics.Projection.ObjectCorner2.CrossProductAxis.zy Physics store result score #Physics.Projection.ObjectCorner3.CrossProductAxis.zy Physics store result score #Physics.Projection.ObjectCenter.CrossProductAxis.zy Physics run scoreboard players operation #Physics.CrossProductAxis.zy.x Physics /= #Physics.Maths.SquareRoot.Output Physics
            execute store result score #Physics.Maths.Value33 Physics store result score #Physics.Maths.Value34 Physics store result score #Physics.Maths.Value35 Physics run scoreboard players operation #Physics.CrossProductAxis.zy.y Physics /= #Physics.Maths.SquareRoot.Output Physics

        # z_block x z_object
            # Calculation
            execute store result score #Physics.Maths.SquareRoot.Input Physics run scoreboard players operation #Physics.CrossProductAxis.zz.x Physics *= #Physics.Constants.-1 Physics

            # Normalization
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics *= #Physics.Maths.SquareRoot.Input Physics
            scoreboard players operation #Physics.Maths.Value11 Physics *= #Physics.Maths.Value11 Physics
            scoreboard players operation #Physics.Maths.SquareRoot.Input Physics += #Physics.Maths.Value11 Physics
            function physics:zprivate/maths/get_square_root

            scoreboard players operation #Physics.CrossProductAxis.zz.x Physics *= #Physics.Constants.1000 Physics
            scoreboard players operation #Physics.CrossProductAxis.zz.y Physics *= #Physics.Constants.1000 Physics
            execute store result score #Physics.Projection.ObjectCorner0.CrossProductAxis.zz Physics store result score #Physics.Projection.ObjectCorner2.CrossProductAxis.zz Physics store result score #Physics.Projection.ObjectCenter.CrossProductAxis.zz Physics run scoreboard players operation #Physics.CrossProductAxis.zz.x Physics /= #Physics.Maths.SquareRoot.Output Physics
            execute store result score #Physics.Maths.Value36 Physics store result score #Physics.Maths.Value37 Physics store result score #Physics.Maths.Value38 Physics run scoreboard players operation #Physics.CrossProductAxis.zz.y Physics /= #Physics.Maths.SquareRoot.Output Physics

    # Project the 8 corner points of world-geometry blocks onto the 3 object axes and the 9 cross products, using relative coordinates from the block position
    # (Important): Because the block positions are their center instead of their coordinate origin, the projections of 4 corners are the just mirrored versions of the other 4. This means I can simply project 4 points, flip the sign to get the other 4 points, then use those 8 points to get the max on that axis. Then flip the sign on the max again to get the min.
    # (Important): Some interim results can be re-used using "execute store result ..." to prevent repeated calculation, because for instance -500*<y axis component>, -500*<x axis component>, 500*<x axis component>, -500*<z axis component> and 500*<z axis component> are used several times
    # (Important): Previously I just corrected the scaling for the min and max to save performance, but I'll need the corner projections for contact generation (Figure out which features are involved). And to avoid "fixing" the scale for every block, I do it here once, even if the respective value might not be needed later depending on the axis of minimum overlap.
    # (Important): The output values will be up to 2 units less accurate, because I already divide the interim results instead of the final results. That could be fixed, but it would require more divisions.
        # x_object
            # Corner 0 [-500, -500, -500]
            scoreboard players operation #Physics.Projection.BlockCornerBase0.ObjectAxis.x Physics = @s Physics.Object.Axis.x.y
            execute store result score #Physics.Projection.BlockCornerBase2.ObjectAxis.x Physics run scoreboard players operation #Physics.Projection.BlockCornerBase0.ObjectAxis.x Physics /= #Physics.Constants.-2 Physics

            scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.Axis.x.x
            scoreboard players operation #Physics.Maths.Value1 Physics /= #Physics.Constants.-2 Physics
            execute store result score #Physics.Projection.BlockCornerBase1.ObjectAxis.x Physics run scoreboard players operation #Physics.Projection.BlockCornerBase0.ObjectAxis.x Physics += #Physics.Maths.Value1 Physics

            scoreboard players operation #Physics.Maths.Value2 Physics = @s Physics.Object.Axis.x.z
            scoreboard players operation #Physics.Maths.Value2 Physics /= #Physics.Constants.-2 Physics
            execute store result score #Physics.Projection.BlockCornerBase7.ObjectAxis.x Physics store result score #Physics.Projection.BlockBase.ObjectAxis.x.Max Physics run scoreboard players operation #Physics.Projection.BlockCornerBase0.ObjectAxis.x Physics += #Physics.Maths.Value2 Physics

            # Corner 1 [-500, -500, 500]
            execute store result score #Physics.Projection.BlockCornerBase6.ObjectAxis.x Physics run scoreboard players operation #Physics.Projection.BlockCornerBase1.ObjectAxis.x Physics -= #Physics.Maths.Value2 Physics

            # Corner 2 [500, -500, -500]
            execute store result score #Physics.Projection.BlockCornerBase3.ObjectAxis.x Physics run scoreboard players operation #Physics.Projection.BlockCornerBase2.ObjectAxis.x Physics -= #Physics.Maths.Value1 Physics
            execute store result score #Physics.Projection.BlockCornerBase5.ObjectAxis.x Physics run scoreboard players operation #Physics.Projection.BlockCornerBase2.ObjectAxis.x Physics += #Physics.Maths.Value2 Physics

            # Corner 3 [500, -500, 500]
            execute store result score #Physics.Projection.BlockCornerBase4.ObjectAxis.x Physics run scoreboard players operation #Physics.Projection.BlockCornerBase3.ObjectAxis.x Physics -= #Physics.Maths.Value2 Physics

            # Corner 4 [-500, 500, -500] (-> Mirrored version of 3)
            scoreboard players operation #Physics.Projection.BlockCornerBase4.ObjectAxis.x Physics *= #Physics.Constants.-1 Physics

            # Corner 5 [-500, 500, 500] (-> Mirrored version of 2)
            scoreboard players operation #Physics.Projection.BlockCornerBase5.ObjectAxis.x Physics *= #Physics.Constants.-1 Physics

            # Corner 6 [500, 500, -500] (-> Mirrored version of 1)
            scoreboard players operation #Physics.Projection.BlockCornerBase6.ObjectAxis.x Physics *= #Physics.Constants.-1 Physics

            # Corner 7 [500, 500, 500] (-> Mirrored version of 0)
            scoreboard players operation #Physics.Projection.BlockCornerBase7.ObjectAxis.x Physics *= #Physics.Constants.-1 Physics

            # Find min and max
            execute if score #Physics.Projection.BlockCornerBase1.ObjectAxis.x Physics > #Physics.Projection.BlockBase.ObjectAxis.x.Max Physics run scoreboard players operation #Physics.Projection.BlockBase.ObjectAxis.x.Max Physics = #Physics.Projection.BlockCornerBase1.ObjectAxis.x Physics
            execute if score #Physics.Projection.BlockCornerBase2.ObjectAxis.x Physics > #Physics.Projection.BlockBase.ObjectAxis.x.Max Physics run scoreboard players operation #Physics.Projection.BlockBase.ObjectAxis.x.Max Physics = #Physics.Projection.BlockCornerBase2.ObjectAxis.x Physics
            execute if score #Physics.Projection.BlockCornerBase3.ObjectAxis.x Physics > #Physics.Projection.BlockBase.ObjectAxis.x.Max Physics run scoreboard players operation #Physics.Projection.BlockBase.ObjectAxis.x.Max Physics = #Physics.Projection.BlockCornerBase3.ObjectAxis.x Physics
            execute if score #Physics.Projection.BlockCornerBase4.ObjectAxis.x Physics > #Physics.Projection.BlockBase.ObjectAxis.x.Max Physics run scoreboard players operation #Physics.Projection.BlockBase.ObjectAxis.x.Max Physics = #Physics.Projection.BlockCornerBase4.ObjectAxis.x Physics
            execute if score #Physics.Projection.BlockCornerBase5.ObjectAxis.x Physics > #Physics.Projection.BlockBase.ObjectAxis.x.Max Physics run scoreboard players operation #Physics.Projection.BlockBase.ObjectAxis.x.Max Physics = #Physics.Projection.BlockCornerBase5.ObjectAxis.x Physics
            execute if score #Physics.Projection.BlockCornerBase6.ObjectAxis.x Physics > #Physics.Projection.BlockBase.ObjectAxis.x.Max Physics run scoreboard players operation #Physics.Projection.BlockBase.ObjectAxis.x.Max Physics = #Physics.Projection.BlockCornerBase6.ObjectAxis.x Physics
            execute if score #Physics.Projection.BlockCornerBase7.ObjectAxis.x Physics > #Physics.Projection.BlockBase.ObjectAxis.x.Max Physics run scoreboard players operation #Physics.Projection.BlockBase.ObjectAxis.x.Max Physics = #Physics.Projection.BlockCornerBase7.ObjectAxis.x Physics
            scoreboard players operation #Physics.Projection.BlockBase.ObjectAxis.x.Min Physics = #Physics.Projection.BlockBase.ObjectAxis.x.Max Physics
            scoreboard players operation #Physics.Projection.BlockBase.ObjectAxis.x.Min Physics *= #Physics.Constants.-1 Physics

        # y_object
            # Corner 0 [-500, -500, -500]
            scoreboard players operation #Physics.Projection.BlockCornerBase0.ObjectAxis.y Physics = @s Physics.Object.Axis.y.y
            execute store result score #Physics.Projection.BlockCornerBase2.ObjectAxis.y Physics run scoreboard players operation #Physics.Projection.BlockCornerBase0.ObjectAxis.y Physics /= #Physics.Constants.-2 Physics

            scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.Axis.y.x
            scoreboard players operation #Physics.Maths.Value1 Physics /= #Physics.Constants.-2 Physics
            execute store result score #Physics.Projection.BlockCornerBase1.ObjectAxis.y Physics run scoreboard players operation #Physics.Projection.BlockCornerBase0.ObjectAxis.y Physics += #Physics.Maths.Value1 Physics

            scoreboard players operation #Physics.Maths.Value2 Physics = @s Physics.Object.Axis.y.z
            scoreboard players operation #Physics.Maths.Value2 Physics /= #Physics.Constants.-2 Physics
            execute store result score #Physics.Projection.BlockCornerBase7.ObjectAxis.y Physics store result score #Physics.Projection.BlockBase.ObjectAxis.y.Max Physics run scoreboard players operation #Physics.Projection.BlockCornerBase0.ObjectAxis.y Physics += #Physics.Maths.Value2 Physics

            # Corner 1 [-500, -500, 500]
            execute store result score #Physics.Projection.BlockCornerBase6.ObjectAxis.y Physics run scoreboard players operation #Physics.Projection.BlockCornerBase1.ObjectAxis.y Physics -= #Physics.Maths.Value2 Physics

            # Corner 2 [500, -500, -500]
            execute store result score #Physics.Projection.BlockCornerBase3.ObjectAxis.y Physics run scoreboard players operation #Physics.Projection.BlockCornerBase2.ObjectAxis.y Physics -= #Physics.Maths.Value1 Physics
            execute store result score #Physics.Projection.BlockCornerBase5.ObjectAxis.y Physics run scoreboard players operation #Physics.Projection.BlockCornerBase2.ObjectAxis.y Physics += #Physics.Maths.Value2 Physics

            # Corner 3 [500, -500, 500]
            execute store result score #Physics.Projection.BlockCornerBase4.ObjectAxis.y Physics run scoreboard players operation #Physics.Projection.BlockCornerBase3.ObjectAxis.y Physics -= #Physics.Maths.Value2 Physics

            # Corner 4 [-500, 500, -500] (-> Mirrored version of 3)
            scoreboard players operation #Physics.Projection.BlockCornerBase4.ObjectAxis.y Physics *= #Physics.Constants.-1 Physics

            # Corner 5 [-500, 500, 500] (-> Mirrored version of 2)
            scoreboard players operation #Physics.Projection.BlockCornerBase5.ObjectAxis.y Physics *= #Physics.Constants.-1 Physics

            # Corner 6 [500, 500, -500] (-> Mirrored version of 1)
            scoreboard players operation #Physics.Projection.BlockCornerBase6.ObjectAxis.y Physics *= #Physics.Constants.-1 Physics

            # Corner 7 [500, 500, 500] (-> Mirrored version of 0)
            scoreboard players operation #Physics.Projection.BlockCornerBase7.ObjectAxis.y Physics *= #Physics.Constants.-1 Physics

            # Find min and max
            execute if score #Physics.Projection.BlockCornerBase1.ObjectAxis.y Physics > #Physics.Projection.BlockBase.ObjectAxis.y.Max Physics run scoreboard players operation #Physics.Projection.BlockBase.ObjectAxis.y.Max Physics = #Physics.Projection.BlockCornerBase1.ObjectAxis.y Physics
            execute if score #Physics.Projection.BlockCornerBase2.ObjectAxis.y Physics > #Physics.Projection.BlockBase.ObjectAxis.y.Max Physics run scoreboard players operation #Physics.Projection.BlockBase.ObjectAxis.y.Max Physics = #Physics.Projection.BlockCornerBase2.ObjectAxis.y Physics
            execute if score #Physics.Projection.BlockCornerBase3.ObjectAxis.y Physics > #Physics.Projection.BlockBase.ObjectAxis.y.Max Physics run scoreboard players operation #Physics.Projection.BlockBase.ObjectAxis.y.Max Physics = #Physics.Projection.BlockCornerBase3.ObjectAxis.y Physics
            execute if score #Physics.Projection.BlockCornerBase4.ObjectAxis.y Physics > #Physics.Projection.BlockBase.ObjectAxis.y.Max Physics run scoreboard players operation #Physics.Projection.BlockBase.ObjectAxis.y.Max Physics = #Physics.Projection.BlockCornerBase4.ObjectAxis.y Physics
            execute if score #Physics.Projection.BlockCornerBase5.ObjectAxis.y Physics > #Physics.Projection.BlockBase.ObjectAxis.y.Max Physics run scoreboard players operation #Physics.Projection.BlockBase.ObjectAxis.y.Max Physics = #Physics.Projection.BlockCornerBase5.ObjectAxis.y Physics
            execute if score #Physics.Projection.BlockCornerBase6.ObjectAxis.y Physics > #Physics.Projection.BlockBase.ObjectAxis.y.Max Physics run scoreboard players operation #Physics.Projection.BlockBase.ObjectAxis.y.Max Physics = #Physics.Projection.BlockCornerBase6.ObjectAxis.y Physics
            execute if score #Physics.Projection.BlockCornerBase7.ObjectAxis.y Physics > #Physics.Projection.BlockBase.ObjectAxis.y.Max Physics run scoreboard players operation #Physics.Projection.BlockBase.ObjectAxis.y.Max Physics = #Physics.Projection.BlockCornerBase7.ObjectAxis.y Physics
            scoreboard players operation #Physics.Projection.BlockBase.ObjectAxis.y.Min Physics = #Physics.Projection.BlockBase.ObjectAxis.y.Max Physics
            scoreboard players operation #Physics.Projection.BlockBase.ObjectAxis.y.Min Physics *= #Physics.Constants.-1 Physics

        # z_object
            # Corner 0 [-500, -500, -500]
            scoreboard players operation #Physics.Projection.BlockCornerBase0.ObjectAxis.z Physics = @s Physics.Object.Axis.z.y
            execute store result score #Physics.Projection.BlockCornerBase2.ObjectAxis.z Physics run scoreboard players operation #Physics.Projection.BlockCornerBase0.ObjectAxis.z Physics /= #Physics.Constants.-2 Physics

            scoreboard players operation #Physics.Maths.Value1 Physics = @s Physics.Object.Axis.z.x
            scoreboard players operation #Physics.Maths.Value1 Physics /= #Physics.Constants.-2 Physics
            execute store result score #Physics.Projection.BlockCornerBase1.ObjectAxis.z Physics run scoreboard players operation #Physics.Projection.BlockCornerBase0.ObjectAxis.z Physics += #Physics.Maths.Value1 Physics

            scoreboard players operation #Physics.Maths.Value2 Physics = @s Physics.Object.Axis.z.z
            scoreboard players operation #Physics.Maths.Value2 Physics /= #Physics.Constants.-2 Physics
            execute store result score #Physics.Projection.BlockCornerBase7.ObjectAxis.z Physics store result score #Physics.Projection.BlockBase.ObjectAxis.z.Max Physics run scoreboard players operation #Physics.Projection.BlockCornerBase0.ObjectAxis.z Physics += #Physics.Maths.Value2 Physics

            # Corner 1 [-500, -500, 500]
            execute store result score #Physics.Projection.BlockCornerBase6.ObjectAxis.z Physics run scoreboard players operation #Physics.Projection.BlockCornerBase1.ObjectAxis.z Physics -= #Physics.Maths.Value2 Physics

            # Corner 2 [500, -500, -500]
            execute store result score #Physics.Projection.BlockCornerBase3.ObjectAxis.z Physics run scoreboard players operation #Physics.Projection.BlockCornerBase2.ObjectAxis.z Physics -= #Physics.Maths.Value1 Physics
            execute store result score #Physics.Projection.BlockCornerBase5.ObjectAxis.z Physics run scoreboard players operation #Physics.Projection.BlockCornerBase2.ObjectAxis.z Physics += #Physics.Maths.Value2 Physics

            # Corner 3 [500, -500, 500]
            execute store result score #Physics.Projection.BlockCornerBase4.ObjectAxis.z Physics run scoreboard players operation #Physics.Projection.BlockCornerBase3.ObjectAxis.z Physics -= #Physics.Maths.Value2 Physics

            # Corner 4 [-500, 500, -500] (-> Mirrored version of 3)
            scoreboard players operation #Physics.Projection.BlockCornerBase4.ObjectAxis.z Physics *= #Physics.Constants.-1 Physics

            # Corner 5 [-500, 500, 500] (-> Mirrored version of 2)
            scoreboard players operation #Physics.Projection.BlockCornerBase5.ObjectAxis.z Physics *= #Physics.Constants.-1 Physics

            # Corner 6 [500, 500, -500] (-> Mirrored version of 1)
            scoreboard players operation #Physics.Projection.BlockCornerBase6.ObjectAxis.z Physics *= #Physics.Constants.-1 Physics

            # Corner 7 [500, 500, 500] (-> Mirrored version of 0)
            scoreboard players operation #Physics.Projection.BlockCornerBase7.ObjectAxis.z Physics *= #Physics.Constants.-1 Physics

            # Find min and max
            execute if score #Physics.Projection.BlockCornerBase1.ObjectAxis.z Physics > #Physics.Projection.BlockBase.ObjectAxis.z.Max Physics run scoreboard players operation #Physics.Projection.BlockBase.ObjectAxis.z.Max Physics = #Physics.Projection.BlockCornerBase1.ObjectAxis.z Physics
            execute if score #Physics.Projection.BlockCornerBase2.ObjectAxis.z Physics > #Physics.Projection.BlockBase.ObjectAxis.z.Max Physics run scoreboard players operation #Physics.Projection.BlockBase.ObjectAxis.z.Max Physics = #Physics.Projection.BlockCornerBase2.ObjectAxis.z Physics
            execute if score #Physics.Projection.BlockCornerBase3.ObjectAxis.z Physics > #Physics.Projection.BlockBase.ObjectAxis.z.Max Physics run scoreboard players operation #Physics.Projection.BlockBase.ObjectAxis.z.Max Physics = #Physics.Projection.BlockCornerBase3.ObjectAxis.z Physics
            execute if score #Physics.Projection.BlockCornerBase4.ObjectAxis.z Physics > #Physics.Projection.BlockBase.ObjectAxis.z.Max Physics run scoreboard players operation #Physics.Projection.BlockBase.ObjectAxis.z.Max Physics = #Physics.Projection.BlockCornerBase4.ObjectAxis.z Physics
            execute if score #Physics.Projection.BlockCornerBase5.ObjectAxis.z Physics > #Physics.Projection.BlockBase.ObjectAxis.z.Max Physics run scoreboard players operation #Physics.Projection.BlockBase.ObjectAxis.z.Max Physics = #Physics.Projection.BlockCornerBase5.ObjectAxis.z Physics
            execute if score #Physics.Projection.BlockCornerBase6.ObjectAxis.z Physics > #Physics.Projection.BlockBase.ObjectAxis.z.Max Physics run scoreboard players operation #Physics.Projection.BlockBase.ObjectAxis.z.Max Physics = #Physics.Projection.BlockCornerBase6.ObjectAxis.z Physics
            execute if score #Physics.Projection.BlockCornerBase7.ObjectAxis.z Physics > #Physics.Projection.BlockBase.ObjectAxis.z.Max Physics run scoreboard players operation #Physics.Projection.BlockBase.ObjectAxis.z.Max Physics = #Physics.Projection.BlockCornerBase7.ObjectAxis.z Physics
            scoreboard players operation #Physics.Projection.BlockBase.ObjectAxis.z.Min Physics = #Physics.Projection.BlockBase.ObjectAxis.z.Max Physics
            scoreboard players operation #Physics.Projection.BlockBase.ObjectAxis.z.Min Physics *= #Physics.Constants.-1 Physics

        # Cross Product: x_block x x_object
        # (Important): Cross product's x component is 0, so x can be ignored
            # Corner 0 [-500, -500]
            scoreboard players operation #Physics.Projection.BlockCornerBase0.CrossProductAxis.xx Physics = #Physics.CrossProductAxis.xx.y Physics
            execute store result score #Physics.Projection.BlockCornerBase1.CrossProductAxis.xx Physics run scoreboard players operation #Physics.Projection.BlockCornerBase0.CrossProductAxis.xx Physics /= #Physics.Constants.-2 Physics

            scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.CrossProductAxis.xx.z Physics
            scoreboard players operation #Physics.Maths.Value1 Physics /= #Physics.Constants.-2 Physics
            execute store result score #Physics.Projection.BlockCornerBase5.CrossProductAxis.xx Physics store result score #Physics.Projection.BlockBase.CrossProductAxis.xx.Max Physics run scoreboard players operation #Physics.Projection.BlockCornerBase0.CrossProductAxis.xx Physics += #Physics.Maths.Value1 Physics

            # Corner 1 [-500, 500]
            execute store result score #Physics.Projection.BlockCornerBase4.CrossProductAxis.xx Physics run scoreboard players operation #Physics.Projection.BlockCornerBase1.CrossProductAxis.xx Physics -= #Physics.Maths.Value1 Physics

            # Corner 2 [-500, -500] (Same as 0)

            # Corner 3 [-500, 500] (Same as 1)

            # Corner 4 [500, -500] (Mirrored version of 1)
            scoreboard players operation #Physics.Projection.BlockCornerBase4.CrossProductAxis.xx Physics *= #Physics.Constants.-1 Physics

            # Corner 5 [500, 500] (Mirrored version of 0)
            scoreboard players operation #Physics.Projection.BlockCornerBase5.CrossProductAxis.xx Physics *= #Physics.Constants.-1 Physics

            # Corner 6 [500, -500] (Same as 4)

            # Corner 7 [500, 500] (Same as 5)

            # Find min and max
            execute if score #Physics.Projection.BlockCornerBase1.CrossProductAxis.xx Physics > #Physics.Projection.BlockBase.CrossProductAxis.xx.Max Physics run scoreboard players operation #Physics.Projection.BlockBase.CrossProductAxis.xx.Max Physics = #Physics.Projection.BlockCornerBase1.CrossProductAxis.xx Physics
            execute if score #Physics.Projection.BlockCornerBase4.CrossProductAxis.xx Physics > #Physics.Projection.BlockBase.CrossProductAxis.xx.Max Physics run scoreboard players operation #Physics.Projection.BlockBase.CrossProductAxis.xx.Max Physics = #Physics.Projection.BlockCornerBase4.CrossProductAxis.xx Physics
            execute if score #Physics.Projection.BlockCornerBase5.CrossProductAxis.xx Physics > #Physics.Projection.BlockBase.CrossProductAxis.xx.Max Physics run scoreboard players operation #Physics.Projection.BlockBase.CrossProductAxis.xx.Max Physics = #Physics.Projection.BlockCornerBase5.CrossProductAxis.xx Physics
            scoreboard players operation #Physics.Projection.BlockBase.CrossProductAxis.xx.Min Physics = #Physics.Projection.BlockBase.CrossProductAxis.xx.Max Physics
            scoreboard players operation #Physics.Projection.BlockBase.CrossProductAxis.xx.Min Physics *= #Physics.Constants.-1 Physics

        # Cross Product: x_block x y_object
        # (Important): Cross product's x component is 0, so x can be ignored
            # Corner 0 [-500, -500]
            scoreboard players operation #Physics.Projection.BlockCornerBase0.CrossProductAxis.xy Physics = #Physics.CrossProductAxis.xy.y Physics
            execute store result score #Physics.Projection.BlockCornerBase1.CrossProductAxis.xy Physics run scoreboard players operation #Physics.Projection.BlockCornerBase0.CrossProductAxis.xy Physics /= #Physics.Constants.-2 Physics

            scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.CrossProductAxis.xy.z Physics
            scoreboard players operation #Physics.Maths.Value1 Physics /= #Physics.Constants.-2 Physics
            execute store result score #Physics.Projection.BlockCornerBase5.CrossProductAxis.xy Physics store result score #Physics.Projection.BlockBase.CrossProductAxis.xy.Max Physics run scoreboard players operation #Physics.Projection.BlockCornerBase0.CrossProductAxis.xy Physics += #Physics.Maths.Value1 Physics

            # Corner 1 [-500, 500]
            execute store result score #Physics.Projection.BlockCornerBase4.CrossProductAxis.xy Physics run scoreboard players operation #Physics.Projection.BlockCornerBase1.CrossProductAxis.xy Physics -= #Physics.Maths.Value1 Physics

            # Corner 2 [-500, -500] (Same as 0)

            # Corner 3 [-500, 500] (Same as 1)

            # Corner 4 [500, -500] (Mirrored version of 1)
            scoreboard players operation #Physics.Projection.BlockCornerBase4.CrossProductAxis.xy Physics *= #Physics.Constants.-1 Physics

            # Corner 5 [500, 500] (Mirrored version of 0)
            scoreboard players operation #Physics.Projection.BlockCornerBase5.CrossProductAxis.xy Physics *= #Physics.Constants.-1 Physics

            # Corner 6 [500, -500] (Same as 4)

            # Corner 7 [500, 500] (Same as 5)

            # Find min and max
            execute if score #Physics.Projection.BlockCornerBase1.CrossProductAxis.xy Physics > #Physics.Projection.BlockBase.CrossProductAxis.xy.Max Physics run scoreboard players operation #Physics.Projection.BlockBase.CrossProductAxis.xy.Max Physics = #Physics.Projection.BlockCornerBase1.CrossProductAxis.xy Physics
            execute if score #Physics.Projection.BlockCornerBase4.CrossProductAxis.xy Physics > #Physics.Projection.BlockBase.CrossProductAxis.xy.Max Physics run scoreboard players operation #Physics.Projection.BlockBase.CrossProductAxis.xy.Max Physics = #Physics.Projection.BlockCornerBase4.CrossProductAxis.xy Physics
            execute if score #Physics.Projection.BlockCornerBase5.CrossProductAxis.xy Physics > #Physics.Projection.BlockBase.CrossProductAxis.xy.Max Physics run scoreboard players operation #Physics.Projection.BlockBase.CrossProductAxis.xy.Max Physics = #Physics.Projection.BlockCornerBase5.CrossProductAxis.xy Physics
            scoreboard players operation #Physics.Projection.BlockBase.CrossProductAxis.xy.Min Physics = #Physics.Projection.BlockBase.CrossProductAxis.xy.Max Physics
            scoreboard players operation #Physics.Projection.BlockBase.CrossProductAxis.xy.Min Physics *= #Physics.Constants.-1 Physics

        # Cross Product: x_block x z_object
        # (Important): Cross product's x component is 0, so x can be ignored
            # Corner 0 [-500, -500]
            scoreboard players operation #Physics.Projection.BlockCornerBase0.CrossProductAxis.xz Physics = #Physics.CrossProductAxis.xz.y Physics
            execute store result score #Physics.Projection.BlockCornerBase1.CrossProductAxis.xz Physics run scoreboard players operation #Physics.Projection.BlockCornerBase0.CrossProductAxis.xz Physics /= #Physics.Constants.-2 Physics

            scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.CrossProductAxis.xz.z Physics
            scoreboard players operation #Physics.Maths.Value1 Physics /= #Physics.Constants.-2 Physics
            execute store result score #Physics.Projection.BlockCornerBase5.CrossProductAxis.xz Physics store result score #Physics.Projection.BlockBase.CrossProductAxis.xz.Max Physics run scoreboard players operation #Physics.Projection.BlockCornerBase0.CrossProductAxis.xz Physics += #Physics.Maths.Value1 Physics

            # Corner 1 [-500, 500]
            execute store result score #Physics.Projection.BlockCornerBase4.CrossProductAxis.xz Physics run scoreboard players operation #Physics.Projection.BlockCornerBase1.CrossProductAxis.xz Physics -= #Physics.Maths.Value1 Physics

            # Corner 2 [-500, -500] (Same as 0)

            # Corner 3 [-500, 500] (Same as 1)

            # Corner 4 [500, -500] (Mirrored version of 1)
            scoreboard players operation #Physics.Projection.BlockCornerBase4.CrossProductAxis.xz Physics *= #Physics.Constants.-1 Physics

            # Corner 5 [500, 500] (Mirrored version of 0)
            scoreboard players operation #Physics.Projection.BlockCornerBase5.CrossProductAxis.xz Physics *= #Physics.Constants.-1 Physics

            # Corner 6 [500, -500] (Same as 4)

            # Corner 7 [500, 500] (Same as 5)

            # Find min and max
            execute if score #Physics.Projection.BlockCornerBase1.CrossProductAxis.xz Physics > #Physics.Projection.BlockBase.CrossProductAxis.xz.Max Physics run scoreboard players operation #Physics.Projection.BlockBase.CrossProductAxis.xz.Max Physics = #Physics.Projection.BlockCornerBase1.CrossProductAxis.xz Physics
            execute if score #Physics.Projection.BlockCornerBase4.CrossProductAxis.xz Physics > #Physics.Projection.BlockBase.CrossProductAxis.xz.Max Physics run scoreboard players operation #Physics.Projection.BlockBase.CrossProductAxis.xz.Max Physics = #Physics.Projection.BlockCornerBase4.CrossProductAxis.xz Physics
            execute if score #Physics.Projection.BlockCornerBase5.CrossProductAxis.xz Physics > #Physics.Projection.BlockBase.CrossProductAxis.xz.Max Physics run scoreboard players operation #Physics.Projection.BlockBase.CrossProductAxis.xz.Max Physics = #Physics.Projection.BlockCornerBase5.CrossProductAxis.xz Physics
            scoreboard players operation #Physics.Projection.BlockBase.CrossProductAxis.xz.Min Physics = #Physics.Projection.BlockBase.CrossProductAxis.xz.Max Physics
            scoreboard players operation #Physics.Projection.BlockBase.CrossProductAxis.xz.Min Physics *= #Physics.Constants.-1 Physics

        # Cross Product: y_block x x_object
        # (Important): Cross product's y component is 0, so y can be ignored
            # Corner 0 [-500, -500]
            scoreboard players operation #Physics.Projection.BlockCornerBase0.CrossProductAxis.yx Physics = #Physics.CrossProductAxis.yx.x Physics
            execute store result score #Physics.Projection.BlockCornerBase1.CrossProductAxis.yx Physics run scoreboard players operation #Physics.Projection.BlockCornerBase0.CrossProductAxis.yx Physics /= #Physics.Constants.-2 Physics

            scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.CrossProductAxis.yx.z Physics
            scoreboard players operation #Physics.Maths.Value1 Physics /= #Physics.Constants.-2 Physics
            execute store result score #Physics.Projection.BlockCornerBase3.CrossProductAxis.yx Physics store result score #Physics.Projection.BlockBase.CrossProductAxis.yx.Max Physics run scoreboard players operation #Physics.Projection.BlockCornerBase0.CrossProductAxis.yx Physics += #Physics.Maths.Value1 Physics

            # Corner 1 [-500, 500]
            execute store result score #Physics.Projection.BlockCornerBase2.CrossProductAxis.yx Physics run scoreboard players operation #Physics.Projection.BlockCornerBase1.CrossProductAxis.yx Physics -= #Physics.Maths.Value1 Physics

            # Corner 2 [500, -500] (Mirrored version of 1)
            scoreboard players operation #Physics.Projection.BlockCornerBase2.CrossProductAxis.yx Physics *= #Physics.Constants.-1 Physics

            # Corner 3 [500, 500] (Mirrored version of 0)
            scoreboard players operation #Physics.Projection.BlockCornerBase3.CrossProductAxis.yx Physics *= #Physics.Constants.-1 Physics

            # Corner 4 [-500, -500] (Same as 0)

            # Corner 5 [-500, 500] (Same as 1)

            # Corner 6 [500, -500] (Same as 2)

            # Corner 7 [500, 500] (Same as 3)

            # Find min and max
            execute if score #Physics.Projection.BlockCornerBase1.CrossProductAxis.yx Physics > #Physics.Projection.BlockBase.CrossProductAxis.yx.Max Physics run scoreboard players operation #Physics.Projection.BlockBase.CrossProductAxis.yx.Max Physics = #Physics.Projection.BlockCornerBase1.CrossProductAxis.yx Physics
            execute if score #Physics.Projection.BlockCornerBase2.CrossProductAxis.yx Physics > #Physics.Projection.BlockBase.CrossProductAxis.yx.Max Physics run scoreboard players operation #Physics.Projection.BlockBase.CrossProductAxis.yx.Max Physics = #Physics.Projection.BlockCornerBase2.CrossProductAxis.yx Physics
            execute if score #Physics.Projection.BlockCornerBase3.CrossProductAxis.yx Physics > #Physics.Projection.BlockBase.CrossProductAxis.yx.Max Physics run scoreboard players operation #Physics.Projection.BlockBase.CrossProductAxis.yx.Max Physics = #Physics.Projection.BlockCornerBase3.CrossProductAxis.yx Physics
            scoreboard players operation #Physics.Projection.BlockBase.CrossProductAxis.yx.Min Physics = #Physics.Projection.BlockBase.CrossProductAxis.yx.Max Physics
            scoreboard players operation #Physics.Projection.BlockBase.CrossProductAxis.yx.Min Physics *= #Physics.Constants.-1 Physics

        # Cross Product: y_block x y_object
        # (Important): Cross product's y component is 0, so y can be ignored
            # Corner 0 [-500, -500]
            scoreboard players operation #Physics.Projection.BlockCornerBase0.CrossProductAxis.yy Physics = #Physics.CrossProductAxis.yy.x Physics
            execute store result score #Physics.Projection.BlockCornerBase1.CrossProductAxis.yy Physics run scoreboard players operation #Physics.Projection.BlockCornerBase0.CrossProductAxis.yy Physics /= #Physics.Constants.-2 Physics

            scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.CrossProductAxis.yy.z Physics
            scoreboard players operation #Physics.Maths.Value1 Physics /= #Physics.Constants.-2 Physics
            execute store result score #Physics.Projection.BlockCornerBase3.CrossProductAxis.yy Physics store result score #Physics.Projection.BlockBase.CrossProductAxis.yy.Max Physics run scoreboard players operation #Physics.Projection.BlockCornerBase0.CrossProductAxis.yy Physics += #Physics.Maths.Value1 Physics

            # Corner 1 [-500, 500]
            execute store result score #Physics.Projection.BlockCornerBase2.CrossProductAxis.yy Physics run scoreboard players operation #Physics.Projection.BlockCornerBase1.CrossProductAxis.yy Physics -= #Physics.Maths.Value1 Physics

            # Corner 2 [500, -500] (Mirrored version of 1)
            scoreboard players operation #Physics.Projection.BlockCornerBase2.CrossProductAxis.yy Physics *= #Physics.Constants.-1 Physics

            # Corner 3 [500, 500] (Mirrored version of 0)
            scoreboard players operation #Physics.Projection.BlockCornerBase3.CrossProductAxis.yy Physics *= #Physics.Constants.-1 Physics

            # Corner 4 [-500, -500] (Same as 0)

            # Corner 5 [-500, 500] (Same as 1)

            # Corner 6 [500, -500] (Same as 2)

            # Corner 7 [500, 500] (Same as 3)

            # Find min and max
            execute if score #Physics.Projection.BlockCornerBase1.CrossProductAxis.yy Physics > #Physics.Projection.BlockBase.CrossProductAxis.yy.Max Physics run scoreboard players operation #Physics.Projection.BlockBase.CrossProductAxis.yy.Max Physics = #Physics.Projection.BlockCornerBase1.CrossProductAxis.yy Physics
            execute if score #Physics.Projection.BlockCornerBase2.CrossProductAxis.yy Physics > #Physics.Projection.BlockBase.CrossProductAxis.yy.Max Physics run scoreboard players operation #Physics.Projection.BlockBase.CrossProductAxis.yy.Max Physics = #Physics.Projection.BlockCornerBase2.CrossProductAxis.yy Physics
            execute if score #Physics.Projection.BlockCornerBase3.CrossProductAxis.yy Physics > #Physics.Projection.BlockBase.CrossProductAxis.yy.Max Physics run scoreboard players operation #Physics.Projection.BlockBase.CrossProductAxis.yy.Max Physics = #Physics.Projection.BlockCornerBase3.CrossProductAxis.yy Physics
            scoreboard players operation #Physics.Projection.BlockBase.CrossProductAxis.yy.Min Physics = #Physics.Projection.BlockBase.CrossProductAxis.yy.Max Physics
            scoreboard players operation #Physics.Projection.BlockBase.CrossProductAxis.yy.Min Physics *= #Physics.Constants.-1 Physics

        # Cross Product: y_block x z_object
        # (Important): Cross product's y component is 0, so y can be ignored
            # Corner 0 [-500, -500]
            scoreboard players operation #Physics.Projection.BlockCornerBase0.CrossProductAxis.yz Physics = #Physics.CrossProductAxis.yz.x Physics
            execute store result score #Physics.Projection.BlockCornerBase1.CrossProductAxis.yz Physics run scoreboard players operation #Physics.Projection.BlockCornerBase0.CrossProductAxis.yz Physics /= #Physics.Constants.-2 Physics

            scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.CrossProductAxis.yz.z Physics
            scoreboard players operation #Physics.Maths.Value1 Physics /= #Physics.Constants.-2 Physics
            execute store result score #Physics.Projection.BlockCornerBase3.CrossProductAxis.yz Physics store result score #Physics.Projection.BlockBase.CrossProductAxis.yz.Max Physics run scoreboard players operation #Physics.Projection.BlockCornerBase0.CrossProductAxis.yz Physics += #Physics.Maths.Value1 Physics

            # Corner 1 [-500, 500]
            execute store result score #Physics.Projection.BlockCornerBase2.CrossProductAxis.yz Physics run scoreboard players operation #Physics.Projection.BlockCornerBase1.CrossProductAxis.yz Physics -= #Physics.Maths.Value1 Physics

            # Corner 2 [500, -500] (Mirrored version of 1)
            scoreboard players operation #Physics.Projection.BlockCornerBase2.CrossProductAxis.yz Physics *= #Physics.Constants.-1 Physics

            # Corner 3 [500, 500] (Mirrored version of 0)
            scoreboard players operation #Physics.Projection.BlockCornerBase3.CrossProductAxis.yz Physics *= #Physics.Constants.-1 Physics

            # Corner 4 [-500, -500] (Same as 0)

            # Corner 5 [-500, 500] (Same as 1)

            # Corner 6 [500, -500] (Same as 2)

            # Corner 7 [500, 500] (Same as 3)

            # Find min and max
            execute if score #Physics.Projection.BlockCornerBase1.CrossProductAxis.yz Physics > #Physics.Projection.BlockBase.CrossProductAxis.yz.Max Physics run scoreboard players operation #Physics.Projection.BlockBase.CrossProductAxis.yz.Max Physics = #Physics.Projection.BlockCornerBase1.CrossProductAxis.yz Physics
            execute if score #Physics.Projection.BlockCornerBase2.CrossProductAxis.yz Physics > #Physics.Projection.BlockBase.CrossProductAxis.yz.Max Physics run scoreboard players operation #Physics.Projection.BlockBase.CrossProductAxis.yz.Max Physics = #Physics.Projection.BlockCornerBase2.CrossProductAxis.yz Physics
            execute if score #Physics.Projection.BlockCornerBase3.CrossProductAxis.yz Physics > #Physics.Projection.BlockBase.CrossProductAxis.yz.Max Physics run scoreboard players operation #Physics.Projection.BlockBase.CrossProductAxis.yz.Max Physics = #Physics.Projection.BlockCornerBase3.CrossProductAxis.yz Physics
            scoreboard players operation #Physics.Projection.BlockBase.CrossProductAxis.yz.Min Physics = #Physics.Projection.BlockBase.CrossProductAxis.yz.Max Physics
            scoreboard players operation #Physics.Projection.BlockBase.CrossProductAxis.yz.Min Physics *= #Physics.Constants.-1 Physics

        # Cross Product: z_block x x_object
        # (Important): Cross product's z component is 0, so z can be ignored
            # Corner 0 [-500, -500]
            scoreboard players operation #Physics.Projection.BlockCornerBase0.CrossProductAxis.zx Physics = #Physics.CrossProductAxis.zx.x Physics
            execute store result score #Physics.Projection.BlockCornerBase4.CrossProductAxis.zx Physics run scoreboard players operation #Physics.Projection.BlockCornerBase0.CrossProductAxis.zx Physics /= #Physics.Constants.-2 Physics

            scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.CrossProductAxis.zx.y Physics
            scoreboard players operation #Physics.Maths.Value1 Physics /= #Physics.Constants.-2 Physics
            execute store result score #Physics.Projection.BlockCornerBase6.CrossProductAxis.zx Physics store result score #Physics.Projection.BlockBase.CrossProductAxis.zx.Max Physics run scoreboard players operation #Physics.Projection.BlockCornerBase0.CrossProductAxis.zx Physics += #Physics.Maths.Value1 Physics

            # Corner 1 [-500, -500] (Same as 0)

            # Corner 3 [500, -500] (Same as 2)

            # Corner 4 [-500, 500]
            execute store result score #Physics.Projection.BlockCornerBase2.CrossProductAxis.zx Physics run scoreboard players operation #Physics.Projection.BlockCornerBase4.CrossProductAxis.zx Physics -= #Physics.Maths.Value1 Physics

            # Corner 2 [500, -500] (Mirrored version of 4)
            scoreboard players operation #Physics.Projection.BlockCornerBase2.CrossProductAxis.zx Physics *= #Physics.Constants.-1 Physics

            # Corner 5 [-500, 500] (Same as 4)

            # Corner 6 [500, 500] (Mirrored version of 0)
            scoreboard players operation #Physics.Projection.BlockCornerBase6.CrossProductAxis.zx Physics *= #Physics.Constants.-1 Physics

            # Corner 7 [500, 500] (Same as 6)

            # Find min and max
            execute if score #Physics.Projection.BlockCornerBase2.CrossProductAxis.zx Physics > #Physics.Projection.BlockBase.CrossProductAxis.zx.Max Physics run scoreboard players operation #Physics.Projection.BlockBase.CrossProductAxis.zx.Max Physics = #Physics.Projection.BlockCornerBase2.CrossProductAxis.zx Physics
            execute if score #Physics.Projection.BlockCornerBase4.CrossProductAxis.zx Physics > #Physics.Projection.BlockBase.CrossProductAxis.zx.Max Physics run scoreboard players operation #Physics.Projection.BlockBase.CrossProductAxis.zx.Max Physics = #Physics.Projection.BlockCornerBase4.CrossProductAxis.zx Physics
            execute if score #Physics.Projection.BlockCornerBase6.CrossProductAxis.zx Physics > #Physics.Projection.BlockBase.CrossProductAxis.zx.Max Physics run scoreboard players operation #Physics.Projection.BlockBase.CrossProductAxis.zx.Max Physics = #Physics.Projection.BlockCornerBase6.CrossProductAxis.zx Physics
            scoreboard players operation #Physics.Projection.BlockBase.CrossProductAxis.zx.Min Physics = #Physics.Projection.BlockBase.CrossProductAxis.zx.Max Physics
            scoreboard players operation #Physics.Projection.BlockBase.CrossProductAxis.zx.Min Physics *= #Physics.Constants.-1 Physics

        # Cross Product: z_block x y_object
        # (Important): Cross product's z component is 0, so z can be ignored
            # Corner 0 [-500, -500]
            scoreboard players operation #Physics.Projection.BlockCornerBase0.CrossProductAxis.zy Physics = #Physics.CrossProductAxis.zy.x Physics
            execute store result score #Physics.Projection.BlockCornerBase4.CrossProductAxis.zy Physics run scoreboard players operation #Physics.Projection.BlockCornerBase0.CrossProductAxis.zy Physics /= #Physics.Constants.-2 Physics

            scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.CrossProductAxis.zy.y Physics
            scoreboard players operation #Physics.Maths.Value1 Physics /= #Physics.Constants.-2 Physics
            execute store result score #Physics.Projection.BlockCornerBase6.CrossProductAxis.zy Physics store result score #Physics.Projection.BlockBase.CrossProductAxis.zy.Max Physics run scoreboard players operation #Physics.Projection.BlockCornerBase0.CrossProductAxis.zy Physics += #Physics.Maths.Value1 Physics

            # Corner 1 [-500, -500] (Same as 0)

            # Corner 3 [500, -500] (Same as 2)

            # Corner 4 [-500, 500]
            execute store result score #Physics.Projection.BlockCornerBase2.CrossProductAxis.zy Physics run scoreboard players operation #Physics.Projection.BlockCornerBase4.CrossProductAxis.zy Physics -= #Physics.Maths.Value1 Physics

            # Corner 2 [500, -500] (Mirrored version of 4)
            scoreboard players operation #Physics.Projection.BlockCornerBase2.CrossProductAxis.zy Physics *= #Physics.Constants.-1 Physics

            # Corner 5 [-500, 500] (Same as 4)

            # Corner 6 [500, 500] (Mirrored version of 0)
            scoreboard players operation #Physics.Projection.BlockCornerBase6.CrossProductAxis.zy Physics *= #Physics.Constants.-1 Physics

            # Corner 7 [500, 500] (Same as 6)

            # Find min and max
            execute if score #Physics.Projection.BlockCornerBase2.CrossProductAxis.zy Physics > #Physics.Projection.BlockBase.CrossProductAxis.zy.Max Physics run scoreboard players operation #Physics.Projection.BlockBase.CrossProductAxis.zy.Max Physics = #Physics.Projection.BlockCornerBase2.CrossProductAxis.zy Physics
            execute if score #Physics.Projection.BlockCornerBase4.CrossProductAxis.zy Physics > #Physics.Projection.BlockBase.CrossProductAxis.zy.Max Physics run scoreboard players operation #Physics.Projection.BlockBase.CrossProductAxis.zy.Max Physics = #Physics.Projection.BlockCornerBase4.CrossProductAxis.zy Physics
            execute if score #Physics.Projection.BlockCornerBase6.CrossProductAxis.zy Physics > #Physics.Projection.BlockBase.CrossProductAxis.zy.Max Physics run scoreboard players operation #Physics.Projection.BlockBase.CrossProductAxis.zy.Max Physics = #Physics.Projection.BlockCornerBase6.CrossProductAxis.zy Physics
            scoreboard players operation #Physics.Projection.BlockBase.CrossProductAxis.zy.Min Physics = #Physics.Projection.BlockBase.CrossProductAxis.zy.Max Physics
            scoreboard players operation #Physics.Projection.BlockBase.CrossProductAxis.zy.Min Physics *= #Physics.Constants.-1 Physics

        # Cross Product: z_block x z_object
        # (Important): Cross product's z component is 0, so z can be ignored
            # Corner 0 [-500, -500]
            scoreboard players operation #Physics.Projection.BlockCornerBase0.CrossProductAxis.zz Physics = #Physics.CrossProductAxis.zz.x Physics
            execute store result score #Physics.Projection.BlockCornerBase4.CrossProductAxis.zz Physics run scoreboard players operation #Physics.Projection.BlockCornerBase0.CrossProductAxis.zz Physics /= #Physics.Constants.-2 Physics

            scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.CrossProductAxis.zz.y Physics
            scoreboard players operation #Physics.Maths.Value1 Physics /= #Physics.Constants.-2 Physics
            execute store result score #Physics.Projection.BlockCornerBase6.CrossProductAxis.zz Physics store result score #Physics.Projection.BlockBase.CrossProductAxis.zz.Max Physics run scoreboard players operation #Physics.Projection.BlockCornerBase0.CrossProductAxis.zz Physics += #Physics.Maths.Value1 Physics

            # Corner 1 [-500, -500] (Same as 0)

            # Corner 3 [500, -500] (Same as 2)

            # Corner 4 [-500, 500]
            execute store result score #Physics.Projection.BlockCornerBase2.CrossProductAxis.zz Physics run scoreboard players operation #Physics.Projection.BlockCornerBase4.CrossProductAxis.zz Physics -= #Physics.Maths.Value1 Physics

            # Corner 2 [500, -500] (Mirrored version of 4)
            scoreboard players operation #Physics.Projection.BlockCornerBase2.CrossProductAxis.zz Physics *= #Physics.Constants.-1 Physics

            # Corner 5 [-500, 500] (Same as 4)

            # Corner 6 [500, 500] (Mirrored version of 0)
            scoreboard players operation #Physics.Projection.BlockCornerBase6.CrossProductAxis.zz Physics *= #Physics.Constants.-1 Physics

            # Corner 7 [500, 500] (Same as 6)

            # Find min and max
            execute if score #Physics.Projection.BlockCornerBase2.CrossProductAxis.zz Physics > #Physics.Projection.BlockBase.CrossProductAxis.zz.Max Physics run scoreboard players operation #Physics.Projection.BlockBase.CrossProductAxis.zz.Max Physics = #Physics.Projection.BlockCornerBase2.CrossProductAxis.zz Physics
            execute if score #Physics.Projection.BlockCornerBase4.CrossProductAxis.zz Physics > #Physics.Projection.BlockBase.CrossProductAxis.zz.Max Physics run scoreboard players operation #Physics.Projection.BlockBase.CrossProductAxis.zz.Max Physics = #Physics.Projection.BlockCornerBase4.CrossProductAxis.zz Physics
            execute if score #Physics.Projection.BlockCornerBase6.CrossProductAxis.zz Physics > #Physics.Projection.BlockBase.CrossProductAxis.zz.Max Physics run scoreboard players operation #Physics.Projection.BlockBase.CrossProductAxis.zz.Max Physics = #Physics.Projection.BlockCornerBase6.CrossProductAxis.zz Physics
            scoreboard players operation #Physics.Projection.BlockBase.CrossProductAxis.zz.Min Physics = #Physics.Projection.BlockBase.CrossProductAxis.zz.Max Physics
            scoreboard players operation #Physics.Projection.BlockBase.CrossProductAxis.zz.Min Physics *= #Physics.Constants.-1 Physics

    # Project the object onto the cross product axes
    # (Important): I'm using the relative corner points, so I know that for example corner 7 is a mirrored version of corner 0, and corner 6 is mirrored corner 1. But note that this is not the same as the [-x, +z] notation; Two corners that both go into positive x can still have different x components, because they're rotated. Because of this, I can't do the same assumptions as before.
    # (Important): I used "execute store result ..." earlier to copy the cross product axis scores into temporary scores to prevent unnecessary "scoreboard players operation ... = ..." calls
    # (Important): Same point about scaling as before: Maybe I need this axis multiple times because I collide with multiple blocks, in which case I don't want to adjust the scaling multiple times. So I do it directly here. It will add some general overhead, but it caps the overhead at least. This is also why I directly make the point projections global, too.
        # Cross Product: x_block x x_object
        # (Important): Cross product's x component is 0, so x can be ignored. Also, cross product is orthogonal to object's x-axis, so points along the same edge have the same projection.
            # Corner 0
            scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.xx Physics *= #Physics.ThisObject Physics.Object.CornerPosRelative.0.y

            scoreboard players operation #Physics.Maths.Value12 Physics *= #Physics.ThisObject Physics.Object.CornerPosRelative.0.z
            scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.xx Physics += #Physics.Maths.Value12 Physics
            execute store result score #Physics.Projection.ObjectCorner5.CrossProductAxis.xx Physics store result score #Physics.Projection.Object.CrossProductAxis.xx.Max Physics run scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.xx Physics /= #Physics.Constants.1000 Physics

            # Corner 1
            scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis.xx Physics *= #Physics.ThisObject Physics.Object.CornerPosRelative.1.y

            scoreboard players operation #Physics.Maths.Value13 Physics *= #Physics.ThisObject Physics.Object.CornerPosRelative.1.z
            scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis.xx Physics += #Physics.Maths.Value13 Physics
            execute store result score #Physics.Projection.ObjectCorner4.CrossProductAxis.xx Physics run scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis.xx Physics /= #Physics.Constants.1000 Physics

            # Corner 2 (Same as 0)

            # Corner 3 (Same as 1)

            # Corner 4 (Mirrored version of 3)
            scoreboard players operation #Physics.Projection.ObjectCorner4.CrossProductAxis.xx Physics *= #Physics.Constants.-1 Physics

            # Corner 5 (Mirrored version of 2)
            scoreboard players operation #Physics.Projection.ObjectCorner5.CrossProductAxis.xx Physics *= #Physics.Constants.-1 Physics

            # Corner 6 (Mirrored version of 1) (Same as 4)

            # Corner 7 (Mirrored version of 0) (Same as 5)

            # Find min and max (Relative)
            execute if score #Physics.Projection.ObjectCorner1.CrossProductAxis.xx Physics > #Physics.Projection.Object.CrossProductAxis.xx.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xx.Max Physics = #Physics.Projection.ObjectCorner1.CrossProductAxis.xx Physics
            execute if score #Physics.Projection.ObjectCorner4.CrossProductAxis.xx Physics > #Physics.Projection.Object.CrossProductAxis.xx.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xx.Max Physics = #Physics.Projection.ObjectCorner4.CrossProductAxis.xx Physics
            execute if score #Physics.Projection.ObjectCorner5.CrossProductAxis.xx Physics > #Physics.Projection.Object.CrossProductAxis.xx.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xx.Max Physics = #Physics.Projection.ObjectCorner5.CrossProductAxis.xx Physics
            scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xx.Min Physics = #Physics.Projection.Object.CrossProductAxis.xx.Max Physics
            scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xx.Min Physics *= #Physics.Constants.-1 Physics

            # Turn the projections and the min/max global by projecting the center point onto the same axis and adding it
            scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.xx Physics *= #Physics.ThisObject Physics.Object.Pos.y

            scoreboard players operation #Physics.Maths.Value14 Physics *= #Physics.ThisObject Physics.Object.Pos.z
            scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.xx Physics += #Physics.Maths.Value14 Physics

            scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.xx Physics /= #Physics.Constants.1000 Physics

            scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.xx Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.xx Physics
            scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis.xx Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.xx Physics
            scoreboard players operation #Physics.Projection.ObjectCorner4.CrossProductAxis.xx Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.xx Physics
            scoreboard players operation #Physics.Projection.ObjectCorner5.CrossProductAxis.xx Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.xx Physics
            scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xx.Min Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.xx Physics
            scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xx.Max Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.xx Physics

        # Cross Product: x_block x y_object
        # (Important): Cross product's x component is 0, so x can be ignored. Also, cross product is orthogonal to object's y-axis, so points along the same edge have the same projection.
            # Corner 0
            scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.xy Physics *= #Physics.ThisObject Physics.Object.CornerPosRelative.0.y

            scoreboard players operation #Physics.Maths.Value15 Physics *= #Physics.ThisObject Physics.Object.CornerPosRelative.0.z
            scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.xy Physics += #Physics.Maths.Value15 Physics
            execute store result score #Physics.Projection.ObjectCorner3.CrossProductAxis.xy Physics store result score #Physics.Projection.Object.CrossProductAxis.xy.Max Physics run scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.xy Physics /= #Physics.Constants.1000 Physics

            # Corner 1
            scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis.xy Physics *= #Physics.ThisObject Physics.Object.CornerPosRelative.1.y

            scoreboard players operation #Physics.Maths.Value16 Physics *= #Physics.ThisObject Physics.Object.CornerPosRelative.1.z
            scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis.xy Physics += #Physics.Maths.Value16 Physics
            execute store result score #Physics.Projection.ObjectCorner2.CrossProductAxis.xy Physics run scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis.xy Physics /= #Physics.Constants.1000 Physics

            # Corner 2
            scoreboard players operation #Physics.Projection.ObjectCorner2.CrossProductAxis.xy Physics *= #Physics.Constants.-1 Physics

            # Corner 3
            scoreboard players operation #Physics.Projection.ObjectCorner3.CrossProductAxis.xy Physics *= #Physics.Constants.-1 Physics

            # Corner 4 (Mirrored version of 3) (Same as 0)

            # Corner 5 (Mirrored version of 2) (Same as 1)

            # Corner 6 (Mirrored version of 1) (Same as 2)

            # Corner 7 (Mirrored version of 0) (Same as 3)

            # Find min and max (relative)
            execute if score #Physics.Projection.ObjectCorner1.CrossProductAxis.xy Physics > #Physics.Projection.Object.CrossProductAxis.xy.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xy.Max Physics = #Physics.Projection.ObjectCorner1.CrossProductAxis.xy Physics
            execute if score #Physics.Projection.ObjectCorner2.CrossProductAxis.xy Physics > #Physics.Projection.Object.CrossProductAxis.xy.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xy.Max Physics = #Physics.Projection.ObjectCorner2.CrossProductAxis.xy Physics
            execute if score #Physics.Projection.ObjectCorner3.CrossProductAxis.xy Physics > #Physics.Projection.Object.CrossProductAxis.xy.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xy.Max Physics = #Physics.Projection.ObjectCorner3.CrossProductAxis.xy Physics
            scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xy.Min Physics = #Physics.Projection.Object.CrossProductAxis.xy.Max Physics
            scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xy.Min Physics *= #Physics.Constants.-1 Physics

            # Turn the projections and the min/max global by projecting the center point onto the same axis and adding it
            scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.xy Physics *= #Physics.ThisObject Physics.Object.Pos.y

            scoreboard players operation #Physics.Maths.Value17 Physics *= #Physics.ThisObject Physics.Object.Pos.z
            scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.xy Physics += #Physics.Maths.Value17 Physics

            scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.xy Physics /= #Physics.Constants.1000 Physics

            scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.xy Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.xy Physics
            scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis.xy Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.xy Physics
            scoreboard players operation #Physics.Projection.ObjectCorner2.CrossProductAxis.xy Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.xy Physics
            scoreboard players operation #Physics.Projection.ObjectCorner3.CrossProductAxis.xy Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.xy Physics
            scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xy.Min Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.xy Physics
            scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xy.Max Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.xy Physics

        # Cross Product: x_block x z_object
        # (Important): Cross product's x component is 0, so x can be ignored. Also, cross product is orthogonal to object's z-axis, so points along the same edge have the same projection.
            # Corner 0
            scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.xz Physics *= #Physics.ThisObject Physics.Object.CornerPosRelative.0.y

            scoreboard players operation #Physics.Maths.Value18 Physics *= #Physics.ThisObject Physics.Object.CornerPosRelative.0.z
            scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.xz Physics += #Physics.Maths.Value18 Physics
            execute store result score #Physics.Projection.ObjectCorner6.CrossProductAxis.xz Physics store result score #Physics.Projection.Object.CrossProductAxis.xz.Max Physics run scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.xz Physics /= #Physics.Constants.1000 Physics

            # Corner 1 (Same as 0)

            # Corner 2
            scoreboard players operation #Physics.Projection.ObjectCorner2.CrossProductAxis.xz Physics *= #Physics.ThisObject Physics.Object.CornerPosRelative.2.y

            scoreboard players operation #Physics.Maths.Value19 Physics *= #Physics.ThisObject Physics.Object.CornerPosRelative.2.z
            scoreboard players operation #Physics.Projection.ObjectCorner2.CrossProductAxis.xz Physics += #Physics.Maths.Value19 Physics
            execute store result score #Physics.Projection.ObjectCorner4.CrossProductAxis.xz Physics run scoreboard players operation #Physics.Projection.ObjectCorner2.CrossProductAxis.xz Physics /= #Physics.Constants.1000 Physics

            # Corner 3 (Same as 2)

            # Corner 4 (Mirrored version of 3)
            scoreboard players operation #Physics.Projection.ObjectCorner4.CrossProductAxis.xz Physics *= #Physics.Constants.-1 Physics

            # Corner 5 (Mirrored version of 2) (Same as 4)

            # Corner 6 (Mirrored version of 1)
            scoreboard players operation #Physics.Projection.ObjectCorner6.CrossProductAxis.xz Physics *= #Physics.Constants.-1 Physics

            # Corner 7 (Mirrored version of 0) (Same as 6)

            # Find min and max (relative)
            execute if score #Physics.Projection.ObjectCorner2.CrossProductAxis.xz Physics > #Physics.Projection.Object.CrossProductAxis.xz.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xz.Max Physics = #Physics.Projection.ObjectCorner2.CrossProductAxis.xz Physics
            execute if score #Physics.Projection.ObjectCorner4.CrossProductAxis.xz Physics > #Physics.Projection.Object.CrossProductAxis.xz.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xz.Max Physics = #Physics.Projection.ObjectCorner4.CrossProductAxis.xz Physics
            execute if score #Physics.Projection.ObjectCorner6.CrossProductAxis.xz Physics > #Physics.Projection.Object.CrossProductAxis.xz.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xz.Max Physics = #Physics.Projection.ObjectCorner6.CrossProductAxis.xz Physics
            scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xz.Min Physics = #Physics.Projection.Object.CrossProductAxis.xz.Max Physics
            scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xz.Min Physics *= #Physics.Constants.-1 Physics

            # Turn the projections and the min/max global by projecting the center point onto the same axis and adding it
            scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.xz Physics *= #Physics.ThisObject Physics.Object.Pos.y

            scoreboard players operation #Physics.Maths.Value20 Physics *= #Physics.ThisObject Physics.Object.Pos.z
            scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.xz Physics += #Physics.Maths.Value20 Physics

            scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.xz Physics /= #Physics.Constants.1000 Physics

            scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.xz Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.xz Physics
            scoreboard players operation #Physics.Projection.ObjectCorner2.CrossProductAxis.xz Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.xz Physics
            scoreboard players operation #Physics.Projection.ObjectCorner4.CrossProductAxis.xz Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.xz Physics
            scoreboard players operation #Physics.Projection.ObjectCorner6.CrossProductAxis.xz Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.xz Physics
            scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xz.Min Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.xz Physics
            scoreboard players operation #Physics.Projection.Object.CrossProductAxis.xz.Max Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.xz Physics

        # Cross Product: y_block x x_object
        # (Important): Cross product's y component is 0, so y can be ignored. Also, cross product is orthogonal to object's x-axis, so points along the same edge have the same projection.
            # Corner 0
            scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.yx Physics *= #Physics.ThisObject Physics.Object.CornerPosRelative.0.x

            scoreboard players operation #Physics.Maths.Value21 Physics *= #Physics.ThisObject Physics.Object.CornerPosRelative.0.z
            scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.yx Physics += #Physics.Maths.Value21 Physics
            execute store result score #Physics.Projection.ObjectCorner5.CrossProductAxis.yx Physics store result score #Physics.Projection.Object.CrossProductAxis.yx.Max Physics run scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.yx Physics /= #Physics.Constants.1000 Physics

            # Corner 1
            scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis.yx Physics *= #Physics.ThisObject Physics.Object.CornerPosRelative.1.x

            scoreboard players operation #Physics.Maths.Value22 Physics *= #Physics.ThisObject Physics.Object.CornerPosRelative.1.z
            scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis.yx Physics += #Physics.Maths.Value22 Physics
            execute store result score #Physics.Projection.ObjectCorner4.CrossProductAxis.yx Physics run scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis.yx Physics /= #Physics.Constants.1000 Physics

            # Corner 2 (Same as 0)

            # Corner 3 (Same as 1)

            # Corner 4 (Mirrored version of 3)
            scoreboard players operation #Physics.Projection.ObjectCorner4.CrossProductAxis.yx Physics *= #Physics.Constants.-1 Physics

            # Corner 5 (Mirrored version of 2)
            scoreboard players operation #Physics.Projection.ObjectCorner5.CrossProductAxis.yx Physics *= #Physics.Constants.-1 Physics

            # Corner 6 (Mirrored version of 1) (Same as 4)

            # Corner 7 (Mirrored version of 0) (Same as 5)

            # Find min and max (relative)
            execute if score #Physics.Projection.ObjectCorner1.CrossProductAxis.yx Physics > #Physics.Projection.Object.CrossProductAxis.yx.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.yx.Max Physics = #Physics.Projection.ObjectCorner1.CrossProductAxis.yx Physics
            execute if score #Physics.Projection.ObjectCorner4.CrossProductAxis.yx Physics > #Physics.Projection.Object.CrossProductAxis.yx.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.yx.Max Physics = #Physics.Projection.ObjectCorner4.CrossProductAxis.yx Physics
            execute if score #Physics.Projection.ObjectCorner5.CrossProductAxis.yx Physics > #Physics.Projection.Object.CrossProductAxis.yx.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.yx.Max Physics = #Physics.Projection.ObjectCorner5.CrossProductAxis.yx Physics
            scoreboard players operation #Physics.Projection.Object.CrossProductAxis.yx.Min Physics = #Physics.Projection.Object.CrossProductAxis.yx.Max Physics
            scoreboard players operation #Physics.Projection.Object.CrossProductAxis.yx.Min Physics *= #Physics.Constants.-1 Physics

            # Turn the projections and the min/max global by projecting the center point onto the same axis and adding it
            scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.yx Physics *= #Physics.ThisObject Physics.Object.Pos.x

            scoreboard players operation #Physics.Maths.Value23 Physics *= #Physics.ThisObject Physics.Object.Pos.z
            scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.yx Physics += #Physics.Maths.Value23 Physics

            scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.yx Physics /= #Physics.Constants.1000 Physics

            scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.yx Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.yx Physics
            scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis.yx Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.yx Physics
            scoreboard players operation #Physics.Projection.ObjectCorner4.CrossProductAxis.yx Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.yx Physics
            scoreboard players operation #Physics.Projection.ObjectCorner5.CrossProductAxis.yx Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.yx Physics
            scoreboard players operation #Physics.Projection.Object.CrossProductAxis.yx.Min Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.yx Physics
            scoreboard players operation #Physics.Projection.Object.CrossProductAxis.yx.Max Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.yx Physics

        # Cross Product: y_block x y_object
        # (Important): Cross product's y component is 0, so y can be ignored. Also, cross product is orthogonal to object's y-axis, so points along the same edge have the same projection.
            # Corner 0
            scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.yy Physics *= #Physics.ThisObject Physics.Object.CornerPosRelative.0.x

            scoreboard players operation #Physics.Maths.Value24 Physics *= #Physics.ThisObject Physics.Object.CornerPosRelative.0.z
            scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.yy Physics += #Physics.Maths.Value24 Physics
            execute store result score #Physics.Projection.ObjectCorner3.CrossProductAxis.yy Physics store result score #Physics.Projection.Object.CrossProductAxis.yy.Max Physics run scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.yy Physics /= #Physics.Constants.1000 Physics

            # Corner 1
            scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis.yy Physics *= #Physics.ThisObject Physics.Object.CornerPosRelative.1.x

            scoreboard players operation #Physics.Maths.Value25 Physics *= #Physics.ThisObject Physics.Object.CornerPosRelative.1.z
            scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis.yy Physics += #Physics.Maths.Value25 Physics
            execute store result score #Physics.Projection.ObjectCorner2.CrossProductAxis.yy Physics run scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis.yy Physics /= #Physics.Constants.1000 Physics

            # Corner 2
            scoreboard players operation #Physics.Projection.ObjectCorner2.CrossProductAxis.yy Physics *= #Physics.Constants.-1 Physics

            # Corner 3
            scoreboard players operation #Physics.Projection.ObjectCorner3.CrossProductAxis.yy Physics *= #Physics.Constants.-1 Physics

            # Corner 4 (Mirrored version of 3) (Same as 0)

            # Corner 5 (Mirrored version of 2) (Same as 1)

            # Corner 6 (Mirrored version of 1) (Same as 2)

            # Corner 7 (Mirrored version of 0) (Same as 3)

            # Find min and max (relative)
            execute if score #Physics.Projection.ObjectCorner1.CrossProductAxis.yy Physics > #Physics.Projection.Object.CrossProductAxis.yy.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.yy.Max Physics = #Physics.Projection.ObjectCorner1.CrossProductAxis.yy Physics
            execute if score #Physics.Projection.ObjectCorner2.CrossProductAxis.yy Physics > #Physics.Projection.Object.CrossProductAxis.yy.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.yy.Max Physics = #Physics.Projection.ObjectCorner2.CrossProductAxis.yy Physics
            execute if score #Physics.Projection.ObjectCorner3.CrossProductAxis.yy Physics > #Physics.Projection.Object.CrossProductAxis.yy.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.yy.Max Physics = #Physics.Projection.ObjectCorner3.CrossProductAxis.yy Physics
            scoreboard players operation #Physics.Projection.Object.CrossProductAxis.yy.Min Physics = #Physics.Projection.Object.CrossProductAxis.yy.Max Physics
            scoreboard players operation #Physics.Projection.Object.CrossProductAxis.yy.Min Physics *= #Physics.Constants.-1 Physics

            # Turn the projections and the min/max global by projecting the center point onto the same axis and adding it
            scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.yy Physics *= #Physics.ThisObject Physics.Object.Pos.x

            scoreboard players operation #Physics.Maths.Value26 Physics *= #Physics.ThisObject Physics.Object.Pos.z
            scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.yy Physics += #Physics.Maths.Value26 Physics

            scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.yy Physics /= #Physics.Constants.1000 Physics

            scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.yy Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.yy Physics
            scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis.yy Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.yy Physics
            scoreboard players operation #Physics.Projection.ObjectCorner2.CrossProductAxis.yy Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.yy Physics
            scoreboard players operation #Physics.Projection.ObjectCorner3.CrossProductAxis.yy Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.yy Physics
            scoreboard players operation #Physics.Projection.Object.CrossProductAxis.yy.Min Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.yy Physics
            scoreboard players operation #Physics.Projection.Object.CrossProductAxis.yy.Max Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.yy Physics

        # Cross Product: y_block x z_object
        # (Important): Cross product's y component is 0, so y can be ignored. Also, cross product is orthogonal to object's z-axis, so points along the same edge have the same projection.
            # Corner 0
            scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.yz Physics *= #Physics.ThisObject Physics.Object.CornerPosRelative.0.x

            scoreboard players operation #Physics.Maths.Value27 Physics *= #Physics.ThisObject Physics.Object.CornerPosRelative.0.z
            scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.yz Physics += #Physics.Maths.Value27 Physics
            execute store result score #Physics.Projection.ObjectCorner6.CrossProductAxis.yz Physics store result score #Physics.Projection.Object.CrossProductAxis.yz.Max Physics run scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.yz Physics /= #Physics.Constants.1000 Physics

            # Corner 1 (Same as 0)

            # Corner 2
            scoreboard players operation #Physics.Projection.ObjectCorner2.CrossProductAxis.yz Physics *= #Physics.ThisObject Physics.Object.CornerPosRelative.2.x

            scoreboard players operation #Physics.Maths.Value28 Physics *= #Physics.ThisObject Physics.Object.CornerPosRelative.2.z
            scoreboard players operation #Physics.Projection.ObjectCorner2.CrossProductAxis.yz Physics += #Physics.Maths.Value28 Physics
            execute store result score #Physics.Projection.ObjectCorner4.CrossProductAxis.yz Physics run scoreboard players operation #Physics.Projection.ObjectCorner2.CrossProductAxis.yz Physics /= #Physics.Constants.1000 Physics

            # Corner 3 (Same as 2)

            # Corner 4 (Mirrored version of 3)
            scoreboard players operation #Physics.Projection.ObjectCorner4.CrossProductAxis.yz Physics *= #Physics.Constants.-1 Physics

            # Corner 5 (Mirrored version of 2) (Same as 4)

            # Corner 6 (Mirrored version of 1)
            scoreboard players operation #Physics.Projection.ObjectCorner6.CrossProductAxis.yz Physics *= #Physics.Constants.-1 Physics

            # Corner 7 (Mirrored version of 0) (Same as 6)

            # Find min and max (relative)
            execute if score #Physics.Projection.ObjectCorner2.CrossProductAxis.yz Physics > #Physics.Projection.Object.CrossProductAxis.yz.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.yz.Max Physics = #Physics.Projection.ObjectCorner2.CrossProductAxis.yz Physics
            execute if score #Physics.Projection.ObjectCorner4.CrossProductAxis.yz Physics > #Physics.Projection.Object.CrossProductAxis.yz.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.yz.Max Physics = #Physics.Projection.ObjectCorner4.CrossProductAxis.yz Physics
            execute if score #Physics.Projection.ObjectCorner6.CrossProductAxis.yz Physics > #Physics.Projection.Object.CrossProductAxis.yz.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.yz.Max Physics = #Physics.Projection.ObjectCorner6.CrossProductAxis.yz Physics
            scoreboard players operation #Physics.Projection.Object.CrossProductAxis.yz.Min Physics = #Physics.Projection.Object.CrossProductAxis.yz.Max Physics
            scoreboard players operation #Physics.Projection.Object.CrossProductAxis.yz.Min Physics *= #Physics.Constants.-1 Physics

            # Turn the projections and the min/max global by projecting the center point onto the same axis and adding it
            scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.yz Physics *= #Physics.ThisObject Physics.Object.Pos.x

            scoreboard players operation #Physics.Maths.Value29 Physics *= #Physics.ThisObject Physics.Object.Pos.z
            scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.yz Physics += #Physics.Maths.Value29 Physics

            scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.yz Physics /= #Physics.Constants.1000 Physics

            scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.yz Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.yz Physics
            scoreboard players operation #Physics.Projection.ObjectCorner2.CrossProductAxis.yz Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.yz Physics
            scoreboard players operation #Physics.Projection.ObjectCorner4.CrossProductAxis.yz Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.yz Physics
            scoreboard players operation #Physics.Projection.ObjectCorner6.CrossProductAxis.yz Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.yz Physics
            scoreboard players operation #Physics.Projection.Object.CrossProductAxis.yz.Min Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.yz Physics
            scoreboard players operation #Physics.Projection.Object.CrossProductAxis.yz.Max Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.yz Physics

        # Cross Product: z_block x x_object
        # (Important): Cross product's z component is 0, so z can be ignored. Also, cross product is orthogonal to object's x-axis, so points along the same edge have the same projection.
            # Corner 0
            scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.zx Physics *= #Physics.ThisObject Physics.Object.CornerPosRelative.0.x

            scoreboard players operation #Physics.Maths.Value30 Physics *= #Physics.ThisObject Physics.Object.CornerPosRelative.0.y
            scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.zx Physics += #Physics.Maths.Value30 Physics
            execute store result score #Physics.Projection.ObjectCorner5.CrossProductAxis.zx Physics store result score #Physics.Projection.Object.CrossProductAxis.zx.Max Physics run scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.zx Physics /= #Physics.Constants.1000 Physics

            # Corner 1
            scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis.zx Physics *= #Physics.ThisObject Physics.Object.CornerPosRelative.1.x

            scoreboard players operation #Physics.Maths.Value31 Physics *= #Physics.ThisObject Physics.Object.CornerPosRelative.1.y
            scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis.zx Physics += #Physics.Maths.Value31 Physics
            execute store result score #Physics.Projection.ObjectCorner4.CrossProductAxis.zx Physics run scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis.zx Physics /= #Physics.Constants.1000 Physics

            # Corner 2 (Same as 0)

            # Corner 3 (Same as 1)

            # Corner 4 (Mirrored version of 3)
            scoreboard players operation #Physics.Projection.ObjectCorner4.CrossProductAxis.zx Physics *= #Physics.Constants.-1 Physics

            # Corner 5 (Mirrored version of 2)
            scoreboard players operation #Physics.Projection.ObjectCorner5.CrossProductAxis.zx Physics *= #Physics.Constants.-1 Physics

            # Corner 6 (Mirrored version of 1) (Same as 4)

            # Corner 7 (Mirrored version of 0) (Same as 5)

            # Find min and max (relative)
            execute if score #Physics.Projection.ObjectCorner1.CrossProductAxis.zx Physics > #Physics.Projection.Object.CrossProductAxis.zx.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.zx.Max Physics = #Physics.Projection.ObjectCorner1.CrossProductAxis.zx Physics
            execute if score #Physics.Projection.ObjectCorner4.CrossProductAxis.zx Physics > #Physics.Projection.Object.CrossProductAxis.zx.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.zx.Max Physics = #Physics.Projection.ObjectCorner4.CrossProductAxis.zx Physics
            execute if score #Physics.Projection.ObjectCorner5.CrossProductAxis.zx Physics > #Physics.Projection.Object.CrossProductAxis.zx.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.zx.Max Physics = #Physics.Projection.ObjectCorner5.CrossProductAxis.zx Physics
            scoreboard players operation #Physics.Projection.Object.CrossProductAxis.zx.Min Physics = #Physics.Projection.Object.CrossProductAxis.zx.Max Physics
            scoreboard players operation #Physics.Projection.Object.CrossProductAxis.zx.Min Physics *= #Physics.Constants.-1 Physics

            # Turn the projections and the min/max global by projecting the center point onto the same axis and adding it
            scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.zx Physics *= #Physics.ThisObject Physics.Object.Pos.x

            scoreboard players operation #Physics.Maths.Value32 Physics *= #Physics.ThisObject Physics.Object.Pos.y
            scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.zx Physics += #Physics.Maths.Value32 Physics

            scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.zx Physics /= #Physics.Constants.1000 Physics

            scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.zx Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.zx Physics
            scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis.zx Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.zx Physics
            scoreboard players operation #Physics.Projection.ObjectCorner4.CrossProductAxis.zx Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.zx Physics
            scoreboard players operation #Physics.Projection.ObjectCorner5.CrossProductAxis.zx Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.zx Physics
            scoreboard players operation #Physics.Projection.Object.CrossProductAxis.zx.Min Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.zx Physics
            scoreboard players operation #Physics.Projection.Object.CrossProductAxis.zx.Max Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.zx Physics

        # Cross Product: z_block x y_object
        # (Important): Cross product's z component is 0, so z can be ignored. Also, cross product is orthogonal to object's y-axis, so points along the same edge have the same projection.
            # Corner 0
            scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.zy Physics *= #Physics.ThisObject Physics.Object.CornerPosRelative.0.x

            scoreboard players operation #Physics.Maths.Value33 Physics *= #Physics.ThisObject Physics.Object.CornerPosRelative.0.y
            scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.zy Physics += #Physics.Maths.Value33 Physics
            execute store result score #Physics.Projection.ObjectCorner3.CrossProductAxis.zy Physics store result score #Physics.Projection.Object.CrossProductAxis.zy.Max Physics run scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.zy Physics /= #Physics.Constants.1000 Physics

            # Corner 1
            scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis.zy Physics *= #Physics.ThisObject Physics.Object.CornerPosRelative.1.x

            scoreboard players operation #Physics.Maths.Value34 Physics *= #Physics.ThisObject Physics.Object.CornerPosRelative.1.y
            scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis.zy Physics += #Physics.Maths.Value34 Physics
            execute store result score #Physics.Projection.ObjectCorner2.CrossProductAxis.zy Physics run scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis.zy Physics /= #Physics.Constants.1000 Physics

            # Corner 2
            scoreboard players operation #Physics.Projection.ObjectCorner2.CrossProductAxis.zy Physics *= #Physics.Constants.-1 Physics

            # Corner 3
            scoreboard players operation #Physics.Projection.ObjectCorner3.CrossProductAxis.zy Physics *= #Physics.Constants.-1 Physics

            # Corner 4 (Mirrored version of 3) (Same as 0)

            # Corner 5 (Mirrored version of 2) (Same as 1)

            # Corner 6 (Mirrored version of 1) (Same as 2)

            # Corner 7 (Mirrored version of 0) (Same as 3)

            # Find min and max (relative)
            execute if score #Physics.Projection.ObjectCorner1.CrossProductAxis.zy Physics > #Physics.Projection.Object.CrossProductAxis.zy.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.zy.Max Physics = #Physics.Projection.ObjectCorner1.CrossProductAxis.zy Physics
            execute if score #Physics.Projection.ObjectCorner2.CrossProductAxis.zy Physics > #Physics.Projection.Object.CrossProductAxis.zy.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.zy.Max Physics = #Physics.Projection.ObjectCorner2.CrossProductAxis.zy Physics
            execute if score #Physics.Projection.ObjectCorner3.CrossProductAxis.zy Physics > #Physics.Projection.Object.CrossProductAxis.zy.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.zy.Max Physics = #Physics.Projection.ObjectCorner3.CrossProductAxis.zy Physics
            scoreboard players operation #Physics.Projection.Object.CrossProductAxis.zy.Min Physics = #Physics.Projection.Object.CrossProductAxis.zy.Max Physics
            scoreboard players operation #Physics.Projection.Object.CrossProductAxis.zy.Min Physics *= #Physics.Constants.-1 Physics

            # Turn the projections and the min/max global by projecting the center point onto the same axis and adding it
            scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.zy Physics *= #Physics.ThisObject Physics.Object.Pos.x

            scoreboard players operation #Physics.Maths.Value35 Physics *= #Physics.ThisObject Physics.Object.Pos.y
            scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.zy Physics += #Physics.Maths.Value35 Physics

            scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.zy Physics /= #Physics.Constants.1000 Physics

            scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.zy Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.zy Physics
            scoreboard players operation #Physics.Projection.ObjectCorner1.CrossProductAxis.zy Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.zy Physics
            scoreboard players operation #Physics.Projection.ObjectCorner2.CrossProductAxis.zy Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.zy Physics
            scoreboard players operation #Physics.Projection.ObjectCorner3.CrossProductAxis.zy Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.zy Physics
            scoreboard players operation #Physics.Projection.Object.CrossProductAxis.zy.Min Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.zy Physics
            scoreboard players operation #Physics.Projection.Object.CrossProductAxis.zy.Max Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.zy Physics

        # Cross Product: z_block x z_object
        # (Important): Cross product's z component is 0, so z can be ignored. Also, cross product is orthogonal to object's z-axis, so points along the same edge have the same projection.
            # Corner 0
            scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.zz Physics *= #Physics.ThisObject Physics.Object.CornerPosRelative.0.x

            scoreboard players operation #Physics.Maths.Value36 Physics *= #Physics.ThisObject Physics.Object.CornerPosRelative.0.y
            scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.zz Physics += #Physics.Maths.Value36 Physics
            execute store result score #Physics.Projection.ObjectCorner6.CrossProductAxis.zz Physics store result score #Physics.Projection.Object.CrossProductAxis.zz.Max Physics run scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.zz Physics /= #Physics.Constants.1000 Physics

            # Corner 1 (Same as 0)

            # Corner 2
            scoreboard players operation #Physics.Projection.ObjectCorner2.CrossProductAxis.zz Physics *= #Physics.ThisObject Physics.Object.CornerPosRelative.2.x

            scoreboard players operation #Physics.Maths.Value37 Physics *= #Physics.ThisObject Physics.Object.CornerPosRelative.2.y
            scoreboard players operation #Physics.Projection.ObjectCorner2.CrossProductAxis.zz Physics += #Physics.Maths.Value37 Physics
            execute store result score #Physics.Projection.ObjectCorner4.CrossProductAxis.zz Physics run scoreboard players operation #Physics.Projection.ObjectCorner2.CrossProductAxis.zz Physics /= #Physics.Constants.1000 Physics

            # Corner 3 (Same as 2)

            # Corner 4 (Mirrored version of 3)
            scoreboard players operation #Physics.Projection.ObjectCorner4.CrossProductAxis.zz Physics *= #Physics.Constants.-1 Physics

            # Corner 5 (Mirrored version of 2) (Same as 4)

            # Corner 6 (Mirrored version of 1)
            scoreboard players operation #Physics.Projection.ObjectCorner6.CrossProductAxis.zz Physics *= #Physics.Constants.-1 Physics

            # Corner 7 (Mirrored version of 0) (Same as 6)

            # Find min and max (relative)
            execute if score #Physics.Projection.ObjectCorner2.CrossProductAxis.zz Physics > #Physics.Projection.Object.CrossProductAxis.zz.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.zz.Max Physics = #Physics.Projection.ObjectCorner2.CrossProductAxis.zz Physics
            execute if score #Physics.Projection.ObjectCorner4.CrossProductAxis.zz Physics > #Physics.Projection.Object.CrossProductAxis.zz.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.zz.Max Physics = #Physics.Projection.ObjectCorner4.CrossProductAxis.zz Physics
            execute if score #Physics.Projection.ObjectCorner6.CrossProductAxis.zz Physics > #Physics.Projection.Object.CrossProductAxis.zz.Max Physics run scoreboard players operation #Physics.Projection.Object.CrossProductAxis.zz.Max Physics = #Physics.Projection.ObjectCorner6.CrossProductAxis.zz Physics
            scoreboard players operation #Physics.Projection.Object.CrossProductAxis.zz.Min Physics = #Physics.Projection.Object.CrossProductAxis.zz.Max Physics
            scoreboard players operation #Physics.Projection.Object.CrossProductAxis.zz.Min Physics *= #Physics.Constants.-1 Physics

            # Turn the projections and the min/max global by projecting the center point onto the same axis and adding it
            scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.zz Physics *= #Physics.ThisObject Physics.Object.Pos.x

            scoreboard players operation #Physics.Maths.Value38 Physics *= #Physics.ThisObject Physics.Object.Pos.y
            scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.zz Physics += #Physics.Maths.Value38 Physics

            scoreboard players operation #Physics.Projection.ObjectCenter.CrossProductAxis.zz Physics /= #Physics.Constants.1000 Physics

            scoreboard players operation #Physics.Projection.ObjectCorner0.CrossProductAxis.zz Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.zz Physics
            scoreboard players operation #Physics.Projection.ObjectCorner2.CrossProductAxis.zz Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.zz Physics
            scoreboard players operation #Physics.Projection.ObjectCorner4.CrossProductAxis.zz Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.zz Physics
            scoreboard players operation #Physics.Projection.ObjectCorner6.CrossProductAxis.zz Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.zz Physics
            scoreboard players operation #Physics.Projection.Object.CrossProductAxis.zz.Min Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.zz Physics
            scoreboard players operation #Physics.Projection.Object.CrossProductAxis.zz.Max Physics += #Physics.Projection.ObjectCenter.CrossProductAxis.zz Physics
