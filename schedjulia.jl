include("src/construct.jl")
include("src/fileio.jl")
include("src/process.jl")

println("SchedJulia, an appointment scheduling script written in Julia.\n")

println("Reading appointments from data/appointments.txt...")
appointments = FileIO.read_appointments("data/appointments.txt")
Process.sort_appointments(appointments)

println("Reading availability from data/availability.txt...")
availability = FileIO.read_availability("data/availability.txt")

println("Validating individual appointments...\n")
Process.validate_appointments(appointments, availability)

println("\nAttempting to construct a schedule...")
schedule = Construct.construct(appointments, availability, false)
if schedule === nothing
    println("  NO SCHEDULE POSSIBLE")
    exit()
end

println("Schedule constructed! Writing to data/schedule.txt...\n")
FileIO.write_schedule(schedule)
println()