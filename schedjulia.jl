include("src/fileio.jl")
include("src/schedule.jl")

appointments = FileIO.read_appointments()
availability = FileIO.read_availability()
schedule = Schedule.construct(appointments, availability)
if schedule == nothing
    println("NO SCHEDULE POSSIBLE")
else
    FileIO.write_schedule(schedule)
end