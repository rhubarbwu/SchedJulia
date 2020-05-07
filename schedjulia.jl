include("src/fileio.jl")
include("src/schedule.jl")

println("SchedJulia, an appointment scheduling script written in Julia.")

println("Reading appointments from data/appointments.txt...")
appointments = FileIO.read_appointments("data/appointments.txt")

println("Reading availability from data/availability.txt...")
availability = FileIO.read_availability("data/availability.txt")

println("Attempting to arrange a schedule...")

# Validate if each individual appointment is possible.
if !Schedule.validate(appointments, availability)
    println("\nNO SCHEDULE POSSIBLE\n")
    exit()
end

# Combine the appointments into a schedule.
schedule = Schedule.construct(appointments, availability)
if schedule == 0 || schedule == -1
    println("\nNO COMBINED SCHEDULE POSSIBLE\n")
    exit()
end

println("Successfully arranged schedule...\n")
FileIO.write_schedule(schedule)
println("\nWriting to data/schedule.txt...")
