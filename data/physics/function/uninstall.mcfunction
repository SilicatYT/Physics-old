# Check if it's installed
scoreboard objectives add Physics.Uninstall dummy
execute if score #Physics.Init Physics matches 1 run scoreboard players set #Physics.Init Physics.Uninstall 1
execute unless score #Physics.Init Physics.Uninstall matches 1 run tellraw @a ["",{text:"Physics >> ",color:"#99EAD6"},{text:"⚠ Could not remove Physics.\nIs it installed?",color:"red"}]
execute unless score #Physics.Init Physics.Uninstall matches 1 run return run scoreboard objectives remove Physics.Uninstall
scoreboard objectives remove Physics.Uninstall

# Tellraw
tellraw @s ["",{text:"Physics >> ",color:"#99EAD6"},"Uninstalled Physics (v0.1.0)"]

# Remove scoreboard objectives
scoreboard objectives remove Physics

scoreboard objectives remove Physics.Object.ID
scoreboard objectives remove Physics.Object.Pos.x
scoreboard objectives remove Physics.Object.Pos.y
scoreboard objectives remove Physics.Object.Pos.z
scoreboard objectives remove Physics.Object.Velocity.x
scoreboard objectives remove Physics.Object.Velocity.y
scoreboard objectives remove Physics.Object.Velocity.z
scoreboard objectives remove Physics.Object.InverseMass
scoreboard objectives remove Physics.Object.InverseMassScaled
scoreboard objectives remove Physics.Object.InverseMassScaled2
scoreboard objectives remove Physics.Object.Gravity
scoreboard objectives remove Physics.Object.AccumulatedForce.x
scoreboard objectives remove Physics.Object.AccumulatedForce.y
scoreboard objectives remove Physics.Object.AccumulatedForce.z
scoreboard objectives remove Physics.Object.AccumulatedTorque.x
scoreboard objectives remove Physics.Object.AccumulatedTorque.y
scoreboard objectives remove Physics.Object.AccumulatedTorque.z
scoreboard objectives remove Physics.Object.Orientation.x
scoreboard objectives remove Physics.Object.Orientation.y
scoreboard objectives remove Physics.Object.Orientation.z
scoreboard objectives remove Physics.Object.Orientation.a
scoreboard objectives remove Physics.Object.AngularVelocity.x
scoreboard objectives remove Physics.Object.AngularVelocity.y
scoreboard objectives remove Physics.Object.AngularVelocity.z
scoreboard objectives remove Physics.Object.InverseInertiaTensorLocal.0
scoreboard objectives remove Physics.Object.InverseInertiaTensorLocal.4
scoreboard objectives remove Physics.Object.InverseInertiaTensorLocal.8
scoreboard objectives remove Physics.Object.Dimension.x
scoreboard objectives remove Physics.Object.Dimension.y
scoreboard objectives remove Physics.Object.Dimension.z
scoreboard objectives remove Physics.Object.MinSeparatingVelocity
scoreboard objectives remove Physics.Object.MaxPenetrationDepth
scoreboard objectives remove Physics.Object.MinSeparatingVelocity.World
scoreboard objectives remove Physics.Object.MaxPenetrationDepth.World
scoreboard objectives remove Physics.Object.FrictionCoefficient
scoreboard objectives remove Physics.Object.RestitutionCoefficient
scoreboard objectives remove Physics.Object.Gametime

