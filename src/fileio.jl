module FileIO

using DelimitedFiles
using Printf

function read_appointments(path)
    appointments = Tuple{String,Int,Set{String}}[]
    for line in readlines(path)
        result = split(line, '|')
        title = result[1]
        duration = parse(Int, result[2])
        names = Set(readdlm(IOBuffer(result[3]), ',', String))
        push!(appointments, (title, duration, names))
    end

    appointments
end

function read_availability(path)
    availability = Dict{String,Set{Int}}()
    for line in readlines(path)
        name, times = split(line, '|')
        if length(times) == 0
            continue
        end

        availability[name] = Set(readdlm(IOBuffer(times), ',', Int))
    end

    availability
end

function write_schedule(schedule)
    open("data/schedule.txt", "w") do io
        appointment_to_str = function (app)
            @sprintf("%s|%d-%d|%s", 
                app[1], app[2], app[3], 
                join(collect(app[4]), ','))
        end
    
        scheduleLines = map(appointment_to_str, schedule)
        writedlm(io, scheduleLines)
        foreach(obj->println("   ", obj), scheduleLines)
    end
end

export read_appointments, read_availability, write_schedule

end