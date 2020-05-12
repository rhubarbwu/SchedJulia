module Process

include("construct.jl")

function sort_appointments(appointments)
    sort!(appointments, by = a->length(a[3]), rev = true)
    sort!(appointments, by = a->a[2], rev = true)
end

function validate_appointments(appointments, availability)
    appointments_count = length(appointments)
    for i in 0:appointments_count - 1
        ii = appointments_count - i
        if Construct.construct(appointments[ii:ii], availability, true)
            println("  ", appointments[ii][1], 
            " is satisfiable...")
        else
            println("  ", appointments[ii][1], 
            " is NOT satisfiable and will be excluded!")
            splice!(appointments, ii)
        end
    end
end

end