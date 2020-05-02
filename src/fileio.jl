module FileIO

using DelimitedFiles

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

export read_appointments, read_availability

end