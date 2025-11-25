# (Important): If no blocks appeared in the world AABB checks, and I therefore only run the setup after world contact generation would've happened, I can skip all the world preparations and speed up things a lot.
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

scoreboard players operation #Physics.ThisObject Physics.Object.ProjectionOwnAxis.x.Min = @s Physics.Object.ProjectionOwnAxis.x.Min
scoreboard players operation #Physics.ThisObject Physics.Object.ProjectionOwnAxis.x.Max = @s Physics.Object.ProjectionOwnAxis.x.Max
scoreboard players operation #Physics.ThisObject Physics.Object.ProjectionOwnAxis.y.Min = @s Physics.Object.ProjectionOwnAxis.y.Min
scoreboard players operation #Physics.ThisObject Physics.Object.ProjectionOwnAxis.y.Max = @s Physics.Object.ProjectionOwnAxis.y.Max
scoreboard players operation #Physics.ThisObject Physics.Object.ProjectionOwnAxis.z.Min = @s Physics.Object.ProjectionOwnAxis.z.Min
scoreboard players operation #Physics.ThisObject Physics.Object.ProjectionOwnAxis.z.Max = @s Physics.Object.ProjectionOwnAxis.z.Max

scoreboard players operation #Physics.ThisObject Physics.Object.Axis.x.x = @s Physics.Object.Axis.x.x
scoreboard players operation #Physics.ThisObject Physics.Object.Axis.x.y = @s Physics.Object.Axis.x.y
scoreboard players operation #Physics.ThisObject Physics.Object.Axis.x.z = @s Physics.Object.Axis.x.z
scoreboard players operation #Physics.ThisObject Physics.Object.Axis.y.x = @s Physics.Object.Axis.y.x
scoreboard players operation #Physics.ThisObject Physics.Object.Axis.y.y = @s Physics.Object.Axis.y.y
scoreboard players operation #Physics.ThisObject Physics.Object.Axis.y.z = @s Physics.Object.Axis.y.z
scoreboard players operation #Physics.ThisObject Physics.Object.Axis.z.x = @s Physics.Object.Axis.z.x
scoreboard players operation #Physics.ThisObject Physics.Object.Axis.z.y = @s Physics.Object.Axis.z.y
scoreboard players operation #Physics.ThisObject Physics.Object.Axis.z.z = @s Physics.Object.Axis.z.z

scoreboard players operation #Physics.ThisObject Physics.Object.MaxPenetrationDepth = @s Physics.Object.MaxPenetrationDepth
scoreboard players operation #Physics.ThisObject Physics.Object.MinSeparatingVelocity = @s Physics.Object.MinSeparatingVelocity
