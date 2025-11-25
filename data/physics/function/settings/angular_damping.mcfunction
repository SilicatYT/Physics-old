$scoreboard players set #Physics.Value Physics $(Value)
execute if score #Physics.Value Physics matches 101.. run tellraw @s [{text:"Physics >> ",color:"#99EAD6"},{text:"Angular damping must not exceed 100 (Factor of 1.0).",color:"red"}]
execute if score #Physics.Value Physics matches 101.. at @s run return run playsound minecraft:entity.villager.no master @s ~ ~ ~
execute if score #Physics.Value Physics matches ..-1 run tellraw @s [{text:"Physics >> ",color:"#99EAD6"},{text:"Angular damping must be at least 0 (Factor of 0.0).",color:"red"}]
execute if score #Physics.Value Physics matches ..-1 at @s run return run playsound minecraft:entity.villager.no master @s ~ ~ ~

scoreboard players operation #Physics.Settings.AngularDamping Physics = #Physics.Value Physics
execute at @s run playsound minecraft:ui.button.click master @s ~ ~ ~
function physics:settings/open
