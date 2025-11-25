# Set default attributes
execute store result score @s Physics.Object.ID run scoreboard players add #Physics.ObjectID Physics 1

data modify storage physics:temp data.Object set from entity @s
execute store result score @s Physics.Object.Pos.x run data get storage physics:temp data.Object.Pos[0] 1000
execute store result score @s Physics.Object.Pos.y run data get storage physics:temp data.Object.Pos[1] 1000
execute store result score @s Physics.Object.Pos.z run data get storage physics:temp data.Object.Pos[2] 1000
scoreboard players set @s Physics.Object.InverseMass 100000
scoreboard players set @s Physics.Object.InverseMassScaled 100
scoreboard players set @s Physics.Object.InverseMassScaled2 1
scoreboard players set @s Physics.Object.Dimension.x 1000
scoreboard players set @s Physics.Object.Dimension.y 1000
scoreboard players set @s Physics.Object.Dimension.z 1000
scoreboard players set @s Physics.Object.Orientation.x 0
scoreboard players set @s Physics.Object.Orientation.y 0
scoreboard players set @s Physics.Object.Orientation.z 0
scoreboard players set @s Physics.Object.Orientation.a 1000
scoreboard players set @s Physics.Object.InverseInertiaTensorLocal.0 6024096
scoreboard players set @s Physics.Object.InverseInertiaTensorLocal.4 6024096
scoreboard players set @s Physics.Object.InverseInertiaTensorLocal.8 6024096
scoreboard players set @s Physics.Object.InverseInertiaTensorGlobal.0 6024096
scoreboard players set @s Physics.Object.InverseInertiaTensorGlobal.1 0
scoreboard players set @s Physics.Object.InverseInertiaTensorGlobal.2 0
scoreboard players set @s Physics.Object.InverseInertiaTensorGlobal.3 0
scoreboard players set @s Physics.Object.InverseInertiaTensorGlobal.4 6024096
scoreboard players set @s Physics.Object.InverseInertiaTensorGlobal.5 0
scoreboard players set @s Physics.Object.InverseInertiaTensorGlobal.6 0
scoreboard players set @s Physics.Object.InverseInertiaTensorGlobal.7 0
scoreboard players set @s Physics.Object.InverseInertiaTensorGlobal.8 6024096
scoreboard players set @s Physics.Object.BoundingBoxLocalMin.x -500
scoreboard players set @s Physics.Object.BoundingBoxLocalMax.x 500
scoreboard players set @s Physics.Object.BoundingBoxLocalMin.y -500
scoreboard players set @s Physics.Object.BoundingBoxLocalMax.y 500
scoreboard players set @s Physics.Object.BoundingBoxLocalMin.z -500
scoreboard players set @s Physics.Object.BoundingBoxLocalMax.z 500
scoreboard players set @s Physics.Object.BoundingBoxStepCount.x 2
scoreboard players set @s Physics.Object.BoundingBoxStepCount.y 2
scoreboard players set @s Physics.Object.BoundingBoxStepCount.z 2
scoreboard players set @s Physics.Object.FrictionCoefficient 50
scoreboard players set @s Physics.Object.RestitutionCoefficient 30

# Remove tag
tag @s remove Physics.New
