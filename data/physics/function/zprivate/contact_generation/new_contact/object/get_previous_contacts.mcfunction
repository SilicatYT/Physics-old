# Copy the previous tick's contacts for that block to a temporary storage & remove the entry that is copied over
# (Important): I tag the object data I want to copy & delete so I only need 1 macro instead of 2.
$data modify storage physics:temp data.ContactsPrevious[{B:$(B)}].R set value 1b
data modify storage physics:temp data.Object set from storage physics:temp data.ContactsPrevious[{R:1b}]
data remove storage physics:temp data.ContactsPrevious[{R:1b}]
