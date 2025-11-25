# Adjust scales
# (Important): I scale MaxFriction by 100x so it's 10,000x. Then I scale PlanarImpulseSquared by 100x so PlanarImpulse is 10x after being square rooted. Then, the final result is 1,000x.
scoreboard players operation #Physics.Maths.MaxFriction Physics *= #Physics.Constants.100 Physics

# Calculate PlanarImpulse
# (Important): PlanarImpulseSquared is scaled up to preserve accuracy after being square rooted.
execute store result score #Physics.Maths.SquareRoot.Input Physics run scoreboard players operation #Physics.Maths.PlanarImpulse Physics *= #Physics.Constants.100 Physics
function physics:zprivate/maths/get_square_root

# Calculate scaling factor for tangential impulses
# (Important): This factor is 1,000x. So I need to scale down the impulses by 1,000x after this.
scoreboard players operation #Physics.Maths.MaxFriction Physics /= #Physics.Maths.SquareRoot.Output Physics

# Apply friction to tangential impulses
execute store result score #Physics.Maths.Impulse.x Physics run scoreboard players operation #Physics.Maths.ContactVelocity.x Physics *= #Physics.Maths.MaxFriction Physics
execute store result score #Physics.Maths.Impulse.z Physics run scoreboard players operation #Physics.Maths.ContactVelocity.z Physics *= #Physics.Maths.MaxFriction Physics

# Set score backups for later use
scoreboard players operation #Physics.Maths.Impulse.x Physics /= #Physics.Constants.1000 Physics
scoreboard players operation #Physics.Maths.Impulse.z Physics /= #Physics.Constants.1000 Physics
