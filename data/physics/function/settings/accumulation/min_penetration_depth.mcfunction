$scoreboard players set #Physics.Value Physics $(Value)
execute if score #Physics.Value Physics matches ..-501 run tellraw @s [{text:"Physics >> ",color:"#99EAD6"},{text:"The minimum penetration depth must not be below -500 (-0.5 blocks).",color:"red"}]
execute if score #Physics.Value Physics matches ..-501 at @s run return run playsound minecraft:entity.villager.no master @s ~ ~ ~
execute if score #Physics.Value Physics matches 1.. run tellraw @s [{text:"Physics >> ",color:"#99EAD6"},{text:"The minimum penetration depth must not exceed 0 (0.0 blocks).",color:"red"}]
execute if score #Physics.Value Physics matches 1.. at @s run return run playsound minecraft:entity.villager.no master @s ~ ~ ~

scoreboard players operation #Physics.Settings.Accumulation.MinPenetrationDepth Physics = #Physics.Value Physics
execute at @s run playsound minecraft:ui.button.click master @s ~ ~ ~
function physics:settings/open
