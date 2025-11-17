# Init
scoreboard players set #Physics.Init Physics 1
tellraw @a ["",{text:"Physics >> ",color:"#99EAD6"},"Installed Physics (v0.1.0)\n"]

# Add object attributes
scoreboard objectives add Physics.Object.ID dummy
scoreboard objectives add Physics.Object.Pos.x dummy
scoreboard objectives add Physics.Object.Pos.y dummy
scoreboard objectives add Physics.Object.Pos.z dummy
scoreboard objectives add Physics.Object.Velocity.x dummy
scoreboard objectives add Physics.Object.Velocity.y dummy
scoreboard objectives add Physics.Object.Velocity.z dummy
scoreboard objectives add Physics.Object.InverseMass dummy
scoreboard objectives add Physics.Object.InverseMassScaled dummy
scoreboard objectives add Physics.Object.InverseMassScaled2 dummy
scoreboard objectives add Physics.Object.Gravity dummy
scoreboard objectives add Physics.Object.Dimension.x dummy
scoreboard objectives add Physics.Object.Dimension.y dummy
scoreboard objectives add Physics.Object.Dimension.z dummy
scoreboard objectives add Physics.Object.AccumulatedForce.x dummy
scoreboard objectives add Physics.Object.AccumulatedForce.y dummy
scoreboard objectives add Physics.Object.AccumulatedForce.z dummy
scoreboard objectives add Physics.Object.AccumulatedTorque.x dummy
scoreboard objectives add Physics.Object.AccumulatedTorque.y dummy
scoreboard objectives add Physics.Object.AccumulatedTorque.z dummy
scoreboard objectives add Physics.Object.Orientation.x dummy
scoreboard objectives add Physics.Object.Orientation.y dummy
scoreboard objectives add Physics.Object.Orientation.z dummy
scoreboard objectives add Physics.Object.Orientation.a dummy
scoreboard objectives add Physics.Object.AngularVelocity.x dummy
scoreboard objectives add Physics.Object.AngularVelocity.y dummy
scoreboard objectives add Physics.Object.AngularVelocity.z dummy
scoreboard objectives add Physics.Object.InverseInertiaTensorLocal.0 dummy
scoreboard objectives add Physics.Object.InverseInertiaTensorLocal.4 dummy
scoreboard objectives add Physics.Object.InverseInertiaTensorLocal.8 dummy
scoreboard objectives add Physics.Object.MinSeparatingVelocity dummy
scoreboard objectives add Physics.Object.MaxPenetrationDepth dummy
scoreboard objectives add Physics.Object.MinSeparatingVelocity.World dummy
scoreboard objectives add Physics.Object.MaxPenetrationDepth.World dummy
scoreboard objectives add Physics.Object.FrictionCoefficient dummy
scoreboard objectives add Physics.Object.RestitutionCoefficient dummy
scoreboard objectives add Physics.Object.Gametime dummy

    # Temporary. Remove once a proper system is added for all x, y and z components for velocityFromAcc
    scoreboard objectives add Physics.Object.DefactoGravity dummy

