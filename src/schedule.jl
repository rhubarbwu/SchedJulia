module Schedule

using Base

function construct(appointments, availability)
    if length(appointments) == 0
        return []
    end

    attendeeFreeTimes = []
    appointment = appointments[1][2]
    for requirement in appointment
        push!(attendeeFreeTimes, availability[requirement])
    end

    commonFreeTimes = reduce(intersect, attendeeFreeTimes)
    for commonFreeTime in commonFreeTimes
        availabilityCopy = copy(availability)
        for freeTime in availabilityCopy
            if freeTime in appointment
                pop!(availabilityCopy[freeTime], freeTime)
            end
        end

        if length(appointments[2:end,1]) == 0
            return [(commonFreeTime, appointment)]
        end

        result = construct(appointments[2:end,1], availabilityCopy)
        if result != nothing
            return vcat((commonFreeTime, appointment), result)
        end
    end
end

end