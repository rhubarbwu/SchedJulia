module Construct

using Base

function construct(appointments, availability, dry_run)
    if length(appointments) == 0
        return []
    end

    # Get the list of attendees' availability, and take its intersection.
    attendeeFreeTimes = []
    title, duration, attendees = appointments[1]
    for attendee in attendees
        push!(attendeeFreeTimes, availability[attendee])
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

                # This appointment config is unsatisfiable, continue.
                if !(timePoint in availabilityCopy[attendee])
                    satisfying = false
                    break
                end

                pop!(availabilityCopy[attendee], timePoint)
            end
            if !satisfying; break; end
        end
        if dry_run; return satisfying; end
        
        if !satisfying; continue; end

        endTime = startTime + duration - 1

        # If this is the last appointment, and it's successful, return it.
        if length(appointments[2:end,1]) == 0
            return [(title, startTime, endTime, attendees)]
        end

        # If there is a successful arrangement of later appointments.
        # Return this appointment config with that arrangement.
        result = construct(appointments[2:end,1], availabilityCopy, false)
        if result !== nothing
            return vcat((title, startTime, endTime, attendees), result)
        end

        # If there is no successful arrangement of later appointments based on
        # this appointment config, backtrack and try different configs.
    end
end

end