# Add derived object attributes (Calculated from object attributes, but stored separately to prevent repeated calculations)
scoreboard objectives add Physics.Object.RotationMatrix.0 dummy
scoreboard objectives add Physics.Object.RotationMatrix.1 dummy
scoreboard objectives add Physics.Object.RotationMatrix.2 dummy
scoreboard objectives add Physics.Object.RotationMatrix.3 dummy
scoreboard objectives add Physics.Object.RotationMatrix.4 dummy
scoreboard objectives add Physics.Object.RotationMatrix.5 dummy
scoreboard objectives add Physics.Object.RotationMatrix.6 dummy
scoreboard objectives add Physics.Object.RotationMatrix.7 dummy
scoreboard objectives add Physics.Object.RotationMatrix.8 dummy
scoreboard objectives add Physics.Object.RotationMatrixTranspose.0 dummy
scoreboard objectives add Physics.Object.RotationMatrixTranspose.1 dummy
scoreboard objectives add Physics.Object.RotationMatrixTranspose.2 dummy
scoreboard objectives add Physics.Object.RotationMatrixTranspose.3 dummy
scoreboard objectives add Physics.Object.RotationMatrixTranspose.4 dummy
scoreboard objectives add Physics.Object.RotationMatrixTranspose.5 dummy
scoreboard objectives add Physics.Object.RotationMatrixTranspose.6 dummy
scoreboard objectives add Physics.Object.RotationMatrixTranspose.7 dummy
scoreboard objectives add Physics.Object.RotationMatrixTranspose.8 dummy
scoreboard objectives add Physics.Object.InverseInertiaTensorGlobal.0 dummy
scoreboard objectives add Physics.Object.InverseInertiaTensorGlobal.1 dummy
scoreboard objectives add Physics.Object.InverseInertiaTensorGlobal.2 dummy
scoreboard objectives add Physics.Object.InverseInertiaTensorGlobal.3 dummy
scoreboard objectives add Physics.Object.InverseInertiaTensorGlobal.4 dummy
scoreboard objectives add Physics.Object.InverseInertiaTensorGlobal.5 dummy
scoreboard objectives add Physics.Object.InverseInertiaTensorGlobal.6 dummy
scoreboard objectives add Physics.Object.InverseInertiaTensorGlobal.7 dummy
scoreboard objectives add Physics.Object.InverseInertiaTensorGlobal.8 dummy
scoreboard objectives add Physics.Object.BoundingBoxLocalMax.x dummy
scoreboard objectives add Physics.Object.BoundingBoxLocalMin.x dummy
scoreboard objectives add Physics.Object.BoundingBoxLocalMax.y dummy
scoreboard objectives add Physics.Object.BoundingBoxLocalMin.y dummy
scoreboard objectives add Physics.Object.BoundingBoxLocalMax.z dummy
scoreboard objectives add Physics.Object.BoundingBoxLocalMin.z dummy
scoreboard objectives add Physics.Object.CornerPosGlobal.0.x dummy
scoreboard objectives add Physics.Object.CornerPosGlobal.0.y dummy
scoreboard objectives add Physics.Object.CornerPosGlobal.0.z dummy
scoreboard objectives add Physics.Object.CornerPosGlobal.1.x dummy
scoreboard objectives add Physics.Object.CornerPosGlobal.1.y dummy
scoreboard objectives add Physics.Object.CornerPosGlobal.1.z dummy
scoreboard objectives add Physics.Object.CornerPosGlobal.2.x dummy
scoreboard objectives add Physics.Object.CornerPosGlobal.2.y dummy
scoreboard objectives add Physics.Object.CornerPosGlobal.2.z dummy
scoreboard objectives add Physics.Object.CornerPosGlobal.3.x dummy
scoreboard objectives add Physics.Object.CornerPosGlobal.3.y dummy
scoreboard objectives add Physics.Object.CornerPosGlobal.3.z dummy
scoreboard objectives add Physics.Object.CornerPosGlobal.4.x dummy
scoreboard objectives add Physics.Object.CornerPosGlobal.4.y dummy
scoreboard objectives add Physics.Object.CornerPosGlobal.4.z dummy
scoreboard objectives add Physics.Object.CornerPosGlobal.5.x dummy
scoreboard objectives add Physics.Object.CornerPosGlobal.5.y dummy
scoreboard objectives add Physics.Object.CornerPosGlobal.5.z dummy
scoreboard objectives add Physics.Object.CornerPosGlobal.6.x dummy
scoreboard objectives add Physics.Object.CornerPosGlobal.6.y dummy
scoreboard objectives add Physics.Object.CornerPosGlobal.6.z dummy
scoreboard objectives add Physics.Object.CornerPosGlobal.7.x dummy
scoreboard objectives add Physics.Object.CornerPosGlobal.7.y dummy
scoreboard objectives add Physics.Object.CornerPosGlobal.7.z dummy
scoreboard objectives add Physics.Object.CornerPosRelative.0.x dummy
scoreboard objectives add Physics.Object.CornerPosRelative.0.y dummy
scoreboard objectives add Physics.Object.CornerPosRelative.0.z dummy
scoreboard objectives add Physics.Object.CornerPosRelative.1.x dummy
scoreboard objectives add Physics.Object.CornerPosRelative.1.y dummy
scoreboard objectives add Physics.Object.CornerPosRelative.1.z dummy
scoreboard objectives add Physics.Object.CornerPosRelative.2.x dummy
scoreboard objectives add Physics.Object.CornerPosRelative.2.y dummy
scoreboard objectives add Physics.Object.CornerPosRelative.2.z dummy
scoreboard objectives add Physics.Object.CornerPosRelative.3.x dummy
scoreboard objectives add Physics.Object.CornerPosRelative.3.y dummy
scoreboard objectives add Physics.Object.CornerPosRelative.3.z dummy
scoreboard objectives add Physics.Object.CornerPosRelative.4.x dummy
scoreboard objectives add Physics.Object.CornerPosRelative.4.y dummy
scoreboard objectives add Physics.Object.CornerPosRelative.4.z dummy
scoreboard objectives add Physics.Object.CornerPosRelative.5.x dummy
scoreboard objectives add Physics.Object.CornerPosRelative.5.y dummy
scoreboard objectives add Physics.Object.CornerPosRelative.5.z dummy
scoreboard objectives add Physics.Object.CornerPosRelative.6.x dummy
scoreboard objectives add Physics.Object.CornerPosRelative.6.y dummy
scoreboard objectives add Physics.Object.CornerPosRelative.6.z dummy
scoreboard objectives add Physics.Object.CornerPosRelative.7.x dummy
scoreboard objectives add Physics.Object.CornerPosRelative.7.y dummy
scoreboard objectives add Physics.Object.CornerPosRelative.7.z dummy
scoreboard objectives add Physics.Object.BoundingBoxGlobalMin.x dummy
scoreboard objectives add Physics.Object.BoundingBoxGlobalMax.x dummy
scoreboard objectives add Physics.Object.BoundingBoxGlobalMin.y dummy
scoreboard objectives add Physics.Object.BoundingBoxGlobalMax.y dummy
scoreboard objectives add Physics.Object.BoundingBoxGlobalMin.z dummy
scoreboard objectives add Physics.Object.BoundingBoxGlobalMax.z dummy
scoreboard objectives add Physics.Object.BoundingBoxStepCount.x dummy
scoreboard objectives add Physics.Object.BoundingBoxStepCount.y dummy
scoreboard objectives add Physics.Object.BoundingBoxStepCount.z dummy
scoreboard objectives add Physics.Object.Axis.x.x dummy
scoreboard objectives add Physics.Object.Axis.x.y dummy
scoreboard objectives add Physics.Object.Axis.x.z dummy
scoreboard objectives add Physics.Object.Axis.y.x dummy
scoreboard objectives add Physics.Object.Axis.y.y dummy
scoreboard objectives add Physics.Object.Axis.y.z dummy
scoreboard objectives add Physics.Object.Axis.z.x dummy
scoreboard objectives add Physics.Object.Axis.z.y dummy
scoreboard objectives add Physics.Object.Axis.z.z dummy
scoreboard objectives add Physics.Object.ProjectionOwnAxis.x.Min dummy
scoreboard objectives add Physics.Object.ProjectionOwnAxis.x.Max dummy
scoreboard objectives add Physics.Object.ProjectionOwnAxis.y.Min dummy
scoreboard objectives add Physics.Object.ProjectionOwnAxis.y.Max dummy
scoreboard objectives add Physics.Object.ProjectionOwnAxis.z.Min dummy
scoreboard objectives add Physics.Object.ProjectionOwnAxis.z.Max dummy

