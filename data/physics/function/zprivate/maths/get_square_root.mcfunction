# Get the square root of a number (Method by Triton365)
# INPUT: scoreboard players set #Physics.Maths.SquareRoot.Input Physics <x>

execute store result score #Physics.Maths.SquareRoot.Value2 Physics run scoreboard players operation #Physics.Maths.SquareRoot.Value1 Physics = #Physics.Maths.SquareRoot.Input Physics
execute if score #Physics.Maths.SquareRoot.Input Physics matches 0..19310 run function physics:zprivate/maths/get_square_root/0
execute if score #Physics.Maths.SquareRoot.Input Physics matches 19311..1705544 run function physics:zprivate/maths/get_square_root/1
execute if score #Physics.Maths.SquareRoot.Input Physics matches 1705545..39400514 run function physics:zprivate/maths/get_square_root/2
execute if score #Physics.Maths.SquareRoot.Input Physics matches 39400515..455779650 run function physics:zprivate/maths/get_square_root/3
execute if score #Physics.Maths.SquareRoot.Input Physics matches 455779651..2147483647 run function physics:zprivate/maths/get_square_root/4

scoreboard players operation #Physics.Maths.SquareRoot.Value2 Physics /= #Physics.Maths.SquareRoot.Output Physics
scoreboard players operation #Physics.Maths.SquareRoot.Output Physics += #Physics.Maths.SquareRoot.Value2 Physics
scoreboard players operation #Physics.Maths.SquareRoot.Output Physics /= #Physics.Constants.2 Physics
scoreboard players operation #Physics.Maths.SquareRoot.Input Physics /= #Physics.Maths.SquareRoot.Output Physics
execute if score #Physics.Maths.SquareRoot.Output Physics > #Physics.Maths.SquareRoot.Input Physics run scoreboard players remove #Physics.Maths.SquareRoot.Output Physics 1

# OUTPUT: scoreboard players get #Physics.Maths.SquareRoot.Output Physics
