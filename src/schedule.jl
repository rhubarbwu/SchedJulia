module Schedule

using Base

function construct(appointments, availability)
    if length(appointments) == 0
        return []
    end

    # Get the list of attendees' availability, and take its intersection.
    attendeeFreeTimes = []
    title, duration, attendees = appointments[1]
    for requirement in attendees
        push!(attendeeFreeTimes, availability[requirement])
    end

    commonFreeTimes = reduce(intersect, attendeeFreeTimes)
    for startTime in commonFreeTimes
        
        # Assume this appointment is satisfiable, and make deep-copy of times.
        satisfying = true
        availabilityCopy = deepcopy(availability)

        # Check the attendees and pop the <duration> times since startTime.
        for attendee in attendees
            for timeOffSet = 0:(duration - 1)
                timePoint = startTime + timeOffSet
                if timePoint in availabilityCopy[attendee]
                    pop!(availabilityCopy[attendee], timePoint)
                else
                    # This appointment config is unsatisfiable, continue.
                    satisfying = false
                    break
                end
            end
            if !satisfying; break; end
        end
        if !satisfying; continue; end

        endTime = startTime + duration - 1

        # If this is the last appointment, and it's successful, return it.
        if length(appointments[2:end,1]) == 0 
            return [(title, startTime, endTime, attendees)]
        end

        # If there is a successful arrangement of later appointments.
        # Return this appointment config with that arrangement.
        result = construct(appointments[2:end,1], availabilityCopy)
        if result != nothing
            return vcat((title, startTime, endTime, attendees), result)
        end

        # If there is no successful arrangement of later appointments based on
        # this appointment config, backtrack and try different configs.
    end
end

function validate(appointments, availability)
    for (title, duration, attendees) in appointments
        attendeeFreeTimes = []
        for requirement in attendees
            push!(attendeeFreeTimes, availability[requirement])
        end

        # If there is no way to arrange this single meeting, return false.    
        commonFreeTimes = reduce(intersect, attendeeFreeTimes)
        if length(commonFreeTimes) == 0
            return false
        end
    end

    # Each individual meeting is possible.
    return true
end

end