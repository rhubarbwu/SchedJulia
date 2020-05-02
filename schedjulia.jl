include("fileio.jl")

appointments = FileIO.read_appointments()
availability = FileIO.read_availability()

println(appointments)
println(availability)