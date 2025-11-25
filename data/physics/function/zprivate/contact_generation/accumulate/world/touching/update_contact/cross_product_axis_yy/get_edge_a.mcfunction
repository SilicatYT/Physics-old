# Get Edge A
$execute store result score #Physics.ObjectA.EdgeStart.x Physics run scoreboard players operation #Physics.Maths.Value1 Physics = #Physics.ThisObject Physics.Object.CornerPosGlobal.$(StartCorner).x
$execute store result score #Physics.ObjectA.EdgeStart.y Physics run scoreboard players operation #Physics.Maths.Value2 Physics = #Physics.ThisObject Physics.Object.CornerPosGlobal.$(StartCorner).y
$execute store result score #Physics.ObjectA.EdgeStart.z Physics run scoreboard players operation #Physics.Maths.Value3 Physics = #Physics.ThisObject Physics.Object.CornerPosGlobal.$(StartCorner).z

$scoreboard players operation #Physics.PenetrationDepth Physics = #Physics.Projection.ObjectCorner$(StartCorner).CrossProductAxis.yy Physics
