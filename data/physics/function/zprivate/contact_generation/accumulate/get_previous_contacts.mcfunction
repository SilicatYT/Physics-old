# Setup (Precalculations)
function physics:zprivate/collision_detection/world/setup

# Get all the contacts for the current object from the previous tick and copy them to a temporary storage
# (Important): If there is no data for this object from the previous tick, it will fail to copy over the data, so it keeps the previous object's data. This is not a problem, however, because the data is always emptied during contact accumulation anyway. So it'll just be empty. And it can be handled without much overhead if the data is empty.
$data modify storage physics:temp data.ContactsPrevious set from storage physics:temp data.ContactGroupsPrevious[{A:$(A)}].Objects

# Copy the world contacts to a temporary storage for easy access & remove the Invalid:1b tags
execute unless data storage physics:temp data.ContactsPrevious[0].Blocks run return 0
data modify storage physics:temp data.Blocks set from storage physics:temp data.ContactsPrevious[0].Blocks
data remove storage physics:temp data.ContactsPrevious[0]