# Add hitbox attributes
scoreboard objectives add Physics.Hitbox.Gametime dummy

# Add player attributes
scoreboard objectives add Physics.Player.LookingAtID dummy
scoreboard objectives add Physics.Player.LookingAtPos.x dummy
scoreboard objectives add Physics.Player.LookingAtPos.y dummy
scoreboard objectives add Physics.Player.LookingAtPos.z dummy
scoreboard objectives add Physics.Player.LookingAtDirection.x dummy
scoreboard objectives add Physics.Player.LookingAtDirection.y dummy
scoreboard objectives add Physics.Player.LookingAtDirection.z dummy
scoreboard objectives add Physics.Player.ID dummy
scoreboard objectives add Physics.Player.PunchStrength dummy

# Set value constants
scoreboard players set #Physics.Constants.-1000 Physics -1000
scoreboard players set #Physics.Constants.-500 Physics -500
scoreboard players set #Physics.Constants.-2 Physics -2
scoreboard players set #Physics.Constants.-1 Physics -1
scoreboard players set #Physics.Constants.2 Physics 2
scoreboard players set #Physics.Constants.10 Physics 10
scoreboard players set #Physics.Constants.12 Physics 12
scoreboard players set #Physics.Constants.20 Physics 20
scoreboard players set #Physics.Constants.100 Physics 100
scoreboard players set #Physics.Constants.141 Physics 141
scoreboard players set #Physics.Constants.500 Physics 500
scoreboard players set #Physics.Constants.833 Physics 833
scoreboard players set #Physics.Constants.1000 Physics 1000
scoreboard players set #Physics.Constants.1732 Physics 1732
scoreboard players set #Physics.Constants.2000 Physics 2000
scoreboard players set #Physics.Constants.7775 Physics 7775
scoreboard players set #Physics.Constants.10000 Physics 10000
scoreboard players set #Physics.Constants.100000 Physics 100000

