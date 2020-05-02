module FileIO

using DelimitedFiles
using Printf

function read_appointments()
    appointments = Tuple{Int,Set{String}}[]
    for line in readlines("appointments.txt")
        result = split(line, '|')
        duration = parse(Int, result[1])
        names = Set(readdlm(IOBuffer(result[2]), ',', String))
        push!(appointments, (duration, names))
    end

    appointments
end

function read_availability()
    availability = Dict{String,Set{Int}}()
    for line in readlines("availability.txt")
        name, times = split(line, '|')
        if length(times) == 0
            continue
        end

        availability[name] = Set(readdlm(IOBuffer(times), ',', Int))
    end

    availability
end

function write_schedule(schedule)
    open("schedule.txt", "w") do io
        appointment_to_str = function (app)
            @sprintf("%d-%d|%s", app[1], app[2], join(collect(app[3]), ','))
        end
    
        scheduleLines = map(appointment_to_str, schedule)
        writedlm(io, scheduleLines)
    end
end

export read_appointments, read_availability, write_schedule

end