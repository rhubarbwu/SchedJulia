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
        for attendee in keys(availabilityCopy)
            if commonFreeTime in availabilityCopy[attendee]
                pop!(availabilityCopy[attendee], commonFreeTime)
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