scoreboard objectives remove Physics.Object.RotationMatrix.0
scoreboard objectives remove Physics.Object.RotationMatrix.1
scoreboard objectives remove Physics.Object.RotationMatrix.2
scoreboard objectives remove Physics.Object.RotationMatrix.3
scoreboard objectives remove Physics.Object.RotationMatrix.4
scoreboard objectives remove Physics.Object.RotationMatrix.5
scoreboard objectives remove Physics.Object.RotationMatrix.6
scoreboard objectives remove Physics.Object.RotationMatrix.7
scoreboard objectives remove Physics.Object.RotationMatrix.8
scoreboard objectives remove Physics.Object.RotationMatrixTranspose.0
scoreboard objectives remove Physics.Object.RotationMatrixTranspose.1
scoreboard objectives remove Physics.Object.RotationMatrixTranspose.2
scoreboard objectives remove Physics.Object.RotationMatrixTranspose.3
scoreboard objectives remove Physics.Object.RotationMatrixTranspose.4
scoreboard objectives remove Physics.Object.RotationMatrixTranspose.5
scoreboard objectives remove Physics.Object.RotationMatrixTranspose.6
scoreboard objectives remove Physics.Object.RotationMatrixTranspose.7
scoreboard objectives remove Physics.Object.RotationMatrixTranspose.8
scoreboard objectives remove Physics.Object.InverseInertiaTensorGlobal.0
scoreboard objectives remove Physics.Object.InverseInertiaTensorGlobal.1
scoreboard objectives remove Physics.Object.InverseInertiaTensorGlobal.2
scoreboard objectives remove Physics.Object.InverseInertiaTensorGlobal.3
scoreboard objectives remove Physics.Object.InverseInertiaTensorGlobal.4
scoreboard objectives remove Physics.Object.InverseInertiaTensorGlobal.5
scoreboard objectives remove Physics.Object.InverseInertiaTensorGlobal.6
scoreboard objectives remove Physics.Object.InverseInertiaTensorGlobal.7
scoreboard objectives remove Physics.Object.InverseInertiaTensorGlobal.8
scoreboard objectives remove Physics.Object.BoundingBoxLocalMax.x
scoreboard objectives remove Physics.Object.BoundingBoxLocalMin.x
scoreboard objectives remove Physics.Object.BoundingBoxLocalMax.y
scoreboard objectives remove Physics.Object.BoundingBoxLocalMin.y
scoreboard objectives remove Physics.Object.BoundingBoxLocalMax.z
scoreboard objectives remove Physics.Object.BoundingBoxLocalMin.z
scoreboard objectives remove Physics.Object.CornerPosGlobal.0.x
scoreboard objectives remove Physics.Object.CornerPosGlobal.0.y
scoreboard objectives remove Physics.Object.CornerPosGlobal.0.z
scoreboard objectives remove Physics.Object.CornerPosGlobal.1.x
scoreboard objectives remove Physics.Object.CornerPosGlobal.1.y
scoreboard objectives remove Physics.Object.CornerPosGlobal.1.z
scoreboard objectives remove Physics.Object.CornerPosGlobal.2.x
scoreboard objectives remove Physics.Object.CornerPosGlobal.2.y
scoreboard objectives remove Physics.Object.CornerPosGlobal.2.z
scoreboard objectives remove Physics.Object.CornerPosGlobal.3.x
scoreboard objectives remove Physics.Object.CornerPosGlobal.3.y
scoreboard objectives remove Physics.Object.CornerPosGlobal.3.z
scoreboard objectives remove Physics.Object.CornerPosGlobal.4.x
scoreboard objectives remove Physics.Object.CornerPosGlobal.4.y
scoreboard objectives remove Physics.Object.CornerPosGlobal.4.z
scoreboard objectives remove Physics.Object.CornerPosGlobal.5.x
scoreboard objectives remove Physics.Object.CornerPosGlobal.5.y
scoreboard objectives remove Physics.Object.CornerPosGlobal.5.z
scoreboard objectives remove Physics.Object.CornerPosGlobal.6.x
scoreboard objectives remove Physics.Object.CornerPosGlobal.6.y
scoreboard objectives remove Physics.Object.CornerPosGlobal.6.z
scoreboard objectives remove Physics.Object.CornerPosGlobal.7.x
scoreboard objectives remove Physics.Object.CornerPosGlobal.7.y
scoreboard objectives remove Physics.Object.CornerPosGlobal.7.z
scoreboard objectives remove Physics.Object.CornerPosRelative.0.x
scoreboard objectives remove Physics.Object.CornerPosRelative.0.y
scoreboard objectives remove Physics.Object.CornerPosRelative.0.z
scoreboard objectives remove Physics.Object.CornerPosRelative.1.x
scoreboard objectives remove Physics.Object.CornerPosRelative.1.y
scoreboard objectives remove Physics.Object.CornerPosRelative.1.z
scoreboard objectives remove Physics.Object.CornerPosRelative.2.x
scoreboard objectives remove Physics.Object.CornerPosRelative.2.y
scoreboard objectives remove Physics.Object.CornerPosRelative.2.z
scoreboard objectives remove Physics.Object.CornerPosRelative.3.x
scoreboard objectives remove Physics.Object.CornerPosRelative.3.y
scoreboard objectives remove Physics.Object.CornerPosRelative.3.z
scoreboard objectives remove Physics.Object.CornerPosRelative.4.x
scoreboard objectives remove Physics.Object.CornerPosRelative.4.y
scoreboard objectives remove Physics.Object.CornerPosRelative.4.z
scoreboard objectives remove Physics.Object.CornerPosRelative.5.x
scoreboard objectives remove Physics.Object.CornerPosRelative.5.y
scoreboard objectives remove Physics.Object.CornerPosRelative.5.z
scoreboard objectives remove Physics.Object.CornerPosRelative.6.x
scoreboard objectives remove Physics.Object.CornerPosRelative.6.y
scoreboard objectives remove Physics.Object.CornerPosRelative.6.z
scoreboard objectives remove Physics.Object.CornerPosRelative.7.x
scoreboard objectives remove Physics.Object.CornerPosRelative.7.y
scoreboard objectives remove Physics.Object.CornerPosRelative.7.z
scoreboard objectives remove Physics.Object.BoundingBoxGlobalMin.x
scoreboard objectives remove Physics.Object.BoundingBoxGlobalMax.x
scoreboard objectives remove Physics.Object.BoundingBoxGlobalMin.y
scoreboard objectives remove Physics.Object.BoundingBoxGlobalMax.y
scoreboard objectives remove Physics.Object.BoundingBoxGlobalMin.z
scoreboard objectives remove Physics.Object.BoundingBoxGlobalMax.z
scoreboard objectives remove Physics.Object.BoundingBoxStepCount.x
scoreboard objectives remove Physics.Object.BoundingBoxStepCount.y
scoreboard objectives remove Physics.Object.BoundingBoxStepCount.z
scoreboard objectives remove Physics.Object.Axis.x.x
scoreboard objectives remove Physics.Object.Axis.x.y
scoreboard objectives remove Physics.Object.Axis.x.z
scoreboard objectives remove Physics.Object.Axis.y.x
scoreboard objectives remove Physics.Object.Axis.y.y
scoreboard objectives remove Physics.Object.Axis.y.z
scoreboard objectives remove Physics.Object.Axis.z.x
scoreboard objectives remove Physics.Object.Axis.z.y
scoreboard objectives remove Physics.Object.Axis.z.z
scoreboard objectives remove Physics.Object.ProjectionOwnAxis.x.Min
scoreboard objectives remove Physics.Object.ProjectionOwnAxis.x.Max
scoreboard objectives remove Physics.Object.ProjectionOwnAxis.y.Min
scoreboard objectives remove Physics.Object.ProjectionOwnAxis.y.Max
scoreboard objectives remove Physics.Object.ProjectionOwnAxis.z.Min
scoreboard objectives remove Physics.Object.ProjectionOwnAxis.z.Max

scoreboard objectives remove Physics.Hitbox.Gametime

scoreboard objectives remove Physics.Player.LookingAtID
scoreboard objectives remove Physics.Player.LookingAtPos.x
scoreboard objectives remove Physics.Player.LookingAtPos.y
scoreboard objectives remove Physics.Player.LookingAtPos.z
scoreboard objectives remove Physics.Player.LookingAtDirection.x
scoreboard objectives remove Physics.Player.LookingAtDirection.y
scoreboard objectives remove Physics.Player.LookingAtDirection.z
scoreboard objectives remove Physics.Player.ID
scoreboard objectives remove Physics.Player.PunchStrength

# Reset scores
# (Important): It resets all Physics.Hitbox.Gametime scores to avoid having unloaded interaction entities be killed after uninstalling, which would permanently offset the InteractionCount score and break things.
scoreboard players reset * Physics.Hitbox.Gametime

# Remove data storages
data remove storage physics:debug data
data remove storage physics:temp data
data remove storage physics:zprivate ContactGroups
