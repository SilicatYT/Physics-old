# Get data
execute store result storage physics:debug data.show_axes.x_Start_x double 0.001 store result storage physics:debug data.show_axes.y_Start_x double 0.001 store result storage physics:debug data.show_axes.z_Start_x double 0.001 run scoreboard players get @s Physics.Object.CornerPosGlobal.0.x
execute store result storage physics:debug data.show_axes.x_Start_y double 0.001 store result storage physics:debug data.show_axes.y_Start_y double 0.001 store result storage physics:debug data.show_axes.z_Start_y double 0.001 run scoreboard players get @s Physics.Object.CornerPosGlobal.0.y
execute store result storage physics:debug data.show_axes.x_Start_z double 0.001 store result storage physics:debug data.show_axes.y_Start_z double 0.001 store result storage physics:debug data.show_axes.z_Start_z double 0.001 run scoreboard players get @s Physics.Object.CornerPosGlobal.0.z

execute store result storage physics:debug data.show_axes.x_Stop_x double 0.001 run scoreboard players get @s Physics.Object.CornerPosGlobal.2.x
execute store result storage physics:debug data.show_axes.x_Stop_y double 0.001 run scoreboard players get @s Physics.Object.CornerPosGlobal.2.y
execute store result storage physics:debug data.show_axes.x_Stop_z double 0.001 run scoreboard players get @s Physics.Object.CornerPosGlobal.2.z

execute store result storage physics:debug data.show_axes.y_Stop_x double 0.001 run scoreboard players get @s Physics.Object.CornerPosGlobal.4.x
execute store result storage physics:debug data.show_axes.y_Stop_y double 0.001 run scoreboard players get @s Physics.Object.CornerPosGlobal.4.y
execute store result storage physics:debug data.show_axes.y_Stop_z double 0.001 run scoreboard players get @s Physics.Object.CornerPosGlobal.4.z

execute store result storage physics:debug data.show_axes.z_Stop_x double 0.001 run scoreboard players get @s Physics.Object.CornerPosGlobal.1.x
execute store result storage physics:debug data.show_axes.z_Stop_y double 0.001 run scoreboard players get @s Physics.Object.CornerPosGlobal.1.y
execute store result storage physics:debug data.show_axes.z_Stop_z double 0.001 run scoreboard players get @s Physics.Object.CornerPosGlobal.1.z

# Convert data to strings (To avoid converting .0 to .5)
data modify storage physics:debug data.show_axes.x_Start_x set string storage physics:debug data.show_axes.x_Start_x 0 -1
data modify storage physics:debug data.show_axes.x_Start_y set string storage physics:debug data.show_axes.x_Start_y 0 -1
data modify storage physics:debug data.show_axes.x_Start_z set string storage physics:debug data.show_axes.x_Start_z 0 -1
data modify storage physics:debug data.show_axes.x_Stop_x set string storage physics:debug data.show_axes.x_Stop_x 0 -1
data modify storage physics:debug data.show_axes.x_Stop_y set string storage physics:debug data.show_axes.x_Stop_y 0 -1
data modify storage physics:debug data.show_axes.x_Stop_z set string storage physics:debug data.show_axes.x_Stop_z 0 -1

data modify storage physics:debug data.show_axes.y_Start_x set string storage physics:debug data.show_axes.y_Start_x 0 -1
data modify storage physics:debug data.show_axes.y_Start_y set string storage physics:debug data.show_axes.y_Start_y 0 -1
data modify storage physics:debug data.show_axes.y_Start_z set string storage physics:debug data.show_axes.y_Start_z 0 -1
data modify storage physics:debug data.show_axes.y_Stop_x set string storage physics:debug data.show_axes.y_Stop_x 0 -1
data modify storage physics:debug data.show_axes.y_Stop_y set string storage physics:debug data.show_axes.y_Stop_y 0 -1
data modify storage physics:debug data.show_axes.y_Stop_z set string storage physics:debug data.show_axes.y_Stop_z 0 -1

data modify storage physics:debug data.show_axes.z_Start_x set string storage physics:debug data.show_axes.z_Start_x 0 -1
data modify storage physics:debug data.show_axes.z_Start_y set string storage physics:debug data.show_axes.z_Start_y 0 -1
data modify storage physics:debug data.show_axes.z_Start_z set string storage physics:debug data.show_axes.z_Start_z 0 -1
data modify storage physics:debug data.show_axes.z_Stop_x set string storage physics:debug data.show_axes.z_Stop_x 0 -1
data modify storage physics:debug data.show_axes.z_Stop_y set string storage physics:debug data.show_axes.z_Stop_y 0 -1
data modify storage physics:debug data.show_axes.z_Stop_z set string storage physics:debug data.show_axes.z_Stop_z 0 -1

# Show
function physics:zprivate/debug/show_axes with storage physics:debug data.show_axes