# Set required initial scores
scoreboard players set #Physics.MinSeparatingVelocityTotal Physics 0
scoreboard players set #Physics.MaxPenetrationDepthTotal Physics 0
scoreboard players set #Physics.HitboxID Physics 1
scoreboard players set #Physics.HitboxType Physics 1
scoreboard players set #Physics.InteractionCount Physics 0
scoreboard players set #Physics.MinDistance Physics 2147483647
scoreboard players set #Physics.LookingAtID Physics 0

scoreboard players set #Physics.Settings.DefaultPlayerStrength Physics 30
scoreboard players set #Physics.Settings.ReactToBlockUpdates Physics 1
scoreboard players set #Physics.Settings.DefaultGravity Physics -49
scoreboard players set #Physics.Settings.LinearDamping Physics 98
scoreboard players set #Physics.Settings.AngularDamping Physics 98
scoreboard players set #Physics.Settings.Accumulation.MinPenetrationDepth Physics -50
scoreboard players set #Physics.Settings.Resolution.MinPenetrationDepth Physics 0
scoreboard players set #Physics.Settings.Resolution.MaxSeparatingVelocity Physics 0
scoreboard players set #Physics.Settings.Resolution.RestitutionThreshold Physics 22500

# Setup starting values for data storages
data modify storage physics:temp data.HitboxPos set value [0d,0d,0d]
data modify storage physics:temp data.HitboxData set value {Pos:[0d,0d,0d],width:0.35f,height:0.35f,response:1b}
data modify storage physics:temp data.Integration set value {Pos:[0d,0d,0d],start_interpolation:0,transformation:{left_rotation:[0f,0f,0f,0f]}}
data modify storage physics:temp data.Integration.Pos set value [0d,0d,0d]
data modify storage physics:temp data.IntersectionPosGlobal set value [0d,0d,0d]
data modify storage physics:temp data.NewContact set value {ContactNormal:[I;0,0,0],ContactPoint:[I;0,0,0],ContactVelocity:[I;0,0,0]}
data modify storage physics:temp data.BlockCorner set value [{x:"Min",y:"Min",z:"Min"},{x:"Min",y:"Min",z:"Max"},{x:"Max",y:"Min",z:"Min"},{x:"Max",y:"Min",z:"Max"},{x:"Min",y:"Max",z:"Min"},{x:"Min",y:"Max",z:"Max"},{x:"Max",y:"Max",z:"Min"},{x:"Max",y:"Max",z:"Max"}]
data modify storage physics:temp data.BlockEdge set value {20:{StartCorner:0b},21:{StartCorner:1b},22:{StartCorner:4b},23:{StartCorner:5b},24:{StartCorner:0b},25:{StartCorner:1b},26:{StartCorner:2b},27:{StartCorner:3b},28:{StartCorner:0b},29:{StartCorner:2b},30:{StartCorner:4b},31:{StartCorner:6b}}
data modify storage physics:temp data.ObjectEdge set value {x:[{Edge:20b,StartCorner:0b},{Edge:21b,StartCorner:1b},{Edge:22b,StartCorner:4b},{Edge:23b,StartCorner:5b}],y:[{Edge:24b,StartCorner:0b},{Edge:25b,StartCorner:1b},{Edge:26b,StartCorner:2b},{Edge:27b,StartCorner:3b}],z:[{Edge:28b,StartCorner:0b},{Edge:29b,StartCorner:2b},{Edge:30b,StartCorner:4b},{Edge:31b,StartCorner:6b}]}
data modify storage physics:temp data.EdgeData set value {x:{Axis:"x",StartCorner0:0b,StartCorner1:1b,StartCorner2:4b,StartCorner3:5b},y:{Axis:"y",StartCorner0:0b,StartCorner1:1b,StartCorner2:2b,StartCorner3:3b},z:{Axis:"z",StartCorner0:0b,StartCorner1:2b,StartCorner2:4b,StartCorner3:6b}}
data modify storage physics:temp data.UpdateBlocks set value []

# Set gamerules
gamerule maxCommandChainLength 2147483647
